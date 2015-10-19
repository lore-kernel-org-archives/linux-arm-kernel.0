From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 19 Oct 2015 11:39:31 +0200
Subject: [PATCH] staging/wilc: fix Kconfig dependencies, second try
In-Reply-To: <5624A1AF.8080607@atmel.com>
References: <5446980.8Rmykv9Tt3@wuerfel> <5624A1AF.8080607@atmel.com>
Message-ID: <4253270.hGxaSY0VLA@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 19 October 2015 16:54:23 Tony Cho wrote:
> Hi Arnd Bergmann,
> 
> When I apply this patch, I cannot make WILC1000 module (wilc1000.ko) because CONFIG_WILC1000 is y and also I can see some link errors for the cfg80211 APIs.
> 
> Can you consider this patch?

Ah, you are right. I see the same thing now and don't know what caused me
to send the patch in an incomplete state.

I hope this snippet is the last missing piece:

diff --git a/drivers/staging/wilc1000/Kconfig b/drivers/staging/wilc1000/Kconfig
index ee51b4278088..e3f109655be4 100644
--- a/drivers/staging/wilc1000/Kconfig
+++ b/drivers/staging/wilc1000/Kconfig
@@ -1,6 +1,7 @@
 config WILC1000_DRIVER
-	bool "WILC1000 support (WiFi only)"
+	tristate "WILC1000 support (WiFi only)"
 	depends on CFG80211 && WEXT_CORE && INET
+	depends on MMC || SPI
 	---help---
 	  This module only support IEEE 802.11n WiFi.
 
@@ -35,7 +36,7 @@ choice
 
 config WILC1000_SDIO
 	bool "SDIO support"
-	depends on MMC
+	depends on MMC=y || (MMC=m && WILC1000_DRIVER=m)
 	select WILC1000
 	---help---
 	  This module adds support for the SDIO interface of adapters using

I'll do a few hundred more randconfig builds with this on top and submit
it once it succeeds.

	Arnd
