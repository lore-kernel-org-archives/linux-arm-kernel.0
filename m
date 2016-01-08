From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Fri, 8 Jan 2016 13:42:22 -0300
Subject: [PATCH] mmc: pwrseq_simple: Make reset-gpios optional to match doc
In-Reply-To: <20160108090726.13066.66125.stgit@localhost>
References: <20160108090726.13066.66125.stgit@localhost>
Message-ID: <CABxcv=mYRG0rikgtY-fPj_BFhY8hgn_LYjcxEeY14rZD-BHpfg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[adding Tony Lindgren to cc list]

Hello Martin,

On Fri, Jan 8, 2016 at 6:07 AM, Martin Fuzzey <mfuzzey@parkeon.com> wrote:
> The DT binding doc says reset-gpios is an optional property but the code
> currently bails out if it is omitted.
>
> Make the code match the documentation.
>
> Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
> ---
>  drivers/mmc/core/pwrseq_simple.c |   21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
> index d10538b..4d2962b 100644
> --- a/drivers/mmc/core/pwrseq_simple.c
> +++ b/drivers/mmc/core/pwrseq_simple.c
> @@ -29,15 +29,18 @@ struct mmc_pwrseq_simple {
>  static void mmc_pwrseq_simple_set_gpios_value(struct mmc_pwrseq_simple *pwrseq,
>                                               int value)
>  {
> -       int i;
>         struct gpio_descs *reset_gpios = pwrseq->reset_gpios;
> -       int values[reset_gpios->ndescs];
>
> -       for (i = 0; i < reset_gpios->ndescs; i++)
> -               values[i] = value;
> +       if (!IS_ERR(reset_gpios)) {
> +               int i;
> +               int values[reset_gpios->ndescs];
>
> -       gpiod_set_array_value_cansleep(reset_gpios->ndescs, reset_gpios->desc,
> -                                      values);
> +               for (i = 0; i < reset_gpios->ndescs; i++)
> +                       values[i] = value;
> +
> +               gpiod_set_array_value_cansleep(
> +                       reset_gpios->ndescs, reset_gpios->desc, values);
> +       }
>  }
>
>  static void mmc_pwrseq_simple_pre_power_on(struct mmc_host *host)
> @@ -79,7 +82,8 @@ static void mmc_pwrseq_simple_free(struct mmc_host *host)
>         struct mmc_pwrseq_simple *pwrseq = container_of(host->pwrseq,
>                                         struct mmc_pwrseq_simple, pwrseq);
>
> -       gpiod_put_array(pwrseq->reset_gpios);
> +       if (!IS_ERR(pwrseq->reset_gpios))
> +               gpiod_put_array(pwrseq->reset_gpios);
>
>         if (!IS_ERR(pwrseq->ext_clk))
>                 clk_put(pwrseq->ext_clk);
> @@ -112,7 +116,8 @@ struct mmc_pwrseq *mmc_pwrseq_simple_alloc(struct mmc_host *host,
>         }
>
>         pwrseq->reset_gpios = gpiod_get_array(dev, "reset", GPIOD_OUT_HIGH);
> -       if (IS_ERR(pwrseq->reset_gpios)) {
> +       if (IS_ERR(pwrseq->reset_gpios) &&
> +           PTR_ERR(pwrseq->reset_gpios) != -ENOENT) {
>                 ret = PTR_ERR(pwrseq->reset_gpios);
>                 goto clk_put;
>         }
>
>

Tony already posted a fix for this before [0] but got some feedback so
is likely to post a v2 soon.

[0]: http://www.spinics.net/lists/linux-mmc/msg34398.html

Best regards,
Javier
