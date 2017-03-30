From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 30 Mar 2017 14:44:17 +0200
Subject: [PATCH v2 2/4] clk: rockchip: rk3228: make noc and some special
 clk as critical_clocks
In-Reply-To: <1490695614-3220-3-git-send-email-zhangqing@rock-chips.com>
References: <1490695614-3220-1-git-send-email-zhangqing@rock-chips.com>
 <1490695614-3220-3-git-send-email-zhangqing@rock-chips.com>
Message-ID: <20170330124417.73ucpdkoonuiyhxz@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 28, 2017 at 06:06:52PM +0800, Elaine Zhang wrote:
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>  drivers/clk/rockchip/clk-rk3228.c | 30 +++++++++++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/rockchip/clk-rk3228.c b/drivers/clk/rockchip/clk-rk3228.c
> index db6e5a9e6de6..4d3203f887e2 100644
> --- a/drivers/clk/rockchip/clk-rk3228.c
> +++ b/drivers/clk/rockchip/clk-rk3228.c
> @@ -445,7 +445,7 @@ enum rk3228_plls {
>  			RK2928_CLKGATE_CON(2), 12, GFLAGS,
>  			&rk3228_spdif_fracmux),
>  
> -	GATE(0, "jtag", "ext_jtag", 0,
> +	GATE(0, "jtag", "ext_jtag", CLK_IGNORE_UNUSED,

CLK_IGNORE_UNUSED only prevents a given clock from being gated at
late_initcall time, but will not prevent it from being gated later in
the life of the system, for example if a reparenting occurs, or if all
the clocks sharing the same clock tree become disabled.

If your clock really should never ever be gated in order for Linux to
operate properly, you should use CLK_IS_CRITICAL.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170330/0dc29049/attachment.sig>
