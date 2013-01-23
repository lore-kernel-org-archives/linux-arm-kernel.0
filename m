From: elezegarcia@gmail.com (Ezequiel Garcia)
Date: Wed, 23 Jan 2013 09:26:29 -0300
Subject: [PATCH] Implements DMA on mmci driver for LPC3250 plateform
In-Reply-To: <AB1CB712-43B0-4E47-9752-91447BD749B9@precidata.com>
References: <AB1CB712-43B0-4E47-9752-91447BD749B9@precidata.com>
Message-ID: <CALF0-+XAxkp=tCxMzZNBNYKJ+WoVFqpRE_CyRe3s130=mka2ZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gabriele,

On Wed, Jan 23, 2013 at 7:11 AM, Gabriele Mondada
<gabriele@precidata.com> wrote:
> Signed-off-by: Gabriele Mondada <gabriele@precidata.com>
>
> UPDATE: Here is the patch cleaned up and validated with scripts/checkpatch.pl. I also add a check to prevent crashing when DMA is disabled.
>
> ORIGINAL POST:
> Hi,
> Currently, LPC32xx plateform do not enable DMA on the mmci driver. This makes the driver useless because getting out data from a 64 bytes FIFO by interrupt is not fast enough (at standard SD-card data rate).
>
> DMA is not enabled because LPC32xx has a bug that prevent DMA to work properly with the MMC controller (silicon bug, I guess). NXP did a patch to workaround this, but it has not been commited on the main branch. The patch is for linux 2.6.39.2 and does not use dmaengine.
>
> So, I reworked this patch to make it compatible with the last kernel (3.7). Here it is. Have I any chance to see this patch be commited on the main branch?
>

You can add this sort of description, that's not intended as part of the
commit message after the "---" line and before the diff stat (*).
It's typically used to add a changelog.

See here:
http://permalink.gmane.org/gmane.linux.ports.arm.omap/92215

Also, given you seem to be having some problems preparing the patch
I suggest you to watch Greg's talk on submitting first patch:

http://www.youtube.com/watch?v=LLBrBBImJt4

>
> ---

(*) here!

> drivers/dma/amba-pl08x.c |   20 ++++++
> drivers/mmc/host/mmci.c  |  159 +++++++++++++++++++++++++++++++++++++++++-----
> drivers/mmc/host/mmci.h  |   12 +++-
> 3 files changed, 174 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
> index d1cc579..728f65f 100644
> --- a/drivers/dma/amba-pl08x.c
> +++ b/drivers/dma/amba-pl08x.c
> @@ -1758,6 +1758,26 @@ static void pl08x_free_virtual_channels(struct dma_device *dmadev)
>         }
> }
[...]

-- 
    Ezequiel
