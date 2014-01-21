From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 21 Jan 2014 16:35:37 -0700
Subject: [PATCH v2 06/15] watchdog: orion: Remove unneeded BRIDGE_CAUSE
 clear
In-Reply-To: <1390295561-3466-7-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1390295561-3466-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1390295561-3466-7-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20140121233537.GS18269@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 21, 2014 at 06:12:32AM -0300, Ezequiel Garcia wrote:
> After adding the IRQ request, the BRIDGE_CAUSE bit should be cleared by the
> bridge interrupt controller. There's no longer a need to do it in the watchdog
> driver, so we can simply remove it.

When we talked about this before I pointed out that sequence here is
important:

- Disable WDT
- Clear bridge
- Enable WDT

Looking at this patch in isolation it looks to me like the clear
bridge lines should be replaced with a request_irq (as that does the
clear) - is the request_irq in the wrong spot?

> @@ -68,9 +66,6 @@ static int orion_wdt_start(struct watchdog_device *wdt_dev)
>  	/* Set watchdog duration */
>  	writel(wdt_tclk * wdt_dev->timeout, wdt_reg + WDT_VAL);
>  
> -	/* Clear watchdog timer interrupt */
> -	writel(~WDT_INT_REQ, BRIDGE_CAUSE);
> -
>  	/* Enable watchdog timer */
>  	atomic_io_modify(wdt_reg + TIMER_CTRL, WDT_EN, WDT_EN);
>  

Regards,
Jason
