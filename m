From: viresh.kumar@st.com (Viresh Kumar)
Date: Mon, 30 May 2011 12:09:41 +0530
Subject: [PATCH 2/3] SPEAr: Add machine support for plgpio
In-Reply-To: <cover.1306737135.git.viresh.kumar@st.com>
References: <cover.1306737135.git.viresh.kumar@st.com>
Message-ID: <d4e5a460ec52c7edd6b7a96da6e163120edd8d79.1306737135.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds machine support for plgpio on SPEAr310 & SPEAr320.
Also it defines macro's for gpio lines for both SPEAr3xx & 6xx.

Reviewed-by: Stanley Miao <stanley.miao@windriver.com>
Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/mach-spear3xx/include/mach/generic.h |    2 +
 arch/arm/mach-spear3xx/include/mach/gpio.h    |  143 +++++++++++++++++++++++++
 arch/arm/mach-spear3xx/spear310.c             |   80 ++++++++++++++-
 arch/arm/mach-spear3xx/spear310_evb.c         |    1 +
 arch/arm/mach-spear3xx/spear320.c             |   40 +++++++-
 arch/arm/mach-spear3xx/spear320_evb.c         |    1 +
 arch/arm/mach-spear6xx/include/mach/gpio.h    |   27 +++++
 7 files changed, 292 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-spear3xx/include/mach/generic.h b/arch/arm/mach-spear3xx/include/mach/generic.h
