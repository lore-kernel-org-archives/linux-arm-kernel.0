From: w@1wt.eu (Willy Tarreau)
Date: Tue, 8 Apr 2014 08:28:41 +0200
Subject: Intel I350 mini-PCIe card (igb) on Mirabox (mvebu / Armada 370)
In-Reply-To: <alpine.DEB.2.10.1404072239050.32332@vroombuntu>
References: <alpine.DEB.2.10.1403270025160.1545@vroombuntu>
 <20140327044054.GA22681@obsidianresearch.com>
 <alpine.DEB.2.10.1403280056250.4521@vroombuntu>
 <alpine.DEB.2.10.1404041408280.8617@vroombuntu>
 <20140406185833.GI29787@1wt.eu>
 <alpine.DEB.2.10.1404062253500.16719@vroombuntu>
 <20140407174106.GD9952@obsidianresearch.com>
 <CAAfodu0kbTspq2QQf0dh3U7LB-q+ECaX9FJ35fCc25UmgPJZSg@mail.gmail.com>
 <20140407204817.GB20736@obsidianresearch.com>
 <alpine.DEB.2.10.1404072239050.32332@vroombuntu>
Message-ID: <20140408062841.GT29787@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Neil,

On Mon, Apr 07, 2014 at 10:58:36PM +0100, Neil Greatorex wrote:
> I have finally managed to get the card working on both ports! Of course, 
> to do so I have added some nice kludges to the code that now need to be 
> implemented properly, but it is verification of what the problem is and 
> how to fix it!
> 
> I have included the patch at the end of this e-mail. It probably won't 
> apply cleanly for you as I have other dev_dbg calls in pci-mvebu.c.
> 
> What I did was to alter mvebu_pcie_align_resource to make the bridge 
> memory resource aligned to 4M. This had the effect that the 2nd bridge to 
> the xHCI controller was bumped to address 0xe0400000 instead of 
> 0xe0300000. I then also made it so that when we request the MBUS window to 
> be set up we ensure that the size is a power of 2. This has the effect of 
> creating the windows and addresses how we want them:
> 
> Relevant part of lspci -vvv:
> 
> 00:01.0 PCI bridge: Marvell Technology Group Ltd. Device 6710 (rev 01) 
> (prog-if 00 [Normal decode])
>         Memory behind bridge: e0000000-e02fffff
> 
> 00:02.0 PCI bridge: Marvell Technology Group Ltd. Device 6710 (rev 01) 
> (prog-if 00 [Normal decode])
>         Memory behind bridge: e0400000-e04fffff
> 
> cat /sys/kernel/debug/mvebu-mbus/devices:
> 
> [00] 00000000e8010000 - 00000000e8020000 : 0004:00e0 (remap 
> 0000000000010000)
> [01] disabled
> [02] disabled
> [03] disabled
> [04] disabled
> [05] disabled
> [06] disabled
> [07] disabled
> [08] 00000000fff00000 - 0000000100000000 : 0001:00e0
> [09] 00000000e0400000 - 00000000e0500000 : 0008:00e8
> [10] 00000000e0000000 - 00000000e0400000 : 0004:00e8
> [11] disabled
> [12] disabled
> [13] disabled
> [14] disabled
> [15] disabled
> [16] disabled
> [17] disabled
> [18] disabled
> [19] disabled
> 
> Now, over to the experts to implement this properly :-)
> 
> Thanks to Jason, Thomas and Willy for your help with tracking this down.

Well, on the XPGP board, it made some progress, but now I'm getting
another crash related to IRQs again when both ports are enabled (note
that I do have your other MSI fix). However, enabling only the second
port works now, so I guess it's just an IRQ assignment issue which is
killing it.

Here's what the bus looks like with your patch :

root at xpgp:~# lspci -tvnn
-[0000:00]-+-01.0-[01]--
           +-09.0-[02]--+-00.0  Intel Corporation Device [8086:1521]
           |            \-00.1  Intel Corporation Device [8086:1521]
           \-0a.0-[03]--

root at xpgp:~# lspci -vvv | egrep -i '(^0|memory)'
00:01.0 PCI bridge: Marvell Technology Group Ltd. Device 7846 (rev 02) (prog-if 00 [Normal decode])
        Memory behind bridge: fff00000-000fffff
        Prefetchable memory behind bridge: 00000000-000fffff
00:09.0 PCI bridge: Marvell Technology Group Ltd. Device 7846 (rev 02) (prog-if 00 [Normal decode])
        Memory behind bridge: e0000000-e02fffff
        Prefetchable memory behind bridge: 00000000-000fffff
00:0a.0 PCI bridge: Marvell Technology Group Ltd. Device 7846 (rev 02) (prog-if 00 [Normal decode])
        Memory behind bridge: fff00000-000fffff
        Prefetchable memory behind bridge: 00000000-000fffff
02:00.0 Ethernet controller: Intel Corporation Device 1521 (rev 01)
        Region 0: Memory at e0000000 (32-bit, non-prefetchable) [disabled] [size=512K]
        Region 3: Memory at e0200000 (32-bit, non-prefetchable) [disabled] [size=16K]
02:00.1 Ethernet controller: Intel Corporation Device 1521 (rev 01)
        Region 0: Memory at e0100000 (32-bit, non-prefetchable) [disabled] [size=512K]
        Region 3: Memory at e0204000 (32-bit, non-prefetchable) [disabled] [size=16K]

