From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 23 Jan 2013 22:28:46 +0000
Subject: [PATCH v5 07/14] dmaengine: add dma_request_slave_channel_compat()
In-Reply-To: <1358281974-8411-8-git-send-email-mporter@ti.com>
References: <1358281974-8411-1-git-send-email-mporter@ti.com>
 <1358281974-8411-8-git-send-email-mporter@ti.com>
Message-ID: <201301232228.46716.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 15 January 2013, Matt Porter wrote:
> Adds a dma_request_slave_channel_compat() wrapper which accepts
> both the arguments from dma_request_channel() and
> dma_request_slave_channel(). Based on whether the driver is
> instantiated via DT, the appropriate channel request call will be
> made.
> 
> This allows for a much cleaner migration of drivers to the
> dmaengine DT API as platforms continue to be mixed between those
> that boot using DT and those that do not.

I noticed today some drivers in linux-next that rely on this patch,
but the patch itself still missing from -next.

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

Hmm, dma_request_channel is actually a macro that passes mask by reference,
presumably because it can get modified by the filter function. Also, there
may be cases where we do have an of_node but don't use the dma binding
yet, or where dma_request_slave_channel doesn't actually use DT information
but rather one of the other methods that Vinod was talking about adding.

I think what it should look like instead is the below.

	Arnd

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index bfcdecb..b6ffd7d 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -993,6 +993,19 @@ static inline void dma_release_channel(struct dma_chan *chan)
 }
 #endif
 
+static inline struct dma_chan *__dma_request_slave_channel_compat(dma_cap_mask_t *mask,
+				dma_filter_fn fn, void *fn_param, struct device *dev,
+				 char *name)
+{
+	struct dma_chan *chan;
+
+	chan = dma_request_slave_channel(dev, name);
+	if (chan)
+		return chan;
+
+	return __dma_request_channel(mask, fn, fn_param);
+}
+
 /* --- DMA device --- */
 
 int dma_async_device_register(struct dma_device *device);
@@ -1001,6 +1014,8 @@ void dma_run_dependencies(struct dma_async_tx_descriptor *tx);
 struct dma_chan *dma_find_channel(enum dma_transaction_type tx_type);
 struct dma_chan *net_dma_find_channel(void);
 #define dma_request_channel(mask, x, y) __dma_request_channel(&(mask), x, y)
+#define dma_request_slave_channel_compat(mask, x, y, dev, name) \
+	 __dma_request_slave_channel_compat(&(mask), x, y, dev, name)
 
 /* --- Helper iov-locking functions --- */
 
