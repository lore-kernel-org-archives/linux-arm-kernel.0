From: cjb@laptop.org (Chris Ball)
Date: Fri, 27 Aug 2010 21:59:54 +0100
Subject: [PATCH] mmc: failure of block read wait for long time
In-Reply-To: <1280230066-27612-1-git-send-email-s-ghorai@ti.com>
References: <1280230066-27612-1-git-send-email-s-ghorai@ti.com>
Message-ID: <20100827205954.GA27804@void.printf.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jul 27, 2010 at 04:57:46PM +0530, Sukumar Ghorai wrote:
>  multi-block read failure retries in single block read one by one. It continues
>  retry of subsequent blocks, even after failure. Application will not be able
>  to decode the interleave data (even if few single block read success).
>  This patch fixes this problem by returning at the first failure instead of
>  waiting for long duration.
> 
> Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
> ---
>  drivers/mmc/card/block.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index cb9fbc8..cfb0827 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -419,7 +419,6 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
>  				spin_lock_irq(&md->lock);
>  				ret = __blk_end_request(req, -EIO, brq.data.blksz);
>  				spin_unlock_irq(&md->lock);
> -				continue;
>  			}
>  			goto cmd_err;
>  		}
> --

Sukumar/Adrian, any thoughts on a new version of this patch containing
Adrian's retry-segments idea?

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
