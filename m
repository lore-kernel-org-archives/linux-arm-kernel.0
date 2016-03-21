From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 21 Mar 2016 08:29:18 +0100
Subject: [PATCH v3 2/5] dmaengine: sun6i: Add 4 as a possible burst value
 for the H3
In-Reply-To: <8485d9976f327cf23e051f64c3a3c5cbff4214a7.1458311540.git.moinejf@free.fr>
References: <cover.1458311540.git.moinejf@free.fr>
 <8485d9976f327cf23e051f64c3a3c5cbff4214a7.1458311540.git.moinejf@free.fr>
Message-ID: <20160321072918.GV30977@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 18, 2016 at 03:12:26PM +0100, Jean-Francois Moine wrote:
> The H3 accepts 4 as a burst value.
> 
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> ---
>  drivers/dma/sun6i-dma.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> index ce1e4d6..9378fda 100644
> --- a/drivers/dma/sun6i-dma.c
> +++ b/drivers/dma/sun6i-dma.c
> @@ -101,6 +101,7 @@ struct sun6i_dma_config {
>  	u32 nr_max_channels;
>  	u32 nr_max_requests;
>  	u32 nr_max_vchans;
> +	u32 burst_4;
>  };
>  
>  /*
> @@ -238,6 +239,8 @@ static inline s8 convert_burst(u32 maxburst)
>  	switch (maxburst) {
>  	case 1:
>  		return 0;
> +	case 4:
> +		return 1;
>  	case 8:
>  		return 2;
>  	default:
> @@ -470,6 +473,10 @@ static int set_config(struct sun6i_dma_dev *sdev,
>  {
>  	s8 src_width, dst_width, src_burst, dst_burst;
>  
> +	if (!sdev->cfg->burst_4 &&
> +	    (sconfig->src_maxburst == 4 || sconfig->dst_maxburst == 4))
> +		return -EINVAL;
> +

I still believe this should be dealt with at the framework level.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160321/b12e55d5/attachment.sig>
