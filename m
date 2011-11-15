From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 15 Nov 2011 11:27:37 +0800
Subject: [PATCH] ARM: mmp: encode device id into {pxa168, pxa910, mmp2}_add_*()
Message-ID: <1321327657-26790-1-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use

  pxa168_add_uart1();

instead of

  pxa168_add_uart(1);

to further eliminate the parameter passing to the function, which
could be error prone, and also making the code a bit simpler and
faster.

Idea came from Russell King.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Haojian Zhuang <haojian.zhuang@marvell.com>
Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-mmp/aspenite.c            |    6 +-
 arch/arm/mach-mmp/avengers_lite.c       |    2 +-
 arch/arm/mach-mmp/brownstone.c          |   10 ++--
 arch/arm/mach-mmp/flint.c               |    4 +-
 arch/arm/mach-mmp/gplugd.c              |    6 +-
 arch/arm/mach-mmp/include/mach/mmp2.h   |   70 +++++++++++++-----------------
 arch/arm/mach-mmp/include/mach/pxa168.h |   72 +++++++++++-------------------
 arch/arm/mach-mmp/include/mach/pxa910.h |   51 ++++++++--------------
 arch/arm/mach-mmp/jasper.c              |    8 ++--
 arch/arm/mach-mmp/tavorevb.c            |    2 +-
 arch/arm/mach-mmp/teton_bga.c           |    4 +-
 arch/arm/mach-mmp/ttc_dkb.c             |    4 +-
 12 files changed, 100 insertions(+), 139 deletions(-)

diff --git a/arch/arm/mach-mmp/aspenite.c b/arch/arm/mach-mmp/aspenite.c
index 7a60bbb..bc5f139 100644
--- a/arch/arm/mach-mmp/aspenite.c
+++ b/arch/arm/mach-mmp/aspenite.c
@@ -226,9 +226,9 @@ static void __init common_init(void)
 	mfp_config(ARRAY_AND_SIZE(common_pin_config));
 
 	/* on-chip devices */
-	pxa168_add_uart(1);
-	pxa168_add_twsi(1, NULL, ARRAY_AND_SIZE(aspenite_i2c_info));
-	pxa168_add_ssp(1);
+	pxa168_add_uart1();
+	pxa168_add_twsi1(NULL, aspenite_i2c_info);
+	pxa168_add_ssp1();
 	pxa168_add_nand(&aspenite_nand_info);
 	pxa168_add_fb(&aspenite_lcd_info);
 	pxa168_add_keypad(&aspenite_keypad_info);
diff --git a/arch/arm/mach-mmp/avengers_lite.c b/arch/arm/mach-mmp/avengers_lite.c
index 39f0878..f29551b 100644
--- a/arch/arm/mach-mmp/avengers_lite.c
+++ b/arch/arm/mach-mmp/avengers_lite.c
@@ -37,7 +37,7 @@ static void __init avengers_lite_init(void)
 	mfp_config(ARRAY_AND_SIZE(avengers_lite_pin_config_V16F));
 
 	/* on-chip devices */
-	pxa168_add_uart(2);
+	pxa168_add_uart2();
 }
 
 MACHINE_START(AVENGERS_LITE, "PXA168 Avengers lite Development Platform")
diff --git a/arch/arm/mach-mmp/brownstone.c b/arch/arm/mach-mmp/brownstone.c
index 983cfb1..c81bec1 100644
--- a/arch/arm/mach-mmp/brownstone.c
+++ b/arch/arm/mach-mmp/brownstone.c
@@ -200,11 +200,11 @@ static void __init brownstone_init(void)
 	mfp_config(ARRAY_AND_SIZE(brownstone_pin_config));
 
 	/* on-chip devices */
