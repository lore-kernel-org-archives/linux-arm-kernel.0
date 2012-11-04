From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 4 Nov 2012 10:08:22 +0000
Subject: [PATCH 1/6 v2] arm: use devicetree to get smp_twd clock
In-Reply-To: <1351882309-733-2-git-send-email-mark.langsdorf@calxeda.com>
References: <1351631056-25938-1-git-send-email-mark.langsdorf@calxeda.com>
 <1351882309-733-1-git-send-email-mark.langsdorf@calxeda.com>
 <1351882309-733-2-git-send-email-mark.langsdorf@calxeda.com>
Message-ID: <20121104100822.GY21164@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 02, 2012 at 01:51:44PM -0500, Mark Langsdorf wrote:
> -static struct clk *twd_get_clock(void)
> +static struct clk *twd_get_clock(struct device_node *np)
>  {
> -	struct clk *clk;
> +	struct clk *clk = NULL;
>  	int err;
>  
> -	clk = clk_get_sys("smp_twd", NULL);
> +	if (np)
> +		clk = of_clk_get(np, 0);
> +	if (!clk)

What does a NULL return from of_clk_get() mean?  Where is this defined?

> @@ -349,6 +348,10 @@ int __init twd_local_timer_register(struct twd_local_timer *tlt)
>  	if (!twd_base)
>  		return -ENOMEM;
>  
> +	twd_clk = twd_get_clock(NULL);
> +
> +	twd_clk = twd_get_clock(NULL);
> +

Why twice?
