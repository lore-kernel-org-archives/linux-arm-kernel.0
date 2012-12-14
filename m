From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Fri, 14 Dec 2012 11:05:40 +0100
Subject: [RFC v1] PCIe support for the Armada 370 and Armada XP SoCs
In-Reply-To: <20121213204718.GA4882@obsidianresearch.com>
References: <20121211075207.GA29977@avionic-0098.adnet.avionic-design.de>
 <50C7A3C5.7050100@wwwdotorg.org>
 <20121212203433.GA7898@avionic-0098.adnet.avionic-design.de>
 <50C9056D.2050309@wwwdotorg.org>
 <20121213070332.GA9946@avionic-0098.adnet.avionic-design.de>
 <20121213080415.GA21178@obsidianresearch.com>
 <20121213082323.GA13620@avionic-0098.adnet.avionic-design.de>
 <50CA1A8D.9070504@wwwdotorg.org>
 <20121213204229.GC18597@avionic-0098.adnet.avionic-design.de>
 <20121213204718.GA4882@obsidianresearch.com>
Message-ID: <20121214100540.GA4586@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 13, 2012 at 01:47:18PM -0700, Jason Gunthorpe wrote:
> On Thu, Dec 13, 2012 at 09:42:29PM +0100, Thierry Reding wrote:
> 
> > So I tried this today and it breaks horribly. There's some internal
> > abort or something. I don't have access to the hardware right now and
> > forgot to save the log output, but I can follow up in the morning. Also
> > up until the abort, bus 0000:00.0 was identified as the virtual switch
> > within the FPGA that's connected to port 0, so that would indicate that
> > it isn't in fact compliant and neither root port is reachable via the
> > regular mapping.
> > 
> > I suppose that may be the reason why the downstream code implements the
> > special case for accesses to the root ports' configuration space.
> 
> With the special case, what does device 0:0.0 show up as? What class?

So here's some more output:

	-sh-4.2# lspci
	00:00.0 PCI bridge: NVIDIA Corporation Device 0bf0 (rev a0)
	01:00.0 PCI bridge: PLD APPLICATIONS Device 4711
	02:00.0 PCI bridge: Avionic Design GmbH FPGA PCIe PCI-to-PCI (P2P) Bridge
	02:01.0 PCI bridge: Avionic Design GmbH FPGA PCIe PCI-to-PCI (P2P) Bridge
	02:02.0 PCI bridge: Avionic Design GmbH FPGA PCIe PCI-to-PCI (P2P) Bridge
	02:03.0 PCI bridge: Avionic Design GmbH FPGA PCIe PCI-to-PCI (P2P) Bridge
	02:04.0 PCI bridge: Avionic Design GmbH FPGA PCIe PCI-to-PCI (P2P) Bridge
	02:05.0 PCI bridge: Avionic Design GmbH FPGA PCIe PCI-to-PCI (P2P) Bridge
	02:06.0 PCI bridge: Avionic Design GmbH FPGA PCIe PCI-to-PCI (P2P) Bridge
	02:07.0 PCI bridge: Avionic Design GmbH FPGA PCIe PCI-to-PCI (P2P) Bridge
	03:00.0 Memory controller: Avionic Design GmbH FPGA PCIe Test Endpoint
	04:00.0 Serial bus controller [0c80]: Avionic Design GmbH OpenCores SPI Controller
	05:00.0 Serial bus controller [0c80]: Avionic Design GmbH OpenCores I2C Controller
	06:00.0 Intelligent controller [0e80]: Avionic Design GmbH 64 pin GPIO Controller
	07:00.0 Modem: Avionic Design GmbH OpenCores 16550 UART
	08:00.0 Modem: Avionic Design GmbH OpenCores 10/100 Mbps Ethernet Controller
	09:00.0 Modem: Avionic Design GmbH OpenCores CAN Protocol Controller
	0a:00.0 Modem: Avionic Design GmbH OpenCores CAN Protocol Controlle

	-sh-4.2# lspci -tv
	-[0000:00]---00.0-[01-0a]----00.0-[02-0a]--+-00.0-[03]----00.0  Avionic Design GmbH FPGA PCIe Test Endpoint
	                                           +-01.0-[04]----00.0  Avionic Design GmbH OpenCores SPI Controller
	                                           +-02.0-[05]----00.0  Avionic Design GmbH OpenCores I2C Controller
	                                           +-03.0-[06]----00.0  Avionic Design GmbH 64 pin GPIO Controller
	                                           +-04.0-[07]----00.0  Avionic Design GmbH OpenCores 16550 UART
	                                           +-05.0-[08]----00.0  Avionic Design GmbH OpenCores 10/100 Mbps Ethernet Controller
	                                           +-06.0-[09]----00.0  Avionic Design GmbH OpenCores CAN Protocol Controller
	                                           \-07.0-[0a]----00.0  Avionic Design GmbH OpenCores CAN Protocol Controller

	-sh-4.2# lspci -s 00:00.0 -v
	00:00.0 PCI bridge: NVIDIA Corporation Device 0bf0 (rev a0) (prog-if 00 [Normal decode])
	        Flags: bus master, fast devsel, latency 0
	        Bus: primary=00, secondary=01, subordinate=0a, sec-latency=0
	        Prefetchable memory behind bridge: 00000000b0000000-00000000b0ffffff
	        Capabilities: [40] Subsystem: NVIDIA Corporation Device 0000
	        Capabilities: [48] Power Management version 3
	        Capabilities: [50] MSI: Enable- Count=1/2 Maskable- 64bit+
	        Capabilities: [60] HyperTransport: MSI Mapping Enable- Fixed-
	        Capabilities: [80] Express Root Port (Slot+), MSI 00
	        Capabilities: [100] #00

So the class is 0x0604. I unfortunately have no setup where hardware is
connected to the second port. It would be interesting to see how that
looks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121214/472414a8/attachment-0001.sig>
