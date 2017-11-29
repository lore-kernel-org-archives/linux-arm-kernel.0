From: arnaud.patard@rtp-net.org (Arnaud Patard)
Date: Wed, 29 Nov 2017 10:30:01 +0100
Subject: [PATCH] meson-gx-socinfo: Fix package id parsing
Message-ID: <20171129093018.129341243@rtp-net.org>
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

Signed-off-by: Arnaud Patard <apatard@hupstream.com>
Index: linux/drivers/soc/amlogic/meson-gx-socinfo.c
===================================================================
--- linux.orig/drivers/soc/amlogic/meson-gx-socinfo.c
+++ linux/drivers/soc/amlogic/meson-gx-socinfo.c
@@ -21,8 +21,8 @@
 #define AO_SEC_SOCINFO_OFFSET	AO_SEC_SD_CFG8
 
 #define SOCINFO_MAJOR	GENMASK(31, 24)
-#define SOCINFO_MINOR	GENMASK(23, 16)
-#define SOCINFO_PACK	GENMASK(15, 8)
+#define SOCINFO_PACK	GENMASK(23, 16)
+#define SOCINFO_MINOR	GENMASK(15, 8)
 #define SOCINFO_MISC	GENMASK(7, 0)
 
 static const struct meson_gx_soc_id {