-	mmp2_add_uart(1);
-	mmp2_add_uart(3);
-	mmp2_add_twsi(1, NULL, ARRAY_AND_SIZE(brownstone_twsi1_info));
-	mmp2_add_sdhost(0, &mmp2_sdh_platdata_mmc0); /* SD/MMC */
-	mmp2_add_sdhost(2, &mmp2_sdh_platdata_mmc2); /* eMMC */
+	mmp2_add_uart1();
+	mmp2_add_uart3();
+	mmp2_add_twsi1(NULL, brownstone_twsi1_info);
+	mmp2_add_sdhost0(&mmp2_sdh_platdata_mmc0); /* SD/MMC */
+	mmp2_add_sdhost2(&mmp2_sdh_platdata_mmc2); /* eMMC */
 	mmp2_add_asram(&mmp2_asram_platdata);
 	mmp2_add_isram(&mmp2_isram_platdata);
 
diff --git a/arch/arm/mach-mmp/flint.c b/arch/arm/mach-mmp/flint.c
index c4fd806..07feb63 100644
--- a/arch/arm/mach-mmp/flint.c
+++ b/arch/arm/mach-mmp/flint.c
@@ -108,8 +108,8 @@ static void __init flint_init(void)
 	mfp_config(ARRAY_AND_SIZE(flint_pin_config));
 
 	/* on-chip devices */
-	mmp2_add_uart(1);
-	mmp2_add_uart(2);
+	mmp2_add_uart1();
+	mmp2_add_uart2();
 
 	/* off-chip devices */
 	platform_device_register(&smc91x_device);
diff --git a/arch/arm/mach-mmp/gplugd.c b/arch/arm/mach-mmp/gplugd.c
index 4665767..5507335 100644
--- a/arch/arm/mach-mmp/gplugd.c
+++ b/arch/arm/mach-mmp/gplugd.c
@@ -181,9 +181,9 @@ static void __init gplugd_init(void)
 	select_disp_freq();
 
 	/* on-chip devices */
-	pxa168_add_uart(3);
-	pxa168_add_ssp(1);
-	pxa168_add_twsi(0, NULL, ARRAY_AND_SIZE(gplugd_i2c_board_info));
+	pxa168_add_uart3();
+	pxa168_add_ssp1();
+	pxa168_add_twsi0(NULL, gplugd_i2c_board_info);
 
 	pxa168_add_eth(&gplugd_eth_platform_data);
 }
diff --git a/arch/arm/mach-mmp/include/mach/mmp2.h b/arch/arm/mach-mmp/include/mach/mmp2.h
index 2f7b2d3..6c2782b 100644
--- a/arch/arm/mach-mmp/include/mach/mmp2.h
+++ b/arch/arm/mach-mmp/include/mach/mmp2.h
@@ -1,6 +1,7 @@
 #ifndef __ASM_MACH_MMP2_H
 #define __ASM_MACH_MMP2_H
 
+#include <linux/kernel.h>
 #include <linux/platform_data/pxa_sdhci.h>
 
 struct sys_timer;
@@ -32,62 +33,53 @@ extern struct pxa_device_desc mmp2_device_sdh3;
 extern struct pxa_device_desc mmp2_device_asram;
 extern struct pxa_device_desc mmp2_device_isram;
 
-static inline int mmp2_add_uart(int id)
+static inline int mmp2_add_uart(struct pxa_device_desc *d)
 {
-	struct pxa_device_desc *d = NULL;
-
-	switch (id) {
-	case 1: d = &mmp2_device_uart1; break;
-	case 2: d = &mmp2_device_uart2; break;
-	case 3: d = &mmp2_device_uart3; break;
-	case 4: d = &mmp2_device_uart4; break;
-	default:
-		return -EINVAL;
-	}
-
 	return pxa_register_device(d, NULL, 0);
 }
 
