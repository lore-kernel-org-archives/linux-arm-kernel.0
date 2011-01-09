From: wim@iguana.be (Wim Van Sebroeck)
Date: Sun, 9 Jan 2011 11:07:32 +0100
Subject: [PATCHv3] watchdog: add support for the Synopsys DesignWare WDT
In-Reply-To: <1294401797-24158-1-git-send-email-jamie@jamieiles.com>
References: <1294401797-24158-1-git-send-email-jamie@jamieiles.com>
Message-ID: <20110109100732.GJ3801@infomag.iguana.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jamie,

On top of other comments from Viresh:

> +static int dw_wdt_open(struct inode *inode, struct file *filp)
> +{
> +	/* Make sure we don't get unloaded. */
> +	__module_get(THIS_MODULE);
> +
> +	spin_lock(&dw_wdt.lock);
> +	if (!dw_wdt_is_enabled()) {
> +		/*
> +		 * The watchdog is not currently enabled. Set the timeout to
> +		 * the maximum and then start it.
> +		 */
> +		dw_wdt_set_top(DW_WDT_MAX_TOP);
> +		writel(WDOG_CONTROL_REG_WDT_EN_MASK,
> +		       dw_wdt.regs + WDOG_CONTROL_REG_OFFSET);
> +	}
> +	spin_unlock(&dw_wdt.lock);
> +
> +	return nonseekable_open(inode, filp);
> +}

Would be nice to have the open /dev/watchdog once protection here also.

> +static int __devexit dw_wdt_drv_remove(struct platform_device *pdev)
> +{
> +	clk_disable(dw_wdt.clk);
> +	clk_put(dw_wdt.clk);
> +
> +	misc_deregister(&dw_wdt_miscdev);
> +
> +	return 0;
> +}

misc_deregister (=link to user-space) should be called before the clk_disabel calls.

Kind regards,
Wim.
