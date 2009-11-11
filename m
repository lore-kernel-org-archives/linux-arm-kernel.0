From: dk-arm-linux@gmx.de (Dieter Kiermaier)
Date: Wed, 11 Nov 2009 17:43:06 +0100
Subject: orion/kirkwood pcie issue still open with 2.6.32-rc6 (marvell
	stock 2.6.22.18 works!)
In-Reply-To: <20091111152134.GX18639@mail.wantstofly.org>
References: <200911090933.46240.dk-arm-linux@gmx.de>
	<200911111529.23176.dk-arm-linux@gmx.de>
	<20091111152134.GX18639@mail.wantstofly.org>
Message-ID: <200911111743.06702.dk-arm-linux@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lennert,


> On Wed, Nov 11, 2009 at 06:29:22AM -0800, Dieter Kiermaier wrote:
> 
> > > > > Ronan Shitrit from marvell gave me the information to clear bit 2 of physical
> > > > > address 0xf1020100 to enable bus scanning.
> > > > > I don't know what this really does but it helped to get my kernel up and running.
> > > >
> > 
> > I've tested again:
> > 
> > with 2.6.22.18 marvell stock kernel my fpga behing the pcie->pci bridge works as expected.
> > Here is the output of lscpi:
> > 
> > sh-3.2# uname -a
> > Linux DB88FXX81 2.6.22.18 #1 Wed Apr 22 20:31:28 IST 2009 armv5tejl GNU/Linux
> > sh-3.2#
> > 
> > 
> > sh-3.2# lspci -vv
> > 00:01.0 Class 0604: Device 11ab:2211 (rev 01)
> >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
> >         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> >         Latency: 0, Cache Line Size: 32 bytes
> >         Bus: primary=00, secondary=01, subordinate=01, sec-latency=240
> >         I/O behind bridge: 00001000-00004fff
> >         Memory behind bridge: e8000000-ebffffff
> >         Secondary status: 66MHz+ FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- <SERR- <PERR-
> >         BridgeCtl: Parity+ SERR- NoISA+ VGA- MAbort+ >Reset- FastB2B-
> >                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> >         Capabilities: [40] Power Management version 2
> >                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
> >                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> >                 Bridge: PM- B3+
> >         Capabilities: [48] Express (v1) PCI/PCI-X Bridge, MSI 00
> >                 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
> >                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
> >                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> >                         RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- BrConfRtry-
> >                         MaxPayload 128 bytes, MaxReadReq 512 bytes
> >                 DevSta: CorrErr- UncorrErr+ FatalErr- UnsuppReq- AuxPwr- TransPend-
> >                 LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Latency L0 <256ns, L1 unlimited
> >                         ClockPM- Surprise- LLActRep- BwNot-
> >                 LnkCtl: ASPM Disabled; Disabled- Retrain- CommClk-
> >                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> >                 LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
> >         Capabilities: [100] #11ab
> >         Capabilities: [221] #f0e8
> >         Capabilities: [f1e] #2a0
> >         Capabilities: [e80] #187
> > 
> > 01:08.0 Class ff00: Device 1731:0101 (rev 10)
> >         Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
> >         Status: Cap- 66MHz- UDF- FastB2B- ParErr+ DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> >         Region 0: Memory at e8000000 (32-bit, non-prefetchable) [size=64M]
> >         Region 1: I/O ports at <ignored>
> >         Kernel driver in use: ArtistaNET-III frame buffer driver
> > 
> > 
> > If I switch to mainline linux kernel (there is no difference between openrd, vanilla, orion.git kernels!) my problems start:
> > I have to patch openrd_init() as follows:
> > 
> > diff --git a/arch/arm/mach-kirkwood/openrd_base-setup.c b/arch/arm/mach-kirkwood/openrd_base-setup.c
> > index 77617c7..670312b 100644
> > --- a/arch/arm/mach-kirkwood/openrd_base-setup.c
> > +++ b/arch/arm/mach-kirkwood/openrd_base-setup.c
> > @@ -14,6 +14,7 @@
> >  #include <linux/mtd/partitions.h>
> >  #include <linux/ata_platform.h>
> >  #include <linux/mv643xx_eth.h>
> > +#include <asm/io.h>
> >  #include <asm/mach-types.h>
> >  #include <asm/mach/arch.h>
> >  #include <mach/kirkwood.h>
> > @@ -76,9 +77,21 @@ static void __init openrd_base_init(void)
> > 
> >  static int __init openrd_base_pci_init(void)
> >  {
> > +       u32 cpu_config_reg;
> > +       void __iomem *base;
> > +
> > +       base = ioremap(0xf1020100, 4);
> > +       if (base)
> > +       {
> > +               cpu_config_reg = readl(base);
> > +               cpu_config_reg &= ~(1 << 2);
> > +               writel(cpu_config_reg, base);
> > +               printk("register 0x20100: %x\n", readl(base));
> > +       }
> > +       iounmap(base);
> >         if (machine_is_openrd_base())
> >                 kirkwood_pcie_init();
> > -
> > +
> >         return 0;
> >   }
> >  subsys_initcall(openrd_base_pci_init);
> > ----
> > to allow my system to boot up
> 
> What's likely happening is that your boot loader either enables or
> does not disable this bit, and the 2.6.22.18 kernel disables the bit,
> while the upstream kernel leaves the bit untouched.
> 
> What this bit does is to decide whether or not aborts on the PCI
> interface are translated into processor aborts.  It's not really
> necessary to have this enabled, as the transaction will return
> 0xffffffff to the CPU anyway, which is then handled appropriately
> as well.
> 
> What uboot version are you using?  The uboot versions I have on my
> Kirkwood boards all jump to the OS with this bit already cleared.
> Perhaps we should clear it explicitly from Linux.
> 
I'm using prafullas latest u-boot from u-boot-marvell at denx.de.
What u-boot are you using?
> 
> > and after succesfully boot my pci device isn't reachable - without any errors / warnings!
> > I've enabled printk (echo 8 > /proc/sys/kernel/printk) and still no console output.
> 
> The device shows up on the bus, the bridge primary/secondary bus numbers
> look good, and the secondary memory address range on the bridge looks
> properly programmed.  It all looks good to me.
> 
> What do you mean by 'not reachable'?  I'm guessing that you're trying
> to access the memory BAR on the 01:08.0 device directly from userland
> by reading from the e000_0000 - e3ff_ffff address range from /dev/mem
> and only getting 0xffffffff back because you don't have an actual kernel
> driver for this FPGA board and thus you're not calling pci_enable_device()
> on your device, causing MEM/IO decoding not to have been enabled on
> the device as seems to be the case in your dump?
> 
No - I've allready a minimal driver here - I will check. It looks like I've forgotten to load it for the dump, sorry :(
Please see my driver probe below
(the FPGA supports simple memory mapped LEDs at the moment):

#define ARTISTA_MEM_SIZE (1024*1024)		/* I don't want to use all 64MBytes write for testing*/


static int probe(struct pci_dev *dev, const struct pci_device_id *id)
{
	int result;
	int i=0, y=0;

	printk(KERN_DEBUG "anetfb probe() called\n");
	
	if ((result = pci_enable_device(dev)) < 0) {
		return result;
	}

	memstart = pci_resource_start(dev, 0);
	memlength = pci_resource_len(dev, 0);

	printk(KERN_DEBUG "anetfb probe() request_mem_region() for BAR0\n");
	printk(KERN_DEBUG "anetfb probe() BAR0 start address:%lx BAR0 length:%lx\n", memstart, memlength);
	if (!request_mem_region(memstart, ARTISTA_MEM_SIZE, "mv_video MMIO"))
	{
		printk(KERN_DEBUG "anetfb probe() request_mem_region() for BAR0 failed\n");
		return -EIO;
	}

	iomem_pointer=ioremap_nocache(memstart, ARTISTA_MEM_SIZE);

	printk(KERN_DEBUG "anetfb trying to access iomem@address %x with length:%d...\n", iomem_pointer, ARTISTA_MEM_SIZE);

	iowrite32(0x0, iomem_pointer);
	printk(KERN_DEBUG "read register value via readl: %x\n", ioread32(iomem_pointer));
	printk(KERN_DEBUG"write 1s to mem space...\n");
	iowrite32(0xffffffff, iomem_pointer);
	printk(KERN_DEBUG "read register value via readl: %x\n", ioread32(iomem_pointer));

}

This driver code works fine with 2.6.22.18 and doesn't with latest git kernels (back to 2.6.30 where sheevaplug support starts).
With latest git kernels everytime 0xffffffff is returned by read calls.

> For what it's worth, I have various mv78xx0 and Kirkwood boards with
> 88SB2211 PCIe-to-PCI bridges on them, and they all work fine, and
> the devices behind those bridges do too.
> 
Do you use marvell 88SB2211 PCIe-to-PCI bridge evalboards? I use this one: DB-88SB2211-B-Pex2PCI


> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
