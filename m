From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 23 Feb 2010 11:05:11 +0000
Subject: [PATCH] mx31ads: Configure SSI5 pins in IOMUX for PMIC module audio
	support
Message-ID: <1266923111-16575-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SSI5 on the CPU is connected to the PMIC module to provide audio support
so unconditionally configure the relevant pins on the CPU to route out
the signals.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-mx3/mach-mx31ads.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-mx31ads.c b/arch/arm/mach-mx3/mach-mx31ads.c
index e5423f8..e402e0d 100644
--- a/arch/arm/mach-mx3/mach-mx31ads.c
+++ b/arch/arm/mach-mx3/mach-mx31ads.c
@@ -490,6 +490,19 @@ static void mxc_init_i2c(void)
 }
 #endif
 
+static unsigned int ssi_pins[] = {
+	MX31_PIN_SFS5__SFS5,
+	MX31_PIN_SCK5__SCK5,
+	MX31_PIN_SRXD5__SRXD5,
+	MX31_PIN_STXD5__STXD5,
+};
+
+static void mxc_init_audio(void)
+{
+	mxc_register_device(&imx_ssi_device0, NULL);
+	mxc_iomux_setup_multiple_pins(ssi_pins, ARRAY_SIZE(ssi_pins), "ssi");
+}
+
 /*!
  * This structure defines static mappings for the i.MX31ADS board.
  */
@@ -525,6 +538,7 @@ static void __init mxc_board_init(void)
 	mxc_init_extuart();
 	mxc_init_imx_uart();
 	mxc_init_i2c();
+	mxc_init_audio();
 }
 
 static void __init mx31ads_timer_init(void)
-- 
1.7.0