index b8f31c3..8cc3a73 100644
--- a/arch/arm/mach-spear3xx/include/mach/generic.h
+++ b/arch/arm/mach-spear3xx/include/mach/generic.h
@@ -140,6 +140,7 @@ void __init spear300_init(struct pmx_mode *pmx_mode, struct pmx_dev **pmx_devs,
 /* spear310 declarations */
 #ifdef CONFIG_MACH_SPEAR310
 /* Add spear310 machine device structure declarations here */
+extern struct platform_device spear310_plgpio_device;
 
 /* pad mux devices */
 extern struct pmx_dev spear310_pmx_emi_cs_0_1_4_5;
@@ -160,6 +161,7 @@ void __init spear310_init(struct pmx_mode *pmx_mode, struct pmx_dev **pmx_devs,
 /* spear320 declarations */
 #ifdef CONFIG_MACH_SPEAR320
 /* Add spear320 machine device structure declarations here */
+extern struct platform_device spear320_plgpio_device;
 
 /* pad mux modes */
 extern struct pmx_mode spear320_auto_net_smii_mode;
diff --git a/arch/arm/mach-spear3xx/include/mach/gpio.h b/arch/arm/mach-spear3xx/include/mach/gpio.h
index 451b208..70d0e61 100644
--- a/arch/arm/mach-spear3xx/include/mach/gpio.h
+++ b/arch/arm/mach-spear3xx/include/mach/gpio.h
@@ -16,4 +16,147 @@
 
 #include <plat/gpio.h>
 
+#ifdef CONFIG_MACH_SPEAR310
+#define SPEAR310_PLGPIO_ENB_OFF		0x0010
+#define SPEAR310_PLGPIO_WDATA_OFF	0x0020
+#define SPEAR310_PLGPIO_DIR_OFF		0x0030
+#define SPEAR310_PLGPIO_RDATA_OFF	0x0040
+#define SPEAR310_PLGPIO_IE_OFF		0x0050
+#define SPEAR310_PLGPIO_MIS_OFF		0x0060
+#endif
+
+#if defined(CONFIG_MACH_SPEAR320)
+#define SPEAR320_PLGPIO_ENB_OFF		0x0024
+#define SPEAR320_PLGPIO_WDATA_OFF	0x0034
+#define SPEAR320_PLGPIO_DIR_OFF		0x0044
+#define SPEAR320_PLGPIO_IE_OFF		0x0064
+#define SPEAR320_PLGPIO_RDATA_OFF	0x0054
+#define SPEAR320_PLGPIO_MIS_OFF		0x0074
+#endif
+
+#define BASIC_GPIO_0		0
+#define BASIC_GPIO_1		1
+#define BASIC_GPIO_2		2
+#define BASIC_GPIO_3		3
+#define BASIC_GPIO_4		4
+#define BASIC_GPIO_5		5
+#define BASIC_GPIO_6		6
+#define BASIC_GPIO_7		7
+
+#ifdef CONFIG_MACH_SPEAR300
+#define RAS_GPIO_0		8
+#define RAS_GPIO_1		9
+#define RAS_GPIO_2		10
+#define RAS_GPIO_3		11
+#define RAS_GPIO_4		12
+#define RAS_GPIO_5		13
+#define RAS_GPIO_6		14
+#define RAS_GPIO_7		15
+#endif /* CONFIG_MACH_SPEAR300 */
+
+#if defined(CONFIG_MACH_SPEAR310) || defined(CONFIG_MACH_SPEAR320)
+#define PLGPIO_0		8
+#define PLGPIO_1		9
+#define PLGPIO_2		10
+#define PLGPIO_3		11
+#define PLGPIO_4		12
+#define PLGPIO_5		13
+#define PLGPIO_6		14
+#define PLGPIO_7		15
+#define PLGPIO_8		16
+#define PLGPIO_9		17
+#define PLGPIO_10		18
+#define PLGPIO_11		19
+#define PLGPIO_12		20
+#define PLGPIO_13		21
+#define PLGPIO_14		22
+#define PLGPIO_15		23
+#define PLGPIO_16		24
+#define PLGPIO_17		25
+#define PLGPIO_18		26
+#define PLGPIO_19		27
+#define PLGPIO_20		28
+#define PLGPIO_21		29
+#define PLGPIO_22		30
+#define PLGPIO_23		31
+#define PLGPIO_24		32
+#define PLGPIO_25		33
+#define PLGPIO_26		34
+#define PLGPIO_27		35
+#define PLGPIO_28		36
+#define PLGPIO_29		37
+#define PLGPIO_30		38
+#define PLGPIO_31		39
+#define PLGPIO_32		40
+#define PLGPIO_33		41
+#define PLGPIO_34		42
+#define PLGPIO_35		43
+#define PLGPIO_36		44
+#define PLGPIO_37		45
+#define PLGPIO_38		46
+#define PLGPIO_39		47
+#define PLGPIO_40		48
+#define PLGPIO_41		49
+#define PLGPIO_42		50
+#define PLGPIO_43		51
+#define PLGPIO_44		52
+#define PLGPIO_45		53
+#define PLGPIO_46		54
+#define PLGPIO_47		55
+#define PLGPIO_48		56
+#define PLGPIO_49		57
+#define PLGPIO_50		58
+#define PLGPIO_51		59
+#define PLGPIO_52		60
+#define PLGPIO_53		61
+#define PLGPIO_54		62
+#define PLGPIO_55		63
+#define PLGPIO_56		64
+#define PLGPIO_57		65
+#define PLGPIO_58		66
+#define PLGPIO_59		67
+#define PLGPIO_60		68
+#define PLGPIO_61		69
+#define PLGPIO_62		70
+#define PLGPIO_63		71
+#define PLGPIO_64		72
+#define PLGPIO_65		73
+#define PLGPIO_66		74
+#define PLGPIO_67		75
+#define PLGPIO_68		76
+#define PLGPIO_69		77
+#define PLGPIO_70		78
+#define PLGPIO_71		79
+#define PLGPIO_72		80
+#define PLGPIO_73		81
+#define PLGPIO_74		82
+#define PLGPIO_75		83
+#define PLGPIO_76		84
+#define PLGPIO_77		85
+#define PLGPIO_78		86
+#define PLGPIO_79		87
+#define PLGPIO_80		88
+#define PLGPIO_81		89
+#define PLGPIO_82		90
+#define PLGPIO_83		91
+#define PLGPIO_84		92
+#define PLGPIO_85		93
+#define PLGPIO_86		94
+#define PLGPIO_87		95
+#define PLGPIO_88		96
+#define PLGPIO_89		97
+#define PLGPIO_90		98
+#define PLGPIO_91		99
+#define PLGPIO_92		100
+#define PLGPIO_93		101
+#define PLGPIO_94		102
+#define PLGPIO_95		103
+#define PLGPIO_96		104
+#define PLGPIO_97		105
+#define PLGPIO_98		106
+#define PLGPIO_99		107
+#define PLGPIO_100		108
+#define PLGPIO_101		109
+#endif /* CONFIG_MACH_SPEAR310 || CONFIG_MACH_SPEAR320 */
+
 #endif /* __MACH_GPIO_H */
diff --git a/arch/arm/mach-spear3xx/spear310.c b/arch/arm/mach-spear3xx/spear310.c
index 9004cf9..a49be3b 100644
--- a/arch/arm/mach-spear3xx/spear310.c
+++ b/arch/arm/mach-spear3xx/spear310.c
@@ -11,10 +11,12 @@
  * warranty of any kind, whether express or implied.
  */
 
+#include <linux/irq.h>
 #include <linux/ptrace.h>
-#include <asm/irq.h>
+#include <linux/spear-plgpio.h>
 #include <plat/shirq.h>
 #include <mach/generic.h>
+#include <mach/gpio.h>
 #include <mach/hardware.h>
 
 /* pad multiplexing support */
@@ -256,6 +258,82 @@ static struct spear_shirq shirq_intrcomm_ras = {
 };
 
 /* Add spear310 specific devices here */
+/* plgpio device registeration */
+/*
+ * pin to offset and offset to pin converter functions
+ *
+ * In spear310 there is inconsistency among bit positions in plgpio regiseters,
+ * for different plgpio pins. For example: for pin 27, bit offset is 23, pin
+ * 28-33 are not supported, pin 95 has offset bit 95, bit 100 has offset bit 1
+ */
+static int spear300_p2o(int pin)
+{
+	int offset = pin;
+
+	if (pin <= 27)
+		offset += 4;
+	else if (pin <= 33)
+		offset = -1;
+	else if (pin <= 97)
+		offset -= 2;
+	else if (pin <= 101)
+		offset = 101 - pin;
+	else
+		offset = -1;
+
+	return offset;
+}
+
+int spear300_o2p(int offset)
+{
+	if (offset <= 3)
+		return 101 - offset;
+	else if (offset <= 31)
+		return offset - 4;
+	else
+		return offset + 2;
+}
+
+static struct spear_plgpio_pdata plgpio_pdata = {
+	.gpio_base = 8,
+	.irq_base = SPEAR3XX_PLGPIO_INT_BASE,
+	.gpio_count = SPEAR3XX_PLGPIO_COUNT,
+	.p2o = spear300_p2o,
+	.o2p = spear300_o2p,
+	/* list of registers with inconsistency */
+	.p2o_regs = PTO_RDATA_REG | PTO_WDATA_REG | PTO_DIR_REG |
+		PTO_IE_REG | PTO_RDATA_REG | PTO_MIS_REG,
+	.regs = {
+		.enb = SPEAR310_PLGPIO_ENB_OFF,
+		.wdata = SPEAR310_PLGPIO_WDATA_OFF,
+		.dir = SPEAR310_PLGPIO_DIR_OFF,
+		.ie = SPEAR310_PLGPIO_IE_OFF,
+		.rdata = SPEAR310_PLGPIO_RDATA_OFF,
+		.mis = SPEAR310_PLGPIO_MIS_OFF,
+	},
+	.irq_trigger_type = IRQ_TYPE_LEVEL_HIGH,
+};
+
+static struct resource plgpio_resources[] = {
+	{
+		.start = SPEAR310_SOC_CONFIG_BASE,
+		.end = SPEAR310_SOC_CONFIG_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	}, {
+		.start = SPEAR310_VIRQ_PLGPIO,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device spear310_plgpio_device = {
+	.name = "spear-plgpio",
+	.id = -1,
+	.dev = {
+		.platform_data = &plgpio_pdata,
+	},
+	.num_resources = ARRAY_SIZE(plgpio_resources),
+	.resource = plgpio_resources,
+};
 
 /* spear310 routines */
 void __init spear310_init(struct pmx_mode *pmx_mode, struct pmx_dev **pmx_devs,
diff --git a/arch/arm/mach-spear3xx/spear310_evb.c b/arch/arm/mach-spear3xx/spear310_evb.c
index c8684ce..f6832c4 100644
--- a/arch/arm/mach-spear3xx/spear310_evb.c
+++ b/arch/arm/mach-spear3xx/spear310_evb.c
@@ -52,6 +52,7 @@ static struct platform_device *plat_devs[] __initdata = {
 	/* spear3xx specific devices */
 
 	/* spear310 specific devices */
+	&spear310_plgpio_device,
 };
 
 static void __init spear310_evb_init(void)
diff --git a/arch/arm/mach-spear3xx/spear320.c b/arch/arm/mach-spear3xx/spear320.c
index ee29bef..575493a 100644
--- a/arch/arm/mach-spear3xx/spear320.c
+++ b/arch/arm/mach-spear3xx/spear320.c
@@ -11,10 +11,12 @@
  * warranty of any kind, whether express or implied.
  */
 
+#include <linux/irq.h>
 #include <linux/ptrace.h>
-#include <asm/irq.h>
+#include <linux/spear-plgpio.h>
 #include <plat/shirq.h>
 #include <mach/generic.h>
+#include <mach/gpio.h>
 #include <mach/hardware.h>
 
 /* pad multiplexing support */
@@ -509,6 +511,42 @@ static struct spear_shirq shirq_intrcomm_ras = {
 };
 
 /* Add spear320 specific devices here */
+/* plgpio device registeration */
+static struct spear_plgpio_pdata plgpio_pdata = {
+	.gpio_base = 8,
+	.irq_base = SPEAR3XX_PLGPIO_INT_BASE,
+	.gpio_count = SPEAR3XX_PLGPIO_COUNT,
+	.regs = {
+		.enb = SPEAR320_PLGPIO_ENB_OFF,
+		.wdata = SPEAR320_PLGPIO_WDATA_OFF,
+		.dir = SPEAR320_PLGPIO_DIR_OFF,
+		.ie = SPEAR320_PLGPIO_IE_OFF,
+		.rdata = SPEAR320_PLGPIO_RDATA_OFF,
+		.mis = SPEAR320_PLGPIO_MIS_OFF,
+	},
+	.irq_trigger_type = IRQ_TYPE_LEVEL_HIGH,
+};
+
+static struct resource plgpio_resources[] = {
+	{
+		.start = SPEAR320_SOC_CONFIG_BASE,
+		.end = SPEAR320_SOC_CONFIG_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	}, {
+		.start = SPEAR320_VIRQ_PLGPIO,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device spear320_plgpio_device = {
+	.name = "spear-plgpio",
+	.id = -1,
+	.dev = {
+		.platform_data = &plgpio_pdata,
+	},
+	.num_resources = ARRAY_SIZE(plgpio_resources),
+	.resource = plgpio_resources,
+};
 
 /* spear320 routines */
 void __init spear320_init(struct pmx_mode *pmx_mode, struct pmx_dev **pmx_devs,
diff --git a/arch/arm/mach-spear3xx/spear320_evb.c b/arch/arm/mach-spear3xx/spear320_evb.c
index a12b353..4d747db 100644
--- a/arch/arm/mach-spear3xx/spear320_evb.c
+++ b/arch/arm/mach-spear3xx/spear320_evb.c
@@ -49,6 +49,7 @@ static struct platform_device *plat_devs[] __initdata = {
 	/* spear3xx specific devices */
 
 	/* spear320 specific devices */
+	&spear320_plgpio_device,
 };
 
 static void __init spear320_evb_init(void)
diff --git a/arch/arm/mach-spear6xx/include/mach/gpio.h b/arch/arm/mach-spear6xx/include/mach/gpio.h
index 3a789db..465b2e7 100644
--- a/arch/arm/mach-spear6xx/include/mach/gpio.h
+++ b/arch/arm/mach-spear6xx/include/mach/gpio.h
@@ -16,4 +16,31 @@
 
 #include <plat/gpio.h>
 
+#define CPU_GPIO_0		0
+#define CPU_GPIO_1		1
+#define CPU_GPIO_2		2
+#define CPU_GPIO_3		3
+#define CPU_GPIO_4		4
+#define CPU_GPIO_5		5
+#define CPU_GPIO_6		6
+#define CPU_GPIO_7		7
+
+#define BASIC_GPIO_0		8
+#define BASIC_GPIO_1		9
+#define BASIC_GPIO_2		10
+#define BASIC_GPIO_3		11
+#define BASIC_GPIO_4		12
+#define BASIC_GPIO_5		13
+#define BASIC_GPIO_6		14
+#define BASIC_GPIO_7		15
+
+#define APPL_GPIO_0		16
+#define APPL_GPIO_1		17
+#define APPL_GPIO_2		18
+#define APPL_GPIO_3		19
+#define APPL_GPIO_4		20
+#define APPL_GPIO_5		21
+#define APPL_GPIO_6		22
+#define APPL_GPIO_7		23
+
 #endif /* __MACH_GPIO_H */
-- 
1.7.2.2
