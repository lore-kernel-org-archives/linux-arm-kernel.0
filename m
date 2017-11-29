From: arnaud.patard@rtp-net.org (Arnaud Patard)
Date: Wed, 29 Nov 2017 16:09:46 +0100
Subject: [PATCH] meson-gx-socinfo: Fix package id parsing
Message-ID: <20171129151000.710502415@rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've noticed the following message while booting a S905X based board:

soc soc0: Amlogic Meson GXL (S905D) Revision 21:82 (b:2) Detected

The S905D string is obviously wrong. The vendor code does:
...
        ver = (readl(assist_hw_rev) >> 8) & 0xff;
        meson_cpu_version[MESON_CPU_VERSION_LVL_MINOR] = ver;
        ver =  (readl(assist_hw_rev) >> 16) & 0xff;
        meson_cpu_version[MESON_CPU_VERSION_LVL_PACK] = ver;
...

while the current code does:
...
#define SOCINFO_MINOR  GENMASK(23, 16)
#define SOCINFO_PACK   GENMASK(15, 8)
...

This means that the current mainline code has package id and minor
version reversed.

Fixes: a9daaba2965e8 ("soc: Add Amlogic SoC Information driver")
Signed-off-by: Arnaud Patard <apatard@hupstream.com>
Index: linux/drivers/soc/amlogic/meson-gx-socinfo.c
===================================================================
--- linux.orig/drivers/soc/amlogic/meson-gx-socinfo.c	2017-11-29 10:26:49.081335917 +0100
+++ linux/drivers/soc/amlogic/meson-gx-socinfo.c	2017-11-29 10:26:49.041335074 +0100
@@ -20,8 +20,8 @@
 #define AO_SEC_SOCINFO_OFFSET	AO_SEC_SD_CFG8
 
 #define SOCINFO_MAJOR	GENMASK(31, 24)
-#define SOCINFO_MINOR	GENMASK(23, 16)
-#define SOCINFO_PACK	GENMASK(15, 8)
+#define SOCINFO_PACK	GENMASK(23, 16)
+#define SOCINFO_MINOR	GENMASK(15, 8)
 #define SOCINFO_MISC	GENMASK(7, 0)
 
 static const struct meson_gx_soc_id {
