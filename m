From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 29 Jul 2011 12:06:38 +0100
Subject: [PATCH 12/18] dmaengine/amba-pl08x: Add
	prep_single_byte_llis() routine
In-Reply-To: <cacf3470c622f311c894e6c72f13ba02be82af73.1311936524.git.viresh.kumar@st.com>
References: <cover.1311936523.git.viresh.kumar@st.com>
	<cacf3470c622f311c894e6c72f13ba02be82af73.1311936524.git.viresh.kumar@st.com>
Message-ID: <20110729110638.GH25640@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 29, 2011 at 04:19:22PM +0530, Viresh Kumar wrote:
> Code for creating single byte llis is present at several places. Create a
> routine to avoid code redundancy.
> 
> Also, we don't need one lli per single byte transfer, we can have single lli to
> do all single byte transfer.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> ---
>  drivers/dma/amba-pl08x.c |   61 +++++++++++++++++++++++++---------------------
>  1 files changed, 33 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
> index 3b7357e..590397d 100644
> --- a/drivers/dma/amba-pl08x.c
> +++ b/drivers/dma/amba-pl08x.c
> @@ -552,6 +552,14 @@ static void pl08x_fill_lli_for_desc(struct pl08x_lli_build_data *bd,
>  	bd->remainder -= len;
>  }
>  
> +static inline void prep_byte_width_lli(struct pl08x_lli_build_data *bd,
> +		u32 *cctl, u32 len, int num_llis, size_t *total_bytes)
> +{
> +		*cctl = pl08x_cctl_bits(*cctl, 1, 1, len);
> +		pl08x_fill_lli_for_desc(bd, num_llis, len, *cctl);
> +		(*total_bytes) += len;

Seeing as your patch series started with a cleanup of spacing/tabbing,
it's surprising to find a patch introducing new code which has broken
tabbing.
