From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 24 Feb 2015 11:27:06 +0100
Subject: [PATCH] spi: sirf: add reset controller dependency
In-Reply-To: <20150224075018.GM6236@finisterre.sirena.org.uk>
References: <4553005.HBquOfbqXe@wuerfel> <6170208.Z0Upu48JrX@wuerfel>
 <20150224075018.GM6236@finisterre.sirena.org.uk>
Message-ID: <5840299.CR2H70RAJi@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 24 February 2015 16:50:18 Mark Brown wrote:
> On Mon, Feb 23, 2015 at 11:01:18PM +0100, Arnd Bergmann wrote:
> > On Saturday 21 February 2015 18:44:58 Mark Brown wrote:
> 
> > > In that case a dependency seems wrong, I'd expect to see a select - it's
> > > a bit obscure to have to grovel around to figure out what magic options
> > > are needed to make things turn on and resets feel more like a utility
> > > thing than a control bus (which tend to be the things we depend on).
> > > Dunno, perhaps I'm wrong?
> 
> > Mixing 'select' and 'depends on' causes recursive dependencies, and
> > there are already lots of drivers that do 'depends on RESET_CONTROLLER'.
> 
> Well, perhaps that's the cleanup we should be doing then...  one of the
> big problems with some of the other randconfig work there's been is that
> a lot of the patches just add dependencies without looking at if that
> makes sense.

I generally try to keep the big picture in mind, but sometimes I take
an easier way out to avoid starting a long discussion.

> > Most users of this symbol seem to follow the strategy of selecting
> > RESET_CONTROLLER when a driver is there to provide the functionality,
> > but depending on it when a driver uses it. We are however a bit
> > inconsistent here and it would be nice to clean it up.
> 
> Right, to me that feels the opposite way round to how we normally do
> things - the drivers for the subsystem normally depend on the subsystem
> (or are hidden by it).

I think it's the more common of the two approaches, but we are definitely
inconsistent here. To make everything consistent here, I'd just do this:

diff --git a/drivers/gpu/drm/sti/Kconfig b/drivers/gpu/drm/sti/Kconfig
index fbccc105819b..0670aa17409d 100644
--- a/drivers/gpu/drm/sti/Kconfig
+++ b/drivers/gpu/drm/sti/Kconfig
@@ -1,7 +1,7 @@
 config DRM_STI
 	tristate "DRM Support for STMicroelectronics SoC stiH41x Series"
 	depends on DRM && (SOC_STIH415 || SOC_STIH416 || ARCH_MULTIPLATFORM) && HAVE_DMA_ATTRS
-	select RESET_CONTROLLER
+	depends on RESET_CONTROLLER
 	select DRM_KMS_HELPER
 	select DRM_GEM_CMA_HELPER
 	select DRM_KMS_CMA_HELPER
diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
index 7d3af190be55..545b442253e4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
+++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
@@ -1,11 +1,11 @@
 config STMMAC_ETH
 	tristate "STMicroelectronics 10/100/1000 Ethernet driver"
 	depends on HAS_IOMEM && HAS_DMA
+	depends on RESET_CONTROLLER
 	select MII
 	select PHYLIB
 	select CRC32
 	select PTP_1588_CLOCK
-	select RESET_CONTROLLER
 	---help---
 	  This is the driver for the Ethernet IPs are built around a
 	  Synopsys IP Core and only tested on the STMicroelectronics

> > In this particular patch, I'm just following what others do.
> 
> > We should probably 'select ARCH_HAS_RESET_CONTROLLER' unconditionally
> > for ARM ARCH_MULTIPLATFORM, as it's a bit silly to select both
> > ARCH_HAS_RESET_CONTROLLER and RESET_CONTROLLER from platform code.
> 
> That does seem a bit odd.  TBH I'm never sure that ARCH_HAS_ is that
> good an idea for the driver things, most of them can just as reasonably
> be used by off-SoC things.

I'm totally fine with a patch to kill that off. I suspect it was introduced
in order to not show up on x86 and stay under Linus' radar. He does get
upset sometimes about seeing too many options for stuff he does not care
about, especially when it breaks on x86.

	Arnd
