From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 09 Jun 2018 14:43:57 +0200
Subject: [RESEND v2] dmaengine: pxa: add a default requestor policy
In-Reply-To: <20180530201249.26972-1-robert.jarzmik@free.fr> (Robert Jarzmik's
 message of "Wed, 30 May 2018 22:12:49 +0200")
References: <20180530201249.26972-1-robert.jarzmik@free.fr>
Message-ID: <878t7oruya.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> As what former drcmr -1 value meant, add a this as a default to each
> channel, ie. that by default no requestor line is used.
>
> This is specifically used for network drivers smc91x and smc911x, and
> needed for their port to slave maps.
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
> Since v1: changed -1 to U32_MAX
Hi Vinod,

Could I have your ack on this so that I add this one to the dma slave map serie
after the merge window is closed please ?

Cheers.

--
Robert

> ---
>  drivers/dma/pxa_dma.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
> index 9505334f9c6e..b31c28b67ad3 100644
> --- a/drivers/dma/pxa_dma.c
> +++ b/drivers/dma/pxa_dma.c
> @@ -762,6 +762,8 @@ static void pxad_free_chan_resources(struct dma_chan *dchan)
>  	dma_pool_destroy(chan->desc_pool);
>  	chan->desc_pool = NULL;
>  
> +	chan->drcmr = U32_MAX;
> +	chan->prio = PXAD_PRIO_LOWEST;
>  }
>  
>  static void pxad_free_desc(struct virt_dma_desc *vd)
> @@ -1386,6 +1388,9 @@ static int pxad_init_dmadev(struct platform_device *op,
>  		c = devm_kzalloc(&op->dev, sizeof(*c), GFP_KERNEL);
>  		if (!c)
>  			return -ENOMEM;
> +
> +		c->drcmr = U32_MAX;
> +		c->prio = PXAD_PRIO_LOWEST;
>  		c->vc.desc_free = pxad_free_desc;
>  		vchan_init(&c->vc, &pdev->slave);
>  		init_waitqueue_head(&c->wq_state);

-- 
Robert
