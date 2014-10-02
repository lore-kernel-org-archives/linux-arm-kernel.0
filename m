From: dianders@google.com (Doug Anderson)
Date: Thu, 2 Oct 2014 09:19:08 -0700
Subject: [PATCH] ARM: dts: fix MMC2 regulators for Exynos5420 Arndale Octa
 board
In-Reply-To: <2750153.I3nVqzmXTP@amdc1032>
References: <2750153.I3nVqzmXTP@amdc1032>
Message-ID: <CAD=FV=XtJVWkUwWK8=E+mvSdvBn1MuS9c+_91VPhbOSQ3kF_kA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bartiomiej,

On Thu, Oct 2, 2014 at 9:10 AM, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
> Regulators for MMC2 (SD card) are PVDD_TFLASH_2V8 (LDO19) for vmmc
> and PVDD_APIO_MMCOFF_2V8 (LDO13) for vqmmc.  Currently the device
> tree entry for MMC2 uses PVDD_PRE_1V8 (LDO10) for vmmc and vqmmc is
> not specified.  Fix it.
>
> Without this patch:
> - "mmc: dw_mmc: use mmc_regulator_get_supply to handle regulators"
>   patch causes a SD card detection to fail
> - "mmc: dw_mmc: Support voltage changes" patch causes a boot hang
>
> This patch fixes both above problems.
>
> Suggested-by: Doug Anderson <dianders@google.com>
> Cc: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5420-arndale-octa.dts |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> Index: b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
> ===================================================================
> --- a/arch/arm/boot/dts/exynos5420-arndale-octa.dts     2014-10-02 15:44:53.014826886 +0200
> +++ b/arch/arm/boot/dts/exynos5420-arndale-octa.dts     2014-10-02 17:35:24.110600398 +0200
> @@ -74,7 +74,8 @@
>                 samsung,dw-mshc-ddr-timing = <1 2>;
>                 pinctrl-names = "default";
>                 pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
> -               vmmc-supply = <&ldo10_reg>;
> +               vmmc-supply = <&ldo19_reg>;
> +               vqmmc-supply = <&ldo13_reg>;

This looks right to me.  ...but I notice that ldo13 and ldo19 are not
"always-on" in the DTS.  Are you sure card detect works for you if you
eject your card and try to put it back in?

...eventually the "always-on" won't be needed, but for now I think it is...

-Doug