-static inline int mmp2_add_twsi(int id, struct i2c_pxa_platform_data *data,
-				  struct i2c_board_info *info, unsigned size)
+#define mmp2_add_uart1()	mmp2_add_uart(&mmp2_device_uart1)
+#define mmp2_add_uart2()	mmp2_add_uart(&mmp2_device_uart2)
+#define mmp2_add_uart3()	mmp2_add_uart(&mmp2_device_uart3)
+#define mmp2_add_uart4()	mmp2_add_uart(&mmp2_device_uart4)
+
+static inline int mmp2_add_twsi(struct pxa_device_desc *d, int id,
+				struct i2c_pxa_platform_data *data,
+				struct i2c_board_info *info, unsigned size)
 {
-	struct pxa_device_desc *d = NULL;
 	int ret;
 
-	switch (id) {
-	case 1: d = &mmp2_device_twsi1; break;
-	case 2: d = &mmp2_device_twsi2; break;
-	case 3: d = &mmp2_device_twsi3; break;
-	case 4: d = &mmp2_device_twsi4; break;
-	case 5: d = &mmp2_device_twsi5; break;
-	case 6: d = &mmp2_device_twsi6; break;
-	default:
-		return -EINVAL;
-	}
-
-	ret = i2c_register_board_info(id - 1, info, size);
+	ret = i2c_register_board_info(id, info, size);
 	if (ret)
 		return ret;
 
 	return pxa_register_device(d, data, sizeof(*data));
 }
 
-static inline int mmp2_add_sdhost(int id, struct sdhci_pxa_platdata *data)
+#define mmp2_add_twsi1(data, info) \
+	mmp2_add_twsi(&mmp2_device_twsi1, 0, data, info, ARRAY_SIZE(info))
+#define mmp2_add_twsi2(data, info) \
+	mmp2_add_twsi(&mmp2_device_twsi2, 1, data, info, ARRAY_SIZE(info))
+#define mmp2_add_twsi3(data, info) \
+	mmp2_add_twsi(&mmp2_device_twsi3, 2, data, info, ARRAY_SIZE(info))
+#define mmp2_add_twsi4(data, info) \
+	mmp2_add_twsi(&mmp2_device_twsi4, 3, data, info, ARRAY_SIZE(info))
+#define mmp2_add_twsi5(data, info) \
+	mmp2_add_twsi(&mmp2_device_twsi5, 4, data, info, ARRAY_SIZE(info))
+#define mmp2_add_twsi6(data, info) \
+	mmp2_add_twsi(&mmp2_device_twsi6, 5, data, info, ARRAY_SIZE(info))
+
+static inline int mmp2_add_sdhost(struct pxa_device_desc *d,
+				  struct sdhci_pxa_platdata *data)
 {
-	struct pxa_device_desc *d = NULL;
-
-	switch (id) {
-	case 0: d = &mmp2_device_sdh0; break;
-	case 1: d = &mmp2_device_sdh1; break;
-	case 2: d = &mmp2_device_sdh2; break;
-	case 3: d = &mmp2_device_sdh3; break;
-	default:
-		return -EINVAL;
-	}
-
 	return pxa_register_device(d, data, sizeof(*data));
 }
 
