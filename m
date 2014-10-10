From: dianders@chromium.org (Doug Anderson)
Date: Fri, 10 Oct 2014 11:54:40 -0700
Subject: [PATCH] clk: rockchip: change PLL setting for better clock jitter
In-Reply-To: <1412918637-9843-1-git-send-email-kever.yang@rock-chips.com>
References: <1412918637-9843-1-git-send-email-kever.yang@rock-chips.com>
Message-ID: <CAD=FV=WzUcvMoATQt6rp5kiZk9URUjdwY5YUcdJ32px21ZOkLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Oct 9, 2014 at 10:23 PM, Kever Yang <kever.yang@rock-chips.com> wrote:
> dclk_vop0/1 is the source of HDMI TMDS clock in rk3288, usually we
> use 594MHz for clock source of dclk_vop0/1.
>
> HDMI CTS 7-9 require TMDS Clock jitter is lower than 0.25*Tbit:
> TMDS clock(MHz)         CTS require jitter (ps)
>         297             84.2
>         148.5           168
>         74.25           336
>         27              1247
>
> PLL BW and VCO frequency effects the jitter of PLL output clock,
> clock jitter is better if BW is lower or VCO frequency is higher.
>
> If PLL use default setting of RK3066_PLL_RATE( 594000000, 2, 198, 4),
> the TMDS Clock jitter is higher than 250ps, which means we can't
> pass the test when TMDS clock is 297MHz or 148.5MHz.
>
> If we use RK3066_PLL_RATE_BWADJ(594000000, 1, 198, 8, 1),
> the TMDS Clock jitter is about 60ps and we can pass all test case.
>
> So we need this patch to make hdmi si test pass.
>
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> ---
>
>  drivers/clk/rockchip/clk-rk3288.c | 2 +-
>  drivers/clk/rockchip/clk.h        | 9 +++++++++
>  2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
> index 7c30a5a..11a7376a 100644
> --- a/drivers/clk/rockchip/clk-rk3288.c
> +++ b/drivers/clk/rockchip/clk-rk3288.c
> @@ -83,7 +83,7 @@ struct rockchip_pll_rate_table rk3288_pll_rates[] = {
>         RK3066_PLL_RATE( 742500000, 8, 495, 2),
>         RK3066_PLL_RATE( 696000000, 1, 58, 2),
>         RK3066_PLL_RATE( 600000000, 1, 50, 2),
> -       RK3066_PLL_RATE( 594000000, 2, 198, 4),
> +       RK3066_PLL_RATE_BWADJ(594000000, 1, 198, 8, 1),

I talked with Kever offline.  Both the old and new values here have
invalid Fvco according to the TRM.  He's going to investigate.  Please
wait before merging this patch.
