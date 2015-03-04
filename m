From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 04 Mar 2015 23:39:18 +0100
Subject: [PATCH] ARM: fix typos in smc91x platform data
In-Reply-To: <55454365.1GsbtFBXGk@wuerfel>
References: <2226303.iMQTNXSl1n@wuerfel>
 <20150228.125721.1605776377351425463.davem@davemloft.net>
 <55454365.1GsbtFBXGk@wuerfel>
Message-ID: <3483843.L07cLWCFPN@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I recently did a rework of the smc91x driver and did some build-testing
by compiling hundreds of randconfig kernels. Unfortunately, my script
was wrong and did not actually test the configurations that mattered,
so I introduced stupid typos in almost every file I touched.

I fixed my script now, built all configurations that actually matter
and fixed all the typos, this is the result.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: b70661c70830d ("net: smc91x: use run-time configuration on all ARM machines")
---
Hi Dave,

I could either take this through our arm-soc tree, or through netdev,
whichever suits you.

diff --git a/arch/arm/mach-pxa/idp.c b/arch/arm/mach-pxa/idp.c
index ddad190c8abc..c5d9b02d5cbf 100644
--- a/arch/arm/mach-pxa/idp.c
+++ b/arch/arm/mach-pxa/idp.c
@@ -36,6 +36,7 @@
 #include <linux/platform_data/video-pxafb.h>
 #include <mach/bitfield.h>
 #include <linux/platform_data/mmc-pxamci.h>
+#include <linux/smc91x.h>
 
 #include "generic.h"
 #include "devices.h"
diff --git a/arch/arm/mach-pxa/lpd270.c b/arch/arm/mach-pxa/lpd270.c
index 5f9f64e4726e..6c896c9375cb 100644
--- a/arch/arm/mach-pxa/lpd270.c
+++ b/arch/arm/mach-pxa/lpd270.c
@@ -195,7 +195,7 @@ static struct resource smc91x_resources[] = {
 };
 
 struct smc91x_platdata smc91x_platdata = {
-	.flags = SMC91X_USE_16BIT | SMC91X_NOWAIT;
+	.flags = SMC91X_USE_16BIT | SMC91X_NOWAIT,
 };
 
 static struct platform_device smc91x_device = {
diff --git a/arch/arm/mach-sa1100/neponset.c b/arch/arm/mach-sa1100/neponset.c
index 7b0cd3172354..af868d258e66 100644
--- a/arch/arm/mach-sa1100/neponset.c
+++ b/arch/arm/mach-sa1100/neponset.c
@@ -268,8 +268,8 @@ static int neponset_probe(struct platform_device *dev)
 		.id = 0,
 		.res = smc91x_resources,
 		.num_res = ARRAY_SIZE(smc91x_resources),
-		.data = &smc91c_platdata,
-		.size_data = sizeof(smc91c_platdata),
+		.data = &smc91x_platdata,
+		.size_data = sizeof(smc91x_platdata),
 	};
 	int ret, irq;
 
diff --git a/arch/arm/mach-sa1100/pleb.c b/arch/arm/mach-sa1100/pleb.c
index 696fd0fe4806..1525d7b5f1b7 100644
--- a/arch/arm/mach-sa1100/pleb.c
+++ b/arch/arm/mach-sa1100/pleb.c
@@ -54,7 +54,7 @@ static struct platform_device smc91x_device = {
 	.num_resources	= ARRAY_SIZE(smc91x_resources),
 	.resource	= smc91x_resources,
 	.dev = {
-		.platform_data  = &smc91c_platdata,
+		.platform_data  = &smc91x_platdata,
 	},
 };
 
diff --git a/drivers/net/ethernet/smsc/smc91x.c b/drivers/net/ethernet/smsc/smc91x.c
index 209ee1b27f8d..5d093dc0f5f5 100644
--- a/drivers/net/ethernet/smsc/smc91x.c
+++ b/drivers/net/ethernet/smsc/smc91x.c
@@ -92,6 +92,7 @@ static const char version[] =
 #include "smc91x.h"
 
 #if defined(CONFIG_ASSABET_NEPONSET)
+#include <mach/assabet.h>
 #include <mach/neponset.h>
 #endif
 
