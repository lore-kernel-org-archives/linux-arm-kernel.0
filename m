From: dianders@chromium.org (Doug Anderson)
Date: Fri, 13 May 2016 13:10:57 -0700
Subject: [PATCH 2/2] clk: rockchip: fix incorrect parent for rk3399's {c,
 g}pll_aclk_perihp_src
In-Reply-To: <1463164937-91089-2-git-send-email-briannorris@chromium.org>
References: <1463164937-91089-1-git-send-email-briannorris@chromium.org>
 <1463164937-91089-2-git-send-email-briannorris@chromium.org>
Message-ID: <CAD=FV=XstYhqpStSGw5PObWvpsvd3Nwp_hfEE-56bpFoVUyu+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, May 13, 2016 at 11:42 AM, Brian Norris <briannorris@chromium.org> wrote:
> From: Xing Zheng <zhengxing@rock-chips.com>
>
> There was a typo, swapping 'c' <--> 'g'.
>
> Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>  drivers/clk/rockchip/clk-rk3399.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk-rk3399.c
> index 145756c4f3c8..9f86bfef70f7 100644
> --- a/drivers/clk/rockchip/clk-rk3399.c
> +++ b/drivers/clk/rockchip/clk-rk3399.c
> @@ -832,9 +832,9 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
>                         RK3399_CLKGATE_CON(13), 1, GFLAGS),
>
>         /* perihp */
> -       GATE(0, "cpll_aclk_perihp_src", "gpll", CLK_IGNORE_UNUSED,
> +       GATE(0, "cpll_aclk_perihp_src", "cpll", CLK_IGNORE_UNUSED,
>                         RK3399_CLKGATE_CON(5), 0, GFLAGS),
> -       GATE(0, "gpll_aclk_perihp_src", "cpll", CLK_IGNORE_UNUSED,
> +       GATE(0, "gpll_aclk_perihp_src", "gpll", CLK_IGNORE_UNUSED,
>                         RK3399_CLKGATE_CON(5), 1, GFLAGS),
>         COMPOSITE(ACLK_PERIHP, "aclk_perihp", mux_aclk_perihp_p, CLK_IGNORE_UNUSED,
>                         RK3399_CLKSEL_CON(14), 7, 1, MFLAGS, 0, 5, DFLAGS,

Definitely there was a bug since this table itself was inconsistent.
...and I _think_ this fix is correct, but I'll note that the TRM has
more inconsistency here.

In the big clock table 'CRU Clock Architecture Diagram', I see:
  CLK 4 is CPLL
  CLK 5 is GPLL
  CLK 125 is aclk_perihp_cpll_src and has 4 (CPLL) as source, with
g5[0] as the bit
  CLK 126 is aclk_perihp_gpll_src and has 5 (GPLL) as source, with
g5[1] as the bit

In the definition of CRU_CLKGATE_CON5:
  bit 0 shows aclk_perihp_gpll_src_en
  bit 1 shows aclk_perihp_cpll_src_en


Thus the table shows CPLL as gate5[0] and GPLL as gate5[1].  The
register definition shows the opposite.  I'll tend to believe the
table over the register definition, but I figured I'd bring it up
anyway.


Xing Zheng: can you confirm that the table is correct and ask
documentation folks to fix the register definition for
CRU_CLKGATE_CON5?



Thanks!

-Doug
