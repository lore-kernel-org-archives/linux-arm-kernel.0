From: itooo@itooo.com (Greg)
Date: Fri, 10 May 2013 18:43:15 +0200
Subject: MVNETA irq with backport-3.8
In-Reply-To: <51897810.8020002@free-electrons.com>
References: <51890C29.8000504@itooo.com> <20130507181823.23342ffb@skate>
 <51892E87.5020903@itooo.com> <518971D4.5000603@free-electrons.com>
 <20130507214256.GC5414@1wt.eu> <51897810.8020002@free-electrons.com>
Message-ID: <518D23A3.9020405@itooo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 07/05/2013 23:54, Gregory CLEMENT a ?crit :
> Hi Willy,
>
> On 05/07/2013 11:42 PM, Willy Tarreau wrote:
>> Hi Gr?gory,
>>
>> On Tue, May 07, 2013 at 11:27:48PM +0200, Gregory CLEMENT wrote:
>>> I built and tested backport-3.8 and indeed the Ethernet is broken.
>>> It was cause by a recent batch of fixes that I added, now I have to
>>> figure out why they have broken the ethernet whereas they were supposed
>>> to make it work better!
>> If that can help you, here is the list of (possibly relevant) patches
>> I have applied on top of 3.9 picked from your repository some time
>> ago (it's not up to date with the latest versions due to merge issues
>> inducing laziness on my side) :
>>
>> $ git log --oneline --grep=free-electrons v3.9..
>> 65d2b5c ARM: mvebu: Add Device Bus and CFI flash memory support to defconfig
>> 26cabde ARM: mvebu: Add support for NOR flash device on Openblocks AX3 board
>> 34b32e8 ARM: mvebu: Add support for NOR flash device on Armada XP-GP board
>> 31504c0 ARM: mvebu: Add Device Bus support for Armada 370/XP SoC
>> 8cc752e drivers: memory: Introduce Marvell EBU Device Bus driver
>> 48c6ddc arm: mvebu: update defconfig with PCI and USB support
>> f4ed5ba arm: mvebu: PCIe Device Tree informations for Armada XP GP
>> b1ed2c5 arm: mvebu: PCIe Device Tree informations for Armada 370 DB
>> 51e91a9 arm: mvebu: PCIe Device Tree informations for Armada 370 Mirabox
>> 402f9ba arm: mvebu: PCIe Device Tree informations for Armada XP DB
>> 4899409 arm: mvebu: PCIe Device Tree informations for OpenBlocks AX3-4
>> fb6d69f arm: mvebu: add PCIe Device Tree informations for Armada XP
>> c523287 arm: mvebu: add PCIe Device Tree informations for Armada 370
>> 998ee7a arm: mvebu: PCIe support is now available on mvebu
>> fc9b219 pci: PCIe driver for Marvell Armada 370/XP systems
>> 4b765fb clk: mvebu: add more PCIe clocks for Armada XP
>> af3bcd9 clk: mvebu: create parent-child relation for PCIe clocks on Armada 370
>> 6cee09e arm: pci: add a align_resource hook
>> 80fa698 pci: infrastructure to add drivers in drivers/pci/host
>> 91ca5a7 of/pci: Provide support for parsing PCI DT ranges property
>> e46b3e7 arm: plat-orion: remove addr-map code
>> d11befe arm: mach-mv78xx0: convert to use the mvebu-mbus driver
>> a508a65 arm: mach-orion5x: convert to use mvebu-mbus driver
>> e249639 arm: mach-dove: convert to use mvebu-mbus driver
>> 70efe5e arm: mach-kirkwood: convert to use mvebu-mbus driver
>> 37e82515 arm: mach-mvebu: convert to use mvebu-mbus driver
>> 035f910 bus: introduce an Marvell EBU MBus driver
>> 527d658 arm: mach-orion5x: use mv_mbus_dram_info() in PCI code
>> c1b44db arm: plat-orion: use mv_mbus_dram_info() in PCIe code
>> 59463f4 arm: plat-orion: only build addr-map.c when needed
>>
>> With those my AX3 works fine. If that can help, I can send them all to
>> you off-list, in case you notice a minor difference with something.
> Thanks for your help but I finally found the guilty commit, it was
> "66d0539 net: mvneta: convert to percpu interrupt".
>
> This commit was never submitted because finally I realized that it was
> broken in SMP. Finally it was the commit "arm: mvebu: Use local
> interrupt only for the timer 0" which was the correct solution.
>
> With the first patch I had converted the mvneta driver to use percpu
> IRQ, but as I explained in the log of the 2nd patch: "the interrupts
> have to be freed when the .stop() function is called. As the
> free_percpu_irq() function don't disable the interrupt line, we have
> to do it on each CPU before calling this. The function
> disable_percpu_irq() only disable the percpu on the current CPU and
> there is no function which allows to disable a percpu irq on a given
> CPU."
>
> So Greg, the solution is just to revert the commit 66d0539. I am going
> to update the backport-3.8 branch in a couple of minutes.
>
>
Gregory,

