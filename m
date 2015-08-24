From: dianders@chromium.org (Doug Anderson)
Date: Mon, 24 Aug 2015 16:03:23 -0700
Subject: [PATCH] clk: rockchip: register pll mux before pll itself
In-Reply-To: <7060610.CC2Q1RMG2L@phil>
References: <7060610.CC2Q1RMG2L@phil>
Message-ID: <CAD=FV=UG_QkU0W5tpb3Y7zxuq6X7dtQmC4m5_j9vMtJgjdiquQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko

On Wed, Aug 19, 2015 at 6:06 AM, Heiko Stuebner <heiko@sntech.de> wrote:
> The structure is xin24m -> pll -> pll-mux (xin24m,pll,xin32k). The pll
> does have an init callback to make sure the boot-selected frequency is
> using the expected pll settings and resets the same frequency using
> the values provided in the driver if necessary.
>
> The setting itself also involves remuxing the pll-mux temporarily to
> the xin24m source to let the new pll rate settle. Until now this worked
> flawlessly, even when it had the flaw of accessing the mux settings
> before the mux actually got registered.
>
> With the recent clock-core conversions this flaw became apparent in
> null pointer dereference in
> [<c03fc400>] (clk_hw_get_num_parents) from [<c0400df0>] (clk_mux_get_parent+0x14/0xc8)
> [<c0400ddc>] (clk_mux_get_parent) from [<c040246c>] (rockchip_rk3066_pll_set_rate+0xd8/0x320)
>
> So to fix that, simply register the pll-mux before the pll, so that
> it will be fully initialized when the pll clock executes its init-
> callback and possibly touches the pll-mux clock.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
> This only surfaced with the clk_core changes for 4.3, so should
> probably just go on top.
>
>  drivers/clk/rockchip/clk-pll.c | 63 +++++++++++++++++++++---------------------
>  1 file changed, 32 insertions(+), 31 deletions(-)

Fixes boot crash on rk3288-veyron-jerry on next-20150824.  It'd be
super great to get this landed somewhere so that we can boot linuxnext
again.  :)

Tested-by: Douglas Anderson <dianders@chromium.org>
