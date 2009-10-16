From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri, 16 Oct 2009 12:09:20 -0700
Subject: [PATCH 16/46] davinci: Add MMC/SD support for DA830/OMAP-L137 EVM
In-Reply-To: <1255720190-7452-17-git-send-email-khilman@deeprootsystems.com>
References: <1255720190-7452-1-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-2-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-3-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-4-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-5-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-6-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-7-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-8-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-9-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-10-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-11-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-12-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-13-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-14-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-15-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-16-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-17-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1255720190-7452-18-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David A. Griego <dgriego@mvista.com>

Add pinmux settings, etc. to enable the MMC/SC hardware.

Signed-off-by: David A. Griego <dgriego@mvista.com>
Signed-off-by: Mark A. Greer <mgreer@mvista.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/board-da830-evm.c |   43 +++++++++++++++++++++++++++++++
 1 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index 39711c1..69a791a 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -23,6 +23,7 @@
 #include <mach/irqs.h>
 #include <mach/cp_intc.h>
 #include <mach/mux.h>
+#include <mach/gpio.h>
 #include <mach/da8xx.h>
 #include <mach/asp.h>
 
@@ -83,6 +84,38 @@ static struct snd_platform_data da830_evm_snd_data = {
 	.rxnumevt	= 1,
 };
 
+/*
+ * GPIO2[1] is used as MMC_SD_WP and GPIO2[2] as MMC_SD_INS.
+ */
+static const short da830_evm_mmc_sd_pins[] = {
+	DA830_MMCSD_DAT_0, DA830_MMCSD_DAT_1, DA830_MMCSD_DAT_2,
+	DA830_MMCSD_DAT_3, DA830_MMCSD_DAT_4, DA830_MMCSD_DAT_5,
+	DA830_MMCSD_DAT_6, DA830_MMCSD_DAT_7, DA830_MMCSD_CLK,
+	DA830_MMCSD_CMD,   DA830_GPIO2_1,     DA830_GPIO2_2,
+	-1
+};
+
+static int da830_evm_mmc_get_ro(int index)
+{
+	int val, status, gpio_num = 33;
+
+	status = gpio_request(gpio_num, "MMC WP\n");
+	if (status < 0) {
+		pr_warning("%s can not open GPIO %d\n", __func__, gpio_num);
+		return 0;
+	}
+	gpio_direction_input(gpio_num);
+	val = gpio_get_value(gpio_num);
+	gpio_free(gpio_num);
+	return val;
+}
+
+static struct davinci_mmc_config da830_evm_mmc_config = {
+	.get_ro			= da830_evm_mmc_get_ro,
+	.wires			= 4,
+	.version		= MMC_CTLR_VERSION_2,
+};
+
 static __init void da830_evm_init(void)
 {
 	struct davinci_soc_info *soc_info = &davinci_soc_info;
@@ -132,6 +165,16 @@ static __init void da830_evm_init(void)
 				ret);
 
 	da8xx_register_mcasp(1, &da830_evm_snd_data);
+
+	ret = da8xx_pinmux_setup(da830_evm_mmc_sd_pins);
+	if (ret)
+		pr_warning("da830_evm_init: mmc/sd mux setup failed: %d\n",
+				ret);
+
+	ret = da8xx_register_mmcsd0(&da830_evm_mmc_config);
+	if (ret)
+		pr_warning("da830_evm_init: mmc/sd registration failed: %d\n",
+				ret);
 }
 
 #ifdef CONFIG_SERIAL_8250_CONSOLE
-- 
1.6.4.3
