From: vinod.koul@intel.com (Koul, Vinod)
Date: Mon, 09 May 2011 10:50:25 +0530
Subject: [PATCH V4 3/5] dmaengine/dw_dmac: Divide one sg to many desc,
	if sg len is greater than DWC_MAX_COUNT
In-Reply-To: <f3150fa0fb160c70760b95ac72423ebba354f188.1304596524.git.viresh.kumar@st.com>
References: <cover.1304596524.git.viresh.kumar@st.com>
	<f3150fa0fb160c70760b95ac72423ebba354f188.1304596524.git.viresh.kumar@st.com>
Message-ID: <1304918425.32447.20.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-05-05 at 17:30 +0530, Viresh Kumar wrote:
> If len passed in sg for slave_sg transfers is greater than DWC_MAX_COUNT, then
> driver programmes controller incorrectly.  This patch adds code to handle this
> situation by allocation more than one desc for same sg.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> ---
>  drivers/dma/dw_dmac.c |   65 +++++++++++++++++++++++++++++++++----------------
>  1 files changed, 44 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/dma/dw_dmac.c b/drivers/dma/dw_dmac.c
> index 75b32e1..1662452 100644
> --- a/drivers/dma/dw_dmac.c
> +++ b/drivers/dma/dw_dmac.c
> @@ -695,9 +695,15 @@ dwc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
>  		reg = dws->tx_reg;
>  		for_each_sg(sgl, sg, sg_len, i) {
>  			struct dw_desc	*desc;
> -			u32		len;
> -			u32		mem;
> +			u32		len, dlen, mem;
>  
> +			mem = sg_phys(sg);
> +			len = sg_dma_len(sg);
> +			mem_width = 2;
hardcoding mem_width doesn't make sense, you should take this from input
params

-- 
~Vinod
