From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 11 Apr 2018 16:14:23 +0100
Subject: [PATCH v2 1/2] dmaengine: stm32-mdma: align TLEN and buffer
 length on burst
In-Reply-To: <1523457879-9869-2-git-send-email-pierre-yves.mordret@st.com>
References: <1523457879-9869-1-git-send-email-pierre-yves.mordret@st.com>
 <1523457879-9869-2-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <9a2a267c-2b0b-0d6a-c762-47e7d37f84ea@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/04/18 15:44, Pierre-Yves MORDRET wrote:
> Both buffer Transfer Length (TLEN if any) and transfer size have to be
> aligned on burst size (burst beats*bus width).
> 
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
> ---
>    Version history:
>      v1:
>         * Initial
>      v2:
> ---
> ---
>   drivers/dma/stm32-mdma.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/stm32-mdma.c b/drivers/dma/stm32-mdma.c
> index daa1602..fbcffa2 100644
> --- a/drivers/dma/stm32-mdma.c
> +++ b/drivers/dma/stm32-mdma.c
> @@ -413,7 +413,7 @@ static u32 stm32_mdma_get_best_burst(u32 buf_len, u32 tlen, u32 max_burst,
>   	u32 best_burst = max_burst;
>   	u32 burst_len = best_burst * width;
>   
> -	while ((burst_len > 0) && (tlen % burst_len)) {
> +	while ((burst_len > 0) && (((tlen | buf_len) & (burst_len - 1)) != 0)) {
>   		best_burst = best_burst >> 1;
>   		burst_len = best_burst * width;
>   	}

FWIW, doesn't that whole loop come down to just:

	burst_len = min(ffs(tlen | buf_len), max_burst * width);

?

Robin.
