From: ryan@bluewatersys.com (Ryan Mallon)
Date: Tue, 18 Jan 2011 10:35:16 +1300
Subject: [PATCH] MTD: atmel_nand: Add DMA support to access Nandflash
In-Reply-To: <1295248809-30334-2-git-send-email-hong.xu@atmel.com>
References: <hong.xu@atmel.com>
	<1295248809-30334-2-git-send-email-hong.xu@atmel.com>
Message-ID: <4D34B614.3000909@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/17/2011 08:20 PM, Hong Xu wrote:
> Some SAM9 chips have the ability to perform DMA between CPU and SMC controller.
> This patch adds DMA support for SAM9RL, SAM9G45, SSAM9G46,AM9M10, SAM9M11.
> 
> Signed-off-by: Hong Xu <hong.xu@atmel.com>
> ---

One more comment:

> +	if (cpu_has_dma() && use_dma) {
> +		dma_cap_mask_t mask;
> +
> +		dma_cap_zero(mask);
> +		dma_cap_set(DMA_MEMCPY, mask);
> +		host->dma_chan = dma_request_channel(mask, 0, NULL);
> +
> +		if (!host->dma_chan) {
> +			dev_err(host->dev, "Failed to request DMA channel\n");
> +			host->dma_ready = 0;

Because host is kzalloc'ed above, you do not need to set host->dma_ready
to zero here.

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
