From: rabin@rab.in (Rabin Vincent)
Date: Fri, 12 Apr 2013 15:54:28 +0200
Subject: [PATCH 4/8] dmaengine: ste_dma40: Do not configure channels
 during an channel allocation
In-Reply-To: <1365532783-27425-4-git-send-email-lee.jones@linaro.org>
References: <1365532783-27425-1-git-send-email-lee.jones@linaro.org>
 <1365532783-27425-4-git-send-email-lee.jones@linaro.org>
Message-ID: <CAH+eYFBk8y28e+NwOBpvpdFa29JRXbNpFgjwNumC8GRtB-e7VQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/4/9 Lee Jones <lee.jones@linaro.org>:
> diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
> index 2a0a9d4..9e423ad 100644
> --- a/drivers/dma/ste_dma40.c
> +++ b/drivers/dma/ste_dma40.c
> @@ -2463,16 +2463,10 @@ static int d40_alloc_chan_resources(struct dma_chan *chan)
>         }
>
>         pm_runtime_get_sync(d40c->base->dev);
> -       /* Fill in basic CFG register values */
> -       d40_phy_cfg(&d40c->dma_cfg, &d40c->src_def_cfg,
> -                   &d40c->dst_def_cfg, chan_is_logical(d40c));
>
>         d40_set_prio_realtime(d40c);
>
>         if (chan_is_logical(d40c)) {
> -               d40_log_cfg(&d40c->dma_cfg,
> -                           &d40c->log_def.lcsp1, &d40c->log_def.lcsp3);
> -
>                 if (d40c->dma_cfg.dir == STEDMA40_PERIPH_TO_MEM)
>                         d40c->lcpa = d40c->base->lcpa_base +
>                                 d40c->dma_cfg.src_dev_type * D40_LCPA_CHAN_SIZE;
> @@ -2487,14 +2481,6 @@ static int d40_alloc_chan_resources(struct dma_chan *chan)
>                  d40c->phy_chan->num,
>                  d40c->dma_cfg.use_fixed_channel ? ", fixed" : "");
>
> -
> -       /*
> -        * Only write channel configuration to the DMA if the physical
> -        * resource is free. In case of multiple logical channels
> -        * on the same physical resource, only the first write is necessary.
> -        */
> -       if (is_free_phy)
> -               d40_config_write(d40c);

This function does basic initial configuration which is linked to
whether the channel is pysical or logical -- something that is not being
allowed to be runtime configured, so the place to call this function is
here.  Furthermore, it clears the SSLNK/SDLNK which has to be done here,
when the phy channel is first allocated.
