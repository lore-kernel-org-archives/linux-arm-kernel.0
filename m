From: neil@fatboyfat.co.uk (Neil Greatorex)
Date: Thu, 27 Mar 2014 00:29:32 +0000 (GMT)
Subject: Intel I350 mini-PCIe card (igb) on Mirabox (mvebu / Armada
 370)
In-Reply-To: <20140326214259.GA12330@obsidianresearch.com>
References: <CAAfodu1eC6=mKwfowW6bmTtf_DcOL_oNQg77kSz+ykfHkMTN-w@mail.gmail.com>
 <20140325202249.GA10378@obsidianresearch.com> <20140325213638.5aba54b6@skate>
 <CAAfodu3RmoN9MYNahwv2kLz5=GvZvK6G9fJorsyVgU8C0J-NEg@mail.gmail.com>
 <20140325222404.GC14718@obsidianresearch.com>
 <20140325223510.GD14718@obsidianresearch.com>
 <CAAfodu3HuzBCAc3r=PPufjrFhEKUQK2b_WRow=GJuC6hSqiuKw@mail.gmail.com>
 <20140326201243.GA1536@obsidianresearch.com>
 <CAAfodu0xZ0V8ikJMT1Z+0JSLeD+nezWAcGNF2_ryvad5tsVDWA@mail.gmail.com>
 <20140326214259.GA12330@obsidianresearch.com>
Message-ID: <alpine.DEB.2.10.1403270025160.1545@vroombuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason,

On Wed, Mar 26, 2014 at 9:42 PM, Jason Gunthorpe 
<jgunthorpe@obsidianresearch.com> wrote:
> On Wed, Mar 26, 2014 at 08:34:19PM +0000, Neil Greatorex wrote:
>> Thanks. Here's the relevant output with that patch:
>>
>> [    0.135772] mvebu-pcie pcie-controller.3: ICR is 0
>> [    0.160889] mvebu-pcie pcie-controller.3: Vendor ID is ffffffff
>> [    0.160897] mvebu-pcie pcie-controller.3: ICR is 800200
>> [    1.170215] mvebu-pcie pcie-controller.3: Try 2: Vendor ID is 
15218086
>> [    1.170228] mvebu-pcie pcie-controller.3: ICR is 0
>
> Okay, this looks better..
>
<snip>
>
> I checked on my board here with the link down and I get:
>
> mvebu-pcie pex.1: Link is 0
> mvebu-pcie pex.1: ICR is 0
> mvebu-pcie pex.1: Vendor ID is ffffffff
> mvebu-pcie pex.1: ICR is 201
>
> Which makes sense - NF Error + Tx while in Link down Error.
>
> In any event, lets try this.
>

I ran with this patch applied (but none of the previous ones you sent - 
was that correct?) but the new dev_info line doesn't fire. I also no 
longer get the ethernet card detected at boot, and get the weird dual XHCI 
controller after a rescan.

mirabox ~ # dmesg | grep "ID read"
mirabox ~ # lspci
00:01.0 PCI bridge: Marvell Technology Group Ltd. Device 6710 (rev 01)
00:02.0 PCI bridge: Marvell Technology Group Ltd. Device 6710 (rev 01)
02:00.0 USB controller: Fresco Logic FL1009 USB 3.0 Host Controller (rev 02)
mirabox ~ # echo 1 > /sys/bus/pci/rescan
mirabox ~ # lspci
00:01.0 PCI bridge: Marvell Technology Group Ltd. Device 6710 (rev 01)
00:02.0 PCI bridge: Marvell Technology Group Ltd. Device 6710 (rev 01)
01:00.0 Ethernet controller: Intel Corporation I350 Gigabit Network Connection (rev 01)
01:00.1 Ethernet controller: Intel Corporation I350 Gigabit Network Connection (rev 01)
02:00.0 USB controller: Fresco Logic FL1009 USB 3.0 Host Controller (rev ff)
03:00.0 USB controller: Fresco Logic FL1009 USB 3.0 Host Controller (rev 02)
mirabox ~ # dmesg | grep "ID read"
mirabox ~ #

Full dmesg showing boot and rescan at https://gist.github.com/9796043

I then added an extra dev_info to print the ICR just after you read it in 
the loop, and get this:

[    0.137047] pci_bus 0000:01: scanning bus
[    0.161098] mvebu-pcie pcie-controller.3: ICR is 808200
[    0.162104] mvebu-pcie pcie-controller.3: ICR is 808201
[    0.162191] pci_bus 0000:01: fixups for bus

So it seems that the first time we have NFErrDet and PexLinkFail, and on 
the second time through the loop we have NFErrDet, PexLinkFail and 
TxReqInDIDownErr, so it then errors out of the loop.

