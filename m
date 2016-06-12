From: dianders@chromium.org (Doug Anderson)
Date: Sun, 12 Jun 2016 14:32:39 -0700
Subject: [PATCH] clk: rockchip: add pclk_vio_grf to critical clock on the
 RK3399
In-Reply-To: <1465724913-14553-1-git-send-email-zhengxing@rock-chips.com>
References: <1465724913-14553-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <CAD=FV=XSSPMOnMD3mqFyqM3wWLShbRc2cXVdN0PYcUxpaDnsTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Xing,

On Sun, Jun 12, 2016 at 2:48 AM, Xing Zheng <zhengxing@rock-chips.com> wrote:
> The pclk_vio_grf supply power for GRF IOs, if it is disabled, will
> cause abnormal operation of the GRF.
>
> The clock tree of the pclk_vio like this:
>              | --> pclk_vio_grf
> ... pclk_vio | --> pclk_mipi_dsi1
>              | --> pclk_mipi_dsi0
>
> and the pclk_mipi_dsi0 and pclk_mipi_dsi1 don't have the flag
> CLK_IGNORE_UNUSED, and they will be disabled by clk_disable_unused
> when startup:
> clk_disable_unused
>   --> clk_disable_unprepare
>     --> clk_disable
>       --> clk_core_disable(core->parent)
>
> then, the pclk_vio_grf also is disabled. Therefore, we need to add
> pclk_vio_grf to critical clock and avoid to disable pclk_vio and
> pclk_vio_grf.
>
> Tested-by: Yakir Yang <ykk@rock-chips.com>
> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
> ---
>
>  drivers/clk/rockchip/clk-rk3399.c |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk-rk3399.c
> index b6742fa..7ecb12c3 100644
> --- a/drivers/clk/rockchip/clk-rk3399.c
> +++ b/drivers/clk/rockchip/clk-rk3399.c
> @@ -1485,6 +1485,7 @@ static const char *const rk3399_cru_critical_clocks[] __initconst = {
>         "gpll_hclk_perilp1_src",
>         "gpll_aclk_perilp0_src",
>         "gpll_aclk_perihp_src",
> +       "pclk_vio_grf",

This clock is only needed when doing video output (like eDP), right?
That means it is not really a critical clock.  Critical clocks are
supposed to be ones that are needed for the basic functioning of the
system and that can never be turned off in any circumstances.  In this
case, if someone were running a rk3399 device and didn't have any
video output they would want this clock off.

Can you figure out in exactly which circumstances this clock needs to
be on and then add a proper consumer of this clock?  For instance, if
this clock is needed whenever the VOP is outputting data, then the VOP
should be a client and should turn this clock on and off when video is
being output.  If this clock is needed whenever you access VOP
registers, then the VOP should be a client and turn this clock on
around register accesses.

-Doug
