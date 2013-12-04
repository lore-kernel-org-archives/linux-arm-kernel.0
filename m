From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 4 Dec 2013 09:29:34 +0100
Subject: [PATCH V2] dma: tegra: register as an OF DMA controller
In-Reply-To: <529E1C1A.5000709@wwwdotorg.org>
References: <1385416416-3536-1-git-send-email-swarren@wwwdotorg.org>
 <20131129141725.GA22771@ulmo.nvidia.com>
 <529E1C1A.5000709@wwwdotorg.org>
Message-ID: <20131204082929.GC19943@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 03, 2013 at 10:59:54AM -0700, Stephen Warren wrote:
> On 11/29/2013 07:17 AM, Thierry Reding wrote:
> > On Mon, Nov 25, 2013 at 02:53:36PM -0700, Stephen Warren wrote: 
> > [...]
> >> memcpy(&tdc->dma_sconfig, sconfig, sizeof(*sconfig)); +	if
> >> (!tdc->slave_id) +		tdc->slave_id = sconfig->slave_id; 
> >> tdc->config_init = true;
> > 
> > This could use some blank lines to unclutter it a bit.
> 
> To be honest, I feel the opposite; random blank lines sprinkled in the
> middle of related code make the code structure harder to follow.

I don't think they are random at all, but we can probably go on arguing
about that for a long time. So if you prefer to keep it cluttered, feel
free to do so. =P

> >> @@ -942,7 +947,7 @@ static struct dma_async_tx_descriptor
> >> *tegra_dma_prep_slave_sg( ahb_seq |=
> >> TEGRA_APBDMA_AHBSEQ_BUS_WIDTH_32;
> >> 
> >> csr |= TEGRA_APBDMA_CSR_ONCE | TEGRA_APBDMA_CSR_FLOW; -	csr |=
> >> tdc->dma_sconfig.slave_id << TEGRA_APBDMA_CSR_REQ_SEL_SHIFT; +
> >> csr |= tdc->slave_id << TEGRA_APBDMA_CSR_REQ_SEL_SHIFT;
> > 
> > Perhaps I'm missing something, but couldn't we reuse the .slave_id
> > field of struct dma_slave_config? It seems like it might be
> > overwritten by the DMA engine core or users when they call
> > dmaengine_slave_config().
> 
> The slave ID seems channel-specific to me, and hence should be managed
> at the channel level. struct dma_slave_config is the client-specified
> runtime properties. As you mention, I also worry about client drivers
> trampling over the dma_slave_config data, so storing it where they
> can't doesn't seem like a good idea.

I think you meant "does seem like a good idea"? The reason why this had
me puzzled is probably that I haven't seen this pattern in subsystems
I'm more familiar with. Like you said, it seems like a channel-specific
property, so clients should have no business modifying it.

But I assume there were valid reasons for doing things this way, so I
withdraw my objections.

> >> static int tegra_dma_probe(struct platform_device *pdev) { struct
> >> resource	*res; @@ -1383,10 +1402,22 @@ static int
> >> tegra_dma_probe(struct platform_device *pdev) goto err_irq; }
> >> 
> >> +	tdma->xlate_info.device = &tdma->dma_dev; +
> >> tdma->xlate_info.post_alloc = tegra_dma_of_xlate_post_alloc; +
> >> ret = of_dma_controller_register(pdev->dev.of_node, +
> >> of_dma_slave_xlate, &tdma->xlate_info); +	if (ret < 0) { +
> >> dev_err(&pdev->dev, +			"Tegra20 APB DMA OF registration failed
> >> %d\n", ret); +		goto err_unregister_dma_dev; +	}
> > 
> > Would it be useful to move this into the core and have it register
> > the OF parts transparently to the driver? That's of course nothing
> > that should be done in this patch.
> 
> That'd probably be possible, yes, given a few extra fields in struct
> dma_device, e.g. for the of_xlate function pointer. As you say, I
> won't address it in this patch though.

Okay, that's fine.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131204/a2e263e8/attachment.sig>
