From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 30 Oct 2018 12:16:28 +0000
Subject: [BUG] MVPP2 driver exploding in presence of a tap interface
In-Reply-To: <20181030105015.GB3407@kwain>
References: <6355174d-4ab6-595d-17db-311bce607aef@arm.com>
 <20181030105015.GB3407@kwain>
Message-ID: <7bd72963-1e7c-5175-ba88-fc020d786f0c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Antoine,

On 30/10/18 10:50, Antoine Tenart wrote:
> Marc,
> 
> On Mon, Oct 29, 2018 at 03:05:53PM +0000, Marc Zyngier wrote:
>>
>> This is a follow-up on the conversation Thomas and I had last week at 
>> ELC, with me ranting at the sorry state of the MVPP2 driver.
> 
>> Triggering this is dead simple:
>> - Add a macvtap to one of the MVPP2 interfaces
>> - Bring it online
>> - Watch the kernel exploding and memory being corrupted
>>
>> You don't even need anything listening on the tap interface, just its
>> simple existence triggers it. I use a similar setup on a large variety 
>> of machines, and this box is the only one that catches fire. Removing
>> the macvtap interface makes it (more) reliable.
>>
>> Given that I cannot reproduce this issue on any other ARM (32 or 64bit)
>> platform, including other Marvell stuff, I can only conclude that the
>> MVPP2 driver is responsible for this.
>>
>> Example crash and .config below (4.19 vanilla, as linux/master dies in
>> new and wonderful ways on this box). I'm looking forward to testing any
>> idea you may have.
> 
> I used a 4.19 vanilla kernel, with both your configuration and mine,
> on 2 different Macchiatobins, but was unable to trigger the issue:
> 
>   # ip link set eth0 up
>   # ip link add link eth0 name macvtap0 type macvtap
>   # ip link set macvtap0 up> 
> I can even configure the eth0/macvtap0 interfaces, and use them
> generating or receiving tcp/udp/icmp traffic.
> 
> (I also made other tests using macvtap and tap interfaces).
> 
> How much memory do you have on the board? What version of ATF are you
> using? Version of U-Boot?

4GB of RAM. As for the version numbers, see below. I don't use u-boot, 
but UEFI (EDK-II v2.60). The problem can be reproduced on two different
machines, with the same configuration (and firmwares dating from a 
similar era):

Starting CP-0 IOROM 1.07
Booting from SD 0 (0x29)
Found valid image at boot postion 0x002
lNOTICE:  Starting binary extension
NOTICE:  Gathering DRAM information
mv_ddr: mv_ddr-armada-17.06.1-g47f4c8b (Jun  2 2017 - 17:07:23)
mv_ddr: completed successfully
NOTICE:  Booting Trusted Firmware
NOTICE:  BL1: v1.3(release):armada-17.06.2:297d68f
NOTICE:  BL1: Built : 17:07:27, Jun  2 2017
NOTICE:  BL1: Booting BL2
lNOTICE:  BL2: v1.3(release):armada-17.06.2:297d68f
NOTICE:  BL2: Built : 17:07:28, Jun  2 2017
NOTICE:  BL1: Booting BL31
lNOTICE:  BL31: v1.3(release):armada-17.06.2:297d68f
NOTICE:  BL31: Built : 17:07:30, Jun  2 2017
lUEFI firmware (version MARVELL_EFI built at 17:12:21 on Jun  2 2017)

Armada 8040 MachiatoBin Platform Init

Comphy0-0: PCIE0         5 Gbps    
Comphy0-1: PCIE0         5 Gbps    
Comphy0-2: PCIE0         5 Gbps    
Comphy0-3: PCIE0         5 Gbps    
Comphy0-4: SFI           10.31 Gbps
Comphy0-5: SATA1         5 Gbps    

Comphy1-0: SGMII1        1.25 Gbps 
Comphy1-1: SATA2         5 Gbps    
Comphy1-2: USB3_HOST0    5 Gbps    
Comphy1-3: SATA3         5 Gbps    
Comphy1-4: SFI           10.31 Gbps
Comphy1-5: SGMII2        3.125 Gbps

UTMI PHY 0 initialized to USB Host0
UTMI PHY 1 initialized to USB Host1
UTMI PHY 0 initialized to USB Host0
RTC: Initialize controller 1
Skip I2c chip 0
Succesfully installed protocol interfaces
ramdisk:blckio install. Status=Success

With the latest mainline, and after fixing that other irq affinity
bug (see patch posted yesterday), I only need to bring the interface
up, without doing anything else:

