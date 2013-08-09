From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Fri, 9 Aug 2013 15:18:41 +0530
Subject: [PATCHv2 1/5] drm/exynos: add device tree support for rotator
In-Reply-To: <1376034053-31910-2-git-send-email-chanho61.park@samsung.com>
References: <1376034053-31910-1-git-send-email-chanho61.park@samsung.com>
 <1376034053-31910-2-git-send-email-chanho61.park@samsung.com>
Message-ID: <CAK9yfHwrE8pnc=jF+7=wuqyemmZFMi5WX+giXYizbP_yy34Wfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chanho,

On 9 August 2013 13:10, Chanho Park <chanho61.park@samsung.com> wrote:
> The exynos4 platform is only dt-based since 3.10, we should convert driver data
> and ids to dt-based parsing methods. The rotator driver has a limit table to get
> size limit of input picture. Each SoCs has slightly different limit value
> compared with any others.
> For example, exynos4210's max_size of RGB888 is 16k x 16k. But, others have
> 8k x 8k. Another example the exynos5250 should have multiple of 2 pixel size
> for its X/Y axis. Thus, we should keep different tables for each of them.
>
> Signed-off-by: Chanho Park <chanho61.park@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/gpu/drm/exynos/exynos_drm_rotator.c |  109 ++++++++++++++++++++-------
>  1 file changed, 81 insertions(+), 28 deletions(-)
[snip]
> +
> +static const struct of_device_id exynos_rotator_match[] = {
> +       {
> +               .compatible = "samsung,exynos4210-rotator",
> +               .data = &rot_limit_tbl_4210,
> +       },
> +       {
> +               .compatible = "samsung,exynos4212-rotator",
> +               .data = &rot_limit_tbl_4x12,
> +       },
> +       {
> +               .compatible = "samsung,exynos5250-rotator",
> +               .data = &rot_limit_tbl_5250,
> +       },
> +       {},
> +};
> +
>  static int rotator_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
> @@ -645,8 +712,19 @@ static int rotator_probe(struct platform_device *pdev)
>                 return -ENOMEM;
>         }
>
> -       rot->limit_tbl = (struct rot_limit_table *)
> -                               platform_get_device_id(pdev)->driver_data;
> +       if (dev->of_node) {
> +               const struct of_device_id *match;
> +               match = of_match_node(of_match_ptr(exynos_rotator_match),

of_match_ptr is not needed since exynos_rotator_match is always compiled in.

[snip]
> -static struct platform_device_id rotator_driver_ids[] = {
> -       {
> -               .name           = "exynos-rot",
> -               .driver_data    = (unsigned long)&rot_limit_tbl,
> -       },
> -       {},
> -};
> -
>  static int rotator_clk_crtl(struct rot_context *rot, bool enable)
>  {
>         if (enable) {
> @@ -804,10 +857,10 @@ static const struct dev_pm_ops rotator_pm_ops = {
>  struct platform_driver rotator_driver = {
>         .probe          = rotator_probe,
>         .remove         = rotator_remove,
> -       .id_table       = rotator_driver_ids,
>         .driver         = {
>                 .name   = "exynos-rot",
>                 .owner  = THIS_MODULE,
>                 .pm     = &rotator_pm_ops,
> +               .of_match_table = of_match_ptr(exynos_rotator_match),

ditto

-- 
With warm regards,
Sachin
