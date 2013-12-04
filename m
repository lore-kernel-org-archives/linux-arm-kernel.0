From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 4 Dec 2013 10:00:13 +0100
Subject: [PATCH 18/31] ASoC: tegra: allocate AHUB FIFO during probe() not
 startup()
In-Reply-To: <529E374B.8090903@wwwdotorg.org>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
 <1384548866-13141-19-git-send-email-swarren@wwwdotorg.org>
 <20131129144025.GA9712@ulmo.nvidia.com>
 <529E374B.8090903@wwwdotorg.org>
Message-ID: <20131204090012.GJ19943@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 03, 2013 at 12:55:55PM -0700, Stephen Warren wrote:
> On 11/29/2013 07:40 AM, Thierry Reding wrote:
> > On Fri, Nov 15, 2013 at 01:54:13PM -0700, Stephen Warren wrote:
> >> Teh Tegra30 I2S driver currently allocates DMA FIFOs from the
> >> AHUB only when an audio stream starts playback. This is
> >> theoretically nice for resource sharing, but makes no practical
> >> difference for any configuration the drivers currently support.
> >> However, this deferral prevents conversion to the standard DMA DT
> >> bindings, since conversion requires knowledge of the specific DMA
> >> channel to be allocated, which in turn depends on which specific
> >> FIFO was allocated.
> >> 
> >> For this reason, move the FIFO allocate into probe() to allow
> >> later
> ...
> >> +	i2s->playback_dma_data.addr_width =
> >> DMA_SLAVE_BUSWIDTH_4_BYTES; +	i2s->playback_dma_data.maxburst =
> >> 4; +	ret =
> >> tegra30_ahub_allocate_tx_fifo(&i2s->playback_fifo_cif, +
> >> &i2s->playback_dma_data.addr, +
> >> &i2s->playback_dma_data.slave_id); +	if (ret) { +
> >> dev_err(&pdev->dev, "Could not alloc TX FIFO: %d\n", ret); +
> >> goto err_suspend; +	} +	ret =
> >> tegra30_ahub_set_rx_cif_source(i2s->playback_i2s_cif, +
> >> i2s->playback_fifo_cif); +	if (ret) { +		dev_err(&pdev->dev,
> >> "Could not route TX FIFO: %d\n", ret); +		goto err_free_tx_fifo; 
> >> +	} + +	i2s->capture_dma_data.addr_width =
> >> DMA_SLAVE_BUSWIDTH_4_BYTES; +	i2s->capture_dma_data.maxburst =
> >> 4; +	ret = tegra30_ahub_allocate_rx_fifo(&i2s->capture_fifo_cif, 
> >> +					    &i2s->capture_dma_data.addr, +
> >> &i2s->capture_dma_data.slave_id); +	if (ret) { +
> >> dev_err(&pdev->dev, "Could not alloc RX FIFO: %d\n", ret); +
> >> goto err_unroute_tx_fifo; +	} +	ret =
> >> tegra30_ahub_set_rx_cif_source(i2s->capture_fifo_cif, +
> >> i2s->capture_i2s_cif); +	if (ret) { +		dev_err(&pdev->dev, "Could
> >> not route TX FIFO: %d\n", ret); +		goto err_free_rx_fifo; +	} +
> > 
> > It could be useful to have these in a separate function so as not
> > to make the .probe() any larger. It's already pretty big as it is.
> 
> May I ignore this; I personally prefer larger linear functions; it's
> much easier to follow the code-flow without having to jump back/forth
> between a bunch of single-use functions.

Alright, I won't lose any sleep over it.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131204/8719cad6/attachment.sig>
