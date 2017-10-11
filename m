From: pierre-yves.mordret@st.com (Pierre Yves MORDRET)
Date: Wed, 11 Oct 2017 14:16:28 +0200
Subject: [PATCH][dma-next] dmaengine: stm32: remove redundant
 initialization of hwdesc
In-Reply-To: <20171011102822.19166-1-colin.king@canonical.com>
References: <20171011102822.19166-1-colin.king@canonical.com>
Message-ID: <c7a5f1e9-1a70-dfd8-025e-7889b170de93@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 10/11/2017 12:28 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> hwdesc is being initialized to desc->hwdesc but this is never read
> as hwdesc is overwritten in a for-loop.  Remove the redundant
> initialization and move the declaration of hwdesc into the for-loop.
> 
> Cleans up clang warning:
> Value stored to 'hwdesc' during its initialization is never read
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/dma/stm32-mdma.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/stm32-mdma.c b/drivers/dma/stm32-mdma.c
> index 0db59a7e80e0..d3be6bffdf12 100644
> --- a/drivers/dma/stm32-mdma.c
> +++ b/drivers/dma/stm32-mdma.c
> @@ -1252,13 +1252,13 @@ static size_t stm32_mdma_desc_residue(struct stm32_mdma_chan *chan,
>  				      u32 curr_hwdesc)
>  {
>  	struct stm32_mdma_device *dmadev = stm32_mdma_get_dev(chan);
> -	struct stm32_mdma_hwdesc *hwdesc = desc->hwdesc;
>  	u32 cbndtr, residue, modulo, burst_size;
>  	int i;
>  
>  	residue = 0;
>  	for (i = curr_hwdesc + 1; i < desc->count; i++) {
> -		hwdesc = &desc->hwdesc[i];
> +		struct stm32_mdma_hwdesc *hwdesc = &desc->hwdesc[i];
> +
>  		residue += STM32_MDMA_CBNDTR_BNDT(hwdesc->cbndtr);
>  	}
>  	cbndtr = stm32_mdma_read(dmadev, STM32_MDMA_CBNDTR(chan->id));
> 

Acked-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
