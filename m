From: stefan@agner.ch (Stefan Agner)
Date: Tue, 02 Dec 2014 17:53:01 +0100
Subject: [PATCH] dmaengine: fsl-edma: fix calculation of remaining bytes
In-Reply-To: <1415879762-12177-1-git-send-email-stefan@agner.ch>
References: <1415879762-12177-1-git-send-email-stefan@agner.ch>
Message-ID: <5f5e46d80c45693b12c3ad8691d3c90a@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-11-13 12:56, Stefan Agner wrote:
> If the current transfer control descriptor (TCD) was not yet started,
> the address will be the same as the initial address. Hence test if the
> current address is less than or equal to the start address of each TCD.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
> This bug was discovered during development on a AC97 capable SAI driver,
> I don't think that this is currently a issue since only a few drivers
> use DMA on Vybrid so far and don't use the remaining bytes information.
> 
>  drivers/dma/fsl-edma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/fsl-edma.c b/drivers/dma/fsl-edma.c
> index 3c5711d..58c6fc7 100644
> --- a/drivers/dma/fsl-edma.c
> +++ b/drivers/dma/fsl-edma.c
> @@ -386,7 +386,7 @@ static size_t fsl_edma_desc_residue(struct
> fsl_edma_chan *fsl_chan,
>  					&(edesc->tcd[i].vtcd->daddr));
>  
>  		len -= size;
> -		if (cur_addr > dma_addr && cur_addr < dma_addr + size) {
> +		if (cur_addr >= dma_addr && cur_addr < dma_addr + size) {
>  			len += dma_addr + size - cur_addr;
>  			break;
>  		}

Hi Vinod,

Afaik, this has not been applied yet, any reasons why?

--
Stefan
