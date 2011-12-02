From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri,  2 Dec 2011 11:52:59 +0200
Subject: [PATCH 4/5] OMAP4: devices: Do not create mcpdm device if the dtb has
 been provided
In-Reply-To: <1322819580-7424-1-git-send-email-peter.ujfalusi@ti.com>
References: <1322819580-7424-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1322819580-7424-5-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If dtb is provided of will create the needed devices dynamically so there
is no need to create the platform device for McPDM here.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/devices.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index d7ca473..469f875 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -323,6 +323,10 @@ static void omap_init_mcpdm(void)
 	struct omap_hwmod *oh;
 	struct platform_device *pdev;
 
+	/* If dtb is there, the devices will be created dynamically */
+	if (of_have_populated_dt())
+		return;
+
 	oh = omap_hwmod_lookup("mcpdm");
 	if (!oh) {
 		printk(KERN_ERR "Could not look up mcpdm hw_mod\n");
-- 
1.7.8.rc4
