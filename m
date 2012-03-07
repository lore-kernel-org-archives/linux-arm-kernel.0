From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 7 Mar 2012 09:34:46 +0000
Subject: [PATCH 1/9 v2] ARM: at91: usb ohci add dt support
In-Reply-To: <1331111746-21393-1-git-send-email-plagnioj@jcrosoft.com>
References: <20120307084924.GK21255@game.jcrosoft.org>
 <1331111746-21393-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <20120307093446.GN17370@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 07, 2012 at 10:15:38AM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> +static u64 at91_ohci_dma_mask = DMA_BIT_MASK(32);
> +
> +static int __devinit ohci_at91_of_init(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	int i, ret, gpio;
> +	enum of_gpio_flags flags;
> +	struct at91_usbh_data	*pdata;
> +	u32 ports;
> +
> +	if (!np)
> +		return 0;
> +
> +	/* Right now device-tree probed devices don't get dma_mask set.
> +	 * Since shared usb code relies on it, set it here for now.
> +	 * Once we have dma capability bindings this can go away.
> +	 */
> +	if (!pdev->dev.dma_mask)
> +		pdev->dev.dma_mask = &at91_ohci_dma_mask;

That sounds like a rather big omission from DT - what's happening to
address this (before we end up with lots of drivers with this).  Pretty
much any device which does DMA needs both this and the coherent DMA mask
set properly.

We really don't want this kind of workaround scattered in every driver
which has been converted to DT.
