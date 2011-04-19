From: viresh.kumar@st.com (viresh kumar)
Date: Tue, 19 Apr 2011 11:55:45 +0530
Subject: [PATCH 1/6] dmaengine/dw_dmac: Replace spin_lock_bh with irqsave
	variants
In-Reply-To: <e52c8e679fbf3007cf7e5e4bcfc86ea208a09d7c.1303123511.git.viresh.kumar@st.com>
References: <e52c8e679fbf3007cf7e5e4bcfc86ea208a09d7c.1303123511.git.viresh.kumar@st.com>
Message-ID: <4DAD2AE9.7060106@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/18/2011 04:19 PM, Viresh KUMAR wrote:
> dmaengine routines can be called from interrupt context and with interrupts
> disabled.  Whereas spin_unlock_bh can't be called from such contexts. So this
> patch converts all spin_*_bh routines to irqsave variants.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> ---
>  drivers/dma/dw_dmac.c      |   56 +++++++++++++++++++++++++------------------
>  drivers/dma/dw_dmac_regs.h |    1 +
>  2 files changed, 33 insertions(+), 24 deletions(-)
> 
> 
> diff --git a/drivers/dma/dw_dmac_regs.h b/drivers/dma/dw_dmac_regs.h
> index 720f821..c89fd83 100644
> --- a/drivers/dma/dw_dmac_regs.h
> +++ b/drivers/dma/dw_dmac_regs.h
> @@ -173,6 +173,7 @@ struct dw_dma {
>  	void __iomem		*regs;
>  	struct tasklet_struct	tasklet;
>  	struct clk		*clk;
> +	unsigned long		flags; /* for spin_lock_irqsave */

Oops!!!
This must have been added in dw_dma_chan instead :(
Will resend it.

-- 
viresh
