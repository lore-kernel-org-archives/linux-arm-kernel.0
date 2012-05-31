From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 31 May 2012 09:32:50 +0000
Subject: ARM Versatile defconfig PCI io out of range?
In-Reply-To: <4FC672BA.8070009@gmail.com>
References: <20120530180242.GA15772@codethink.co.uk>
 <4FC672BA.8070009@gmail.com>
Message-ID: <201205310932.51140.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 30 May 2012, Rob Herring wrote:
> On 05/30/2012 01:02 PM, Richard Maw wrote:

> > 
> > We've tried to track down the problem, but we couldn't get much further
> > than finding out that the IO_SPACE_LIMIT in kernel/resource.c is 0xffff,
> > which is lower than the required 0x44000000.
> > 
> > We're not sure whether this is a problem with it not being allocated
> > enough space, or that it is not being translated properly.
> > 
> > Is this a known issue, I did a quick google for the "sym53c8xx
> >  can't reserve io" error, but nothing turned up.
> > If not, does anyone have any pointers to how this could be fixed?
> > 
> 
> I believe this is the same issue:
> 
> http://www.gossamer-threads.com/lists/linux/kernel/1543569
> 
> In looking at various PCI platforms and for a qemu platform with PCI to
> test PCI changes, I had concluded (wrongly I guess) that Versatile PCI
> was broken. This patch which has never gone upstream also played a part
> in my conclusion:
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2010-July/021035.html
> 
> The simple fix is to restore io.h for Versatile, but I'm looking for a
> better way.

It looks like it's a simple bug in pci.c, which puts the wrong thing into the
pcibios_min_io variable.

Does the below patch fix it?

	Arnd

diff --git a/arch/arm/mach-versatile/pci.c b/arch/arm/mach-versatile/pci.c
index 4ae4fc8..aeb7b60 100644
--- a/arch/arm/mach-versatile/pci.c
+++ b/arch/arm/mach-versatile/pci.c
@@ -305,7 +305,7 @@ int __init pci_versatile_setup(int nr, struct pci_sys_data *sys)
 
 void __init pci_versatile_preinit(void)
 {
-	pcibios_min_io = 0x44000000;
+	pcibios_min_io = 0x100;
 	pcibios_min_mem = 0x50000000;
 
 	__raw_writel(VERSATILE_PCI_MEM_BASE0 >> 28, PCI_IMAP0);
