From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 26 Jul 2017 10:59:31 +0530
Subject: [PATCH v3 2/5] dmaengine: Add STM32 DMAMUX driver
In-Reply-To: <2b916330-9b65-f4d5-817f-79b66cc236b3@st.com>
References: <1499343623-5964-1-git-send-email-pierre-yves.mordret@st.com>
 <1499343623-5964-3-git-send-email-pierre-yves.mordret@st.com>
 <20170722065133.GT3053@localhost>
 <2b916330-9b65-f4d5-817f-79b66cc236b3@st.com>
Message-ID: <20170726052930.GF3053@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 24, 2017 at 01:55:10PM +0000, Pierre Yves MORDRET wrote:

> >> +
> >> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >> +	if (!res)
> >> +		return -ENODEV;
> >> +
> >> +	iomem = devm_ioremap_resource(&pdev->dev, res);
> >> +	if (!iomem)
> >> +		return -ENOMEM;
> >> +
> >> +	spin_lock_init(&stm32_dmamux->lock);
> >> +
> >> +	stm32_dmamux->clk = devm_clk_get(&pdev->dev, NULL);
> >> +	if (IS_ERR(stm32_dmamux->clk)) {
> >> +		dev_info(&pdev->dev, "Missing controller clock\n");
> > 
> > Can you check for EPROBE_DEFER and print only for if that is not the error
> > otherwise we end up sapmming with defered probe issues
> > 
> 
> This is what you meant ?
> 	if (IS_ERR(stm32_dmamux->clk) != EPROBE_DEFER) {
> 		dev_info(&pdev->dev, "Missing controller clock\n");
> 		return PTR_ERR(stm32_dmamux->clk);
> 	}
> 
> OR
> 
> 	if (IS_ERR(stm32_dmamux->clk)) {
> 		if (IS_ERR(stm32_dmamux->clk) != EPROBE_DEFER)
> 			dev_info(&pdev->dev, "Missing controller clock\n");
> 		return PTR_ERR(stm32_dmamux->clk);
> 	}

This one please

> 
> >> +
> >> +#ifndef __DMA_STM32_DMAMUX_H
> >> +#define __DMA_STM32_DMAMUX_H
> >> +
> >> +#if defined(CONFIG_STM32_DMAMUX)
> >> +int stm32_dmamux_set_config(struct device *dev, void *route_data, u32 chan_id);
> > 
> > Why do we need a custom API in this case?
> > 
> 
> This API is called by DMA when a slave is requested by client. DMA can work
> without DMAMUX this API has been put in place to configure DMAMUX whether client
> is requesting a DMAMUX Channel instead of a DMA one.

You mean the dmaengine driver right?

-- 
~Vinod
