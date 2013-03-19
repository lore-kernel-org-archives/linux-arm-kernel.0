From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 19 Mar 2013 11:50:17 +0100
Subject: [PATCH 1/7] serial: 8250_dw: add support for clk api
In-Reply-To: <1363689316-7847-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1363689316-7847-1-git-send-email-maxime.ripard@free-electrons.com>
 <1363689316-7847-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <514842E9.401@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Le 19/03/2013 11:35, Maxime Ripard a ?crit :
> From: Emilio L?pez <emilio@elopez.com.ar>
> 
> This commit implements support for using the clk api; this lets us use
> the "clocks" property with device tree, instead of having to use
> clock-frequency.
> 
> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
> ---
>  drivers/tty/serial/8250/8250_dw.c |   33 ++++++++++++++++++++++++---------
>  1 file changed, 24 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> index db0e66f..3dedd24 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -26,6 +26,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/acpi.h>
> +#include <linux/clk.h>
>  
>  #include "8250.h"
>  
> @@ -55,8 +56,9 @@
>  
>  
>  struct dw8250_data {
> -	int	last_lcr;
> -	int	line;
> +	int		last_lcr;
> +	int		line;
> +	struct clk	*clk;
>  };
>  
>  static void dw8250_serial_out(struct uart_port *p, int offset, int value)
> @@ -136,8 +138,13 @@ static int dw8250_probe_of(struct uart_port *p)
>  	if (!of_property_read_u32(np, "reg-shift", &val))
>  		p->regshift = val;
>  
> +	/* clock got configured through clk api, all done */
> +	if (IS_ERR(p->uartclk))

Hmm, I messed up here.

I'll resend a new version of this mail without this IS_ERR call

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
