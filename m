From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 18 Feb 2015 20:47:30 +0100
Subject: [PATCH] net: smc91x: improve neponset hack
Message-ID: <5763365.j5Nvv4LgM3@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The smc91x driver tries to support multiple platforms at compile
time, but they are mutually exclusive at runtime, and not clearly
defined.

Trying to build for CONFIG_SA1100_ASSABET without CONFIG_ASSABET_NEPONSET
results in this link error:

drivers/built-in.o: In function `smc_drv_probe':
:(.text+0x33310c): undefined reference to `neponset_ncr_frob'

since the neponset_ncr_set function is not defined otherwise.

Similarly, building for both CONFIG_SA1100_ASSABET and CONFIG_SA1100_PLEB
results in a different build error:

smsc/smc91x.c: In function 'smc_drv_probe':
smsc/smc91x.c:2299:2: error: implicit declaration of function 'neponset_ncr_set' [-Werror=implicit-function-declaration]
  neponset_ncr_set(NCR_ENET_OSC_EN);
  ^
smsc/smc91x.c:2299:19: error: 'NCR_ENET_OSC_EN' undeclared (first use in this function)
  neponset_ncr_set(NCR_ENET_OSC_EN);
                   ^

This is an attempt to fix the call site responsible for both
errors, making sure we call the function exactly when the driver
is actually trying to run on the assabet/neponset machine. With
this patch, I no longer see randconfig build errors in this file.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/net/ethernet/smsc/smc91x.c b/drivers/net/ethernet/smsc/smc91x.c
index 88a55f95fe09..fa3f193b5f4d 100644
--- a/drivers/net/ethernet/smsc/smc91x.c
+++ b/drivers/net/ethernet/smsc/smc91x.c
@@ -2355,7 +2355,7 @@ static int smc_drv_probe(struct platform_device *pdev)
 	ret = smc_request_attrib(pdev, ndev);
 	if (ret)
 		goto out_release_io;
-#if defined(CONFIG_SA1100_ASSABET)
+#if defined(CONFIG_ASSABET_NEPONSET) && !defined(CONFIG_SA1100_PLEB)
 	neponset_ncr_set(NCR_ENET_OSC_EN);
 #endif
 	platform_set_drvdata(pdev, ndev);
