From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Wed, 13 Apr 2016 09:26:15 +0300
Subject: [PATCH] clk: samsung: exynos7: Enable clocks for CMU_CCORE and
 CMU_FSYS0 blocks
In-Reply-To: <1460459243-27120-1-git-send-email-alim.akhtar@samsung.com>
References: <1460459243-27120-1-git-send-email-alim.akhtar@samsung.com>
Message-ID: <CA+Ln22G0b1O9HHyePg60Q2uZnGT_a3J1LMU0o3+CpPoLCTbksA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-04-12 14:07 GMT+03:00 Alim Akhtar <alim.akhtar@samsung.com>:
> This patch enables clocks for CMU_CCORE and CMU_FSYS0 blocks. This is
> required before accessing registers of these blocks.
>
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos7.c |    9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/clk/samsung/clk-exynos7.c b/drivers/clk/samsung/clk-exynos7.c
> index ad68d46..7013aa7 100644
> --- a/drivers/clk/samsung/clk-exynos7.c
> +++ b/drivers/clk/samsung/clk-exynos7.c
> @@ -8,6 +8,7 @@
>   *
>  */
>
> +#include <linux/clk.h>
>  #include <linux/clk-provider.h>
>  #include <linux/of.h>
>
> @@ -205,7 +206,11 @@ static struct samsung_cmu_info topc_cmu_info __initdata = {
>
>  static void __init exynos7_clk_topc_init(struct device_node *np)
>  {
> +       struct clk *clk;
> +
>         samsung_cmu_register_one(np, &topc_cmu_info);
> +       clk = __clk_lookup("aclk_ccore_133");
> +       clk_prepare_enable(clk);

Shouldn't this be rather done before calling
samsung_cmu_register_one()? I don't remember exactly, but wouldn't
clock registration trigger reading back current (mux, div) values from
registers?

Also, do we have any guarantees on order of initialization of
particular CMUs? I believe this will happen in order of DT nodes and
so would be not any kind of guarantee at all.

Best regards,
Tomasz
