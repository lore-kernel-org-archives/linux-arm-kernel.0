From: adrian.hunter@nokia.com (Adrian Hunter)
Date: Tue, 27 Jul 2010 16:22:13 +0300
Subject: [PATCH] mmc: failure of block read wait for long time
In-Reply-To: <1280230066-27612-1-git-send-email-s-ghorai@ti.com>
References: <1280230066-27612-1-git-send-email-s-ghorai@ti.com>
Message-ID: <4C4EDD85.5060606@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sukumar Ghorai wrote:
>  multi-block read failure retries in single block read one by one. It continues
>  retry of subsequent blocks, even after failure. Application will not be able
>  to decode the interleave data (even if few single block read success).
>  This patch fixes this problem by returning at the first failure instead of
>  waiting for long duration.

How can you know what sectors are important to the upper layers?

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
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
