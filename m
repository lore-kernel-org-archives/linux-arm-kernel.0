From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 19 Aug 2013 10:55:16 +0530
Subject: [PATCH v3 1/2] dmaengine: add interface of dma_get_slave_channel
In-Reply-To: <1376550163-30145-2-git-send-email-zhangfei.gao@linaro.org>
References: <1376550163-30145-1-git-send-email-zhangfei.gao@linaro.org>
 <1376550163-30145-2-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <20130819052516.GT32147@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 15, 2013 at 03:02:42PM +0800, Zhangfei Gao wrote:
> Suggested by Arnd, add dma_get_slave_channel interface
> Dma host driver could get specific channel specificied by request line, rather than filter.
> 
> host example:
> static struct dma_chan *xx_of_dma_simple_xlate(struct of_phandle_args *dma_spec,
> 		struct of_dma *ofdma)
> {
> 	struct xx_dma_dev *d = ofdma->of_dma_data;
> 	unsigned int request = dma_spec->args[0];
> 
> 	if (request > d->dma_requests)
> 		return NULL;
> 
> 	return dma_get_slave_channel(&(d->chans[request].vc.chan));
> }
> 
> probe:
> of_dma_controller_register((&op->dev)->of_node, xx_of_dma_simple_xlate, d);
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/dma/dmaengine.c   |   25 +++++++++++++++++++++++++
>  include/linux/dmaengine.h |    1 +
>  2 files changed, 26 insertions(+)
> 
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index 9e56745..38dd8c3 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -504,6 +504,31 @@ static struct dma_chan *private_candidate(const dma_cap_mask_t *mask,
>  }
>  
>  /**
> + * dma_request_channel - try to get specific channel exclusively
> + * @chan: target channel
> + */
> +struct dma_chan *dma_get_slave_channel(struct dma_chan *chan)
> +{
> +	int err = -EBUSY;
> +
> +	/* lock against __dma_request_channel */
> +	mutex_lock(&dma_list_mutex);
> +
> +	if (chan->client_count == 0) {
> +		err = dma_chan_get(chan);
> +		if (err)
> +			pr_debug("%s: failed to get %s: (%d)\n",
> +				__func__, dma_chan_name(chan), err);
> +	} else
> +		chan = NULL;
> +
> +	mutex_unlock(&dma_list_mutex);
> +
> +	return chan;
> +}
> +EXPORT_SYMBOL_GPL(dma_get_slave_channel);
No, this is not the right approach.

When patch is applied and you find an issue you fix the issue. I have already
pushed and merged this. So removing is a bad idea.
you provide a fix for this miss.

Also for this you need to give due credit to Dan (reporter). That is how the
process works.

Anyway I have applied the below fix and will push it out.

---
dmaengine: fix - error: potential NULL dereference 'chan'

commit 7bb587f4 "dmaengine: add interface of dma_get_slave_channel" introduced
the above error so fix it

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Suggested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 drivers/dma/dmaengine.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 5932ab1..755ba2f 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -514,16 +514,16 @@ struct dma_chan *dma_get_slave_channel(struct dma_chan *chan)
 	/* lock against __dma_request_channel */
 	mutex_lock(&dma_list_mutex);
 
-	if (chan->client_count == 0)
+	if (chan->client_count == 0) {
 		err = dma_chan_get(chan);
-	else
+		if (err)
+			pr_debug("%s: failed to get %s: (%d)\n",
+				__func__, dma_chan_name(chan), err);
+	} else
 		chan = NULL;
 
 	mutex_unlock(&dma_list_mutex);
 
-	if (err)
-		pr_debug("%s: failed to get %s: (%d)\n",
-			__func__, dma_chan_name(chan), err);
 
 	return chan;
 }

--
~Vinod
