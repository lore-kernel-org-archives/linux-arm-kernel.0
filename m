From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 29 Jul 2011 12:15:38 +0100
Subject: [PATCH 18/18] dmaengine/amba-pl08x: Call pl08x_free_txd()
	instead of calling kfree() directly
In-Reply-To: <90793b4b9824f8152aa4cea07fd91a8ecd3481e8.1311936524.git.viresh.kumar@st.com>
References: <cover.1311936523.git.viresh.kumar@st.com>
	<90793b4b9824f8152aa4cea07fd91a8ecd3481e8.1311936524.git.viresh.kumar@st.com>
Message-ID: <20110729111538.GJ25640@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 29, 2011 at 04:19:28PM +0530, Viresh Kumar wrote:
> pl08x_prep_channel_resources() is calling kfree() directly for txd(). To
> maintain consistency in code call pl08x_free_txd() instead.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> ---
>  drivers/dma/amba-pl08x.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
> index a72255c..b2a95ce 100644
> --- a/drivers/dma/amba-pl08x.c
> +++ b/drivers/dma/amba-pl08x.c
> @@ -1193,7 +1193,7 @@ static int pl08x_prep_channel_resources(struct pl08x_dma_chan *plchan,
>  
>  	num_llis = pl08x_fill_llis_for_desc(pl08x, txd);
>  	if (!num_llis) {
> -		kfree(txd);
> +		pl08x_free_txd(pl08x, txd);

pl08x_free_txd() is supposed to be called under the channel spinlock,
which is why it isn't used here.  We don't want to hold the spinlock
throughout the LLI filling because that could cause some problems,
and potentially worsen IRQ latency.

It's something which needs more work...
