From: icenowy@aosc.io (Icenowy Zheng)
Date: Wed, 14 Jun 2017 16:46:07 +0800
Subject: [linux-sunxi] Re: [PATCH 1/2] dmaengine: sun6i: make gate bit in
 sun8i's DMA engines a common quirk
In-Reply-To: <20170614084529.GL13020@localhost>
References: <20170605123348.26137-1-icenowy@aosc.io>
 <20170605123348.26137-2-icenowy@aosc.io> <20170614083252.GK13020@localhost>
 <AD656BCC-5064-454F-9576-FA59283E0C45@aosc.io>
 <20170614084529.GL13020@localhost>
Message-ID: <91ABF048-F73B-40FC-B039-2B2B5007404C@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2017?6?14? GMT+08:00 ??4:45:29, Vinod Koul <vinod.koul@intel.com> ??:
>On Wed, Jun 14, 2017 at 04:32:57PM +0800, Icenowy Zheng wrote:
>> 
>> 
>> ? 2017?6?14? GMT+08:00 ??4:32:52, Vinod Koul <vinod.koul@intel.com>
>??:
>> >On Mon, Jun 05, 2017 at 08:33:47PM +0800, Icenowy Zheng wrote:
>> >> From: Icenowy Zheng <icenowy@aosc.xyz>
>> >> 
>> >> Originally we enable a special gate bit when the compatible
>indicates
>> >> A23/33.
>> >> 
>> >> But according to BSP sources and user manuals, more SoCs will need
>> >this
>> >> gate bit.
>> >> 
>> >> So make it a common quirk configured in the config struct.
>> >> 
>> >> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
>> >> ---
>> >> Changes since original codec patchset v3:
>> >> - Refactored comments to cover some words found in official
>> >documents.
>> >> - Removed the comments when toggling the gate bit.
>> >> 
>> >>  drivers/dma/sun6i-dma.c | 20 +++++++++++++-------
>> >>  1 file changed, 13 insertions(+), 7 deletions(-)
>> >> 
>> >> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
>> >> index a2358780ab2c..252b59c1d1d5 100644
>> >> --- a/drivers/dma/sun6i-dma.c
>> >> +++ b/drivers/dma/sun6i-dma.c
>> >> @@ -101,6 +101,17 @@ struct sun6i_dma_config {
>> >>  	u32 nr_max_channels;
>> >>  	u32 nr_max_requests;
>> >>  	u32 nr_max_vchans;
>> >> +	/*
>> >> +	 * In the datasheets/user manuals of newer Allwinner SoCs, a
>> >special
>> >> +	 * bit (bit 2 at register 0x20) is present.
>> >> +	 * It's named "DMA MCLK interface circuit auto gating bit" in
>the
>> >> +	 * documents, and the footnote of this register says that this
>bit
>> >> +	 * should be set up when initializing the DMA controller.
>> >> +	 * Allwinner A23/A33 user manuals do not have this bit
>documented,
>> >> +	 * however these SoCs really have and need this bit, as seen in
>the
>> >> +	 * BSP kernel source code.
>> >> +	 */
>> >> +	bool gate_needed;
>> >
>> >Since this is a hw property, why is this not added as an optional DT
>> >property?
>> 
>> As it's SoC-specified.
>> 
>> Some SoCs need it, and some don't.
>
>and that is the reason it should be a property
>
>> 
>> SoC info is in compatible, so there's no reason to make it a
>property.
>
>that's why it would need to be optional for the SoC's that needs
>these..

I don't think it proper to add block-specified properties
that can be bound to compatible.

I added Rob Herring to the recipient list.

Rob, do you think this can be added as a property?

This is SoC-specific and compatibles are also SoC-specific.

>
>> 
>> >
>> >>  };
>> >>  
>> >>  /*
>> >> @@ -1009,6 +1020,7 @@ static struct sun6i_dma_config
>> >sun8i_a23_dma_cfg = {
>> >>  	.nr_max_channels = 8,
>> >>  	.nr_max_requests = 24,
>> >>  	.nr_max_vchans   = 37,
>> >> +	.gate_needed	 = true,
>> >>  };
>> >>  
>> >>  static struct sun6i_dma_config sun8i_a83t_dma_cfg = {
>> >> @@ -1174,13 +1186,7 @@ static int sun6i_dma_probe(struct
>> >platform_device *pdev)
>> >>  		goto err_dma_unregister;
>> >>  	}
>> >>  
>> >> -	/*
>> >> -	 * sun8i variant requires us to toggle a dma gating register,
>> >> -	 * as seen in Allwinner's SDK. This register is not documented
>> >> -	 * in the A23 user manual.
>> >> -	 */
>> >> -	if (of_device_is_compatible(pdev->dev.of_node,
>> >> -				    "allwinner,sun8i-a23-dma"))
>> >> +	if (sdc->cfg->gate_needed)
>> >>  		writel(SUN8I_DMA_GATE_ENABLE, sdc->base + SUN8I_DMA_GATE);
>> >>  
>> >>  	return 0;
>> >> -- 
>> >> 2.12.2
>> >> 
