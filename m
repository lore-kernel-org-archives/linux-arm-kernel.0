From: skuribay@pobox.com (Shinya Kuribayashi)
Date: Sun, 16 Jan 2011 21:20:36 +0900
Subject: [PATCH 27/48] ARM: PL08x: avoid duplicating registers in txd and
	phychan structures
In-Reply-To: <AANLkTim_1yK_Q7sy4a1iMX2zXG1p3EJ0avGvcYeTP9Us@mail.gmail.com>
References: <20110103222943.GB4572@n2100.arm.linux.org.uk>
	<E1PZt3Z-00025W-0c@rmk-PC.arm.linux.org.uk>
	<AANLkTi=GsMaDQDSuR=Z4AT4Vk4GThx6O_0Le=pjsu9gj@mail.gmail.com>
	<20110115092324.GX15996@n2100.arm.linux.org.uk>
	<AANLkTim_1yK_Q7sy4a1iMX2zXG1p3EJ0avGvcYeTP9Us@mail.gmail.com>
Message-ID: <4D32E294.9040400@pobox.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>> On Mon, Jan 3, 2011 at 2:39 PM, Russell King - ARM Linux
>>> <linux@arm.linux.org.uk>  wrote:
>>>> As we now have all the code accessing the phychan {csrc,cdst,clli,cctl,
>>>> ccfg} members in one function, there's no point storing the data into
>>>> the struct.  Get rid of the struct members.  Re-order the register dump
>>>> in the dev_dbg() to reflect the order we write the registers to the DMA
>>>> device.

If it's revised, fix one nit, s/dev_dbg/dev_vdbg/ to be exact, too.

> @@ -227,19 +219,15 @@ static void pl08x_start_txd(struct pl08x_dma_chan *plchan,
>
>   	dev_vdbg(&pl08x->adev->dev,
>   		"WRITE channel %d: csrc=0x%08x, cdst=0x%08x, "
> -		 "cctl=0x%08x, clli=0x%08x, ccfg=0x%08x\n",
> -		phychan->id,
> -		phychan->csrc,
> -		phychan->cdst,
> -		phychan->cctl,
> -		phychan->clli,
> -		phychan->ccfg);
> -
> -	writel(phychan->csrc, phychan->base + PL080_CH_SRC_ADDR);
> -	writel(phychan->cdst, phychan->base + PL080_CH_DST_ADDR);
> -	writel(phychan->clli, phychan->base + PL080_CH_LLI);
> -	writel(phychan->cctl, phychan->base + PL080_CH_CONTROL);
> -	writel(phychan->ccfg, phychan->base + PL080_CH_CONFIG);
> +		"clli=0x%08x, cctl=0x%08x, ccfg=0x%08x\n",
> +		phychan->id, lli->src, lli->dst, lli->lli, lli->cctl,
> +		ccfg);
