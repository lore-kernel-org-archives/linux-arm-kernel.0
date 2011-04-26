From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 26 Apr 2011 21:30:44 +0100
Subject: [PATCH 1/6] dmaengine/dw_dmac: Replace spin_lock_bh with
	irqsave variants
In-Reply-To: <e52c8e679fbf3007cf7e5e4bcfc86ea208a09d7c.1303123511.git.viresh.kumar@st.com>
References: <e52c8e679fbf3007cf7e5e4bcfc86ea208a09d7c.1303123511.git.viresh.kumar@st.com>
Message-ID: <20110426203044.GA17290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 18, 2011 at 04:19:59PM +0530, Viresh Kumar wrote:
>  static struct dw_desc *dwc_desc_get(struct dw_dma_chan *dwc)
>  {
> +	struct dw_dma *dw = to_dw_dma(dwc->chan.device);
>  	struct dw_desc *desc, *_desc;
>  	struct dw_desc *ret = NULL;
>  	unsigned int i = 0;
>  
> -	spin_lock_bh(&dwc->lock);
> +	spin_lock_irqsave(&dwc->lock, dw->flags);

It's a very bad idea to store the IRQ flags like this - it means that
another thread operating on this corrupts this threads interrupt flag
settings.

It should be a local variable.
