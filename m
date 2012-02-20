From: nsekhar@ti.com (Nori, Sekhar)
Date: Mon, 20 Feb 2012 14:19:29 +0000
Subject: [PATCH v7 3/8] davinci: eliminate use of IO_ADDRESS() on sysmod
In-Reply-To: <1324475021-32509-4-git-send-email-manjunath.hadli@ti.com>
References: <1324475021-32509-1-git-send-email-manjunath.hadli@ti.com>
 <1324475021-32509-4-git-send-email-manjunath.hadli@ti.com>
Message-ID: <DF0F476B391FA8409C78302C7BA518B6317C7996@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Manju,

On Wed, Dec 21, 2011 at 19:13:36, Hadli, Manjunath wrote:
> Current devices.c file has a number of instances where
> IO_ADDRESS() is used for system module register

You seemed to have limited yourself to devices.c, but there
is one more IO_ADDRESS() usage in dm646x.c which can also be
eliminated with the change you are making in this patch.
I included that clean-up too in this patch.

> access. Eliminate this in favor of a ioremap()
> based access.

Along with IO_ADDRESS() I also found some VPIF specific registers
in system module were being ioremapped separately in DM646x EVM code.
I included fixing that into this patch as well.

I also found duplicate system module register offsets definitions
in code so I consolidated system module register offsets in davinci.h.

> 
> Signed-off-by: Manjunath Hadli <manjunath.hadli@ti.com>

Arnd had acked one of the earlier versions of this patch.
Please carry forward the acks you receive on previous versions
of the patch (unless the patch is now doing something totally
different). Otherwise, there is no way for a person like me
to add the proper acks before committing.

> ---
>  arch/arm/mach-davinci/davinci.h               |    9 +++++++++
>  arch/arm/mach-davinci/devices.c               |   25 ++++++++++++++++---------
>  arch/arm/mach-davinci/dm355.c                 |    1 +
>  arch/arm/mach-davinci/dm365.c                 |    1 +
>  arch/arm/mach-davinci/dm644x.c                |    1 +
>  arch/arm/mach-davinci/dm646x.c                |    1 +
>  arch/arm/mach-davinci/include/mach/hardware.h |    2 --
>  7 files changed, 29 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/mach-davinci/davinci.h b/arch/arm/mach-davinci/davinci.h
> index 238c282..065b3a0 100644
> --- a/arch/arm/mach-davinci/davinci.h
> +++ b/arch/arm/mach-davinci/davinci.h
> @@ -23,10 +23,19 @@
>  
>  #include <mach/asp.h>
>  #include <mach/keyscan.h>
> +#include <mach/hardware.h>
>  
>  #include <media/davinci/vpfe_capture.h>
>  #include <media/davinci/vpif_types.h>
>  
> +#define DAVINCI_SYSTEM_MODULE_BASE        0x01c40000
> +
> +#ifndef __ASSEMBLER__
> +extern void __iomem *davinci_sysmodbase;
> +#define DAVINCI_SYSMODULE_VIRT(x)	(davinci_sysmodbase + (x))
> +void davinci_map_sysmod(void);
> +#endif

I couldn't see the reason why ifndef __ASSEMBLER__ is required here
I don't see this file being included in any assembly file. So, I have
removed it in my commit.

