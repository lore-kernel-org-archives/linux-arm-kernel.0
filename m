From: zhangfei.gao@gmail.com (zhangfei gao)
Date: Mon, 24 Jun 2013 16:49:08 +0800
Subject: [PATCH] dmaengine: Add hisilicon k3 DMA engine driver
In-Reply-To: <201306211341.53928.arnd@arndb.de>
References: <1371444872-26994-1-git-send-email-zhangfei.gao@linaro.org>
 <201306172258.08185.arnd@arndb.de>
 <20130621104355.GG23141@intel.com>
 <201306211341.53928.arnd@arndb.de>
Message-ID: <CAMj5Bkg_4G9n9BaQjA-Xj2p8jGO8PZxNW7E7jOeWMMZa5sH6yQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 21, 2013 at 7:41 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 21 June 2013, Vinod Koul wrote:
>> On Mon, Jun 17, 2013 at 10:58:07PM +0200, Arnd Bergmann wrote:
>> > On Monday 17 June 2013, Zhangfei Gao wrote:
>> >
>> > int dma_get_slave_channel(struct dma_chan *chan)
>> > {
>> >       /* lock against __dma_request_channel */
>> >       mutex_lock(&dma_list_mutex);
>> >
>> >       if (chan->client_count == 0)
>> >               ret = dma_chan_get(chan);
>> >       else
>> >               ret = -EBUSY;
>> >
>> >       mutex_unlock(&dma_list_mutex);
>> >
>> >       return ret;
>> > }
>> > EXPORT_SYMBOL_GPL(dma_get_slave_channel);
>> and you add filter on top?
>
> No, the idea is to no longer require a filter function when
> we use dma_request_slave_channel with a DT specifier.
>
>> This is getting you any channel and maynot work where we need to do some
>> filtering.
>
> This function would be called only by the dmaengine driver's
> xlate function. That driver obviously has to ensure that the
> channel works for the specification from DT (or ACPI or
> something else), but that part is easy, since that is
> the same information that we currently pass into the filter
> function.
>

Dear Arnd & Vinod

