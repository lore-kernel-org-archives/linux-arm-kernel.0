From: mgreer@animalcreek.com (Mark A. Greer)
Date: Fri, 21 Dec 2012 09:28:04 -0700
Subject: [PATCH 04/15] ARM: OMAP2+: Remove unnecessary message when no SHA IP
 is present
In-Reply-To: <1356107295-11121-1-git-send-email-mgreer@animalcreek.com>
References: <1356107295-11121-1-git-send-email-mgreer@animalcreek.com>
Message-ID: <1356107295-11121-5-git-send-email-mgreer@animalcreek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Mark A. Greer" <mgreer@animalcreek.com>

Remove the error message that prints when there is no SHA IP
present to make it consistent with all the other IPs.

CC: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
---
 arch/arm/mach-omap2/devices.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index a217408..598ab1e 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -466,20 +466,15 @@ static void omap_init_rng(void)
 
 static void __init omap_init_sham(void)
 {
-	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
-		struct omap_hwmod *oh;
-		struct platform_device *pdev;
+	struct omap_hwmod *oh;
+	struct platform_device *pdev;
 
-		oh = omap_hwmod_lookup("sham");
-		if (!oh)
-			return;
+	oh = omap_hwmod_lookup("sham");
+	if (!oh)
+		return;
 
-		pdev = omap_device_build("omap-sham", -1, oh, NULL, 0, NULL,
-					 0, 0);
-		WARN(IS_ERR(pdev), "Can't build omap_device for omap-sham\n");
-	} else {
-		pr_err("%s: platform not supported\n", __func__);
-	}
+	pdev = omap_device_build("omap-sham", -1, oh, NULL, 0, NULL, 0, 0);
+	WARN(IS_ERR(pdev), "Can't build omap_device for omap-sham\n");
 }
 
 #if defined(CONFIG_CRYPTO_DEV_OMAP_AES) || defined(CONFIG_CRYPTO_DEV_OMAP_AES_MODULE)
-- 
1.7.12
