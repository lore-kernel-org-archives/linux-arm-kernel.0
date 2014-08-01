From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 01 Aug 2014 11:26:23 +0100
Subject: [PATCH] ARM: multi_v7_defconfig: major refresh
In-Reply-To: <1406052070-6207-1-git-send-email-olof@lixom.net>
References: <1406052070-6207-1-git-send-email-olof@lixom.net>
Message-ID: <53DB6B4F.9080605@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 22/07/14 19:01, Olof Johansson wrote:
> This is a major refresh of the multi_v7_defconfig:
>
> - Bring over a bunch of Samsung drivers to make ODROID-U3 and Chromebooks usable
>   * Enable big.LITTLE
>   * MCPM
>   * CYAPA touchpad
>   * Samsung-related MTD/regulator/clk/pinmux drivers
>   * Add some of the CrOS EC drivers
> - Turn on TPM, HW_RANDOM
> - OMAP_USB3 -> TI_PIPE3 option rename
> - Enable MCPM/b.L for VEXPRESS
> - Add new CONFIG_MTD_SPI_NOR since it otherwise masks off SPI NOR drivers
> - CONFIG_LOGO, because penguins.
>
> I took care to keep the new options that have been added for whose the
> drivers are not yet in our for-next branch. This was pretty awkward so
> we should sort out how to handle those better in the future.
>
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
>   arch/arm/configs/multi_v7_defconfig |   74 +++++++++++++++++++++++++++--------
>   1 file changed, 58 insertions(+), 16 deletions(-)
>
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index 16518a7..c7654cf 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -50,6 +50,7 @@ CONFIG_MACH_SPEAR1310=y
>   CONFIG_MACH_SPEAR1340=y
>   CONFIG_ARCH_STI=y
>   CONFIG_ARCH_EXYNOS=y
> +CONFIG_EXYNOS5420_MCPM=y
>   CONFIG_ARCH_SUNXI=y
>   CONFIG_ARCH_SIRF=y
>   CONFIG_ARCH_TEGRA=y
> @@ -57,21 +58,23 @@ CONFIG_ARCH_TEGRA_2x_SOC=y
>   CONFIG_ARCH_TEGRA_3x_SOC=y
>   CONFIG_ARCH_TEGRA_114_SOC=y
>   CONFIG_ARCH_TEGRA_124_SOC=y
> -CONFIG_TEGRA_EMC_SCALING_ENABLE=y
>   CONFIG_ARCH_U8500=y
>   CONFIG_MACH_HREFV60=y
>   CONFIG_MACH_SNOWBALL=y
> -CONFIG_MACH_UX500_DT=y
>   CONFIG_ARCH_VEXPRESS=y
>   CONFIG_ARCH_VEXPRESS_CA9X4=y
> +CONFIG_ARCH_VEXPRESS_DCSCB=y
> +CONFIG_ARCH_VEXPRESS_TC2_PM=y
>   CONFIG_ARCH_WM8850=y
>   CONFIG_ARCH_ZYNQ=y
> -CONFIG_TRUSTED_FOUNDATIONS=y
>   CONFIG_PCI=y
>   CONFIG_PCI_MSI=y
>   CONFIG_PCI_MVEBU=y
>   CONFIG_PCI_TEGRA=y
>   CONFIG_SMP=y
> +CONFIG_BIG_LITTLE=y
> +CONFIG_BL_SWITCHER=y

IIUC, this will enable switcher code by default. I am not sure if this
is intentional ? E.g.: After this I can have only 2 active cpus instead
of 5 on my Vexpress TC2 platform.

IMO we can keep this enabled by default in the build, but disabled
by default on boot. One way to achieve this:
(There's sysfs to re-enable it runtime)

-->8
diff --git a/arch/arm/common/bL_switcher.c b/arch/arm/common/bL_switcher.c
index 490f3dced749..f4c36e70166a 100644
--- a/arch/arm/common/bL_switcher.c
+++ b/arch/arm/common/bL_switcher.c
@@ -794,7 +794,7 @@ static int bL_switcher_hotplug_callback(struct 
notifier_block *nfb,
         return NOTIFY_DONE;
  }

-static bool no_bL_switcher;
+static bool no_bL_switcher = true;
  core_param(no_bL_switcher, no_bL_switcher, bool, 0644);

  static int __init bL_switcher_init(void)

---

> +CONFIG_BL_SWITCHER_DUMMY_IF=y

This was added only for debugging purposes, again not sure if you want
this enabled by default. Ideally it should be triggered by CPUFreq.

Regards,
Sudeep