The suggestion of using dma_get_slave_channel instead of filter works here.
Dma driver should modify accordingly.
Here is draft patch:

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 93f7992..78dbbe0 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -504,6 +504,32 @@ static struct dma_chan *private_candidate(const
dma_cap_mask_t *mask,
 }

 /**
+ * dma_request_channel - try to get specific channel exclusively
+ * @chan: target channel
+ */
+struct dma_chan *dma_get_slave_channel(struct dma_chan *chan)
+{
+ int err = -EBUSY;
+
+ /* lock against __dma_request_channel */
+ mutex_lock(&dma_list_mutex);
+
+ if (chan->client_count == 0)
+ err = dma_chan_get(chan);
+ else
+ chan = NULL;
+
+ mutex_unlock(&dma_list_mutex);
+
+ if (err)
+ pr_debug("%s: failed to get %s: (%d)\n",
+ __func__, dma_chan_name(chan), err);
+
+ return chan;
+}
+EXPORT_SYMBOL_GPL(dma_get_slave_channel);
+
+/**
  * dma_request_channel - try to allocate an exclusive channel
  * @mask: capabilities that the channel must satisfy
  * @fn: optional callback to disposition available channels
diff --git a/drivers/dma/k3dma.c b/drivers/dma/k3dma.c
index afac13f..549247d 100644
--- a/drivers/dma/k3dma.c
+++ b/drivers/dma/k3dma.c
@@ -99,9 +99,11 @@ struct k3_dma_dev {
  spinlock_t lock;
  struct list_head chan_pending;
  struct k3_dma_phy *phy;
+ struct k3_dma_chan *chans;
  struct dma_pool *pool;
  struct clk *clk;
  u32 dma_channels;
+ u32 dma_requests;
 };

 #define to_k3_dma(dmadev) container_of(dmadev, struct k3_dma_dev, slave)
@@ -599,10 +601,17 @@ static struct of_device_id k3_pdma_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, k3_pdma_dt_ids);

-static struct of_dma_filter_info k3_dma_filter;
-static bool k3_dma_filter_fn(struct dma_chan *chan, void *param)
+static struct dma_chan *k3_of_dma_simple_xlate(struct of_phandle_args
*dma_spec,
+ struct of_dma *ofdma)
 {
- return  (*(int *)param == chan->chan_id);
+ struct k3_dma_dev *d = ofdma->of_dma_data;
+ unsigned int request = dma_spec->args[0];
+
+ if (request > d->dma_requests)
+ return NULL;
+
+ return dma_get_slave_channel(&(d->chans[request].vc.chan));
 }

 static int k3_dma_probe(struct platform_device *op)
@@ -611,8 +620,6 @@ static int k3_dma_probe(struct platform_device *op)
  const struct of_device_id *of_id;
  struct resource *iores;
  int i, ret, irq = 0;
- int dma_requests = 0;
- struct k3_dma_chan *chans;

  iores = platform_get_resource(op, IORESOURCE_MEM, 0);
  if (!iores)
@@ -631,7 +638,7 @@ static int k3_dma_probe(struct platform_device *op)
  of_property_read_u32((&op->dev)->of_node,
  "dma-channels", &d->dma_channels);
  of_property_read_u32((&op->dev)->of_node,
- "dma-requests", &dma_requests);
+ "dma-requests", &d->dma_requests);
  }

  d->clk = devm_clk_get(&op->dev, NULL);
@@ -672,16 +679,16 @@ static int k3_dma_probe(struct platform_device *op)
  d->slave.device_issue_pending = k3_dma_issue_pending;
  d->slave.device_control = k3_dma_control;
  d->slave.copy_align = DMA_ALIGN;
- d->slave.chancnt = dma_requests;
+ d->slave.chancnt = d->dma_requests;

  /* init virtual channel */
- chans = devm_kzalloc(&op->dev,
- dma_requests * sizeof(struct k3_dma_chan), GFP_KERNEL);
- if (chans == NULL)
+ d->chans = devm_kzalloc(&op->dev,
+ d->dma_requests * sizeof(struct k3_dma_chan), GFP_KERNEL);
+ if (d->chans == NULL)
  return -ENOMEM;

- for (i = 0; i < dma_requests; i++) {
- struct k3_dma_chan *c = &chans[i];
+ for (i = 0; i < d->dma_requests; i++) {
+ struct k3_dma_chan *c = &d->chans[i];

  INIT_LIST_HEAD(&c->node);
  c->vc.desc_free = k3_dma_free_desc;
@@ -707,9 +714,8 @@ static int k3_dma_probe(struct platform_device *op)
  if (ret)
  goto of_dma_register_fail;

- k3_dma_filter.dma_cap = d->slave.cap_mask;
- k3_dma_filter.filter_fn = k3_dma_filter_fn;
- ret = of_dma_controller_register((&op->dev)->of_node,
of_dma_simple_xlate, &k3_dma_filter);
+ ret = of_dma_controller_register((&op->dev)->of_node,
+ k3_of_dma_simple_xlate, d);
  if (ret)
  goto dma_async_regitster_fail;

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 96d3e4a..4e1c843 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -1000,6 +1000,7 @@ int dma_async_device_register(struct dma_device *device);
 void dma_async_device_unregister(struct dma_device *device);
 void dma_run_dependencies(struct dma_async_tx_descriptor *tx);
 struct dma_chan *dma_find_channel(enum dma_transaction_type tx_type);
+struct dma_chan *dma_get_slave_channel(struct dma_chan *chan);
 struct dma_chan *net_dma_find_channel(void);
 #define dma_request_channel(mask, x, y) __dma_request_channel(&(mask), x, y)
 #define dma_request_slave_channel_compat(mask, x, y, dev, name) \
