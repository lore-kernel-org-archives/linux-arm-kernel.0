From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 29 May 2018 16:02:19 +0200
Subject: [PATCH] rtc: sun6i: Fix bit_idx value for clk_register_gate
In-Reply-To: <20180528075032.6769-1-jagan@amarulasolutions.com>
References: <20180528075032.6769-1-jagan@amarulasolutions.com>
Message-ID: <20180529140219.auat656qcl5jdru7@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, May 28, 2018 at 01:20:32PM +0530, Jagan Teki wrote:
> From: Michael Trimarchi <michael@amarulasolutions.com>
> 
> clk-gate core will take bit_idx through clk_register_gate
> and then do clk_gate_ops by using BIT(bit_idx), but rtc-sun6i
> is passing bit_idx as BIT(bit_idx) it becomes BIT(BIT(bit_idx)
> which is wrong and eventually external gate clock is not enabling.
> 
> This patch fixed by passing bit index and the original change
> introduced from below commit.
> "rtc: sun6i: Add support for the external oscillator gate"
> (sha1: 	17ecd246414b3a0fe0cb248c86977a8bda465b7b)
> 
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

Cc'ing to stable and adding a Fixes tag would be great.

> ---
>  drivers/rtc/rtc-sun6i.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
> index 2e6fb275acc8..a66f40c96582 100644
> --- a/drivers/rtc/rtc-sun6i.c
> +++ b/drivers/rtc/rtc-sun6i.c
> @@ -74,7 +74,7 @@
>  #define SUN6I_ALARM_CONFIG_WAKEUP		BIT(0)
>  
>  #define SUN6I_LOSC_OUT_GATING			0x0060
> -#define SUN6I_LOSC_OUT_GATING_EN		BIT(0)
> +#define SUN6I_LOSC_OUT_GATING_EN		0

All the other register definitions in that driver are the actual value
needed, and not the offset. Just to make it obvious that it shouldn't
be used as is, please add an _OFFSET at the end of the defined name

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