> diff --git a/arch/arm/mach-davinci/devices.c b/arch/arm/mach-davinci/devices.c
> index 806a2f0..faff29a 100644
> --- a/arch/arm/mach-davinci/devices.c
> +++ b/arch/arm/mach-davinci/devices.c
> @@ -23,6 +23,7 @@
>  #include <mach/mmc.h>
>  #include <mach/time.h>
>  
> +#include "davinci.h"
>  #include "clock.h"
>  
>  #define DAVINCI_I2C_BASE	     0x01C21000
> @@ -36,6 +37,14 @@
>  /* System control register offsets */
>  #define DM64XX_VDD3P3V_PWDN	0x48
>  
> +void __iomem  *davinci_sysmodbase;
> +
> +void davinci_map_sysmod(void)
> +{
> +	davinci_sysmodbase = ioremap_nocache(DAVINCI_SYSTEM_MODULE_BASE, 0x800);
> +	WARN_ON(!davinci_sysmodbase);

I converted this to a bug since this is something basic
for SoC initialization and I did not see a point in going
ahead and failing elsewhere. I also think ioremap() failing
this early in system boot needs attention anyway. I have
included these reasons in a comment above the BUG_ON().

With  these items fixed, here is the updated patch.

Thanks,
Sekhar
----8<-----
commit 0180a7edde29929e36b97ca8493bf35b3e39a6dc
Author:     Manjunath Hadli <manjunath.hadli@ti.com>
AuthorDate: Wed Dec 21 19:13:36 2011 +0530
Commit:     Sekhar Nori <nsekhar@ti.com>
CommitDate: Mon Feb 20 19:38:03 2012 +0530

    ARM: davinci: streamline sysmod access
    
    There are instances of IO_ADDRESS() being used for system module
    (sysmod) register access. Eliminate this in favor of a ioremap()
    based access. ioremap() the entire sysmod address space once during
    boot-up and provide a helper macro to access specific register
    offsets within the address space.
    
    With this, also eliminate ioremap() of specific sysmodule registers
    related to VPIF happening in DM646x EVM code.
    
    While at it, also eliminate some duplicate sysmod register offset macros
    defined in code and place offset definitions at one place in davinci.h
    
    Signed-off-by: Manjunath Hadli <manjunath.hadli@ti.com>
    Acked-by: Arnd Bergmann <arnd@arndb.de>
    [nsekhar at ti.com: removed the addition of ifndef __ASSEMBLER__
    in davinci.h, eliminate IO_ADDRESS() usage left out in dm646x.c,
    cleanup VPIF sysmodule register access as part of this patch and
    keep all sysmod offsets in davinci.h Also, convert the WARN_ON()
    on failure to setup sysmod base to BUG_ON()]
    Signed-off-by: Sekhar Nori <nsekhar@ti.com>

diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index 74ae0c4..9468904 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -410,8 +410,6 @@ static struct davinci_i2c_platform_data i2c_pdata = {
 	.bus_delay      = 0 /* usec */,
 };
 
-#define VIDCLKCTL_OFFSET	(DAVINCI_SYSTEM_MODULE_BASE + 0x38)
-#define VSCLKDIS_OFFSET		(DAVINCI_SYSTEM_MODULE_BASE + 0x6c)
 #define VCH2CLK_MASK		(BIT_MASK(10) | BIT_MASK(9) | BIT_MASK(8))
 #define VCH2CLK_SYSCLK8		(BIT(9))
 #define VCH2CLK_AUXCLK		(BIT(9) | BIT(8))
@@ -429,8 +427,6 @@ static struct davinci_i2c_platform_data i2c_pdata = {
 #define TVP5147_CH0		"tvp514x-0"
 #define TVP5147_CH1		"tvp514x-1"
 
-static void __iomem *vpif_vidclkctl_reg;
-static void __iomem *vpif_vsclkdis_reg;
 /* spin lock for updating above registers */
 static spinlock_t vpif_reg_lock;
 
@@ -441,14 +437,14 @@ static int set_vpif_clock(int mux_mode, int hd)
 	int val = 0;
 	int err = 0;
 
-	if (!vpif_vidclkctl_reg || !vpif_vsclkdis_reg || !cpld_client)
+	if (!cpld_client)
 		return -ENXIO;
 
 	/* disable the clock */
 	spin_lock_irqsave(&vpif_reg_lock, flags);
-	value = __raw_readl(vpif_vsclkdis_reg);
+	value = __raw_readl(DAVINCI_SYSMOD_VIRT(SYSMOD_VSCLKDIS));
 	value |= (VIDCH3CLK | VIDCH2CLK);
-	__raw_writel(value, vpif_vsclkdis_reg);
+	__raw_writel(value, DAVINCI_SYSMOD_VIRT(SYSMOD_VSCLKDIS));
 	spin_unlock_irqrestore(&vpif_reg_lock, flags);
 
 	val = i2c_smbus_read_byte(cpld_client);
@@ -464,7 +460,7 @@ static int set_vpif_clock(int mux_mode, int hd)
 	if (err)
 		return err;
 
-	value = __raw_readl(vpif_vidclkctl_reg);
+	value = __raw_readl(DAVINCI_SYSMOD_VIRT(SYSMOD_VIDCLKCTL));
 	value &= ~(VCH2CLK_MASK);
 	value &= ~(VCH3CLK_MASK);
 
@@ -473,13 +469,13 @@ static int set_vpif_clock(int mux_mode, int hd)
 	else
 		value |= (VCH2CLK_AUXCLK | VCH3CLK_AUXCLK);
 
-	__raw_writel(value, vpif_vidclkctl_reg);
+	__raw_writel(value, DAVINCI_SYSMOD_VIRT(SYSMOD_VIDCLKCTL));
 
 	spin_lock_irqsave(&vpif_reg_lock, flags);
-	value = __raw_readl(vpif_vsclkdis_reg);
+	value = __raw_readl(DAVINCI_SYSMOD_VIRT(SYSMOD_VSCLKDIS));
 	/* enable the clock */
 	value &= ~(VIDCH3CLK | VIDCH2CLK);
-	__raw_writel(value, vpif_vsclkdis_reg);
+	__raw_writel(value, DAVINCI_SYSMOD_VIRT(SYSMOD_VSCLKDIS));
 	spin_unlock_irqrestore(&vpif_reg_lock, flags);
 
 	return 0;
@@ -564,7 +560,7 @@ static int setup_vpif_input_channel_mode(int mux_mode)
 	int val;
 	u32 value;
 
-	if (!vpif_vidclkctl_reg || !cpld_client)
+	if (!cpld_client)
 		return -ENXIO;
 
 	val = i2c_smbus_read_byte(cpld_client);
@@ -572,7 +568,7 @@ static int setup_vpif_input_channel_mode(int mux_mode)
 		return val;
 
 	spin_lock_irqsave(&vpif_reg_lock, flags);
-	value = __raw_readl(vpif_vidclkctl_reg);
+	value = __raw_readl(DAVINCI_SYSMOD_VIRT(SYSMOD_VIDCLKCTL));
 	if (mux_mode) {
 		val &= VPIF_INPUT_TWO_CHANNEL;
 		value |= VIDCH1CLK;
@@ -580,7 +576,7 @@ static int setup_vpif_input_channel_mode(int mux_mode)
 		val |= VPIF_INPUT_ONE_CHANNEL;
 		value &= ~VIDCH1CLK;
 	}
-	__raw_writel(value, vpif_vidclkctl_reg);
+	__raw_writel(value, DAVINCI_SYSMOD_VIRT(SYSMOD_VIDCLKCTL));
 	spin_unlock_irqrestore(&vpif_reg_lock, flags);
 
 	err = i2c_smbus_write_byte(cpld_client, val);
@@ -674,12 +670,6 @@ static struct vpif_capture_config dm646x_vpif_capture_cfg = {
 
 static void __init evm_init_video(void)
 {
-	vpif_vidclkctl_reg = ioremap(VIDCLKCTL_OFFSET, 4);
-	vpif_vsclkdis_reg = ioremap(VSCLKDIS_OFFSET, 4);
-	if (!vpif_vidclkctl_reg || !vpif_vsclkdis_reg) {
-		pr_err("Can't map VPIF VIDCLKCTL or VSCLKDIS registers\n");
-		return;
-	}
 	spin_lock_init(&vpif_reg_lock);
 
 	dm646x_setup_vpif(&dm646x_vpif_display_config,
diff --git a/arch/arm/mach-davinci/davinci.h b/arch/arm/mach-davinci/davinci.h
index 5e4f85e..b1a52fb 100644
--- a/arch/arm/mach-davinci/davinci.h
+++ b/arch/arm/mach-davinci/davinci.h
@@ -25,10 +25,21 @@
 
 #include <mach/asp.h>
 #include <mach/keyscan.h>
+#include <mach/hardware.h>
 
 #include <media/davinci/vpfe_capture.h>
 #include <media/davinci/vpif_types.h>
 
+#define DAVINCI_SYSTEM_MODULE_BASE	0x01c40000
+#define SYSMOD_VIDCLKCTL		0x38
+#define SYSMOD_VDD3P3VPWDN		0x48
+#define SYSMOD_VSCLKDIS			0x6c
+#define SYSMOD_PUPDCTL1			0x7c
+
+extern void __iomem *davinci_sysmod_base;
+#define DAVINCI_SYSMOD_VIRT(x)	(davinci_sysmod_base + (x))
+void davinci_map_sysmod(void);
+
 /* DM355 base addresses */
 #define DM355_ASYNC_EMIF_CONTROL_BASE	0x01e10000
 #define DM355_ASYNC_EMIF_DATA_CE0_BASE	0x02000000
diff --git a/arch/arm/mach-davinci/devices.c b/arch/arm/mach-davinci/devices.c
index 50c0156..d2f9666 100644
--- a/arch/arm/mach-davinci/devices.c
+++ b/arch/arm/mach-davinci/devices.c
@@ -23,6 +23,7 @@
 #include <mach/mmc.h>
 #include <mach/time.h>
 
+#include "davinci.h"
 #include "clock.h"
 
 #define DAVINCI_I2C_BASE	     0x01C21000
@@ -33,8 +34,19 @@
 #define DM365_MMCSD0_BASE	     0x01D11000
 #define DM365_MMCSD1_BASE	     0x01D00000
 
-/* System control register offsets */
-#define DM64XX_VDD3P3V_PWDN	0x48
+void __iomem  *davinci_sysmod_base;
+
+void davinci_map_sysmod(void)
+{
+	davinci_sysmod_base = ioremap_nocache(DAVINCI_SYSTEM_MODULE_BASE,
+					      0x800);
+	/*
+	 * Throw a bug since a lot of board initialization code depends
+	 * on system module availability. ioremap() failing this early
+	 * need careful looking into anyway.
+	 */
+	BUG_ON(!davinci_sysmod_base);
+}
 
 static struct resource i2c_resources[] = {
 	{
@@ -212,12 +224,12 @@ void __init davinci_setup_mmc(int module, struct davinci_mmc_config *config)
 			davinci_cfg_reg(DM355_SD1_DATA2);
 			davinci_cfg_reg(DM355_SD1_DATA3);
 		} else if (cpu_is_davinci_dm365()) {
-			void __iomem *pupdctl1 =
-				IO_ADDRESS(DAVINCI_SYSTEM_MODULE_BASE + 0x7c);
-
 			/* Configure pull down control */
-			__raw_writel((__raw_readl(pupdctl1) & ~0xfc0),
-					pupdctl1);
+			unsigned v;
+
+			v = __raw_readl(DAVINCI_SYSMOD_VIRT(SYSMOD_PUPDCTL1));
+			__raw_writel(v & ~0xfc0,
+					DAVINCI_SYSMOD_VIRT(SYSMOD_PUPDCTL1));
 
 			mmcsd1_resources[0].start = DM365_MMCSD1_BASE;
 			mmcsd1_resources[0].end = DM365_MMCSD1_BASE +
@@ -246,11 +258,9 @@ void __init davinci_setup_mmc(int module, struct davinci_mmc_config *config)
 			mmcsd0_resources[2].start = IRQ_DM365_SDIOINT0;
 		} else if (cpu_is_davinci_dm644x()) {
 			/* REVISIT: should this be in board-init code? */
-			void __iomem *base =
-				IO_ADDRESS(DAVINCI_SYSTEM_MODULE_BASE);
-
 			/* Power-on 3.3V IO cells */
-			__raw_writel(0, base + DM64XX_VDD3P3V_PWDN);
+			__raw_writel(0,
+				DAVINCI_SYSMOD_VIRT(SYSMOD_VDD3P3VPWDN));
 			/*Set up the pull regiter for MMC */
 			davinci_cfg_reg(DM644X_MSTK);
 		}
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index 0b0d41c..fd3d09a 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -871,6 +871,7 @@ void __init dm355_init_asp1(u32 evt_enable, struct snd_platform_data *pdata)
 void __init dm355_init(void)
 {
 	davinci_common_init(&davinci_soc_info_dm355);
+	davinci_map_sysmod();
 }
 
 static int __init dm355_init_devices(void)
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index d831d94..1a2e953 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -1138,6 +1138,7 @@ void __init dm365_init_rtc(void)
 void __init dm365_init(void)
 {
 	davinci_common_init(&davinci_soc_info_dm365);
+	davinci_map_sysmod();
 }
 
 static struct resource dm365_vpss_resources[] = {
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index c6f47c6..bf14ec0 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -786,6 +786,7 @@ void __init dm644x_init_asp(struct snd_platform_data *pdata)
 void __init dm644x_init(void)
 {
 	davinci_common_init(&davinci_soc_info_dm644x);
+	davinci_map_sysmod();
 }
 
 static int __init dm644x_init_devices(void)
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 3b84195..9eb87c1 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -32,8 +32,6 @@
 #include "mux.h"
 
 #define DAVINCI_VPIF_BASE       (0x01C12000)
-#define VDD3P3V_PWDN_OFFSET	(0x48)
-#define VSCLKDIS_OFFSET		(0x6C)
 
 #define VDD3P3V_VID_MASK	(BIT_MASK(3) | BIT_MASK(2) | BIT_MASK(1) |\
 					BIT_MASK(0))
@@ -880,15 +878,14 @@ void dm646x_setup_vpif(struct vpif_display_config *display_config,
 		       struct vpif_capture_config *capture_config)
 {
 	unsigned int value;
-	void __iomem *base = IO_ADDRESS(DAVINCI_SYSTEM_MODULE_BASE);
 
-	value = __raw_readl(base + VSCLKDIS_OFFSET);
+	value = __raw_readl(DAVINCI_SYSMOD_VIRT(SYSMOD_VSCLKDIS));
 	value &= ~VSCLKDIS_MASK;
-	__raw_writel(value, base + VSCLKDIS_OFFSET);
+	__raw_writel(value, DAVINCI_SYSMOD_VIRT(SYSMOD_VSCLKDIS));
 
-	value = __raw_readl(base + VDD3P3V_PWDN_OFFSET);
+	value = __raw_readl(DAVINCI_SYSMOD_VIRT(SYSMOD_VDD3P3VPWDN));
 	value &= ~VDD3P3V_VID_MASK;
-	__raw_writel(value, base + VDD3P3V_PWDN_OFFSET);
+	__raw_writel(value, DAVINCI_SYSMOD_VIRT(SYSMOD_VDD3P3VPWDN));
 
 	davinci_cfg_reg(DM646X_STSOMUX_DISABLE);
 	davinci_cfg_reg(DM646X_STSIMUX_DISABLE);
@@ -912,6 +909,7 @@ int __init dm646x_init_edma(struct edma_rsv_info *rsv)
 void __init dm646x_init(void)
 {
 	davinci_common_init(&davinci_soc_info_dm646x);
+	davinci_map_sysmod();
 }
 
 static int __init dm646x_init_devices(void)
diff --git a/arch/arm/mach-davinci/include/mach/hardware.h b/arch/arm/mach-davinci/include/mach/hardware.h
index 414e0b9..0209b1f 100644
--- a/arch/arm/mach-davinci/include/mach/hardware.h
+++ b/arch/arm/mach-davinci/include/mach/hardware.h
@@ -19,8 +19,6 @@
  * and the chip/board init code should then explicitly include
  * <chipname>.h
  */
-#define DAVINCI_SYSTEM_MODULE_BASE        0x01C40000
-
 /*
  * I/O mapping
  */
