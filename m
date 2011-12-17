From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 17 Dec 2011 21:17 +0100
Subject: [PATCHv2 5/5] ARM: picoxcell: implement watchdog restart
In-Reply-To: <1324129357-16030-6-git-send-email-jamie@jamieiles.com>
References: <1324129357-16030-1-git-send-email-jamie@jamieiles.com>
 <1324129357-16030-6-git-send-email-jamie@jamieiles.com>
Message-ID: <1771411.xn5pEUbjJo@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 17 December 2011 13:42:37 Jamie Iles wrote:
> Allow the platform to be restarted by triggering the watchdog to expire
> with the shortest possible expiry.  This should reset the CPU core and
> all on-chip peripherals.
> 
> Signed-off-by: Jamie Iles <jamie@jamieiles.com>

Hi Jamie,

> @@ -23,6 +24,22 @@
>  
>  #include "common.h"
>  
> +#define WDT_CTRL_REG_EN_MASK	(1 << 0)
> +#define WDT_CTRL_REG_OFFS	(0x00)
> +#define WDT_TIMEOUT_REG_OFFS	(0x04)
> +static void __iomem *wdt_regs;
> +
> +static void picoxcell_setup_restart(void)
> +{
> +	struct device_node *np = of_find_compatible_node(NULL, NULL,
> +							 "snps,dw-apb-wdg");
> +	if (WARN(!np, "unable to setup watchdog restart"))
> +		return;
> +
> +	wdt_regs = of_iomap(np, 0);
> +	WARN(!wdt_regs, "failed to remap watchdog regs");
> +}

Can you do this at restart time? I think it would be nicer to
avoid the global variable and init function and instead have
everything in a single function call for restart

> +static void picoxcell_wdt_restart(char mode, const char *cmd)
> +{
> +	/*
> +	 * Configure the watchdog to reset with the shortest possible timeout
> +	 * and give it chance to do the reset.
> +	 */
> +	if (wdt_regs) {
> +		__raw_writel(WDT_CTRL_REG_EN_MASK, wdt_regs + WDT_CTRL_REG_OFFS);
> +		__raw_writel(0, wdt_regs + WDT_TIMEOUT_REG_OFFS);
> +		mdelay(500);
> +	}
> +}

Does this work if the real watchdog is still running, on a preemtible kernel?

Also, please always use writel_relaxed instead of __raw_writel, and try to use
msleep instead of mdelay by default. If msleep doesn't work here because it
actually causes the system not to be reset, just add a comment.

	Arnd
