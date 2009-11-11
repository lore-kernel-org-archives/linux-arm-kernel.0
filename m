From: dk-arm-linux@gmx.de (Dieter Kiermaier)
Date: Wed, 11 Nov 2009 18:18:06 +0100
Subject: orion/kirkwood pcie issue still open with 2.6.32-rc6 (marvell
	stock 2.6.22.18 works!)
In-Reply-To: <20091111165927.GB22741@mail.wantstofly.org>
References: <200911090933.46240.dk-arm-linux@gmx.de>
	<200911111743.06702.dk-arm-linux@gmx.de>
	<20091111165927.GB22741@mail.wantstofly.org>
Message-ID: <200911111818.06996.dk-arm-linux@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch 11 November 2009 17:59:27 schrieb Lennert Buytenhek:
> On Wed, Nov 11, 2009 at 05:43:06PM +0100, Dieter Kiermaier wrote:
> 
> > > What's likely happening is that your boot loader either enables or
> > > does not disable this bit, and the 2.6.22.18 kernel disables the bit,
> > > while the upstream kernel leaves the bit untouched.
> > > 
> > > What this bit does is to decide whether or not aborts on the PCI
> > > interface are translated into processor aborts.  It's not really
> > > necessary to have this enabled, as the transaction will return
> > > 0xffffffff to the CPU anyway, which is then handled appropriately
> > > as well.
> > > 
> > > What uboot version are you using?  The uboot versions I have on my
> > > Kirkwood boards all jump to the OS with this bit already cleared.
> > > Perhaps we should clear it explicitly from Linux.
> > 
> > I'm using prafullas latest u-boot from u-boot-marvell at denx.de.
> > What u-boot are you using?
> 
> I think my boards are still on the stock uboot version.
> 

Very strange - with stock u-boot everything works!?!

Hm, now my problem changed to not stick on stock u-boot :)

How can we go on to find out what is different?

Dieter



> 
> > > > and after succesfully boot my pci device isn't reachable - without any errors / warnings!
> > > > I've enabled printk (echo 8 > /proc/sys/kernel/printk) and still no console output.
> > > 
> > > The device shows up on the bus, the bridge primary/secondary bus numbers
> > > look good, and the secondary memory address range on the bridge looks
> > > properly programmed.  It all looks good to me.
> > > 
> > > What do you mean by 'not reachable'?  I'm guessing that you're trying
> > > to access the memory BAR on the 01:08.0 device directly from userland
> > > by reading from the e000_0000 - e3ff_ffff address range from /dev/mem
> > > and only getting 0xffffffff back because you don't have an actual kernel
> > > driver for this FPGA board and thus you're not calling pci_enable_device()
> > > on your device, causing MEM/IO decoding not to have been enabled on
> > > the device as seems to be the case in your dump?
> > > 
> > No - I've allready a minimal driver here - I will check. It looks like I've forgotten to load it for the dump, sorry :(
> > Please see my driver probe below
> > (the FPGA supports simple memory mapped LEDs at the moment):
> > 
> > #define ARTISTA_MEM_SIZE (1024*1024)		/* I don't want to use all 64MBytes write for testing*/
> > 
> > 
> > static int probe(struct pci_dev *dev, const struct pci_device_id *id)
> > {
> > 	int result;
> > 	int i=0, y=0;
> > 
> > 	printk(KERN_DEBUG "anetfb probe() called\n");
> > 	
> > 	if ((result = pci_enable_device(dev)) < 0) {
> > 		return result;
> > 	}
> > 
> > 	memstart = pci_resource_start(dev, 0);
> > 	memlength = pci_resource_len(dev, 0);
> > 
> > 	printk(KERN_DEBUG "anetfb probe() request_mem_region() for BAR0\n");
> > 	printk(KERN_DEBUG "anetfb probe() BAR0 start address:%lx BAR0 length:%lx\n", memstart, memlength);
> > 	if (!request_mem_region(memstart, ARTISTA_MEM_SIZE, "mv_video MMIO"))
> > 	{
> > 		printk(KERN_DEBUG "anetfb probe() request_mem_region() for BAR0 failed\n");
> > 		return -EIO;
> > 	}
> > 
> > 	iomem_pointer=ioremap_nocache(memstart, ARTISTA_MEM_SIZE);
> 
> Here you should probably use pci_iomap().
> 
> 
> > This driver code works fine with 2.6.22.18 and doesn't with latest
> > git kernels (back to 2.6.30 where sheevaplug support starts).
> > With latest git kernels everytime 0xffffffff is returned by read calls.
> 
> The fact that the bridge has transaction forwarding disables explains
> this -- see my other reply.
> 
> 
> > > For what it's worth, I have various mv78xx0 and Kirkwood boards with
> > > 88SB2211 PCIe-to-PCI bridges on them, and they all work fine, and
> > > the devices behind those bridges do too.
> > 
> > Do you use marvell 88SB2211 PCIe-to-PCI bridge evalboards? I use this
> > one: DB-88SB2211-B-Pex2PCI
> 
> No, the mv78xx0 and Kirkwood development boards (ATX sized) come with
> 88SB2211 bridges integrated on the board, which is what I use.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
