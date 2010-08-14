From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Sat, 14 Aug 2010 22:33:36 +0200 (CEST)
Subject: [PATCH] tmio_mmc: fix misuse of kunmap_atomic() in tmio_mmc.c
In-Reply-To: <1281628291-23802-1-git-send-email-eric.y.miao@gmail.com>
References: <1281628291-23802-1-git-send-email-eric.y.miao@gmail.com>
Message-ID: <Pine.LNX.4.64.1008142230040.16329@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric

On Thu, 12 Aug 2010, Eric Miao wrote:

> According to commit 597781f3e51f48ef8e67be772196d9e9673752c4
> 
>     kmap_atomic: make kunmap_atomic() harder to misuse
> 
> kunmap_atomic() takes a pointer to within the page, instead of a pointer
> to 'struct page'.  So tmio_mmc_kunmap_atomic() should really take the
> pointer what tmio_mmc_kmap_atomic() returns.

As you have seen, I've also prepared a fix for this problem, just haven't 
sent it fast enough;) And, I think, your fix isn't quite correct: "buf" is 
not the returned value from tmio_mmc_kmap_atomic(), so, you cannot use it 
for unmapping.

Thanks
Guennadi

> 
> Cc: Ian Molton <spyro@f2s.com>
> Cc: Magnus Damm <damm@opensource.se>
> Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
> ---
>  drivers/mmc/host/tmio_mmc.c |    2 +-
>  drivers/mmc/host/tmio_mmc.h |    5 ++---
>  2 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
> index ee7d0a5..24b9c3e 100644
> --- a/drivers/mmc/host/tmio_mmc.c
> +++ b/drivers/mmc/host/tmio_mmc.c
> @@ -191,7 +191,7 @@ static void tmio_mmc_pio_irq(struct tmio_mmc_host *host)
>  
>  	host->sg_off += count;
>  
> -	tmio_mmc_kunmap_atomic(host, &flags);
> +	tmio_mmc_kunmap_atomic(buf, &flags);
>  
>  	if (host->sg_off == host->sg_ptr->length)
>  		tmio_mmc_next_sg(host);
> diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
> index 64f7d5d..8f308b9 100644
> --- a/drivers/mmc/host/tmio_mmc.h
> +++ b/drivers/mmc/host/tmio_mmc.h
> @@ -186,10 +186,9 @@ static inline char *tmio_mmc_kmap_atomic(struct tmio_mmc_host *host,
>  	return kmap_atomic(sg_page(sg), KM_BIO_SRC_IRQ) + sg->offset;
>  }
>  
> -static inline void tmio_mmc_kunmap_atomic(struct tmio_mmc_host *host,
> -	unsigned long *flags)
> +static inline void tmio_mmc_kunmap_atomic(void *buf, unsigned long *flags)
>  {
> -	kunmap_atomic(sg_page(host->sg_ptr), KM_BIO_SRC_IRQ);
> +	kunmap_atomic(buf, KM_BIO_SRC_IRQ);
>  	local_irq_restore(*flags);
>  }
>  
> -- 
> 1.7.0.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
