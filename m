From: rabin@rab.in (Rabin Vincent)
Date: Fri, 12 Apr 2013 16:02:21 +0200
Subject: [PATCH 5/8] dmaengine: ste_dma40: Ensure src and dst registers
 are configured correctly
In-Reply-To: <1365532783-27425-5-git-send-email-lee.jones@linaro.org>
References: <1365532783-27425-1-git-send-email-lee.jones@linaro.org>
 <1365532783-27425-5-git-send-email-lee.jones@linaro.org>
Message-ID: <CAH+eYFCuYg5cyqs8-jWq+9-qjG=Q1s5q+fz+5pu-BxHXtFe2Hw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/4/9 Lee Jones <lee.jones@linaro.org>:
> diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
> index 9e423ad..49d8c9d 100644
> --- a/drivers/dma/ste_dma40.c
> +++ b/drivers/dma/ste_dma40.c
> @@ -2810,9 +2810,9 @@ static int d40_set_runtime_config(struct dma_chan *chan,
>         /* Fill in register values */
>         if (chan_is_logical(d40c))
>                 d40_log_cfg(cfg, &d40c->log_def.lcsp1, &d40c->log_def.lcsp3);
> -       else
> -               d40_phy_cfg(cfg, &d40c->src_def_cfg,
> -                           &d40c->dst_def_cfg, false);
> +
> +       d40_phy_cfg(cfg, &d40c->src_def_cfg, &d40c->dst_def_cfg,
> +                   chan_is_logical(d40c));
>
>         /* These settings will take precedence later */
>         d40c->runtime_addr = config_addr;

There is no need to call this function there.  For a logical channel,
the underlying physical channel's SSCFG/SDCFG should only be written
once in the beginning (via d40_config_write()) so there is no need to
change this src_def_cfg and dst_def_cfg again without using them.  For a
logical channel, d40_phy_cfg() does nothing else which is
runtime_config()able.
