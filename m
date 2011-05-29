From: rientjes@google.com (David Rientjes)
Date: Sat, 28 May 2011 19:22:44 -0700 (PDT)
Subject: IrDA driver fails on PXA255
In-Reply-To: <20110528234614.GV24876@n2100.arm.linux.org.uk>
References: <20110528205701.GA1788@doriath.ww600.siemens.net>
	<alpine.DEB.2.00.1105281628480.9934@chino.kir.corp.google.com>
	<20110528234614.GV24876@n2100.arm.linux.org.uk>
Message-ID: <alpine.DEB.2.00.1105281913490.15709@chino.kir.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 29 May 2011, Russell King - ARM Linux wrote:

> > The driver is attempting to allocate DMA memory and you have 
> > CONFIG_ZONE_DMA disabled, which is the only reason you would get this 
> > warning.  If the allocation did not fail as a result of a197b59ae6e8, the 
> > page allocator may return any memory in a higher zone that the driver may 
> > not be expecting.  If you had never noticed a problem before, it may be 
> > possible that the driver doesn't actually have any zone restrictions and 
> > GFP_DMA can be removed, but this code is pretty old.  Otherwise, it'll 
> > need to depend on ZONE_DMA in the Kconfig.
> > 
> > Let's cc Nicolas and Russell as well.
> 
> Ouch.  We're probably going to have a pile of work to do to check that
> the DMA masks on all our devices are correct for the unrestricted case
> then.  That's probably going to be a very _big_ patch.
> 

There are probably a lot of drivers that are requesting DMA but don't 
explicitly require its support.  ARM has always been one of the exceptions 
when it comes to enabling CONFIG_ZONE_DMA, most archs do by default (x86 
_just_ made it configurable during this merge window), so this probably 
isn't the last report you'll get now that it fails the allocation and 
emits a warning.

	$ grep -r GFP_DMA drivers/* | wc -l
	299



arm, pxa2xx: enable DMA support for pxa2xx IRDA interface

The pxa2xx-ir driver allocates with GFP_DMA, so it must always have 
ZONE_DMA.

Reported-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Signed-off-by: David Rientjes <rientjes@google.com>
---
 drivers/net/irda/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/net/irda/Kconfig b/drivers/net/irda/Kconfig
--- a/drivers/net/irda/Kconfig
+++ b/drivers/net/irda/Kconfig
@@ -374,6 +374,7 @@ config VIA_FIR
 config PXA_FICP
 	tristate "Intel PXA2xx Internal FICP"
 	depends on ARCH_PXA && IRDA
+	select ZONE_DMA
 	help
 	  Say Y or M here if you want to build support for the PXA2xx
 	  built-in IRDA interface which can support both SIR and FIR.
