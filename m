From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Tue, 22 Oct 2013 15:41:06 +0530
Subject: [PATCH v2 5/7] exynos/drm: fix ddc i2c device probe failure
In-Reply-To: <1382436668-15813-1-git-send-email-rahul.sharma@samsung.com>
References: <1382436668-15813-1-git-send-email-rahul.sharma@samsung.com>
Message-ID: <1382436668-15813-6-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Exynos hdmi ddc is a I2C device and if we register hdmi ddc
driver with id_table as NULL, cause failure in probing.

id_table field should not be NULL for i2c_driver registeration.

Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_ddc.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/exynos/exynos_ddc.c b/drivers/gpu/drm/exynos/exynos_ddc.c
index 6a8c84e..54ead55 100644
--- a/drivers/gpu/drm/exynos/exynos_ddc.c
+++ b/drivers/gpu/drm/exynos/exynos_ddc.c
@@ -51,12 +51,17 @@ static struct of_device_id hdmiddc_match_types[] = {
 	}
 };
 
+static struct i2c_device_id ddc_idtable[] = {
+	{ },
+};
+
 struct i2c_driver ddc_driver = {
 	.driver = {
 		.name = "exynos-hdmiddc",
 		.owner = THIS_MODULE,
 		.of_match_table = hdmiddc_match_types,
 	},
+	.id_table	= ddc_idtable,
 	.probe		= s5p_ddc_probe,
 	.remove		= s5p_ddc_remove,
 	.command		= NULL,
-- 
1.7.10.4
