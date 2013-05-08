From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 8 May 2013 19:03:43 +0100
Subject: [PATCH V2 1/2] ARM/MVF600: add Vybrid Family platform support
In-Reply-To: <1367480285-26159-2-git-send-email-b35083@freescale.com>
References: <1367480285-26159-1-git-send-email-b35083@freescale.com>
 <1367480285-26159-2-git-send-email-b35083@freescale.com>
Message-ID: <20130508180343.GN18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 02, 2013 at 03:38:04PM +0800, Jingchang Lu wrote:
> +void mvf_restart(char mode, const char *cmd)
> +{
> +	struct device_node *np;
> +	void __iomem *wdog_base;
> +	struct clk *wdog_clk;
> +
> +	np = of_find_compatible_node(NULL, NULL, "fsl,mvf-wdt");
> +	wdog_base = of_iomap(np, 0);
> +	if (!wdog_base)
> +		goto soft;
> +
> +	wdog_clk = of_clk_get_by_name(np, "wdog");
> +	if (!IS_ERR(wdog_clk))
> +		clk_prepare_enable(wdog_clk);

I just spotted this in another email.  This is _not_ going to work
reliably.  This path gets called from all sorts of contexts, including
when the system has crashed.  It can also be called from unschedulable
contexts - and the above functions _will_ trigger might_sleep()
warnings as a result.

The only solution to this is to put this setup for this in a separate
function which is called at boot time.
