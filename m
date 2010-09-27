From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 27 Sep 2010 15:51:00 +0200
Subject: [PATCH 24/40] ARM: mx5: add spi_imx device registration
In-Reply-To: <20100927135009.GC6271@pengutronix.de>
References: <20100927135009.GC6271@pengutronix.de>
Message-ID: <1285595476-10025-24-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Jason Wang <jason77.wang@gmail.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx5/devices-imx51.h            |    8 ++++++++
 arch/arm/plat-mxc/devices/platform-spi_imx.c |   12 ++++++++++++
 2 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/devices-imx51.h b/arch/arm/mach-mx5/devices-imx51.h
index a3cc383..09d2b5c 100644
--- a/arch/arm/mach-mx5/devices-imx51.h
+++ b/arch/arm/mach-mx5/devices-imx51.h
@@ -12,3 +12,11 @@
 extern const struct imx_imx_i2c_data imx51_imx_i2c_data[] __initconst;
 #define imx51_add_imx_i2c(id, pdata)	\
 	imx_add_imx_i2c(&imx51_imx_i2c_data[id], pdata)
+
+extern const struct imx_spi_imx_data imx51_cspi_data __initconst;
+#define imx51_add_cspi(pdata)	\
+	imx_add_spi_imx(&imx51_cspi_data, pdata)
+
+extern const struct imx_spi_imx_data imx51_ecspi_data[] __initconst;
+#define imx51_add_ecspi(id, pdata)	\
+	imx_add_spi_imx(&imx51_ecspi_data[id], pdata)
diff --git a/arch/arm/plat-mxc/devices/platform-spi_imx.c b/arch/arm/plat-mxc/devices/platform-spi_imx.c
index bd30d4b..e48340e 100644
--- a/arch/arm/plat-mxc/devices/platform-spi_imx.c
+++ b/arch/arm/plat-mxc/devices/platform-spi_imx.c
@@ -68,6 +68,18 @@ const struct imx_spi_imx_data imx35_cspi_data[] __initconst = {
 };
 #endif /* ifdef CONFIG_ARCH_MX35 */
 
+#ifdef CONFIG_ARCH_MX51
+const struct imx_spi_imx_data imx51_cspi_data __initconst =
+	imx_spi_imx_data_entry_single(MX51, CSPI, "imx51-cspi", 0, , SZ_4K);
+
+const struct imx_spi_imx_data imx51_ecspi_data[] __initconst = {
+#define imx51_ecspi_data_entry(_id, _hwid)				\
+	imx_spi_imx_data_entry(MX51, ECSPI, "imx51-ecspi", _id, _hwid, SZ_4K)
+	imx51_ecspi_data_entry(0, 1),
+	imx51_ecspi_data_entry(1, 2),
+};
+#endif /* ifdef CONFIG_ARCH_MX51 */
+
 struct platform_device *__init imx_add_spi_imx(
 		const struct imx_spi_imx_data *data,
 		const struct spi_imx_master *pdata)
-- 
1.7.2.3
