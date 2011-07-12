From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Tue, 12 Jul 2011 09:47:19 +0530
Subject: [PATCH] dmaengine: add dma_ctrl_cmd to pass buffer stride
	configuration
In-Reply-To: <1310310203-12288-1-git-send-email-sundaram@ti.com>
References: <1310310203-12288-1-git-send-email-sundaram@ti.com>
Message-ID: <CABb+yY1HJOR+QzmM4-ju4cs+8keoyUbMv+SpVoM6BW=DCMzmQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 10, 2011 at 8:33 PM, Sundaram Raju <sundaram@ti.com> wrote:
> Added new dma_ctrl_cmd TI_DMA_STRIDE_CONFIG to pass the TI DMA
> controller specific configurations on how a buffer must be walked
> through and how data is picked for transfer based on a specified
> pattern over the channel.
>
> The configuration passed is specific to the TI DMA controller used.
>
> Signed-off-by: Sundaram Raju <sundaram@ti.com>
> ---
> ?include/linux/dmaengine.h | ? ?5 +++++
> ?1 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index eee7add..51dadc4 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -123,6 +123,10 @@ enum dma_ctrl_flags {
> ?* command.
> ?* @FSLDMA_EXTERNAL_START: this command will put the Freescale DMA controller
> ?* into external start mode.
> + * @TI_DMA_STRIDE_CONFIG: this command is only implemented by TI DMA
> + * controllers that need to pass special configuration on how to walk through
> + * the buffer to pick up data in a specified pattern to be transferred in
> + * the channel.
> ?*/
> ?enum dma_ctrl_cmd {
> ? ? ? ?DMA_TERMINATE_ALL,
> @@ -130,6 +134,7 @@ enum dma_ctrl_cmd {
> ? ? ? ?DMA_RESUME,
> ? ? ? ?DMA_SLAVE_CONFIG,
> ? ? ? ?FSLDMA_EXTERNAL_START,
> + ? ? ? TI_DMA_STRIDE_CONFIG,
> ?};
IMHO this isn't very correct.

1) Striding, in one form or other, is supported by other DMACs as well.
   The number will only increase in future.
   Are we to add  <VENDOR>_DMA_STRIDE_CONFIG for each case ?

2) As Dan noted, client drivers are going to have ifdef hackery in
order to be common
 to other SoCs.

3) TI may not have just one DMAC IP used in all the SoCs. So if you want
  vendor specific defines anyway, please atleast also add DMAC version to it.
  Something like
>        DMA_SLAVE_CONFIG,
>        FSLDMA_EXTERNAL_START,
> +       TI_DMA_v1_STRIDE_CONFIG,
