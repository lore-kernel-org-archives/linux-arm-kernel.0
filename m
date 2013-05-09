From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 9 May 2013 22:33:49 +0100
Subject: [PATCH] USB: set device dma_mask without reference to global data
In-Reply-To: <201305080142.12025.arnd@arndb.de>
References: <1367967232-10128-1-git-send-email-swarren@wwwdotorg.org>
 <20130507230445.GC9105@kroah.com> <201305080142.12025.arnd@arndb.de>
Message-ID: <20130509213349.GN21614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 08, 2013 at 01:42:11AM +0200, Arnd Bergmann wrote:
> On Wednesday 08 May 2013, Greg Kroah-Hartman wrote:
> > On Tue, May 07, 2013 at 04:53:52PM -0600, Stephen Warren wrote:
> > > From: Stephen Warren <swarren@nvidia.com>
> 
> > > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > > Signed-off-by: Stephen Warren <swarren@nvidia.com>
> > 
> > So this needs to go in for 3.10, right?  Any older kernels as well?  If
> > so, which ones?
> 
> The fix should definitely go into 3.10, but I'd suggest waiting with
> the backport for a couple of -rc releases to avoid possible regressions.
> We know that the current code is broken, but few people fully understand
> what is going on with coherent_dma_mask, so it might cause new problems
> in combination with some other unknown bug, and I don't see this as
> urgent: none of the ARM defconfigs build this driver as a loadable
> module and there is no bug in the built-in case. For some reason, only
> the ARM back-end drivers are broken.
> 
> The first occurence was apparently in 3.3, but only in ehci-tegra.c,
> while the other drivers subsequently copied the bug.

I've already suggested this approach:

diff --git a/arch/arm/include/asm/device.h b/arch/arm/include/asm/device.h
index dc662fc..51bb740 100644
--- a/arch/arm/include/asm/device.h
+++ b/arch/arm/include/asm/device.h
@@ -22,6 +22,7 @@ struct dev_archdata {
 struct omap_device;
 
 struct pdev_archdata {
+	u64 dma_mask;
 #ifdef CONFIG_ARCH_OMAP
 	struct omap_device *od;
 #endif

And then we can have dev->dma_mask pointed at that instead, which fully
eliminates any possible problems of things like dma_set_mask() interfering
with dma_set_coherent_mask().

Even better - because this is a common problem - would be to make 'dma_mask'
be a member of struct platform_device so that all arches can sort this
out once and for all (correction: generic code/drivers can in an arch-
independent way.)  IOW:

diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 9abf1db..121c74c 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -26,6 +26,7 @@ struct platform_device {
 	struct device	dev;
 	u32		num_resources;
 	struct resource	*resource;
+	u64		dma_mask;
 
 	const struct platform_device_id	*id_entry;
 
