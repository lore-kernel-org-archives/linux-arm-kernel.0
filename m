From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 28 Jan 2012 16:00:11 +0000
Subject: [PATCH] Fix LPC32XX's clock.c
In-Reply-To: <1327673868-19741-1-git-send-email-stigge@antcom.de>
References: <1327673868-19741-1-git-send-email-stigge@antcom.de>
Message-ID: <20120128160011.GA15455@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 27, 2012 at 03:17:48PM +0100, Roland Stigge wrote:
> @@ -382,30 +388,62 @@ static u32 local_clk_usbpll_setup(struct clk_pll_setup *pHCLKPllSetup)
>  static int local_usbpll_enable(struct clk *clk, int enable)
>  {
>  	u32 reg;
> -	int ret = -ENODEV;
> -	unsigned long timeout = 1 + msecs_to_jiffies(10);
> +	int ret = 0;
> +	unsigned long timeout = jiffies + msecs_to_jiffies(20);

...

> -		/* Wait for PLL lock */
> -		while ((timeout > jiffies) & (ret == -ENODEV)) {
> +		/*
> +		 * Enable PLL
> +		 */
> +		reg |= LPC32XX_CLKPWR_USBCTRL_PLL_PWRUP;
> +		__raw_writel(reg, LPC32XX_CLKPWR_USB_CTRL);
> +
> +		/*
> +		 * Wait for PLL to lock
> +		 */
> +		while ((timeout > jiffies) && (ret == -ENODEV)) {

This is buggy - it's waiting to go wrong when jiffies wraps.  You really
want to use time_before() or time_after() to make these comparisons, which
are safe against wrap-around.
