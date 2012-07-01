From: shijie8@gmail.com (Huang Shijie)
Date: Sun, 1 Jul 2012 11:32:02 -0400
Subject: [PATCH v2 3/3] mtd: gpmi: change the code for clocks
In-Reply-To: <1341199476-7446-4-git-send-email-shijie8@gmail.com>
References: <1341199476-7446-1-git-send-email-shijie8@gmail.com>
 <1341199476-7446-4-git-send-email-shijie8@gmail.com>
Message-ID: <CAMiH66GYmfvhbRpDqd1u=eQK7eVE7YzjmHWH7tAv-n5t4EUU2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sorry, I will resend this patch set.

I find a bug in it.



On Sun, Jul 1, 2012 at 11:24 PM, Huang Shijie <shijie8@gmail.com> wrote:
> From: Huang Shijie <b32955@freescale.com>
>
> The gpmi nand driver may needs several clocks(MX6Q needs five clocks).
>
> In the old clock framework, all these clocks are chained together,
> all you need is to manipulate the first clock.
>
> But the kernel uses the common clk framework now, which forces us to
> get the clocks one by one. When we use them, we have to enable them
> one by one too.
>
> Signed-off-by: Huang Shijie <shijie8@gmail.com>
> ---
>  drivers/mtd/nand/gpmi-nand/gpmi-lib.c  |   43 ++++++++++++++---
>  drivers/mtd/nand/gpmi-nand/gpmi-nand.c |   82 ++++++++++++++++++++++++++++----
>  drivers/mtd/nand/gpmi-nand/gpmi-nand.h |    3 +-
>  3 files changed, 110 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-lib.c b/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
> index a1f4332..c3778c0 100644
> --- a/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
> +++ b/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
> @@ -124,12 +124,40 @@ error:
>         return -ETIMEDOUT;
>  }
>
> +static int __gpmi_enable_clk(struct gpmi_nand_data *this, bool v)
> +{
> +       struct clk *clk;
> +       int ret;
> +       int i;
> +
> +       for (i = 0; i < GPMI_CLK_MAX; i++) {
> +               clk = this->resources.clock[i];
> +               if (!clk)
> +                       break;
> +
> +               if (v) {
> +                       ret = clk_prepare_enable(clk);
> +                       if (ret)
> +                               goto err_clk;
> +               } else {
> +                       clk_disable_unprepare(clk);
> +               }
> +       }
> +       return 0;
> +
> +err_clk:
> +       return ret;
> +}
> +
> +#define gpmi_enable_clk(x) __gpmi_enable_clk(x, true)
> +#define gpmi_disable_clk(x) __gpmi_enable_clk(x, false)
> +
>  int gpmi_init(struct gpmi_nand_data *this)
>  {
>         struct resources *r = &this->resources;
>         int ret;
>
> -       ret = clk_prepare_enable(r->clock);
> +       ret = gpmi_enable_clk(this);
>         if (ret)
>                 goto err_out;
>         ret = gpmi_reset_block(r->gpmi_regs, false);
> @@ -149,7 +177,7 @@ int gpmi_init(struct gpmi_nand_data *this)
>         /* Select BCH ECC. */
>         writel(BM_GPMI_CTRL1_BCH_MODE, r->gpmi_regs + HW_GPMI_CTRL1_SET);
>
> -       clk_disable_unprepare(r->clock);
> +       gpmi_disable_clk(this);
>         return 0;
>  err_out:
>         return ret;
> @@ -205,7 +233,7 @@ int bch_set_geometry(struct gpmi_nand_data *this)
>         ecc_strength  = bch_geo->ecc_strength >> 1;
>         page_size     = bch_geo->page_size;
>
> -       ret = clk_prepare_enable(r->clock);
> +       ret = gpmi_enable_clk(this);
>         if (ret)
>                 goto err_out;
>
> @@ -240,7 +268,7 @@ int bch_set_geometry(struct gpmi_nand_data *this)
>         writel(BM_BCH_CTRL_COMPLETE_IRQ_EN,
>                                 r->bch_regs + HW_BCH_CTRL_SET);
>
> -       clk_disable_unprepare(r->clock);
> +       gpmi_disable_clk(this);
>         return 0;
>  err_out:
>         return ret;
> @@ -716,7 +744,7 @@ void gpmi_begin(struct gpmi_nand_data *this)
>         int ret;
>
>         /* Enable the clock. */
> -       ret = clk_prepare_enable(r->clock);
> +       ret = gpmi_enable_clk(this);
>         if (ret) {
>                 pr_err("We failed in enable the clk\n");
>                 goto err_out;
> @@ -727,7 +755,7 @@ void gpmi_begin(struct gpmi_nand_data *this)
>                 gpmi_regs + HW_GPMI_TIMING1);
>
>         /* Get the timing information we need. */
> -       nfc->clock_frequency_in_hz = clk_get_rate(r->clock);
> +       nfc->clock_frequency_in_hz = clk_get_rate(r->clock[0]);
>         clock_period_in_ns = 1000000000 / nfc->clock_frequency_in_hz;
>
>         gpmi_nfc_compute_hardware_timing(this, &hw);
> @@ -784,8 +812,7 @@ err_out:
>
>  void gpmi_end(struct gpmi_nand_data *this)
>  {
> -       struct resources *r = &this->resources;
> -       clk_disable_unprepare(r->clock);
> +       gpmi_disable_clk(this);
>  }
>
>  /* Clears a BCH interrupt. */
> diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
> index 941cfb7..e7f362c 100644
> --- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
> +++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
> @@ -464,9 +464,78 @@ acquire_err:
>         return -EINVAL;
>  }
>
> +static void gpmi_put_clks(struct gpmi_nand_data *this)
> +{
> +       struct resources *r = &this->resources;
> +       struct clk *clk;
> +       int i;
> +
> +       for (i = 0; i < GPMI_CLK_MAX; i++) {
> +               clk = r->clock[i];
> +               if (clk) {
> +                       clk_put(clk);
> +                       r->clock[i] = NULL;
> +               }
> +       }
> +}
> +
> +static char *extra_clks_for_mx6q[GPMI_CLK_MAX] = {
> +       "gpmi_apb", "gpmi_bch", "gpmi_bch_apb", "per1_bch",
> +};
> +
> +static int __devinit gpmi_get_clks(struct gpmi_nand_data *this)
> +{
> +       struct resources *r = &this->resources;
> +       char **extra_clks = NULL;
> +       struct clk *clk;
> +       int i;
> +
> +       /* The main clock is stored in the first. */
> +       r->clock[0] = clk_get(this->dev, NULL);
> +       if (IS_ERR(r->clock[0]))
> +               goto err_clock;
> +
> +       /* Get extra clocks */
> +       if (GPMI_IS_MX6Q(this))
> +               extra_clks = extra_clks_for_mx6q;
> +       if (!extra_clks)
> +               return 0;
> +
> +       for (i = 1; i < GPMI_CLK_MAX; i++) {
> +               if (extra_clks[i - 1] == NULL)
> +                       break;
> +
> +               clk = clk_get(this->dev, extra_clks[i - 1]);
> +               if (IS_ERR(clk))
> +                       goto err_clock;
> +
> +               r->clock[i] = clk;
> +       }
> +
> +       if (GPMI_IS_MX6Q(this)) {
> +               /*
> +                * Set the default values for the clocks in mx6q:
> +                *    The main clock(enfc) : 22MHz
> +                *    The others           : 44.5MHz
> +                *
> +                * These are just the default values. If you want to use
> +                * the ONFI nand which is in the Synchronous Mode, you should
> +                * change the clocks's frequencies as you need.
> +                */
> +               clk_set_rate(r->clock[0], 22000000);
> +               for (i = 1; i < GPMI_CLK_MAX; i++)
> +                       clk_set_rate(r->clock[0], 44500000);
> +       }
> +       return 0;
> +
> +err_clock:
> +       dev_dbg(this->dev, "failed in finding the clocks.\n");
> +       gpmi_put_clks(this);
> +       return -ENOMEM;
> +}
> +
>  static int __devinit acquire_resources(struct gpmi_nand_data *this)
>  {
> -       struct resources *res = &this->resources;
>         struct pinctrl *pinctrl;
>         int ret;
>
> @@ -492,12 +561,9 @@ static int __devinit acquire_resources(struct gpmi_nand_data *this)
>                 goto exit_pin;
>         }
>
> -       res->clock = clk_get(&this->pdev->dev, NULL);
> -       if (IS_ERR(res->clock)) {
> -               pr_err("can not get the clock\n");
> -               ret = -ENOENT;
> +       ret = gpmi_get_clks(this);
> +       if (ret)
>                 goto exit_clock;
> -       }
>         return 0;
>
>  exit_clock:
> @@ -512,9 +578,7 @@ exit_regs:
>
>  static void release_resources(struct gpmi_nand_data *this)
>  {
> -       struct resources *r = &this->resources;
> -
> -       clk_put(r->clock);
> +       gpmi_put_clks(this);
>         release_register_block(this);
>         release_bch_irq(this);
>         release_dma_channels(this);
> diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.h b/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
> index ce5daa1..1547a60 100644
> --- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
> +++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
> @@ -22,6 +22,7 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/fsl/mxs-dma.h>
>
> +#define GPMI_CLK_MAX 5 /* MX6Q needs five clocks */
>  struct resources {
>         void          *gpmi_regs;
>         void          *bch_regs;
> @@ -29,7 +30,7 @@ struct resources {
>         unsigned int  bch_high_interrupt;
>         unsigned int  dma_low_channel;
>         unsigned int  dma_high_channel;
> -       struct clk    *clock;
> +       struct clk    *clock[GPMI_CLK_MAX];
>  };
>
>  /**
> --
> 1.7.4.4
>
