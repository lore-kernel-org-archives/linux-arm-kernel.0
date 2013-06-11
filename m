From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 11 Jun 2013 10:32:00 +0200
Subject: [PATCH 3/3] ARM: OMAP2+: devices: Do not print error when dss_hdmi
 hwmod lookup fails
In-Reply-To: <1370939520-16132-1-git-send-email-peter.ujfalusi@ti.com>
References: <1370939520-16132-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1370939520-16132-4-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dss_hdmi hwmod is used to create the HDMI audio device for OMAP4+
When we boot the kernel we can silently ignore the failure since the IP
does not exist on them.

Reported-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/devices.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 8f268b4..daa0ff6 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -417,10 +417,8 @@ static void __init omap_init_hdmi_audio(void)
 	struct platform_device *pdev;
 
 	oh = omap_hwmod_lookup("dss_hdmi");
-	if (!oh) {
-		printk(KERN_ERR "Could not look up dss_hdmi hw_mod\n");
+	if (!oh)
 		return;
-	}
 
 	pdev = omap_device_build("omap-hdmi-audio-dai", -1, oh, NULL, 0);
 	WARN(IS_ERR(pdev),
-- 
1.8.2.1
