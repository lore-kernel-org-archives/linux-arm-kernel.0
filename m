From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Mon, 28 Jan 2013 21:34:25 +0200
Subject: [PATCH v5 07/14] dmaengine: add dma_request_slave_channel_compat()
In-Reply-To: <1358281974-8411-8-git-send-email-mporter@ti.com>
References: <1358281974-8411-1-git-send-email-mporter@ti.com>
 <1358281974-8411-8-git-send-email-mporter@ti.com>
Message-ID: <CAHp75VeqikcTuOd14utb9E0P3b9t1mr=JsmkAbz5=3FJwU2kFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 15, 2013 at 10:32 PM, Matt Porter <mporter@ti.com> wrote:
> Adds a dma_request_slave_channel_compat() wrapper which accepts
> both the arguments from dma_request_channel() and
> dma_request_slave_channel(). Based on whether the driver is
> instantiated via DT, the appropriate channel request call will be
> made.
>
> This allows for a much cleaner migration of drivers to the
> dmaengine DT API as platforms continue to be mixed between those
> that boot using DT and those that do not.

Does it mean the introduced function is kinda temporary?

>
> Suggested-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Matt Porter <mporter@ti.com>
> Acked-by: Tony Lindgren <tony@atomide.com>
> ---
>  include/linux/dmaengine.h |   10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 9fd0c5b..64f9f69 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -1047,6 +1047,16 @@ void dma_run_dependencies(struct dma_async_tx_descriptor *tx);
>  struct dma_chan *dma_find_channel(enum dma_transaction_type tx_type);
>  struct dma_chan *net_dma_find_channel(void);
>  #define dma_request_channel(mask, x, y) __dma_request_channel(&(mask), x, y)
> +static inline struct dma_chan
> +*dma_request_slave_channel_compat(dma_cap_mask_t mask, dma_filter_fn fn,
> +                                 void *fn_param, struct device *dev,
> +                                 char *name)
> +{
> +       if (dev->of_node)
> +               return dma_request_slave_channel(dev, name);
> +       else
> +               return dma_request_channel(mask, fn, fn_param);
> +}
>
>  /* --- Helper iov-locking functions --- */
>
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



-- 
With Best Regards,
Andy Shevchenko
