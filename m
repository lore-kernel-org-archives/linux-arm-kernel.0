From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 27 Aug 2012 17:36:12 -0600
Subject: [PATCH 5/5] hwrng: OMAP: remove SoC restrictions from driver
 registration
In-Reply-To: <20120827232922.15045.56522.stgit@dusk.lan>
References: <20120827232922.15045.56522.stgit@dusk.lan>
Message-ID: <20120827233611.15045.19688.stgit@dusk.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the SoC restriction code from the OMAP RNG driver.  The
integration code in arch/arm/*omap* should handle this.  The device
shouldn't be created if it doesn't exist on the currently-booted SoC.

This allows us to remove some OMAP-specific cpu_is_omap*() calls from
the driver.  Also, if other OMAP chips have RNGs that can be used
by Linux, there will be no need to modify the driver.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Matt Mackall <mpm@selenic.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
---
 arch/arm/mach-omap1/devices.c     |    3 +++
 drivers/char/hw_random/omap-rng.c |    3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
index 7f3d9d2..aedd7a4 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -377,6 +377,9 @@ static struct platform_device omap1_rng_device = {
 
 static void omap1_init_rng(void)
 {
+	if (!cpu_is_omap16xx())
+		return;
+
 	(void) platform_device_register(&omap1_rng_device);
 }
 
diff --git a/drivers/char/hw_random/omap-rng.c b/drivers/char/hw_random/omap-rng.c
index 748fcc8..a5effd8 100644
--- a/drivers/char/hw_random/omap-rng.c
+++ b/drivers/char/hw_random/omap-rng.c
@@ -220,9 +220,6 @@ static struct platform_driver omap_rng_driver = {
 
 static int __init omap_rng_init(void)
 {
-	if (!cpu_is_omap16xx() && !cpu_is_omap24xx())
-		return -ENODEV;
-
 	return platform_driver_register(&omap_rng_driver);
 }
 
