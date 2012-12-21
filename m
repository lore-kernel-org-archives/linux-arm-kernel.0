From: mgreer@animalcreek.com (Mark A. Greer)
Date: Fri, 21 Dec 2012 09:28:11 -0700
Subject: [PATCH 11/15] ARM: OMAP2+: Remove unnecessary message when no AES IP
 is present
In-Reply-To: <1356107295-11121-1-git-send-email-mgreer@animalcreek.com>
References: <1356107295-11121-1-git-send-email-mgreer@animalcreek.com>
Message-ID: <1356107295-11121-12-git-send-email-mgreer@animalcreek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Mark A. Greer" <mgreer@animalcreek.com>

Remove the error message that prints when there is no AES IP
present to make it consistent with all the other IPs.

CC: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
---
 arch/arm/mach-omap2/devices.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index f5d5c89..ab8658c 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -479,20 +479,15 @@ static void __init omap_init_sham(void)
 
 static void __init omap_init_aes(void)
 {
-	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
-		struct omap_hwmod *oh;
-		struct platform_device *pdev;
-
-		oh = omap_hwmod_lookup("aes");
-		if (!oh)
-			return;
-
-		pdev = omap_device_build("omap-aes", -1, oh, NULL, 0, NULL,
-					 0, 0);
-		WARN(IS_ERR(pdev), "Can't build omap_device for omap-aes\n");
-	} else {
-		pr_err("%s: platform not supported\n", __func__);
-	}
+	struct omap_hwmod *oh;
+	struct platform_device *pdev;
+
+	oh = omap_hwmod_lookup("aes");
+	if (!oh)
+		return;
+
+	pdev = omap_device_build("omap-aes", -1, oh, NULL, 0, NULL, 0, 0);
+	WARN(IS_ERR(pdev), "Can't build omap_device for omap-aes\n");
 }
 
 /*-------------------------------------------------------------------------*/
-- 
1.7.12
