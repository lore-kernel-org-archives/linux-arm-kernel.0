From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 4 Jan 2013 19:39:52 -0200
Subject: [PATCH 2/2] ARM: disable errata work-arounds which access secure
 registers
In-Reply-To: <CAOMZO5BpB7-9=S76VgNh5txZ=G3Q0UOaX6Px4OcMa+cVUi-_gg@mail.gmail.com>
References: <1355351150-15942-2-git-send-email-robherring2@gmail.com>
 <CAOMZO5BpB7-9=S76VgNh5txZ=G3Q0UOaX6Px4OcMa+cVUi-_gg@mail.gmail.com>
Message-ID: <CAOMZO5DXVcSi9ZD_2EpPTcv9OP=Jb2ZzWk9roJ02Jc_HSfmhFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 4, 2013 at 7:29 PM, Fabio Estevam <festevam@gmail.com> wrote:
> On Wed, Dec 12, 2012 at 8:25 PM, Rob Herring <robherring2@gmail.com> wrote:
>> From: Rob Herring <rob.herring@calxeda.com>
>>
>> In order to support secure and non-secure platforms in multi-platform
>> kernels, errata work-arounds that access secure only registers need to
>> be disabled. Make all the errata options that fit in this category
>> depend on !CONFIG_ARCH_MULTIPLATFORM.
>>
>> This will effectively remove the errata options as platforms are
>> converted over to multi-platform.
>>
>> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
>
> With this patch applied I get:
>
> $ make imx_v6_v7_defconfig
> warning: (SOC_IMX6Q && ARCH_TEGRA_2x_SOC && ARCH_TEGRA_3x_SOC) selects
> ARM_ERRATA_751472 which has unmet direct dependencies (CPU_V7 &&
> !ARCH_MULTIPLATFORM)
> warning: (SOC_IMX6Q && ARCH_TEGRA_3x_SOC) selects ARM_ERRATA_743622
> which has unmet direct dependencies (CPU_V7 && !ARCH_MULTIPLATFORM)
> warning: (SOC_IMX6Q && ARCH_TEGRA_3x_SOC) selects ARM_ERRATA_743622
> which has unmet direct dependencies (CPU_V7 && !ARCH_MULTIPLATFORM)
> warning: (SOC_IMX6Q && ARCH_TEGRA_2x_SOC && ARCH_TEGRA_3x_SOC) selects
> ARM_ERRATA_751472 which has unmet direct dependencies (CPU_V7 &&
> !ARCH_MULTIPLATFORM)
> #
> # configuration written to .config
> #
>
> Any suggestion?

Should we do like this?

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 1ad0d76..b11bba8 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -841,9 +841,9 @@ config SOC_IMX6Q
        select ARCH_HAS_CPUFREQ
        select ARCH_HAS_OPP
        select ARM_CPU_SUSPEND if PM
-       select ARM_ERRATA_743622
-       select ARM_ERRATA_751472
-       select ARM_ERRATA_754322
+       select ARM_ERRATA_743622 if !ARCH_MULTIPLATFORM
+       select ARM_ERRATA_751472 if !ARCH_MULTIPLATFORM
+       select ARM_ERRATA_754322
        select ARM_ERRATA_764369 if SMP
        select ARM_ERRATA_775420
        select ARM_GIC
