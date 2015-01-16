From: dianders@chromium.org (Doug Anderson)
Date: Fri, 16 Jan 2015 09:11:06 -0800
Subject: [PATCH] clk: rockchip: fix deadlock possibility in cpuclk
In-Reply-To: <355359386.nxMIlHNuqO@phil>
References: <355359386.nxMIlHNuqO@phil>
Message-ID: <CAD=FV=Xc_yabbrC0c0i-wJS+7eW3gq+pHDa81uxNin55jUciNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko,

On Fri, Jan 16, 2015 at 8:52 AM, Heiko St?bner <heiko@sntech.de> wrote:
> Lockdep reported a possible deadlock between the cpuclk lock and for example
> the i2c driver.
>
>        CPU0                    CPU1
>        ----                    ----
>   lock(clk_lock);
>                                local_irq_disable();
>                                lock(&(&i2c->lock)->rlock);
>                                lock(clk_lock);
>   <Interrupt>
>     lock(&(&i2c->lock)->rlock);
>
>  *** DEADLOCK ***
>
> The generic clock-types of the core ccf already use spin_lock_irqsave when
> touching clock registers, so do the same for the cpuclk.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/clk/rockchip/clk-cpu.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/clk/rockchip/clk-cpu.c b/drivers/clk/rockchip/clk-cpu.c
> index 75c8c45..3ecdf7d 100644
> --- a/drivers/clk/rockchip/clk-cpu.c
> +++ b/drivers/clk/rockchip/clk-cpu.c
> @@ -124,10 +124,11 @@ static int rockchip_cpuclk_pre_rate_change(struct rockchip_cpuclk *cpuclk,
>  {
>         const struct rockchip_cpuclk_reg_data *reg_data = cpuclk->reg_data;
>         unsigned long alt_prate, alt_div;
> +       unsigned long flags = 0;

nit: I don't often see flags initted to 0 here when using
spin_lock_irqsave().  I don't think it's needed...

I doubt it really matters though, and this looks fine to me.

Reviewed-by: Doug Anderson <dianders@chromium.org>

-Doug