+#define mmp2_add_sdhost0(data)	mmp2_add_sdhost(&mmp2_device_sdh0, data)
+#define mmp2_add_sdhost1(data)	mmp2_add_sdhost(&mmp2_device_sdh1, data)
+#define mmp2_add_sdhost2(data)	mmp2_add_sdhost(&mmp2_device_sdh2, data)
+#define mmp2_add_sdhost3(data)	mmp2_add_sdhost(&mmp2_device_sdh3, data)
+
 static inline int mmp2_add_asram(struct sram_platdata *data)
 {
 	return pxa_register_device(&mmp2_device_asram, data, sizeof(*data));
diff --git a/arch/arm/mach-mmp/include/mach/pxa168.h b/arch/arm/mach-mmp/include/mach/pxa168.h
index 7fb568d..7da7147 100644
--- a/arch/arm/mach-mmp/include/mach/pxa168.h
+++ b/arch/arm/mach-mmp/include/mach/pxa168.h
@@ -1,6 +1,8 @@
 #ifndef __ASM_MACH_PXA168_H
 #define __ASM_MACH_PXA168_H
 
+#include <linux/kernel.h>
+
 struct sys_timer;
 
 extern struct sys_timer pxa168_timer;
@@ -42,35 +44,21 @@ struct pxa168_usb_pdata {
 /* pdata can be NULL */
 int __init pxa168_add_usb_host(struct pxa168_usb_pdata *pdata);
 
-static inline int pxa168_add_uart(int id)
+static inline int pxa168_add_uart(struct pxa_device_desc *d)
 {
-	struct pxa_device_desc *d = NULL;
-
-	switch (id) {
-	case 1: d = &pxa168_device_uart1; break;
-	case 2: d = &pxa168_device_uart2; break;
-	case 3: d = &pxa168_device_uart3; break;
-	}
-
-	if (d == NULL)
-		return -EINVAL;
-
 	return pxa_register_device(d, NULL, 0);
 }
 
-static inline int pxa168_add_twsi(int id, struct i2c_pxa_platform_data *data,
+#define pxa168_add_uart1()	pxa168_add_uart(&pxa168_device_uart1)
+#define pxa168_add_uart2()	pxa168_add_uart(&pxa168_device_uart2)
+#define pxa168_add_uart3()	pxa168_add_uart(&pxa168_device_uart3)
+
+static inline int pxa168_add_twsi(struct pxa_device_desc *d, int id,
+				  struct i2c_pxa_platform_data *data,
 				  struct i2c_board_info *info, unsigned size)
 {
-	struct pxa_device_desc *d = NULL;
 	int ret;
 
-	switch (id) {
-	case 0: d = &pxa168_device_twsi0; break;
-	case 1: d = &pxa168_device_twsi1; break;
-	default:
-		return -EINVAL;
-	}
-
 	ret = i2c_register_board_info(id, info, size);
 	if (ret)
 		return ret;
@@ -78,38 +66,32 @@ static inline int pxa168_add_twsi(int id, struct i2c_pxa_platform_data *data,
 	return pxa_register_device(d, data, sizeof(*data));
 }
 
-static inline int pxa168_add_pwm(int id)
-{
-	struct pxa_device_desc *d = NULL;
-
-	switch (id) {
-	case 1: d = &pxa168_device_pwm1; break;
-	case 2: d = &pxa168_device_pwm2; break;
-	case 3: d = &pxa168_device_pwm3; break;
-	case 4: d = &pxa168_device_pwm4; break;
-	default:
-		return -EINVAL;
-	}
+#define pxa168_add_twsi0(data, info) \
+	pxa168_add_twsi(&pxa168_device_twsi0, 0, data, info, ARRAY_SIZE(info))
+#define pxa168_add_twsi1(data, info) \
+	pxa168_add_twsi(&pxa168_device_twsi1, 1, data, info, ARRAY_SIZE(info))
 
+static inline int pxa168_add_pwm(struct pxa_device_desc *d)
+{
 	return pxa_register_device(d, NULL, 0);
 }
 
-static inline int pxa168_add_ssp(int id)
+#define pxa168_add_pwm1()	pxa168_add_pwm(&pxa168_device_pwm1)
+#define pxa168_add_pwm2()	pxa168_add_pwm(&pxa168_device_pwm2)
+#define pxa168_add_pwm3()	pxa168_add_pwm(&pxa168_device_pwm3)
+#define pxa168_add_pwm4()	pxa168_add_pwm(&pxa168_device_pwm4)
+
+static inline int pxa168_add_ssp(struct pxa_device_desc *d)
 {
-	struct pxa_device_desc *d = NULL;
-
-	switch (id) {
-	case 1: d = &pxa168_device_ssp1; break;
-	case 2: d = &pxa168_device_ssp2; break;
-	case 3: d = &pxa168_device_ssp3; break;
-	case 4: d = &pxa168_device_ssp4; break;
-	case 5: d = &pxa168_device_ssp5; break;
-	default:
-		return -EINVAL;
-	}
 	return pxa_register_device(d, NULL, 0);
 }
 
+#define pxa168_add_ssp1()	pxa168_add_ssp(&pxa168_device_ssp1)
+#define pxa168_add_ssp2()	pxa168_add_ssp(&pxa168_device_ssp2)
+#define pxa168_add_ssp3()	pxa168_add_ssp(&pxa168_device_ssp3)
+#define pxa168_add_ssp4()	pxa168_add_ssp(&pxa168_device_ssp4)
+#define pxa168_add_ssp5()	pxa168_add_ssp(&pxa168_device_ssp5)
+
 static inline int pxa168_add_nand(struct pxa3xx_nand_platform_data *info)
 {
 	return pxa_register_device(&pxa168_device_nand, info, sizeof(*info));
diff --git a/arch/arm/mach-mmp/include/mach/pxa910.h b/arch/arm/mach-mmp/include/mach/pxa910.h
index 91be755..a5c66f6 100644
--- a/arch/arm/mach-mmp/include/mach/pxa910.h
+++ b/arch/arm/mach-mmp/include/mach/pxa910.h
@@ -1,6 +1,8 @@
 #ifndef __ASM_MACH_PXA910_H
 #define __ASM_MACH_PXA910_H
 
+#include <linux/kernel.h>
+
 struct sys_timer;
 
 extern struct sys_timer pxa910_timer;
@@ -21,34 +23,20 @@ extern struct pxa_device_desc pxa910_device_pwm3;
 extern struct pxa_device_desc pxa910_device_pwm4;
 extern struct pxa_device_desc pxa910_device_nand;
 
-static inline int pxa910_add_uart(int id)
+static inline int pxa910_add_uart(struct pxa_device_desc *d)
 {
-	struct pxa_device_desc *d = NULL;
-
-	switch (id) {
-	case 1: d = &pxa910_device_uart1; break;
-	case 2: d = &pxa910_device_uart2; break;
-	}
-
-	if (d == NULL)
-		return -EINVAL;
-
 	return pxa_register_device(d, NULL, 0);
 }
 
-static inline int pxa910_add_twsi(int id, struct i2c_pxa_platform_data *data,
+#define pxa910_add_uart1()	pxa910_add_uart(&pxa910_device_uart1)
+#define pxa910_add_uart2()	pxa910_add_uart(&pxa910_device_uart2)
+
+static inline int pxa910_add_twsi(struct pxa_device_desc *d, int id,
+				  struct i2c_pxa_platform_data *data,
 				  struct i2c_board_info *info, unsigned size)
 {
-	struct pxa_device_desc *d = NULL;
 	int ret;
 
-	switch (id) {
-	case 0: d = &pxa910_device_twsi0; break;
-	case 1: d = &pxa910_device_twsi1; break;
-	default:
-		return -EINVAL;
-	}
-
 	ret = i2c_register_board_info(id, info, size);
 	if (ret)
 		return ret;
@@ -56,22 +44,21 @@ static inline int pxa910_add_twsi(int id, struct i2c_pxa_platform_data *data,
 	return pxa_register_device(d, data, sizeof(*data));
 }
 
-static inline int pxa910_add_pwm(int id)
-{
-	struct pxa_device_desc *d = NULL;
-
-	switch (id) {
-	case 1: d = &pxa910_device_pwm1; break;
-	case 2: d = &pxa910_device_pwm2; break;
-	case 3: d = &pxa910_device_pwm3; break;
-	case 4: d = &pxa910_device_pwm4; break;
-	default:
-		return -EINVAL;
-	}
+#define pxa910_add_twsi0(data, info) \
+	pxa910_add_twsi(&pxa910_device_twsi0, 0, data, info, ARRAY_SIZE(info))
+#define pxa910_add_twsi0(data, info) \
+	pxa910_add_twsi(&pxa910_device_twsi0, 0, data, info, ARRAY_SIZE(info))
 
+static inline int pxa910_add_pwm(struct pxa_device_desc *d)
+{
 	return pxa_register_device(d, NULL, 0);
 }
 
+#define pxa910_add_pwm1()	pxa910_add_pwm(&pxa910_device_pwm1)
+#define pxa910_add_pwm2()	pxa910_add_pwm(&pxa910_device_pwm2)
+#define pxa910_add_pwm3()	pxa910_add_pwm(&pxa910_device_pwm3)
+#define pxa910_add_pwm4()	pxa910_add_pwm(&pxa910_device_pwm4)
+
 static inline int pxa910_add_nand(struct pxa3xx_nand_platform_data *info)
 {
 	return pxa_register_device(&pxa910_device_nand, info, sizeof(*info));
diff --git a/arch/arm/mach-mmp/jasper.c b/arch/arm/mach-mmp/jasper.c
index 8bfac66..8e48ed2 100644
--- a/arch/arm/mach-mmp/jasper.c
+++ b/arch/arm/mach-mmp/jasper.c
@@ -161,10 +161,10 @@ static void __init jasper_init(void)
 	mfp_config(ARRAY_AND_SIZE(jasper_pin_config));
 
 	/* on-chip devices */
-	mmp2_add_uart(1);
-	mmp2_add_uart(3);
-	mmp2_add_twsi(1, NULL, ARRAY_AND_SIZE(jasper_twsi1_info));
-	mmp2_add_sdhost(0, &mmp2_sdh_platdata_mmc0); /* SD/MMC */
+	mmp2_add_uart1();
+	mmp2_add_uart3();
+	mmp2_add_twsi1(NULL, jasper_twsi1_info);
+	mmp2_add_sdhost0(&mmp2_sdh_platdata_mmc0); /* SD/MMC */
 
 	regulator_has_full_constraints();
 }
diff --git a/arch/arm/mach-mmp/tavorevb.c b/arch/arm/mach-mmp/tavorevb.c
index eb5be87..5cdced9 100644
--- a/arch/arm/mach-mmp/tavorevb.c
+++ b/arch/arm/mach-mmp/tavorevb.c
@@ -92,7 +92,7 @@ static void __init tavorevb_init(void)
 	mfp_config(ARRAY_AND_SIZE(tavorevb_pin_config));
 
 	/* on-chip devices */
-	pxa910_add_uart(1);
+	pxa910_add_uart1();
 
 	/* off-chip devices */
 	platform_device_register(&smc91x_device);
diff --git a/arch/arm/mach-mmp/teton_bga.c b/arch/arm/mach-mmp/teton_bga.c
index bbe4727..0066634 100644
--- a/arch/arm/mach-mmp/teton_bga.c
+++ b/arch/arm/mach-mmp/teton_bga.c
@@ -75,9 +75,9 @@ static void __init teton_bga_init(void)
 	mfp_config(ARRAY_AND_SIZE(teton_bga_pin_config));
 
 	/* on-chip devices */
-	pxa168_add_uart(1);
+	pxa168_add_uart1();
 	pxa168_add_keypad(&teton_bga_keypad_info);
-	pxa168_add_twsi(0, NULL, ARRAY_AND_SIZE(teton_bga_i2c_info));
+	pxa168_add_twsi0(NULL, teton_bga_i2c_info);
 }
 
 MACHINE_START(TETON_BGA, "PXA168-based Teton BGA Development Platform")
diff --git a/arch/arm/mach-mmp/ttc_dkb.c b/arch/arm/mach-mmp/ttc_dkb.c
index 176515a..e5e073a 100644
--- a/arch/arm/mach-mmp/ttc_dkb.c
+++ b/arch/arm/mach-mmp/ttc_dkb.c
@@ -146,10 +146,10 @@ static void __init ttc_dkb_init(void)
 	mfp_config(ARRAY_AND_SIZE(ttc_dkb_pin_config));
 
 	/* on-chip devices */
-	pxa910_add_uart(1);
+	pxa910_add_uart1();
 
 	/* off-chip devices */
-	pxa910_add_twsi(0, NULL, ARRAY_AND_SIZE(ttc_dkb_i2c_info));
+	pxa910_add_twsi0(NULL, ttc_dkb_i2c_info);
 	platform_add_devices(ARRAY_AND_SIZE(ttc_dkb_devices));
 }
 
-- 
1.7.5.4
