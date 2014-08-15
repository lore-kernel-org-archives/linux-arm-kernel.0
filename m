From: tony@atomide.com (Tony Lindgren)
Date: Fri, 15 Aug 2014 14:02:11 -0700
Subject: [PATCH 15/15] tty: serial: 8250: omap: add dma support
In-Reply-To: <1408124563-31541-16-git-send-email-bigeasy@linutronix.de>
References: <1408124563-31541-1-git-send-email-bigeasy@linutronix.de>
 <1408124563-31541-16-git-send-email-bigeasy@linutronix.de>
Message-ID: <20140815210211.GD9239@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Sebastian Andrzej Siewior <bigeasy@linutronix.de> [140815 11:13]:
> +#ifdef CONFIG_SERIAL_8250_DMA
> +	if (pdev->dev.of_node) {
> +		/*
> +		 * Oh DMA support. If there are no DMA properties in the DT then
> +		 * we will fall back to a generic DMA channel which does not
> +		 * really work here. To ensure that we do not get a generic DMA
> +		 * channel assigned, we have the the_no_dma_filter_fn() here.
> +		 * To avoid "failed to request DMA" messages we check for DMA
> +		 * properties in DT.
> +		 */
> +		ret = of_property_count_strings(pdev->dev.of_node, "dma-names");
> +		if (ret == 2) {
> +			up.dma = &priv->omap8250_dma;
> +			priv->omap8250_dma.fn = the_no_dma_filter_fn;
> +			priv->omap8250_dma.rx_size = RX_TRIGGER;
> +			priv->omap8250_dma.rxconf.src_maxburst = RX_TRIGGER;
> +			priv->omap8250_dma.txconf.dst_maxburst = TX_TRIGGER;
> +
> +			if (of_machine_is_compatible("ti,am33xx"))
> +				up.bugs |= UART_BUG_DMATX;
> +		}
> +	}
> +#endif

Hmm I wonder if there's a more generic solution to this?

It would be also nice to be able to specify the use of DMA from
the board specific .dts file.

Also, with DMA enabled, looks like omap deeper idle states are
blocked as the DMA stays reserved. After I commented out the
DMA info for my console UART, PM started working.

Regards,

Tony
