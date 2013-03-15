From: jon-hunter@ti.com (Jon Hunter)
Date: Fri, 15 Mar 2013 10:21:16 -0500
Subject: [PATCH V3 18/18] ARM: OMAP2+: return -ENODEV if GPMC child device
 creation fails
In-Reply-To: <1363360876-13617-1-git-send-email-jon-hunter@ti.com>
References: <1363360876-13617-1-git-send-email-jon-hunter@ti.com>
Message-ID: <1363360876-13617-19-git-send-email-jon-hunter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

gpmc_probe_nor_child() calls of_platform_device_create() to create a
platform device for the NOR child. If this function fails the value
of ret is returned to the caller but this value is zero since it was
assigned the return of a previous call to gpmc_cs_program_settings()
that had to succeed or otherwise gpmc_probe_nor_child() would have
returned before.

This means that if of_platform_device_create() fails, 0 will be returned
to the caller instead of an appropriate error code.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/gpmc.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index ee6601c..d4ec5bb 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -1504,6 +1504,7 @@ static int gpmc_probe_nor_child(struct platform_device *pdev,
 		return 0;
 
 	dev_err(&pdev->dev, "failed to create gpmc child %s\n", child->name);
+	ret = -ENODEV;
 
 err:
 	gpmc_cs_free(cs);
-- 
1.7.10.4
