From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 28 Apr 2011 18:11:18 +0100
Subject: [PATCH V3 3/7] dmaengine/dw_dmac: don't call callback routine
	in case dmaengine_terminate_all() is called
In-Reply-To: <b5e9038ecac3f44d265c7321de551bd9b66cdddd.1303896567.git.viresh.kumar@st.com>
References: <cover.1303896566.git.viresh.kumar@st.com>
	<b5e9038ecac3f44d265c7321de551bd9b66cdddd.1303896567.git.viresh.kumar@st.com>
Message-ID: <20110428171118.GC17290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 27, 2011 at 03:06:45PM +0530, Viresh Kumar wrote:
> If dmaengine_terminate_all() is called for dma channel, then it doesn't make
> much sense to call registered callback routine. While in case of success or
> failure it must be called.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> ---
>  drivers/dma/dw_dmac.c |   27 ++++++++++++++-------------
>  1 files changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/dma/dw_dmac.c b/drivers/dma/dw_dmac.c
> index b6dfc39..f590109 100644
> --- a/drivers/dma/dw_dmac.c
> +++ b/drivers/dma/dw_dmac.c
> @@ -198,7 +198,8 @@ static void dwc_dostart(struct dw_dma_chan *dwc, struct dw_desc *first)
>  /*----------------------------------------------------------------------*/
>  
>  static void
> -dwc_descriptor_complete(struct dw_dma_chan *dwc, struct dw_desc *desc)
> +dwc_descriptor_complete(struct dw_dma_chan *dwc, struct dw_desc *desc,
> +		bool callback_required)

If you're using 'bool' then using 'true' and 'false' with it rather than
'1' and '0' is a good idea.
