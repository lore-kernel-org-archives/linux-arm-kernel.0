From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 30 Nov 2015 15:11:49 +0100
Subject: [RFC v02 04/15] dmaengine: edma: Add support for DMA filter
 mapping to slave devices
In-Reply-To: <1448891145-10766-5-git-send-email-peter.ujfalusi@ti.com>
References: <1448891145-10766-1-git-send-email-peter.ujfalusi@ti.com>
 <1448891145-10766-5-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <7490116.jHcmUxB3Rf@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 30 November 2015 15:45:34 Peter Ujfalusi wrote:
> @@ -2428,6 +2436,22 @@ bool edma_filter_fn(struct dma_chan *chan, void *param)
>  }
>  EXPORT_SYMBOL(edma_filter_fn);
>  
> +static bool edma_filter_for_map(struct dma_chan *chan, void *param)
> +{
> +       bool match = false;
> +
> +       if (chan->device->dev->driver == &edma_driver.driver) {
> +               struct edma_chan *echan = to_edma_chan(chan);
> +               unsigned ch_req = (unsigned)param;
> +               if (ch_req == echan->ch_num) {
> +                       /* The channel is going to be used as HW synchronized */
> +                       echan->hw_triggered = true;
> +                       match = true;
> +               }
> +       }
> +       return match;
> +}
> +
>  static int edma_init(void)
> 

I don't see the difference between edma_filter_fn and edma_filter_for_map.
Why do you need both?

	Arnd
