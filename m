From: thiago.correa@gmail.com (=?ISO-8859-1?Q?Thiago_A=2E_Corr=EAa?=)
Date: Thu, 9 Jun 2011 23:55:25 -0300
Subject: LAN9221 with Samsumg S3C2416
Message-ID: <BANLkTimQTxzxaOHnMqf7zaRwZD5GhecTKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

    I'm using the mini2416 [1] and it has a SMC LAN9221 chip
connected to CS2 that I'm trying to use with mainline kernel. I'm
patching the kernel, using their very old kernel as reference, but so
far I haven't been able to get the kernel to detect the chip. It looks
like it won't even probe for it. Could someone give me some advice?
Please take a look at my patch below.

[1] http://www.armdesigner.com/MINI2416.html

diff -Naur linux-2.6.38-orig//arch/arm/mach-s3c2416/mach-smdk2416.c
linux-2.6.38/arch/arm/mach-s3c2416/mach-smdk2416.c
--- linux-2.6.38-orig//arch/arm/mach-s3c2416/mach-smdk2416.c    2011-03-14
22:20:32.000000000 -0300
+++ linux-2.6.38/arch/arm/mach-s3c2416/mach-smdk2416.c  2011-06-09
18:32:10.000000000 -0300
@@ -35,6 +35,7 @@
 #include <plat/regs-serial.h>
 #include <mach/regs-gpio.h>
 #include <mach/regs-lcd.h>
+#include <mach/regs-mem.h>

 #include <mach/idle.h>
 #include <mach/leds-gpio.h>
@@ -53,9 +54,11 @@

 #include <plat/common-smdk.h>

+#define S3C_PA_SMC9115 (0x08000000)
+
 static struct map_desc smdk2416_iodesc[] __initdata = {
       /* ISA IO Space map (memory space selected by A24) */
-
+/*
       {
               .virtual        = (u32)S3C24XX_VA_ISA_WORD,
               .pfn            = __phys_to_pfn(S3C2410_CS2),
@@ -76,7 +79,7 @@
               .pfn            = __phys_to_pfn(S3C2410_CS2 + (1<<24)),
               .length         = SZ_4M,
               .type           = MT_DEVICE,
-       }
+       } */
 };

 #define UCON (S3C2410_UCON_DEFAULT     | \
@@ -179,6 +182,26 @@
       .cd_type                = S3C_SDHCI_CD_NONE,
 };

+static struct resource s3c_smc911x_resources[] = {
+       [0] = {
+               .start  = S3C_PA_SMC9115,
+               .end    = S3C_PA_SMC9115 + 0x1fffffff,
+               .flags  = IORESOURCE_MEM,
+       },
+       [1] = {
+               .start  = IRQ_EINT4,
+               .end    = IRQ_EINT4,
+               .flags  = IORESOURCE_IRQ,
+       },
+};
+
+static struct platform_device s3c_device_smc911x = {
+       .name           = "smc911x",
+       .id             = -1,
+       .num_resources  = ARRAY_SIZE(s3c_smc911x_resources),
+       .resource       = s3c_smc911x_resources,
+};
+
 static struct platform_device *smdk2416_devices[] __initdata = {
       &s3c_device_fb,
       &s3c_device_wdt,
@@ -186,6 +209,7 @@
       &s3c_device_i2c0,
       &s3c_device_hsmmc0,
       &s3c_device_hsmmc1,
+       &s3c_device_smc911x,
 };

 static void __init smdk2416_map_io(void)
@@ -195,8 +219,58 @@
       s3c24xx_init_uarts(smdk2416_uartcfgs, ARRAY_SIZE(smdk2416_uartcfgs));
 }

