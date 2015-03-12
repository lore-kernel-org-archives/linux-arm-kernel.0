From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 12 Mar 2015 10:06:27 +0200
Subject: [RESEND 3/7] ARM: davinci: devices-da8xx: Clean up and correct the
 McASP device creation
In-Reply-To: <1426147591-31764-1-git-send-email-peter.ujfalusi@ti.com>
References: <1426147591-31764-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1426147591-31764-4-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both DA830 and DA850 has McASP0 module, so do not restrict the use of
McASP0 for da850 only.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-davinci/devices-da8xx.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index e15e046c5438..fdc3219ba684 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -526,14 +526,25 @@ static struct platform_device da850_mcasp_device = {
 
 void __init da8xx_register_mcasp(int id, struct snd_platform_data *pdata)
 {
-	/* DA830/OMAP-L137 has 3 instances of McASP */
-	if (cpu_is_davinci_da830() && id == 1) {
-		da830_mcasp1_device.dev.platform_data = pdata;
-		platform_device_register(&da830_mcasp1_device);
-	} else if (cpu_is_davinci_da850()) {
-		da850_mcasp_device.dev.platform_data = pdata;
-		platform_device_register(&da850_mcasp_device);
+	struct platform_device *pdev;
+
+	switch (id) {
+	case 0:
+		/* Valid for DA830/OMAP-L137 or DA850/OMAP-L138 */
+		pdev = &da850_mcasp_device;
+		break;
+	case 1:
+		/* Valid for DA830/OMAP-L137 only */
+		if (!cpu_is_davinci_da830())
+			return;
+		pdev = &da830_mcasp1_device;
+		break;
+	default:
+		return;
 	}
+
+	pdev->dev.platform_data = pdata;
+	platform_device_register(pdev);
 }
 
 static struct resource da8xx_pruss_resources[] = {
-- 
2.3.0
