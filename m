From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 9 Oct 2012 20:01:26 +0000
Subject: [PATCH 0/3] new ARM-soc warning fixes
In-Reply-To: <20121009174631.GA19606@quad.lixom.net>
References: <1349796861-31164-1-git-send-email-arnd@arndb.de>
 <20121009174631.GA19606@quad.lixom.net>
Message-ID: <201210092001.26947.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 09 October 2012, Olof Johansson wrote:
> On Tue, Oct 09, 2012 at 05:34:18PM +0200, Arnd Bergmann wrote:
> > Hi Olof,
> > 
> > Here are three more fixes that I'd like to merge through the arm-soc
> > as time permits. All of them should be completely harmless and they
> > only fix harmless gcc warnings.
> > 
> > I don't know what your plans are for sending the next fixes branch.
> > I've uploaded these into a new "fixes2" branch on top of the patches
> > that are already in "fixes". We can either send them all together,
> > or you send the ones that are already queued first and these ones
> > with the next batch. Feel free to rebase if necessary.
> 
> I've pulled it in and will send up with fixes tonight (Tony has OMAP
> fixes coming, others might too).
> 

Ok, thanks!

I just noticed that I was missing yet another one, which I now added
directly. It was part of a longer series I sent last week. I wasn't
really sure whether this one would better be included in arm-soc or
Russell's arm tree and then I ended up not putting it in either series :(

	Arnd

8<----------
>From bfbad32a63fa6287723961f07bcd043dc9c5965c Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 30 Apr 2012 13:34:13 +0000
Subject: [PATCH] ARM: pxa: armcore: fix PCI PIO warnings

The it8152 PCI host used on the pxa/cm_x2xx machines
uses the old-style I/O window registration. This should
eventually get converted to pci_ioremap_io() but for
now, let's cast the IT8152_IO_BASE constant to an integer
type to get rid of the warnings.

Without this patch, building cm_x2xx_defconfig results in:

arch/arm/common/it8152.c: In function 'it8152_pci_setup':
arch/arm/common/it8152.c:287:18: warning: assignment makes integer from pointer without a cast [enabled by default]
arch/arm/common/it8152.c:288:16: warning: assignment makes integer from pointer without a cast [enabled by default]
arch/arm/common/it8152.c:291:17: warning: assignment makes integer from pointer without a cast [enabled by default]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Igor Grinberg <grinberg@compulab.co.il>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Mike Rapoport <mike@compulab.co.il>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Eric Miao <eric.y.miao@gmail.com>

diff --git a/arch/arm/common/it8152.c b/arch/arm/common/it8152.c
index c4110d1..001f491 100644
--- a/arch/arm/common/it8152.c
+++ b/arch/arm/common/it8152.c
@@ -284,11 +284,17 @@ int dma_set_coherent_mask(struct device *dev, u64 mask)
 
 int __init it8152_pci_setup(int nr, struct pci_sys_data *sys)
 {
-	it8152_io.start = IT8152_IO_BASE + 0x12000;
-	it8152_io.end	= IT8152_IO_BASE + 0x12000 + 0x100000;
+	/*
+	 * FIXME: use pci_ioremap_io to remap the IO space here and
+	 * move over to the generic io.h implementation.
+	 * This requires solving the same problem for PXA PCMCIA
+	 * support.
+	 */
+	it8152_io.start = (unsigned long)IT8152_IO_BASE + 0x12000;
+	it8152_io.end	= (unsigned long)IT8152_IO_BASE + 0x12000 + 0x100000;
 
 	sys->mem_offset = 0x10000000;
-	sys->io_offset  = IT8152_IO_BASE;
+	sys->io_offset  = (unsigned long)IT8152_IO_BASE;
 
 	if (request_resource(&ioport_resource, &it8152_io)) {
 		printk(KERN_ERR "PCI: unable to allocate IO region\n");
