From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 22 Mar 2017 13:00:56 +0100
Subject: [PATCH v6 4/4] clk: samsung: exynos-audss: Use runtime PM
In-Reply-To: <1490182543-28550-5-git-send-email-m.szyprowski@samsung.com>
References: <CGME20170322113556eucas1p1b3434935701aba1db7868415a9c3b4f9@eucas1p1.samsung.com>
 <1490182543-28550-1-git-send-email-m.szyprowski@samsung.com>
 <1490182543-28550-5-git-send-email-m.szyprowski@samsung.com>
Message-ID: <CAPDyKFrL9pvGQw+09rP52p72FqKuh6rLNt0NEUZ-TFxU838Nzw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 March 2017 at 12:35, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> This patch adds support for runtime PM to Exynos Audio SubSystem driver to
> enable full support for audio power domain on Exynos5 SoCs. The main change
> is moving register saving and restoring code from system sleep PM ops to
> runtime PM ops and implementing system sleep PM ops with generic
> pm_runtime_force_suspend/resume helpers. Runtime PM of the Exynos AudSS
> device is managed from clock core depending on the preparation status
> of the provided clocks.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Minor nitpick below.

[...]

>
> -#ifdef CONFIG_PM_SLEEP
>  static unsigned long reg_save[][2] = {
>         { ASS_CLK_SRC,  0 },
>         { ASS_CLK_DIV,  0 },
>         { ASS_CLK_GATE, 0 },
>  };
>
> -static int exynos_audss_clk_suspend(struct device *dev)
> +static int __maybe_unused exynos_audss_clk_suspend(struct device *dev)

Instead of using "__maybe_unused", I would rather change from
"CONFIG_PM_SLEEP" to "CONFIG_PM". However, no strong opinion.

Perhaps you need something like this for patch 3/4 as well?

>  {
>         int i;
>
> @@ -54,7 +54,7 @@ static int exynos_audss_clk_suspend(struct device *dev)
>         return 0;
>  }

[...]

Kind regards
Uffe
