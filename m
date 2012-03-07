From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 7 Mar 2012 18:21:55 +0000
Subject: [PATCH v2 0/9] DMA engine cookie handling cleanups
In-Reply-To: <CABb+yY0A9=XKuw=N1fFXCB507zR3U=wofqATVcO_wtnnVrgXzQ@mail.gmail.com>
References: <20120306223321.GD15201@n2100.arm.linux.org.uk>
 <CABb+yY0A9=XKuw=N1fFXCB507zR3U=wofqATVcO_wtnnVrgXzQ@mail.gmail.com>
Message-ID: <20120307182155.GD18787@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 07, 2012 at 11:39:25PM +0530, Jassi Brar wrote:
> Compilation is broken without the following minor fix.
> After that you may add
>        Acked-by: Jassi Brar <jassisinghbrar@gmail.com>
> 
> diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
> index 49c123f..abf35a3 100644
> --- a/drivers/dma/pl330.c
> +++ b/drivers/dma/pl330.c
> @@ -339,7 +339,6 @@ static int pl330_control(struct dma_chan *chan,
> enum dma_ctrl_cmd cmd, unsigned
>  		/* Mark all desc done */
>  		list_for_each_entry_safe(desc, _dt, &pch->work_list , node) {
>  			desc->status = DONE;
> -			pch->completed = desc->txd.cookie;

I'm not sure just removing this is sufficient.  Presumably it's
there for some reason - maybe it needs replacing with a call to
dma_cookie_complete() to preserve existing behaviour?
