From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 3 May 2013 10:51:50 +0200
Subject: [PATCH] clk: ux500: clk-sysctrl: handle clocks with no parents
In-Reply-To: <1367325906-23045-1-git-send-email-fabio.baltieri@linaro.org>
References: <1367325906-23045-1-git-send-email-fabio.baltieri@linaro.org>
Message-ID: <CAPDyKFpZ+-6b3kPyNacPQ33=Ssdjs=fvFxkr4iSUT_hm1YzVTg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 April 2013 14:45, Fabio Baltieri <fabio.baltieri@linaro.org> wrote:
> Fix clk_reg_sysctrl() to set main clock registers of new struct
> clk_sysctrl even if the registered clock has no parents.
>
> This fixes an issue where "ulpclk" was registered with all clk->reg_*
> fields uninitialized, causing a -EINVAL error from clk_prepare().
>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>
> ---
>  drivers/clk/ux500/clk-sysctrl.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/ux500/clk-sysctrl.c b/drivers/clk/ux500/clk-sysctrl.c
> index bc7e9bd..e364c9d 100644
> --- a/drivers/clk/ux500/clk-sysctrl.c
> +++ b/drivers/clk/ux500/clk-sysctrl.c
> @@ -145,7 +145,13 @@ static struct clk *clk_reg_sysctrl(struct device *dev,
>                 return ERR_PTR(-ENOMEM);
>         }
>
> -       for (i = 0; i < num_parents; i++) {
> +       /* set main clock registers */
> +       clk->reg_sel[0] = reg_sel[0];
> +       clk->reg_bits[0] = reg_bits[0];
> +       clk->reg_mask[0] = reg_mask[0];
> +
> +       /* handle clocks with more than one parent */
> +       for (i = 1; i < num_parents; i++) {
>                 clk->reg_sel[i] = reg_sel[i];
>                 clk->reg_bits[i] = reg_bits[i];
>                 clk->reg_mask[i] = reg_mask[i];
> --
> 1.8.2
>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

This is bugfix, should go "stable" as well?

Kind regards
Ulf Hansson
