From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 27 Nov 2012 23:56:44 +0100
Subject: [PATCH] clk: ux500: fix bit error
In-Reply-To: <1354043720-30850-1-git-send-email-linus.walleij@stericsson.com>
References: <1354043720-30850-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <CAPDyKFqb2Trqk02K_ROb_UPfT4z8zV_mS4EsrXVTt8jAqU3bVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 November 2012 20:15, Linus Walleij <linus.walleij@stericsson.com> wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
>
> This fixes a bit error in the U8500 clock implementation: the
> unused p2_pclk12 registered at bit 12 in periphereral group 6
> was defined as using bit 11 rather than bit 12.
>
> When walking over and disabling the unused clocks in the tree
> at late init time, p2_pclk12 was disabled, by effectively
> clearing the but for p2_pclk11 instead of bit 12 as it should
> have, thus disabling gpio block 6 and 7.
>
> Reported-by: Lee Jones <lee.jones@linaro.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Philippe Begnic <philippe.begnic@st.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Mike if this gets ACKed (beware of more mistakes from this
> coder) it should go into v3.7 or if that fails be tagged with
> Cc: stable at kernel.org.
> ---
>  drivers/clk/ux500/u8500_clk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/ux500/u8500_clk.c b/drivers/clk/ux500/u8500_clk.c
> index fb9f291..20ecaa7 100644
> --- a/drivers/clk/ux500/u8500_clk.c
> +++ b/drivers/clk/ux500/u8500_clk.c
> @@ -317,7 +317,7 @@ void u8500_clk_init(void)
>         clk_register_clkdev(clk, NULL, "gpioblock1");
>
>         clk = clk_reg_prcc_pclk("p2_pclk12", "per2clk", U8500_CLKRST2_BASE,
> -                               BIT(11), 0);
> +                               BIT(12), 0);
>
>         clk = clk_reg_prcc_pclk("p3_pclk0", "per3clk", U8500_CLKRST3_BASE,
>                                 BIT(0), 0);
> --
> 1.7.11.3
>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Yes, for sure this need to go stable. What a mess a "typo" can cause.
Thanks a lot Linus for finding this!

Kind regards
Ulf Hansson