Full dmesg for this boot is at https://gist.github.com/9796442

Then, I added back in the 1 second delay just after the call to 
mvebu_pcie_set_local_dev_nr and the card was detected again with the 
following:

[    2.133299] pci_bus 0000:01: scanning bus
[    2.133313] mvebu-pcie pcie-controller.3: ICR is 808000
[    2.133351] pci 0000:01:00.0: [8086:1521] type 00 class 0x020000
[    2.133379] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x0007ffff]
[    2.133405] pci 0000:01:00.0: reg 0x18: [io  0x0000-0x001f]
[    2.133422] pci 0000:01:00.0: reg 0x1c: [mem 0x00000000-0x00003fff]
[    2.133456] pci 0000:01:00.0: reg 0x30: [mem 0x00000000-0x0007ffff pref]
[    2.133473] pci 0000:01:00.0: calling pci_fixup_ide_bases+0x0/0x3c
[    2.133589] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[    2.133601] pci 0000:01:00.0: PME# disabled
[    2.133658] pci 0000:01:00.0: reg 0x184: [mem 0x00000000-0x00003fff]
[    2.133692] pci 0000:01:00.0: reg 0x190: [mem 0x00000000-0x00003fff]
[    2.133945] mvebu-pcie pcie-controller.3: ICR is 808000
[    2.133987] pci 0000:01:00.1: [8086:1521] type 00 class 0x020000
[    2.134014] pci 0000:01:00.1: reg 0x10: [mem 0x00000000-0x0007ffff]
[    2.134040] pci 0000:01:00.1: reg 0x18: [io  0x0000-0x001f]
[    2.134057] pci 0000:01:00.1: reg 0x1c: [mem 0x00000000-0x00003fff]
[    2.134091] pci 0000:01:00.1: reg 0x30: [mem 0x00000000-0x0007ffff pref]
[    2.134106] pci 0000:01:00.1: calling pci_fixup_ide_bases+0x0/0x3c
[    2.134215] pci 0000:01:00.1: PME# supported from D0 D3hot D3cold
[    2.134226] pci 0000:01:00.1: PME# disabled
[    2.134281] pci 0000:01:00.1: reg 0x184: [mem 0x00000000-0x00003fff]
[    2.134316] pci 0000:01:00.1: reg 0x190: [mem 0x00000000-0x00003fff]
[    2.134560] mvebu-pcie pcie-controller.3: ICR is 808000
[    2.134571] mvebu-pcie pcie-controller.3: ICR is 808000
[    2.134581] mvebu-pcie pcie-controller.3: ICR is 808000
[    2.134590] mvebu-pcie pcie-controller.3: ICR is 808000
[    2.134599] mvebu-pcie pcie-controller.3: ICR is 808000
[    2.134607] mvebu-pcie pcie-controller.3: ICR is 808000
[    2.134633] pci_bus 0000:01: fixups for bus

mirabox ~ # lspci
[   71.400126] mvebu-pcie pcie-controller.3: ICR is 0
[   71.407226] mvebu-pcie pcie-controller.3: ICR is 808000
[   71.412559] mvebu-pcie pcie-controller.3: ICR is 808000
00:01.0 PCI bridge: Marvell Technology Group Ltd. Device 6710 (rev 01)
00:02.0 PCI bridge: Marvell Technology Group Ltd. Device 6710 (rev 01)
01:00.0 Ethernet controller: Intel Corporation I350 Gigabit Network Connection (rev 01)
01:00.1 Ethernet controller: Intel Corporation I350 Gigabit Network Connection (rev 01)
03:00.0 USB controller: Fresco Logic FL1009 USB 3.0 Host Controller (rev 02)

Full dmesg for this boot is at: https://gist.github.com/9796851

For clarity, the patch that I've applied on top of your last patch is at 
the end of this e-mail...

Cheers,
Neil

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index 75d2a73..46f72f54 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -273,6 +273,8 @@ static int mvebu_pcie_hw_rd_conf(struct 
mvebu_pcie_port *port,

  		if (where == 0) {
  			u32 icr = mvebu_readl(port, PCIE_ICR);
+			dev_info(&port->pcie->pdev->dev,
+				 "ICR is %x\n", icr);
  			if (icr & PCIE_ICR_TX_IN_DOWN)
  				goto err_out;

@@ -1018,6 +1020,7 @@ static int mvebu_pcie_probe(struct platform_device 
*pdev)
  		}

  		mvebu_pcie_set_local_dev_nr(port, 1);
+		mdelay(1000);

  		port->dn = child;
  		spin_lock_init(&port->conf_lock);
