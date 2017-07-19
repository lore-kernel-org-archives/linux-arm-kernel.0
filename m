From: alexander.sverdlin@gmail.com (Alexander Sverdlin)
Date: Wed, 19 Jul 2017 07:04:40 +0200
Subject: [PATCH 1/9] ARM: ep93xx: allow NULL clock for clk_get_rate
In-Reply-To: <20170718101730.2541-2-jonas.gorski@gmail.com>
References: <20170718101730.2541-1-jonas.gorski@gmail.com>
 <20170718101730.2541-2-jonas.gorski@gmail.com>
Message-ID: <e700ebab-0fd1-f699-3b1c-d528bf003a8e@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/07/17 12:17, Jonas Gorski wrote:
> Make the behaviour of clk_get_rate consistent with common clk's
> clk_get_rate by accepting NULL clocks as parameter. Some device
> drivers rely on this, and will cause an OOPS otherwise.
> 
> Fixes: 1d81eedb8f6c ("[ARM] 3634/1: ep93xx: initial implementation of the clk_* API")
> Cc: Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> Reported-by: Mathias Kresin <dev@kresin.me>
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

Acked-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

> ---
>  arch/arm/mach-ep93xx/clock.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/mach-ep93xx/clock.c b/arch/arm/mach-ep93xx/clock.c
> index 39ef3b613912..f0768befafe8 100644
> --- a/arch/arm/mach-ep93xx/clock.c
> +++ b/arch/arm/mach-ep93xx/clock.c
> @@ -316,6 +316,9 @@ static unsigned long get_uart_rate(struct clk *clk)
>  
>  unsigned long clk_get_rate(struct clk *clk)
>  {
> +	if (!clk)
> +		return 0;
> +
>  	if (clk->get_rate)
>  		return clk->get_rate(clk);
