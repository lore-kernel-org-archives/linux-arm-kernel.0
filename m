From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 21 Apr 2015 11:02:40 +0100
Subject: [PATCH v4 08/11] ARM: imx: add gpt system timer support for imx7d
In-Reply-To: <1429563933-3129-9-git-send-email-Frank.Li@freescale.com>
References: <1429563933-3129-1-git-send-email-Frank.Li@freescale.com>
 <1429563933-3129-9-git-send-email-Frank.Li@freescale.com>
Message-ID: <20150421100240.GR12732@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 21, 2015 at 05:05:30AM +0800, Frank.Li at freescale.com wrote:
> From: Frank Li <Frank.Li@freescale.com>
> 
> Add GPT system timer support for i.MX7D, it has same hardware
> as i.MX6DL.
> 
> Signed-off-by: Frank Li <Frank.Li@freescale.com>
> Signed-off-by: Anson Huang <b20788@freescale.com>
> ---
>  arch/arm/mach-imx/time.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-imx/time.c b/arch/arm/mach-imx/time.c
> index 15d18e1..7c1d8a3 100644
> --- a/arch/arm/mach-imx/time.c
> +++ b/arch/arm/mach-imx/time.c
> @@ -321,7 +321,7 @@ static void __init _mxc_timer_init(int irq,
>  		tctl_val = V2_TCTL_FRR | V2_TCTL_WAITEN | MXC_TCTL_TEN;
>  		if (clk_get_rate(clk_per) == V2_TIMER_RATE_OSC_DIV8) {
>  			tctl_val |= V2_TCTL_CLK_OSC_DIV8;
> -			if (cpu_is_imx6dl() || cpu_is_imx6sx()) {
> +			if (cpu_is_imx6dl() || cpu_is_imx6sx() || cpu_is_imx7d()) {
>  				/* 24 / 8 = 3 MHz */
>  				__raw_writel(7 << V2_TPRER_PRE24M,
>  					timer_base + MXC_TPRER);
> @@ -383,3 +383,4 @@ CLOCKSOURCE_OF_DECLARE(mx53_timer, "fsl,imx53-gpt", mxc_timer_init_dt);
>  CLOCKSOURCE_OF_DECLARE(mx6q_timer, "fsl,imx6q-gpt", mxc_timer_init_dt);
>  CLOCKSOURCE_OF_DECLARE(mx6sl_timer, "fsl,imx6sl-gpt", mxc_timer_init_dt);
>  CLOCKSOURCE_OF_DECLARE(mx6sx_timer, "fsl,imx6sx-gpt", mxc_timer_init_dt);
> +CLOCKSOURCE_OF_DECLARE(mx7d_timer, "fsl,imx7d-gpt", mxc_timer_init_dt);

Hmm, this suggests to me that something is very wrong here, especially
those cpu_is_imx*() things.

Several questions crop up:

* Shouldn't the code be split between a timer v1 and timer v2 driver,
  and the appropriate one be selected via the DT compatible?

* Shouldn't the clock source for the v2 timer be determined from DT?
  (It looks to me like the v2 timer can be clocked by the perclk or
  by a 24MHz clock with a built-in prescaler.)

* Shouldn't the prescaler for the timer be calculated in the driver and
  the associated divisor automatically set, or specified via DT?

Had these been fixed, you probably wouldn't need to modify the driver to
add iMX7 support here - which is really what DT is supposed to be about.

I'm not expecting you to fix them - but it would be good to get this
properly sorted out so that when iMX8 comes along, the same process
doesn't happen again.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
