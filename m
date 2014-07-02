From: stefan@agner.ch (Stefan Agner)
Date: Wed, 02 Jul 2014 16:13:04 +0200
Subject: [PATCH] dmaengine: fsl-edma: fix dmamux index calculating error
In-Reply-To: <1404204063-20961-1-git-send-email-jingchang.lu@freescale.com>
References: <1404204063-20961-1-git-send-email-jingchang.lu@freescale.com>
Message-ID: <9c969818e13bcd71307db22fd163a6db@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 2014-07-01 10:41, schrieb Jingchang Lu:
>  	u32 ch = fsl_chan->vchan.chan.chan_id;
> -	void __iomem *muxaddr = fsl_chan->edma->muxbase[ch / DMAMUX_NR];
> +	void __iomem *muxaddr;
>  	unsigned chans_per_mux, ch_off;
>  
>  	chans_per_mux = fsl_chan->edma->n_chans / DMAMUX_NR;
>  	ch_off = fsl_chan->vchan.chan.chan_id % chans_per_mux;
> +	muxaddr = fsl_chan->edma->muxbase[ch / chans_per_mux];

After realizing that only one DMA channel was working on Vybrid I first
came up with an almost identically patch before I found this one. I now
applied and tested this one. Without this patch, the DMA user (e.g.
lpuart) fails gracefully and work nonetheless, however without DMA.
Since eDMA support is broken in current state in 3.16-rc3, it would be
good to get this patch into 3.16.

Tested-by: Stefan Agner <stefan@agner.ch>

--
Stefan
