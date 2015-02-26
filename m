From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 26 Feb 2015 00:56:01 +0000
Subject: [PATCH v3] drivers/tty: amba: defer probing DMA availability
 until hw_init
In-Reply-To: <1424910661-26474-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
References: <1424910661-26474-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
Message-ID: <20150226005601.GJ8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 25, 2015 at 07:31:01PM -0500, Jorge Ramirez-Ortiz wrote:
> @@ -275,9 +277,16 @@ static void pl011_dma_probe_initcall(struct device *dev, struct uart_amba_port *
>  	struct dma_chan *chan;
>  	dma_cap_mask_t mask;
>  
> -	chan = dma_request_slave_channel(dev, "tx");
> +	uap->dma_probed = true;
> +
> +	chan = dma_request_slave_channel_reason(dev, "tx");
> +	if (IS_ERR(chan)) {
> +		if (PTR_ERR(chan) == -EPROBE_DEFER) {
> +			dev_warn(uap->port.dev, "DMA driver not ready\n");
> +			return;
> +		}
> +		dev_info(uap->port.dev, "no OF or ACPI DMA data\n");

So if we get an -EPROBE_DEFER, we never try again, because uap->dma_probed
is left true?

Should we even emit a message here?  What if userspace opens and closes
the device multiple times before the DMA driver is ready?

Please get rid of that "no OF or ACPI DMA data" message.  There are
situations where we have a DMA engine, but there is quite legally no
DMA available on the port.  Such a message would be an annoyance.
DMA is optional.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