I pulled the change and got it working fine.
I also got the PCIe link established, I haven't tried to stress it yet, 
I will do so quickly.

I got a backtrace that might interrest you, a "deadlock" condition while 
polling network counters :

Deadlock detection:
> INFO: rcu_sched self-detected stall on CPU { 0}  (t=2100 jiffies 
> g=4229 c=4228 q=421)
> [<c0014e24>] (unwind_backtrace+0x0/0xfc) from [<c006c5c8>] 
> (rcu_check_callbacks+0x1d0/0x734)
> [<c006c5c8>] (rcu_check_callbacks+0x1d0/0x734) from [<c002ca24>] 
> (update_process_times+0x38/0x4c)
> [<c002ca24>] (update_process_times+0x38/0x4c) from [<c0058eb8>] 
> (tick_sched_timer+0x68/0x210)
> [<c0058eb8>] (tick_sched_timer+0x68/0x210) from [<c0040040>] 
> (__run_hrtimer.isra.17+0x74/0x134)
> [<c0040040>] (__run_hrtimer.isra.17+0x74/0x134) from [<c0040860>] 
> (hrtimer_interrupt+0xf8/0x2cc)
> [<c0040860>] (hrtimer_interrupt+0xf8/0x2cc) from [<c03569c0>] 
> (armada_370_xp_timer_interrupt+0x3c/0x50)
> [<c03569c0>] (armada_370_xp_timer_interrupt+0x3c/0x50) from 
> [<c0067420>] (handle_percpu_devid_irq+0x64/0x84)
> [<c0067420>] (handle_percpu_devid_irq+0x64/0x84) from [<c0063d08>] 
> (generic_handle_irq+0x24/0x30)
> [<c0063d08>] (generic_handle_irq+0x24/0x30) from [<c000eef4>] 
> (handle_IRQ+0x38/0x94)
> [<c000eef4>] (handle_IRQ+0x38/0x94) from [<c0008610>] 
> (armada_370_xp_handle_irq+0xa0/0xb4)
> [<c0008610>] (armada_370_xp_handle_irq+0xa0/0xb4) from [<c000dca0>] 
> (__irq_svc+0x40/0x50)
> Exception stack(0xee69bd20 to 0xee69bd68)
> bd20: 0094809d 00000001 f0ab5a55 0094809d eeba3000 ee69be10 00000610 
> c031a500
> bd40: ee69bf10 ef0f6380 4c000001 00000000 00000618 ee69bd68 c031a518 
> c031a558
> bd60: 00000013 ffffffff
Hung process
> [<c000dca0>] (__irq_svc+0x40/0x50) from [<c031a558>] 
> (mvneta_get_stats64+0x58/0xc0)
> [<c031a558>] (mvneta_get_stats64+0x58/0xc0) from [<c0379974>] 
> (dev_get_stats+0x38/0xb4)
> [<c0379974>] (dev_get_stats+0x38/0xb4) from [<c0379b10>] 
> (dev_seq_printf_stats+0x1c/0x114)
> [<c0379b10>] (dev_seq_printf_stats+0x1c/0x114) from [<c037d83c>] 
> (dev_seq_show+0x10/0x2c)
> [<c037d83c>] (dev_seq_show+0x10/0x2c) from [<c00bfe3c>] 
> (seq_read+0x330/0x4c8)
> [<c00bfe3c>] (seq_read+0x330/0x4c8) from [<c00ea2ac>] 
> (proc_reg_read+0x8c/0xd0)
> [<c00ea2ac>] (proc_reg_read+0x8c/0xd0) from [<c00a0554>] 
> (vfs_read+0xa0/0x134)
> [<c00a0554>] (vfs_read+0xa0/0x134) from [<c00a0628>] (sys_read+0x40/0x6c)
> [<c00a0628>] (sys_read+0x40/0x6c) from [<c000dfe0>] 
> (ret_fast_syscall+0x0/0x30)

I noticed this using "ethstatus" tool, you can see the counters are not 
incrementing smoothly under traffic.

Cheers,