+static void smdk2416_cx89x0_set(void)
+{
+       u32 val;
+
+       val = readl(S3C_BANK_CFG);
+       val &= ~(1<<8)|(1<<9)|(1<<10);
+       writel(val, S3C_BANK_CFG);
+
+       /* Bank1 Idle cycle ctrl. */
+       writel(0xf, S3C_SSMC_SMBIDCYR1);
+
+       /* Bank1 Read Wait State cont. = 14 clk          Tacc? */
+       writel(12, S3C_SSMC_SMBWSTRDR1);
+
+       /* Bank1 Write Wait State ctrl. */
+       writel(12, S3C_SSMC_SMBWSTWRR1);
+
+       /* Bank1 Output Enable Assertion Delay ctrl.     Tcho? */
+       writel(2, S3C_SSMC_SMBWSTOENR1);
+
+       /* Bank1 Write Enable Assertion Delay ctrl. */
+       writel(2, S3C_SSMC_SMBWSTWENR1);
+
+       /* SMWAIT active High, Read Byte Lane Enabl      WS1? */
+       val = readl(S3C_SSMC_SMBCR1);
+
+       val |=  ((1<<15)|(1<<7));
+       writel(val, S3C_SSMC_SMBCR1);
+
+       val = readl(S3C_SSMC_SMBCR1);
+       val |=  ((1<<2)|(1<<0));
+       writel(val, S3C_SSMC_SMBCR1);
+
+       val = readl(S3C_SSMC_SMBCR1);
+       val &= ~((3<<20)|(3<<12));
+       writel(val, S3C_SSMC_SMBCR1);
+
+       val = readl(S3C_SSMC_SMBCR1);
+       val &= ~(3<<4);
+       writel(val, S3C_SSMC_SMBCR1);
+
+       val = readl(S3C_SSMC_SMBCR1);
+       val |= (1<<4);
+
+       writel(val, S3C_SSMC_SMBCR1);
+
+}
+
 static void __init smdk2416_machine_init(void)
 {
+       smdk2416_cx89x0_set();
+
       s3c_i2c0_set_platdata(NULL);
       s3c_fb_set_platdata(&smdk2416_fb_platdata);

diff -Naur linux-2.6.38-orig//arch/arm/mach-s3c2416/s3c2416.c
linux-2.6.38/arch/arm/mach-s3c2416/s3c2416.c
--- linux-2.6.38-orig//arch/arm/mach-s3c2416/s3c2416.c  2011-03-14
22:20:32.000000000 -0300
+++ linux-2.6.38/arch/arm/mach-s3c2416/s3c2416.c        2011-06-01
21:59:50.000000000 -0300
@@ -63,6 +63,8 @@
       IODESC_ENT(WATCHDOG),
       IODESC_ENT(CLKPWR),
       IODESC_ENT(TIMER),
+       IODESC_ENT(EBI),
+       IODESC_ENT(SROMC),
 };

 struct sysdev_class s3c2416_sysclass = {
diff -Naur linux-2.6.38-orig//arch/arm/plat-s3c24xx/devs.c
linux-2.6.38/arch/arm/plat-s3c24xx/devs.c
--- linux-2.6.38-orig//arch/arm/plat-s3c24xx/devs.c     2011-03-14
22:20:32.000000000 -0300
+++ linux-2.6.38/arch/arm/plat-s3c24xx/devs.c   2011-05-26
02:42:12.000000000 -0300
@@ -509,3 +509,4 @@
 EXPORT_SYMBOL(s3c2412_device_iis);

 #endif // CONFIG_CPU_S32440
+
diff -Naur linux-2.6.38-orig//arch/arm/plat-s3c24xx/include/plat/map.h
linux-2.6.38/arch/arm/plat-s3c24xx/include/plat/map.h
--- linux-2.6.38-orig//arch/arm/plat-s3c24xx/include/plat/map.h 2011-03-14
22:20:32.000000000 -0300
+++ linux-2.6.38/arch/arm/plat-s3c24xx/include/plat/map.h       2011-05-27
00:51:53.000000000 -0300
@@ -81,6 +81,105 @@
 #define S3C24XX_VA_ISA_WORD  S3C2410_ADDR(0x02000000)
 #define S3C24XX_VA_ISA_BYTE  S3C2410_ADDR(0x03000000)

+/* EBI Registers */
+#if defined(CONFIG_CPU_S3C2416)
+#define S3C24XX_VA_EBI       S3C2410_ADDR(0x03c00000)
+#define S3C24XX_VA_SROMC     S3C2410_ADDR(0x03700000)
+
+#define S3C_EBIREG(x)  (S3C24XX_VA_EBI + (x))
+#define S3C_SSMCREG(x) (S3C24XX_VA_SROMC + (x))
+
+#define S3C_BANK_CFG                S3C_EBIREG(0x0008)
+
+/* Bank Idle Cycle Control Registers 0-5 */
+#define S3C_SSMC_SMBIDCYR0          S3C_SSMCREG(0x0000)
+#define S3C_SSMC_SMBIDCYR1          S3C_SSMCREG(0x0020)
+#define S3C_SSMC_SMBIDCYR2          S3C_SSMCREG(0x0040)
+#define S3C_SSMC_SMBIDCYR3          S3C_SSMCREG(0x0060)
+#define S3C_SSMC_SMBIDCYR4          S3C_SSMCREG(0x0080)
+#define S3C_SSMC_SMBIDCYR5          S3C_SSMCREG(0x00A0)
+#define S3C_SSMC_SMBIDCYR6          S3C_SSMCREG(0x00C0)
+#define S3C_SSMC_SMBIDCYR7          S3C_SSMCREG(0x00E0)
+
+/* Bank Read Wait State Contro, Registers 0-5 */
+#define S3C_SSMC_SMBWSTRDR0         S3C_SSMCREG(0x0004)
+#define S3C_SSMC_SMBWSTRDR1         S3C_SSMCREG(0x0024)
+#define S3C_SSMC_SMBWSTRDR2         S3C_SSMCREG(0x0044)
+#define S3C_SSMC_SMBWSTRDR3         S3C_SSMCREG(0x0064)
+#define S3C_SSMC_SMBWSTRDR4         S3C_SSMCREG(0x0084)
+#define S3C_SSMC_SMBWSTRDR5         S3C_SSMCREG(0x00A4)
+#define S3C_SSMC_SMBWSTRDR6         S3C_SSMCREG(0x00C4)
+#define S3C_SSMC_SMBWSTRDR7         S3C_SSMCREG(0x00E4)
+
+/* Bank Write Wait State Control, Registers 0-5 */
+#define S3C_SSMC_SMBWSTWRR0         S3C_SSMCREG(0x0008)
+#define S3C_SSMC_SMBWSTWRR1         S3C_SSMCREG(0x0028)
+#define S3C_SSMC_SMBWSTWRR2         S3C_SSMCREG(0x0048)
+#define S3C_SSMC_SMBWSTWRR3         S3C_SSMCREG(0x0068)
+#define S3C_SSMC_SMBWSTWRR4         S3C_SSMCREG(0x0088)
+#define S3C_SSMC_SMBWSTWRR5         S3C_SSMCREG(0x00A8)
+#define S3C_SSMC_SMBWSTWRR6         S3C_SSMCREG(0x00C8)
+#define S3C_SSMC_SMBWSTWRR7         S3C_SSMCREG(0x00E8)
+
+/* Bank OutPut enable Assertion Delay Control Registers 0-5 */
+#define S3C_SSMC_SMBWSTOENR0        S3C_SSMCREG(0x000C)
+#define S3C_SSMC_SMBWSTOENR1        S3C_SSMCREG(0x002C)
+#define S3C_SSMC_SMBWSTOENR2        S3C_SSMCREG(0x004C)
+#define S3C_SSMC_SMBWSTOENR3        S3C_SSMCREG(0x006C)
+#define S3C_SSMC_SMBWSTOENR4        S3C_SSMCREG(0x008C)
+#define S3C_SSMC_SMBWSTOENR5        S3C_SSMCREG(0x00AC)
+#define S3C_SSMC_SMBWSTOENR6        S3C_SSMCREG(0x00CC)
+#define S3C_SSMC_SMBWSTOENR7        S3C_SSMCREG(0x00EC)
+
+/* Bank Write enable Assertion Delay Control Registers 0-5 */
+#define S3C_SSMC_SMBWSTWENR0        S3C_SSMCREG(0x0010)
+#define S3C_SSMC_SMBWSTWENR1        S3C_SSMCREG(0x0030)
+#define S3C_SSMC_SMBWSTWENR2        S3C_SSMCREG(0x0050)
+#define S3C_SSMC_SMBWSTWENR3        S3C_SSMCREG(0x0070)
+#define S3C_SSMC_SMBWSTWENR4        S3C_SSMCREG(0x0090)
+#define S3C_SSMC_SMBWSTWENR5        S3C_SSMCREG(0x00B0)
+#define S3C_SSMC_SMBWSTWENR6        S3C_SSMCREG(0x00D0)
+#define S3C_SSMC_SMBWSTWENR7        S3C_SSMCREG(0x00F0)
+
+/* Bank Control Registers 0-5 */
+#define S3C_SSMC_SMBCR0     S3C_SSMCREG(0x0014)
+#define S3C_SSMC_SMBCR1     S3C_SSMCREG(0x0034)
+#define S3C_SSMC_SMBCR2     S3C_SSMCREG(0x0054)
+#define S3C_SSMC_SMBCR3     S3C_SSMCREG(0x0074)
+#define S3C_SSMC_SMBCR4     S3C_SSMCREG(0x0094)
+#define S3C_SSMC_SMBCR5     S3C_SSMCREG(0x00B4)
+#define S3C_SSMC_SMBCR6     S3C_SSMCREG(0x00D4)
+#define S3C_SSMC_SMBCR7     S3C_SSMCREG(0x00F4)
+
+/* Bank Status Registers 0-5 */
+#define S3C_SSMC_SMBSR0     S3C_SSMCREG(0x0018)
+#define S3C_SSMC_SMBSR1     S3C_SSMCREG(0x0038)
+#define S3C_SSMC_SMBSR2     S3C_SSMCREG(0x0058)
+#define S3C_SSMC_SMBSR3     S3C_SSMCREG(0x0078)
+#define S3C_SSMC_SMBSR4     S3C_SSMCREG(0x0098)
+#define S3C_SSMC_SMBSR5     S3C_SSMCREG(0x00B8)
+#define S3C_SSMC_SMBSR6     S3C_SSMCREG(0x00D8)
+#define S3C_SSMC_SMBSR7     S3C_SSMCREG(0x00F8)
+
+/* Bank Burst Read Wait delay Control Registers 0-5 */
+#define S3C_SSMC_SMBWSTBRDR0        S3C_SSMCREG(0x001C)
+#define S3C_SSMC_SMBWSTBRDR1        S3C_SSMCREG(0x003C)
+#define S3C_SSMC_SMBWSTBRDR2        S3C_SSMCREG(0x005C)
+#define S3C_SSMC_SMBWSTBRDR3        S3C_SSMCREG(0x007C)
+#define S3C_SSMC_SMBWSTBRDR4        S3C_SSMCREG(0x009C)
+#define S3C_SSMC_SMBWSTBRDR5        S3C_SSMCREG(0x00BC)
+#define S3C_SSMC_SMBWSTBRDR6        S3C_SSMCREG(0x00DC)
+#define S3C_SSMC_SMBWSTBRDR7        S3C_SSMCREG(0x00FC)
+
+/* SROMC status register  */
+#define S3C_SSMC_SSMCSR     S3C_SSMCREG(0x0200)
+/* SROMC control register  */
+#define S3C_SSMC_SSMCCR     S3C_SSMCREG(0x0204)
+/* bus priority decision */
+#define S3C_EBIPR           S3C_EBIREG(0x0000)
+
+#endif /* CONFIG_CPU_S3C2416 */
+
 /* deal with the registers that move under the 2412/2413 */

 #if defined(CONFIG_CPU_S3C2412) || defined(CONFIG_CPU_S3C2413)
diff -Naur linux-2.6.38-orig//drivers/net/smc911x.c
linux-2.6.38/drivers/net/smc911x.c
--- linux-2.6.38-orig//drivers/net/smc911x.c    2011-03-14
22:20:32.000000000 -0300
+++ linux-2.6.38/drivers/net/smc911x.c  2011-05-26 13:51:10.000000000 -0300
@@ -35,8 +35,8 @@
 #define ENABLE_SMC_DEBUG_TX            0
 #define ENABLE_SMC_DEBUG_DMA           0
 #define ENABLE_SMC_DEBUG_PKTS          0
-#define ENABLE_SMC_DEBUG_MISC          0
-#define ENABLE_SMC_DEBUG_FUNC          0
+#define ENABLE_SMC_DEBUG_MISC          1
+#define ENABLE_SMC_DEBUG_FUNC          1

 #define SMC_DEBUG_RX           ((ENABLE_SMC_DEBUG_RX   ? 1 : 0) << 0)
 #define SMC_DEBUG_TX           ((ENABLE_SMC_DEBUG_TX   ? 1 : 0) << 1)
diff -Naur linux-2.6.38-orig//drivers/net/smc911x.h
linux-2.6.38/drivers/net/smc911x.h
--- linux-2.6.38-orig//drivers/net/smc911x.h    2011-03-14
22:20:32.000000000 -0300
+++ linux-2.6.38/drivers/net/smc911x.h  2011-05-26 13:04:21.000000000 -0300
@@ -52,6 +52,9 @@
  #define SMC_USE_32BIT                1
  #define SMC_IRQ_SENSE                IRQF_TRIGGER_LOW
  #define SMC_MEM_RESERVED     1
+#elif defined(CONFIG_MARCH_SMDK2416)
+  #define SMC_USE_16BIT                0
+  #define SMC_USE_32BIT                1
 #else
 /*
 * Default configuration
@@ -687,6 +690,8 @@
 #define CHIP_9215      0x115A
 #define CHIP_9217      0x117A
 #define CHIP_9218      0x118A
+#define CHIP_9220      0x9220
+#define CHIP_9221      0x9221

 struct chip_id {
       u16 id;
@@ -702,6 +707,8 @@
       { CHIP_9215, "LAN9215" },
       { CHIP_9217, "LAN9217" },
       { CHIP_9218, "LAN9218" },
+       { CHIP_9220, "LAN9220" },
+       { CHIP_9221, "LAN9221" },
       { 0, NULL },
 };


Kind Regards,
     Thiago A. Correa
