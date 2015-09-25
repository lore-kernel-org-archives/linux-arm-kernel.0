From: rsahu@apm.com (Rameshwar Sahu)
Date: Fri, 25 Sep 2015 12:48:21 +0530
Subject: [PATCH] dmaengine: xgene-dma: Fix overwritting DMA tx ring
In-Reply-To: <1442390603-21129-1-git-send-email-rsahu@apm.com>
References: <1442390603-21129-1-git-send-email-rsahu@apm.com>
Message-ID: <CAFd313z_Xxu4BaUvHHOzYJO9bW66XjJFe4+w6igsydTqRcZGwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

On Wed, Sep 16, 2015 at 1:33 PM, Rameshwar Prasad Sahu <rsahu@apm.com> wrote:
> This patch fixes an over flow issue with the TX ring descriptor. Each
> descriptor is 32B in size and an operation requires 2 of these
> descriptors.
>
> Signed-off-by: Rameshwar Prasad Sahu <rsahu@apm.com>
> ---
>  drivers/dma/xgene-dma.c | 37 +++++++++++--------------------------
>  1 file changed, 11 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/dma/xgene-dma.c b/drivers/dma/xgene-dma.c
> index b23e8d5..21ba2cc 100644
> --- a/drivers/dma/xgene-dma.c
> +++ b/drivers/dma/xgene-dma.c
> @@ -59,7 +59,6 @@
>  #define XGENE_DMA_RING_MEM_RAM_SHUTDOWN                0xD070
>  #define XGENE_DMA_RING_BLK_MEM_RDY             0xD074
>  #define XGENE_DMA_RING_BLK_MEM_RDY_VAL         0xFFFFFFFF
> -#define XGENE_DMA_RING_DESC_CNT(v)             (((v) & 0x0001FFFE) >> 1)
>  #define XGENE_DMA_RING_ID_GET(owner, num)      (((owner) << 6) | (num))
>  #define XGENE_DMA_RING_DST_ID(v)               ((1 << 10) | (v))
>  #define XGENE_DMA_RING_CMD_OFFSET              0x2C
> @@ -379,14 +378,6 @@ static u8 xgene_dma_encode_xor_flyby(u32 src_cnt)
>         return flyby_type[src_cnt];
>  }
>
> -static u32 xgene_dma_ring_desc_cnt(struct xgene_dma_ring *ring)
> -{
> -       u32 __iomem *cmd_base = ring->cmd_base;
> -       u32 ring_state = ioread32(&cmd_base[1]);
> -
> -       return XGENE_DMA_RING_DESC_CNT(ring_state);
> -}
> -
>  static void xgene_dma_set_src_buffer(__le64 *ext8, size_t *len,
>                                      dma_addr_t *paddr)
>  {
> @@ -659,15 +650,12 @@ static void xgene_dma_clean_running_descriptor(struct xgene_dma_chan *chan,
>         dma_pool_free(chan->desc_pool, desc, desc->tx.phys);
>  }
>
> -static int xgene_chan_xfer_request(struct xgene_dma_ring *ring,
> -                                  struct xgene_dma_desc_sw *desc_sw)
> +static void xgene_chan_xfer_request(struct xgene_dma_chan *chan,
> +                                   struct xgene_dma_desc_sw *desc_sw)
>  {
> +       struct xgene_dma_ring *ring = &chan->tx_ring;
>         struct xgene_dma_desc_hw *desc_hw;
>
> -       /* Check if can push more descriptor to hw for execution */
> -       if (xgene_dma_ring_desc_cnt(ring) > (ring->slots - 2))
> -               return -EBUSY;
> -
>         /* Get hw descriptor from DMA tx ring */
>         desc_hw = &ring->desc_hw[ring->head];
>
> @@ -694,11 +682,13 @@ static int xgene_chan_xfer_request(struct xgene_dma_ring *ring,
>                 memcpy(desc_hw, &desc_sw->desc2, sizeof(*desc_hw));
>         }
>
> +       /* Increment the pending transaction count */
> +       chan->pending += ((desc_sw->flags &
> +                         XGENE_DMA_FLAG_64B_DESC) ? 2 : 1);
> +
>         /* Notify the hw that we have descriptor ready for execution */
>         iowrite32((desc_sw->flags & XGENE_DMA_FLAG_64B_DESC) ?
>                   2 : 1, ring->cmd);
> -
> -       return 0;
>  }
>
>  /**
> @@ -710,7 +700,6 @@ static int xgene_chan_xfer_request(struct xgene_dma_ring *ring,
>  static void xgene_chan_xfer_ld_pending(struct xgene_dma_chan *chan)
>  {
>         struct xgene_dma_desc_sw *desc_sw, *_desc_sw;
> -       int ret;
>
>         /*
>          * If the list of pending descriptors is empty, then we
> @@ -735,18 +724,13 @@ static void xgene_chan_xfer_ld_pending(struct xgene_dma_chan *chan)
>                 if (chan->pending >= chan->max_outstanding)
>                         return;
>
> -               ret = xgene_chan_xfer_request(&chan->tx_ring, desc_sw);
> -               if (ret)
> -                       return;
> +               xgene_chan_xfer_request(chan, desc_sw);
>
>                 /*
>                  * Delete this element from ld pending queue and append it to
>                  * ld running queue
>                  */
>                 list_move_tail(&desc_sw->node, &chan->ld_running);
> -
> -               /* Increment the pending transaction count */
> -               chan->pending++;
>         }
>  }
>
> @@ -821,7 +805,8 @@ static void xgene_dma_cleanup_descriptors(struct xgene_dma_chan *chan)
>                  * Decrement the pending transaction count
>                  * as we have processed one
>                  */
> -               chan->pending--;
> +               chan->pending -= ((desc_sw->flags &
> +                                 XGENE_DMA_FLAG_64B_DESC) ? 2 : 1);
>
>                 /*
>                  * Delete this node from ld running queue and append it to
> @@ -1482,7 +1467,7 @@ static int xgene_dma_create_chan_rings(struct xgene_dma_chan *chan)
>                  tx_ring->id, tx_ring->num, tx_ring->desc_vaddr);
>
>         /* Set the max outstanding request possible to this channel */
> -       chan->max_outstanding = rx_ring->slots;
> +       chan->max_outstanding = tx_ring->slots;
>
>         return ret;
>  }
> --
> 1.8.2.1
>

Any comments on above patch ??
