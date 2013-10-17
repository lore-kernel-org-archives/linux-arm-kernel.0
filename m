From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 17 Oct 2013 15:10:33 -0400 (EDT)
Subject: [PATCH 2/2 v3] usb: ohci: remove ep93xx bus glue platform driver
In-Reply-To: <201310171125.50024.hartleys@visionengravers.com>
Message-ID: <Pine.LNX.4.44L0.1310171506210.2436-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 17 Oct 2013, H Hartley Sweeten wrote:

> Convert ep93xx to use the OHCI platform driver and remove the
> ohci-ep93xx bus glue driver.
> 
> Enable CONFIG_OHCI_HCD_PLATFORM in the ep93xx_defconfig so that USB
> is still enabled by default on the EP93xx platform.
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>

> +/*************************************************************************
> + * EP93xx OHCI USB Host
> + *************************************************************************/
> +
> +static struct clk *ep93xx_ohci_host_clock;
> +
> +static int ep93xx_ohci_power_on(struct platform_device *pdev)
> +{
> +	if (!ep93xx_ohci_host_clock) {
> +		ep93xx_ohci_host_clock = devm_clk_get(&pdev->dev, NULL);
> +		if (IS_ERR(ep93xx_ohci_host_clock))
> +			return PTR_ERR(ep93xx_ohci_host_clock);
> +	}
> +
> +	clk_enable(ep93xx_ohci_host_clock);
> +
> +	return 0;

Wasn't this supposed to be changed to:

	return clk_enable(ep93xx_ohci_host_clock);

?  Otherwise it looks fine.  After fixing this, you can add

Acked-by: Alan Stern <stern@rowland.harvard.edu>

Alan Stern
