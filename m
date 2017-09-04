From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 4 Sep 2017 09:06:20 +0200
Subject: [PATCH 01/10] dmaengine: sun6i: Correct setting of clock
 autogating register for A83T/H3
In-Reply-To: <b88769ec-a42d-6b8e-d211-8f1cea139254@arm.com>
References: <20170903224100.17893-1-stefan.bruens@rwth-aachen.de>
 <20170903224100.17893-2-stefan.bruens@rwth-aachen.de>
 <b88769ec-a42d-6b8e-d211-8f1cea139254@arm.com>
Message-ID: <20170904070620.3lpkmq6nt2qrgwah@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 04, 2017 at 12:23:09AM +0100, Andr? Przywara wrote:
> On 03/09/17 23:40, Stefan Br?ns wrote:
> > The H83T uses a compatible string different from the A23, but requires
> 
>       A83T
> 
> > the same clock autogating register setting.
> > 
> > The H3 also requires setting the clock autogating register, but has
> > the register at a different offset.
> > 
> > Some currently available SoCs not yet supported by the sun6i-dma driver
> > will require new compatible strings. These SoCs either follow the A23
> > register model (e.g. V3s) or the H3 register model (A64, R40), so a new
> > variable is added to the config struct to group SoCs with common register
> > models.
> 
> As mentioned in that other mail, using the actual properties as names
> here instead of grouping them to rather arbitrary groups seems more
> useful and future-proof to me and should be easier to read.
> In this case this should simplify this patch:
> sun8i_a23_dma_cfg = {
>  	.nr_max_channels = 8,
>  	.nr_max_requests = 24,
>  	.nr_max_vchans   = 37,
> +	.auto_clock_gate = 0x20,
> ...
> -	if (of_device_is_compatible(pdev->dev.of_node,
> -				    "allwinner,sun8i-a23-dma"))
> -		writel(SUN8I_DMA_GATE_ENABLE, sdc->base + SUN8I_DMA_GATE);
> +	if (sdc->cfg->auto_clock_gate)
> +		writel(SUN8I_DMA_GATE_ENABLE,
> +		       sdc->base + sdc->cfg->auto_clock_gate);

I agree.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170904/858b1032/attachment.sig>