I don't know if it's normal to see bridges 00:01.0 and 00:0a.0 overlap
their areas or not. Maybe it's just because they're not configured.
The second bridge seems to correctly cover the IGB's regions though.
Also noteworthy, I get the exact same output when leaving SZ_1M instead
of SZ_4M in your patch. Thus I think that the real part of the fix is this
one :

	if (!is_power_of_2(port->memwin_size))
		port->memwin_size = 1 << fls(port->memwin_size);

BTW, this could be simplified this way (which also happens to be more
readable) which I could verify also works :

	port->memwin_size = roundup_pow_of_two(port->memwin_size);
	
Concerning the panic with the two ports enabled, I suspect that it's again
an issue related to the way IRQs are registered and rolled back in case of
error.

Before the patch :
PCI: enabling device 0000:02:00.1 (0140 -> 0142)
Unhandled fault: external abort on non-linefetch (0x1008) at 0xf0400018
Internal error: : 1008 [#1] SMP THUMB2
Modules linked in: igb(+) i2c_algo_bit
CPU: 1 PID: 1250 Comm: modprobe Not tainted 3.14.0-mvebu #6
task: c74b0e40 ti: c751c000 task.ti: c751c000
PC is at igb_get_invariants_82575+0x75/0x894 [igb]
LR is at igb_probe+0x22a/0xb80 [igb]
...

After the patch :
PCI: enabling device 0000:02:00.1 (0140 -> 0142)
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1266 at kernel/irq/irqdomain.c:277 irq_domain_associate+0xb9/0x110()
error: hwirq 0xffffffe4 is too large for armada_370_xp_msi_irq
Modules linked in: igb(+) i2c_algo_bit
CPU: 0 PID: 1266 Comm: modprobe Not tainted 3.14.0-mvebu #4
[<c0011c39>] (unwind_backtrace) from [<c000f20b>] (show_stack+0xb/0xc)
[<c000f20b>] (show_stack) from [<c02b5cbb>] (dump_stack+0x4f/0x64)
[<c02b5cbb>] (dump_stack) from [<c001a145>] (warn_slowpath_common+0x49/0x68)
[<c001a145>] (warn_slowpath_common) from [<c001a1bd>] (warn_slowpath_fmt+0x1d/0x28)
[<c001a1bd>] (warn_slowpath_fmt) from [<c0044e81>] (irq_domain_associate+0xb9/0x110)
[<c0044e81>] (irq_domain_associate) from [<c0044f1d>] (irq_create_mapping+0x45/0xa0)
[<c0044f1d>] (irq_create_mapping) from [<c016fd2d>] (armada_370_xp_setup_msi_irq+0x35/0x80)
[<c016fd2d>] (armada_370_xp_setup_msi_irq) from [<c0185243>] (arch_setup_msi_irq+0x17/0x2c)
[<c0185243>] (arch_setup_msi_irq) from [<c018530d>] (arch_setup_msi_irqs+0x39/0x4c)
[<c018530d>] (arch_setup_msi_irqs) from [<c01858bd>] (pci_enable_msix+0x195/0x2b0)
[<c01858bd>] (pci_enable_msix) from [<bf80617b>] (igb_msix_other+0x8de/0xb44 [igb])
[<bf80617b>] (igb_msix_other [igb]) from [<bf806dff>] (igb_probe+0x37a/0xb80 [igb])
[<bf806dff>] (igb_probe [igb]) from [<c017d185>] (pci_device_probe+0x45/0x6c)
...
Unable to handle kernel NULL pointer dereference at virtual address 00000024
pgd = ed9a0000
[00000024] *pgd=074b3831, *pte=00000000, *ppte=00000000
Internal error: Oops: 17 [#1] SMP THUMB2
Modules linked in: igb(+) i2c_algo_bit
CPU: 0 PID: 1266 Comm: modprobe Tainted: G        W    3.14.0-mvebu #4
task: ed97aec0 ti: c75be000 task.ti: c75be000
PC is at igb_set_mac+0x5d/0x164 [igb]
LR is at igb_set_mac+0xaa/0x164 [igb]
pc : [<bf80489e>]    lr : [<bf8048eb>]    psr: 200f0033
sp : c75bfce8  ip : 00000000  fp : ec938898
r10: bf816950  r9 : 00000001  r8 : ec938440
r7 : edadc868  r6 : 00000008  r5 : ec938440  r4 : 00000006
r3 : 00000000  r2 : 80000000  r1 : ec93845c  r0 : ec938440
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA Thumb  Segment user
Control: 50c53c7d  Table: 2d9a006a  DAC: 00000015
Process modprobe (pid: 1266, stack limit = 0xc75be240)
...
[<bf80489e>] (igb_set_mac [igb]) from [<bf8048eb>] (igb_set_mac+0xaa/0x164 [igb])
[<bf8048eb>] (igb_set_mac [igb]) from [<bf806183>] (igb_msix_other+0x8e6/0xb44 [igb])
[<bf806183>] (igb_msix_other [igb]) from [<bf806dff>] (igb_probe+0x37a/0xb80 [igb])
[<bf806dff>] (igb_probe [igb]) from [<c017d185>] (pci_device_probe+0x45/0x6c)

So we had :

     igb_probe()
         igb_msix_other()
             pci_enable_msix()  => Warning
             igb_set_mac()      => Panic

Cheers,
Willy
