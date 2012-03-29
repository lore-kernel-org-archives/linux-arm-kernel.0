From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 28 Mar 2012 18:34:05 -0700
Subject: [PATCH 1/4] ARM: Exynos: Use CHIP_ID to detect cpu type during
 decompression setup
In-Reply-To: <1332840365-24827-2-git-send-email-thomas.abraham@linaro.org>
References: <1332840365-24827-1-git-send-email-thomas.abraham@linaro.org>
 <1332840365-24827-2-git-send-email-thomas.abraham@linaro.org>
Message-ID: <4F73BC0D.7070004@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas Abraham wrote:
> The config option MACH_SMDK5250 is not available for Exynos5 since only
> a device tree based machine is supported and selected by MACH_EXYNOS5_DT.
> Hence, the detection of the cpu type based on machine_is_smdk5250 always
> fails and boot hangs due to incorrect uart base being used. Fix this by
> reading the chip id to determine the cpu type and setup the uart_base
> accordingly.
> 
> Signed-off-by: Thomas Abraham<thomas.ab@samsung.com>
> ---
>   arch/arm/mach-exynos/include/mach/uncompress.h |    6 +++++-
>   1 files changed, 5 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/include/mach/uncompress.h b/arch/arm/mach-exynos/include/mach/uncompress.h
> index 493f4f3..603ea9b 100644
> --- a/arch/arm/mach-exynos/include/mach/uncompress.h
> +++ b/arch/arm/mach-exynos/include/mach/uncompress.h
> @@ -14,15 +14,19 @@
> 
>   #include<asm/mach-types.h>
> 
> +#include<plat/cpu.h>
>   #include<mach/map.h>
> 
>   volatile u8 *uart_base;
> 
>   #include<plat/uncompress.h>
> 
> +#define __raw_readl(addr)		\
> +	(*((volatile unsigned int __force *)(addr)))
> +
>   static void arch_detect_cpu(void)
>   {
> -	if (machine_is_smdk5250())
> +	if ((__raw_readl(EXYNOS_PA_CHIPID)&  EXYNOS5_SOC_MASK) == EXYNOS5250_SOC_ID)
>   		uart_base = (volatile u8 *)EXYNOS5_PA_UART + (S3C_UART_OFFSET * CONFIG_S3C_LOWLEVEL_UART_PORT);
>   	else
>   		uart_base = (volatile u8 *)EXYNOS4_PA_UART + (S3C_UART_OFFSET * CONFIG_S3C_LOWLEVEL_UART_PORT);

Hi Thomas,

Thanks for fix.

But I have following patch and it is not required to add inclusion of
<plat/cpu.h>. How do you think? If you're ok, I would preferred to use
follwoing.

diff --git a/arch/arm/mach-exynos/include/mach/uncompress.h
b/arch/arm/mach-exynos/include/mach/uncompress.h
index 493f4f3..2979995 100644
--- a/arch/arm/mach-exynos/include/mach/uncompress.h
+++ b/arch/arm/mach-exynos/include/mach/uncompress.h
@@ -20,9 +20,24 @@ volatile u8 *uart_base;

 #include <plat/uncompress.h>

+static unsigned int __raw_readl(unsigned int ptr)
+{
+	return *((volatile unsigned int *)ptr);
+}
+
 static void arch_detect_cpu(void)
 {
-	if (machine_is_smdk5250())
+	u32 chip_id = __raw_readl(EXYNOS_PA_CHIPID);
+
+	/*
+	 * product_id is bits 31:12
+	 *    bits 23:20 describe the exynosX family
+	 *
+	 */
+	chip_id >>= 20;
+	chip_id &= 0xf;
+
+	if (chip_id == 0x5)
 		uart_base = (volatile u8 *)EXYNOS5_PA_UART + (S3C_UART_OFFSET *
CONFIG_S3C_LOWLEVEL_UART_PORT);
 	else
 		uart_base = (volatile u8 *)EXYNOS4_PA_UART + (S3C_UART_OFFSET *
CONFIG_S3C_LOWLEVEL_UART_PORT);


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
