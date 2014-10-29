From: dianders@chromium.org (Doug Anderson)
Date: Wed, 29 Oct 2014 10:10:34 -0700
Subject: [PATCH] clk: rockchip: change PLL setting for better clock jitter
In-Reply-To: <1412918637-9843-1-git-send-email-kever.yang@rock-chips.com>
References: <1412918637-9843-1-git-send-email-kever.yang@rock-chips.com>
Message-ID: <CAD=FV=XDYe203VZmPtpAVibtmAXcBwGBdQ=2BNUVD-kA6gCP0w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kever,

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

As per offline discussion, I have now received a TRM (2014-10-22) that
has expanded the valid ranges of the PLLs.  This now looks OK to me.

Reviewed-by: Doug Anderson <dianders@chromium.org>