# ip link set eth0 up
[  155.507877] mvpp2 f2000000.ethernet eth0: PHY [f212a600.mdio-mii:00] driver [mv88x3310]
[  155.526732] mvpp2 f2000000.ethernet eth0: configuring for phy/10gbase-kr link mode
[  157.592581] mvpp2 f2000000.ethernet eth0: Link is Up - 1Gbps/Full - flow control rx/tx
[  158.339396] BUG: Bad page state in process swapper/0  pfn:e6804
[  158.345345] page:ffff7e00039a0100 count:0 mapcount:0 mapping:ffff8000e7bf3b00 index:0xffff8000e6804c00
[  158.354696] flags: 0xfffc00000000200(slab)
[  158.358815] raw: 0fffc00000000200 ffff7e00039cff80 0000000400000004 ffff8000e7bf3b00
[  158.366594] raw: ffff8000e6804c00 000000008010000f 00000000ffffffff 0000000000000000
[  158.374371] page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
[  158.380840] bad because of flags: 0x200(slab)
[  158.385216] Modules linked in:
[  158.388288] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.19.0-09420-g34ae82ac683c #278
[  158.396148] Hardware name: Marvell 8040 MACCHIATOBin (DT)
[  158.401567] Call trace:
[  158.404031]  dump_backtrace+0x0/0x148
[  158.407708]  show_stack+0x14/0x20
[  158.411036]  dump_stack+0x90/0xb4
[  158.414365]  bad_page+0x104/0x130
[  158.417692]  free_pages_check_bad+0x9c/0xa8
[  158.421892]  __free_pages_ok+0x1b0/0x450
[  158.425829]  page_frag_free+0x8c/0xa8
[  158.429505]  skb_free_head+0x18/0x30
[  158.433093]  skb_release_data+0x130/0x160
[  158.437117]  skb_release_all+0x24/0x30
[  158.440881]  consume_skb+0x2c/0x58
[  158.444296]  arp_process.constprop.4+0x200/0x6f0
[  158.448931]  arp_rcv+0xf4/0x128
[  158.452084]  __netif_receive_skb_one_core+0x54/0x78
[  158.456981]  __netif_receive_skb+0x14/0x60
[  158.461094]  netif_receive_skb_internal+0x40/0x138
[  158.465903]  napi_gro_receive+0x64/0xc8
[  158.469754]  mvpp2_poll+0x3f4/0x810
[  158.473255]  net_rx_action+0x104/0x2c0
[  158.477018]  __do_softirq+0x11c/0x234
[  158.480695]  irq_exit+0xb8/0xc8
[  158.483848]  __handle_domain_irq+0x64/0xb8
[  158.487959]  gic_handle_irq+0x50/0xa0
[  158.491634]  el1_irq+0xb0/0x128
[  158.494786]  arch_cpu_idle+0x10/0x18
[  158.498375]  do_idle+0x208/0x280
[  158.501615]  cpu_startup_entry+0x20/0x28
[  158.505553]  rest_init+0xd4/0xe0
[  158.508793]  arch_call_rest_init+0xc/0x14
[  158.512818]  start_kernel+0x3d8/0x400
[  158.516497] Disabling lock debugging due to kernel taint
[  159.461058] BUG: Bad page state in process swapper/0  pfn:e681d
[  159.467013] page:ffff7e00039a0740 count:0 mapcount:0 mapping:ffff8000ef43fb00 index:0x0
[  159.475051] flags: 0xfffc00000000200(slab)
[  159.479170] raw: 0fffc00000000200 dead000000000100 dead000000000200 ffff8000ef43fb00
[  159.486947] raw: 0000000000000000 00000000001e001e 00000000ffffffff 0000000000000000
[  159.494721] page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
[  159.501189] bad because of flags: 0x200(slab)
[  159.505566] Modules linked in:
[  159.508636] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G    B             4.19.0-09420-g34ae82ac683c #278
[  159.517892] Hardware name: Marvell 8040 MACCHIATOBin (DT)
[  159.523311] Call trace:
[  159.525775]  dump_backtrace+0x0/0x148
[  159.529451]  show_stack+0x14/0x20
[  159.532779]  dump_stack+0x90/0xb4
[  159.536106]  bad_page+0x104/0x130
[  159.539433]  free_pages_check_bad+0x9c/0xa8
[  159.543633]  __free_pages_ok+0x1b0/0x450
[  159.547570]  page_frag_free+0x8c/0xa8
[  159.551247]  skb_free_head+0x18/0x30
[  159.554836]  skb_release_data+0x130/0x160
[  159.558860]  skb_release_all+0x24/0x30
[  159.562623]  kfree_skb+0x2c/0x58
[  159.565864]  __udp4_lib_rcv+0x850/0x948
[  159.569713]  udp_rcv+0x1c/0x28
[  159.572779]  ip_local_deliver_finish+0x100/0x248
[  159.577414]  ip_local_deliver+0x60/0x110
[  159.581350]  ip_rcv_finish+0x38/0x50
[  159.584938]  ip_rcv+0x50/0xd8
[  159.587918]  __netif_receive_skb_one_core+0x54/0x78
[  159.592815]  __netif_receive_skb+0x14/0x60
[  159.596928]  netif_receive_skb_internal+0x40/0x138
[  159.601738]  napi_gro_receive+0x64/0xc8
[  159.605589]  mvpp2_poll+0x3f4/0x810
[  159.609090]  net_rx_action+0x104/0x2c0
[  159.612853]  __do_softirq+0x11c/0x234
[  159.616530]  irq_exit+0xb8/0xc8
[  159.619683]  __handle_domain_irq+0x64/0xb8
[  159.623794]  gic_handle_irq+0x50/0xa0
[  159.627470]  el1_irq+0xb0/0x128
[  159.630622]  arch_cpu_idle+0x10/0x18
[  159.634211]  do_idle+0x208/0x280
[  159.637451]  cpu_startup_entry+0x24/0x28
[  159.641388]  rest_init+0xd4/0xe0
[  159.644630]  arch_call_rest_init+0xc/0x14
[  159.648655]  start_kernel+0x3d8/0x400

Bizarrely, eth1 and eth2 do not crash this way. I have no way to test 
eth3 (no transceiver).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
