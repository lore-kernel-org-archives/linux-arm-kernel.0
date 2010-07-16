From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 16 Jul 2010 21:04:44 +0900
Subject: [PATCH 2/5] ARM: S5P: Added default pll values for APLL
	800/1000MHz
In-Reply-To: <1279184768-28971-3-git-send-email-myungjoo.ham@samsung.com>
References: <1279184768-28971-1-git-send-email-myungjoo.ham@samsung.com>
	<1279184768-28971-2-git-send-email-myungjoo.ham@samsung.com>
	<1279184768-28971-3-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <012d01cb24df$163b8ee0$42b2aca0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MyungJoo Ham wrote:
> 
> CPUFREQ of S5PV210 uses different APLL settings and we provide
> such values for CPUFREQ at pll.h. We have been using differently
> between EVT0 and EVT1 machines. Although this version of kernel
> assumes that the CPU is EVT1, users may use code for EVT0 later.
> 
> Note that at 1GHz of ARMCLK, APLL should be 1GHz and for other lower
> ARMCLK, APLL should be 800MHz.
> 
> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/plat-s5p/include/plat/pll.h |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-s5p/include/plat/pll.h
b/arch/arm/plat-s5p/include/plat/pll.h
> index 7db3227..3112aba 100644
> --- a/arch/arm/plat-s5p/include/plat/pll.h
> +++ b/arch/arm/plat-s5p/include/plat/pll.h
> @@ -21,6 +21,14 @@
> 
>  #include <asm/div64.h>
> 
> +#ifdef CONFIG_CPU_S5PC110_EVT0_ERRATA

Actually, EVT0 is not real chip and not for mass production.
So don't use in here.

> +#define PLL45XX_APLL_VAL_1000	(1 << 31) | (0xfa<<16) | (0x6<<8) |
(0x1)
> +#define PLL45XX_APLL_VAL_800	(1 << 31) | (0xc8<<16) | (0x6<<8) | (0x1)
> +#else
> +#define PLL45XX_APLL_VAL_1000	(1 << 31) | (125<<16) | (3<<8) | (1)
> +#define PLL45XX_APLL_VAL_800	(1 << 31) | (100<<16) | (3<<8) | (1)
> +#endif
> +
>  enum pll45xx_type_t {
>  	pll_4500,
>  	pll_4502,
> --

And...I got the below result from scripts/checkpatch.pl...
If this time is first, maybe mistake...but this is not...

--

ERROR: Macros with complex values should be enclosed in parenthesis
#27: FILE: arch/arm/plat-s5p/include/plat/pll.h:25:
+#define PLL45XX_APLL_VAL_1000  (1 << 31) | (0xfa<<16) | (0x6<<8) | (0x1)

ERROR: Macros with complex values should be enclosed in parenthesis
#28: FILE: arch/arm/plat-s5p/include/plat/pll.h:26:
+#define PLL45XX_APLL_VAL_800   (1 << 31) | (0xc8<<16) | (0x6<<8) | (0x1)

ERROR: Macros with complex values should be enclosed in parenthesis
#30: FILE: arch/arm/plat-s5p/include/plat/pll.h:28:
+#define PLL45XX_APLL_VAL_1000  (1 << 31) | (125<<16) | (3<<8) | (1)

ERROR: Macros with complex values should be enclosed in parenthesis
#31: FILE: arch/arm/plat-s5p/include/plat/pll.h:29:
+#define PLL45XX_APLL_VAL_800   (1 << 31) | (100<<16) | (3<<8) | (1)

total: 4 errors, 0 warnings, 14 lines checked

--

I already said to you about that :-(
Please make sure your patch has no problem to send before submitting.

See the Documentation/SubmittingPatches...

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
