From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Tue, 23 Oct 2018 10:10:22 -0700
Subject: [PATCH v2 03/15] clk: sunxi-ng: Add check for maximum rate to NKM
 PLLs
In-Reply-To: <20181023155035.9101-4-jagan@amarulasolutions.com>
References: <20181023155035.9101-1-jagan@amarulasolutions.com>
 <20181023155035.9101-4-jagan@amarulasolutions.com>
Message-ID: <CA+E=qVcs0xT2Vqksjs4tz5eBtp_RZ_dqX0AEPfjSaJqA5YBt-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 23, 2018 at 8:51 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> Some NKM PLLs, frequency can be set above PLL working range.
>
> Add a constraint for maximum supported rate. This way, drivers can
> specify which is maximum allowed rate for PLL.

I'd squash patches 2 and 3 into a single patch.

> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v2:
> - new patch
>
>  drivers/clk/sunxi-ng/ccu_nkm.c | 7 +++++++
>  drivers/clk/sunxi-ng/ccu_nkm.h | 1 +
>  2 files changed, 8 insertions(+)
>
> diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_nkm.c
> index d17539dc88dd..574fd2cd2a79 100644
> --- a/drivers/clk/sunxi-ng/ccu_nkm.c
> +++ b/drivers/clk/sunxi-ng/ccu_nkm.c
> @@ -132,6 +132,13 @@ static unsigned long ccu_nkm_round_rate(struct ccu_mux_internal *mux,
>                 return rate;
>         }
>
> +       if (nkm->max_rate && rate > nkm->max_rate) {
> +               rate = nkm->max_rate;
> +               if (nkm->common.features & CCU_FEATURE_FIXED_POSTDIV)
> +                       rate /= nkm->fixed_post_div;
> +               return rate;
> +       }
> +
>         ccu_nkm_find_best(*parent_rate, rate, &_nkm);
>
>         rate = *parent_rate * _nkm.n * _nkm.k / _nkm.m;
> diff --git a/drivers/clk/sunxi-ng/ccu_nkm.h b/drivers/clk/sunxi-ng/ccu_nkm.h
> index ff5bd00f429f..c82590481188 100644
> --- a/drivers/clk/sunxi-ng/ccu_nkm.h
> +++ b/drivers/clk/sunxi-ng/ccu_nkm.h
> @@ -36,6 +36,7 @@ struct ccu_nkm {
>
>         unsigned int            fixed_post_div;
>         unsigned int            min_rate;
> +       unsigned int            max_rate;
>
>         struct ccu_common       common;
>  };
> --
> 2.18.0.321.gffc6fa0e3
>
