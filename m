From: iivanov@mm-sol.com (Ivan T. Ivanov)
Date: Mon, 20 Jul 2015 17:46:47 +0300
Subject: [PATCH V4 5/7] i2c: qup: Add bam dma capabilities
In-Reply-To: <1436412350-19519-6-git-send-email-sricharan@codeaurora.org>
References: <1436412350-19519-1-git-send-email-sricharan@codeaurora.org>
 <1436412350-19519-6-git-send-email-sricharan@codeaurora.org>
Message-ID: <1437403607.6267.16.camel@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Sricharan,

On Thu, 2015-07-09 at 08:55 +0530, Sricharan R wrote:
> QUP cores can be attached to a BAM module, which acts as a dma engine for the
> QUP core. When DMA with BAM is enabled, the BAM consumer pipe transmitted data
> is written to the output FIFO and the BAM producer pipe received data is read
> from the input FIFO.
> 
> With BAM capabilities, qup-i2c core can transfer more than 256 bytes, without a
> 'stop' which is not possible otherwise.
> 
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> ---
>  drivers/i2c/busses/i2c-qup.c | 431 +++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 415 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
> index c0757d9..810b021 100644
> --- a/drivers/i2c/busses/i2c-qup.c
> +++ b/drivers/i2c/busses/i2c-qup.c
> @@ -24,6 +24,11 @@
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/scatterlist.h>
> +#include <linux/atomic.h>
> +#include <linux/dmaengine.h>
> +#include <linux/dmapool.h>

Keep includes sorted alphabetically.

<snip>

> +#define MX_TX_RX_LEN                   SZ_64K
> +#define MX_BLOCKS                      (MX_TX_RX_LEN / QUP_READ_LIMIT)
> +
> +/* Max timeout in ms for 32k bytes */
> +#define TOUT_MAX                       300
> +
>  struct qup_i2c_block {
>         int     count;
>         int     pos;
> @@ -125,6 +143,23 @@ struct qup_i2c_block {
>         int     config_run;
>  };
> 
> +struct qup_i2c_tag {
> +       u8 *start;
> +       dma_addr_t addr;
> +};
> +
> +struct qup_i2c_bam_rx {
> +       struct  qup_i2c_tag scratch_tag;
> +       struct  dma_chan *dma_rx;
> +       struct  scatterlist *sg_rx;
> +};
> +
> +struct qup_i2c_bam_tx {
> +       struct  qup_i2c_tag footer_tag;
> +       struct  dma_chan *dma_tx;
> +       struct  scatterlist *sg_tx;
> +};
> +

The only difference between above 2 structures is name of the fields.
Please, just define one struct qup_i2c_bam and instantiate it twice.

>  struct qup_i2c_dev {
>         struct device*dev;
>         void __iomem*base;
> @@ -154,14 +189,20 @@ struct qup_i2c_dev {
> 
>         int (*qup_i2c_write_one)(struct qup_i2c_dev *qup,
>                                         struct i2c_msg *msg);
> +       int (*qup_i2c_read_one)(struct qup_i2c_dev *qup,
> +                               struct i2c_msg *msg);
> +
>         /* Current i2c_msg in i2c_msgs */
>         int     cmsg;
>         /* total num of i2c_msgs */
>         int     num;
> 
> -       int (*qup_i2c_read_one)(struct qup_i2c_dev *qup,
> -                               struct i2c_msg *msg);
> -
> +       /* dma parameters */
> +       bool    is_dma;
> +       struct  dma_pool *dpool;
> +       struct  qup_i2c_tag start_tag;
> +       struct  qup_i2c_bam_rx brx;
> +       struct  qup_i2c_bam_tx btx;
>         struct completionxfer;
>  };
> 
> @@ -238,6 +279,14 @@ static int qup_i2c_poll_state(struct qup_i2c_dev *qup, u32 req_state)
>         return qup_i2c_poll_state_mask(qup, req_state, QUP_STATE_MASK);
>  }
> 
> +static void qup_i2c_flush(struct qup_i2c_dev *qup)
> +{
> +       u32 val = readl(qup->base + QUP_STATE);
> +
> +       val |= QUP_I2C_FLUSH;
> +       writel(val, qup->base + QUP_STATE);
> +}
> +

Used in only one place.

<snip>

> 
> +static void qup_i2c_bam_cb(void *data)
> +{
> +       struct qup_i2c_dev *qup = data;
> +
> +       complete(&qup->xfer);
> +}
> +
> +void qup_sg_set_buf(struct scatterlist *sg, void *buf, struct qup_i2c_tag *tg,
> +                                               unsigned int buflen, struct qup_i2c_dev *qup,
> +                                               int map, int dir)
> +{
> +       sg_set_buf(sg, buf, buflen);
> +       dma_map_sg(qup->dev, sg, 1, dir);
> +
> +       if (!map)
> +               sg_dma_address(sg) = tg->addr + ((u8 *)buf - tg->start);

Changing DMA address that we just mapped?

> +}
> +
> +static void qup_i2c_rel_dma(struct qup_i2c_dev *qup)
> +{
> +       if (qup->btx.dma_tx)
> +               dma_release_channel(qup->btx.dma_tx);
> +       if (qup->brx.dma_rx)
> +               dma_release_channel(qup->brx.dma_rx);
> +       qup->btx.dma_tx = NULL;
> +       qup->brx.dma_rx = NULL;
> +}
> +
> +static int qup_i2c_req_dma(struct qup_i2c_dev *qup)
> +{
> +       if (!qup->btx.dma_tx) {
> +               qup->btx.dma_tx = dma_request_slave_channel(qup->dev, "tx");

Please use dma_request_slave_channel_reason() and let deferred probe work.

> +               if (!qup->btx.dma_tx) {
> +                       dev_err(qup->dev, "\n tx channel not available");
> +                       return -ENODEV;
> +               }
> +       }
> +
> +       if (!qup->brx.dma_rx) {
> +               qup->brx.dma_rx = dma_request_slave_channel(qup->dev, "rx");
> +               if (!qup->brx.dma_rx) {
> +                       dev_err(qup->dev, "\n rx channel not available");
> +                       qup_i2c_rel_dma(qup);
> +                       return -ENODEV;
> +               }
> +       }
> +       return 0;
> +}
> +
> +static int bam_do_xfer(struct qup_i2c_dev *qup, struct i2c_msg *msg)
> +{

Please use consistent naming convention.

> +       struct dma_async_tx_descriptor *txd, *rxd = NULL;
> +       int ret = 0;
> +       dma_cookie_t cookie_rx, cookie_tx;
> +       u32 rx_nents = 0, tx_nents = 0, len, blocks, rem;
> +       u32 i, tlen, tx_len, tx_buf = 0, rx_buf = 0, off = 0;
> +       u8 *tags;
> +
> +       while (qup->cmsg < qup->num) {
> +               blocks = (msg->len + QUP_READ_LIMIT) / QUP_READ_LIMIT;
> +               rem = msg->len % QUP_READ_LIMIT;
> +               tx_len = 0, len = 0, i = 0;
> +
> +               qup_i2c_get_blk_data(qup, msg);
> +
> +               if (msg->flags & I2C_M_RD) {
> +                       rx_nents += (blocks * 2) + 1;
> +                       tx_nents += 1;
> +
> +                       while (qup->blk.pos < blocks) {
> +                               /* length set to '0' implies 256 bytes */
> +                               tlen = (i == (blocks - 1)) ? rem : 0;
> +                               tags = &qup->start_tag.start[off + len];
> +                               len += qup_i2c_get_tags(tags, qup, msg, 1);
> +
> +                               /* scratch buf to read the start and len tags */
> +                               qup_sg_set_buf(&qup->brx.sg_rx[rx_buf++],
> +                                                                                               &qup->brx.scratch_tag.start[0],
> +                                                                                               &qup->brx.scratch_tag,
> +                                                                                               2, qup, 0, 0);
> +
> +                               qup_sg_set_buf(&qup->brx.sg_rx[rx_buf++],
> +                                                                                               &msg->buf[QUP_READ_LIMIT * i],
> +                                                                                               NULL, tlen, qup,
> +                                                                                               1, DMA_FROM_DEVICE);
> +                               i++;
> +                               qup->blk.pos = i;
> +                       }
> +                       qup_sg_set_buf(&qup->btx.sg_tx[tx_buf++],
> +                                                                                       &qup->start_tag.start[off],
> +                                                                                       &qup->start_tag, len, qup, 0, 0);
> +                       off += len;
> +                       /* scratch buf to read the BAM EOT and FLUSH tags */
> +                       qup_sg_set_buf(&qup->brx.sg_rx[rx_buf++],
> +                                                                                       &qup->brx.scratch_tag.start[0],
> +                                                                                       &qup->brx.scratch_tag, 2,
> +                                                                                       qup, 0, 0);
> +               } else {
> +                       tx_nents += (blocks * 2);
> +
> +                       while (qup->blk.pos < blocks) {
> +                               tlen = (i == (blocks - 1)) ? rem : 0;
> +                               tags = &qup->start_tag.start[off + tx_len];
> +                               len = qup_i2c_get_tags(tags, qup, msg, 1);
> +
> +                               qup_sg_set_buf(&qup->btx.sg_tx[tx_buf++],
> +                                                                                               tags,
> +                                                                                               &qup->start_tag, len,
> +                                                                                               qup, 0, 0);
> +
> +                               tx_len += len;
> +                               qup_sg_set_buf(&qup->btx.sg_tx[tx_buf++],
> +                                                                                               &msg->buf[QUP_READ_LIMIT * i],
> +                                                                                               NULL, tlen, qup, 1,
> +                                                                                               DMA_TO_DEVICE);
> +                               i++;
> +                               qup->blk.pos = i;
> +                       }
> +                       off += tx_len;
> +
> +                       if (qup->cmsg == (qup->num - 1)) {
> +                               qup->btx.footer_tag.start[0] =
> +                                                                       QUP_BAM_FLUSH_STOP;
> +                               qup->btx.footer_tag.start[1] =
> +                                                                       QUP_BAM_FLUSH_STOP;
> +                               qup_sg_set_buf(&qup->btx.sg_tx[tx_buf++],
> +                                                                                               &qup->btx.footer_tag.start[0],
> +                                                                                               &qup->btx.footer_tag, 2,
> +                                                                                               qup, 0, 0);
> +                               tx_nents += 1;
> +                       }
> +               }
> +               qup->cmsg++;
> +               msg++;
> +       }
> +
> +       txd = dmaengine_prep_slave_sg(qup->btx.dma_tx, qup->btx.sg_tx, tx_nents,
> +                                                                               DMA_MEM_TO_DEV,
> +                                                                               DMA_PREP_INTERRUPT | DMA_PREP_FENCE);
> +       if (!txd) {
> +               dev_err(qup->dev, "failed to get tx desc\n");
> +               ret = -EINVAL;
> +               goto desc_err;
> +       }
> +
> +       if (!rx_nents) {
> +               txd->callback = qup_i2c_bam_cb;
> +               txd->callback_param = qup;
> +       }
> +
> +       cookie_tx = dmaengine_submit(txd);

Check this cookie for error? Same bellow.

> +       dma_async_issue_pending(qup->btx.dma_tx);

Why TX messages are started first?

> +
> +       if (rx_nents) {
> +               rxd = dmaengine_prep_slave_sg(qup->brx.dma_rx, qup->brx.sg_rx,
> +                                                                                       rx_nents, DMA_DEV_TO_MEM,
> +                                                                                       DMA_PREP_INTERRUPT);
> +               if (!rxd) {
> +                       dev_err(qup->dev, "failed to get rx desc\n");
> +                       ret = -EINVAL;
> +
> +                       /* abort TX descriptors */
> +                       dmaengine_terminate_all(qup->btx.dma_tx);
> +                       goto desc_err;
> +               }
> +
> +               rxd->callback = qup_i2c_bam_cb;
> +               rxd->callback_param = qup;
> +               cookie_rx = dmaengine_submit(rxd);
> +               dma_async_issue_pending(qup->brx.dma_rx);
> +       }
> +
> +       if (!wait_for_completion_timeout(&qup->xfer, TOUT_MAX * HZ)) {
> +               dev_err(qup->dev, "normal trans timed out\n");
> +               ret = -ETIMEDOUT;
> +       }

There could be multiple messages for RX and TX queued for transfer, 
and they could be mixed. Using just one completion did't look right. 

> +
> +       if (ret || qup->bus_err || qup->qup_err) {
> +               if (qup->bus_err & QUP_I2C_NACK_FLAG) {
> +                       msg--;
> +                       dev_err(qup->dev, "NACK from %x\n", msg->addr);
> +                       ret = -EIO;
> +
> +                       if (qup_i2c_change_state(qup, QUP_RUN_STATE)) {
> +                               dev_err(qup->dev, "change to run state timed out");
> +                               return ret;
> +                       }
> +
> +                       if (rx_nents)
> +                               writel(QUP_BAM_INPUT_EOT,
> +                                                                                       qup->base + QUP_OUT_FIFO_BASE);
> +
> +                       writel(QUP_BAM_FLUSH_STOP,
> +                                                                               qup->base + QUP_OUT_FIFO_BASE);
> +
> +                       qup_i2c_flush(qup);
> +
> +                       /* wait for remaining interrupts to occur */
> +                       if (!wait_for_completion_timeout(&qup->xfer, HZ))
> +                               dev_err(qup->dev, "flush timed out\n");
> +
> +                       qup_i2c_rel_dma(qup);
> +               }
> +       }
> +
> +       dma_unmap_sg(qup->dev, qup->btx.sg_tx, tx_nents, DMA_TO_DEVICE);
> +
> +       if (rx_nents)
> +               dma_unmap_sg(qup->dev, qup->brx.sg_rx, rx_nents,
> +                                                               DMA_FROM_DEVICE);
> +desc_err:
> +       return ret;
> +}
> +
> +static int qup_bam_xfer(struct i2c_adapter *adap, struct i2c_msg *msg)
> +{

Please use consistent naming convention.

> +       struct qup_i2c_dev *qup = i2c_get_adapdata(adap);
> +       int ret = 0;
> +
> +       enable_irq(qup->irq);
> +       if (qup_i2c_req_dma(qup))

Why?

> 
> +
>  static int qup_i2c_xfer(struct i2c_adapter *adap,
>                         struct i2c_msg msgs[],
>                         int num)
> @@ -836,7 +1143,7 @@ static int qup_i2c_xfer_v2(struct i2c_adapter *adap,
>                                                 int num)
>  {
>         struct qup_i2c_dev *qup = i2c_get_adapdata(adap);
> -       int ret, idx;
> +       int ret, idx, len, use_dma  = 0;
> 
>         qup->num = num;
>         qup->cmsg = 0;
> @@ -854,12 +1161,27 @@ static int qup_i2c_xfer_v2(struct i2c_adapter *adap,
>         writel(I2C_MINI_CORE | I2C_N_VAL_V2, qup->base + QUP_CONFIG);
>         writel(QUP_V2_TAGS_EN, qup->base + QUP_I2C_MASTER_GEN);
> 
> -       for (idx = 0; idx < num; idx++) {
> -               if (msgs[idx].len == 0) {
> -                       ret = -EINVAL;
> -                       goto out;
> +       if ((qup->is_dma)) {
> +               /* All i2c_msgs should be transferred using either dma or cpu */
> +               for (idx = 0; idx < num; idx++) {
> +                       if (msgs[idx].len == 0) {
> +                               ret = -EINVAL;
> +                               goto out;
> +                       }
> +
> +                       len = (msgs[idx].len > qup->out_fifo_sz) ||
> +                                                                       (msgs[idx].len > qup->in_fifo_sz);
> +
> +                       if ((!is_vmalloc_addr(msgs[idx].buf)) && len) {

What is wrong with vmalloc addresses?

> +                               use_dma = 1;
> +                               } else {
> +                               use_dma = 0;
> +                               break;
> +                       }
>                 }
> +       }
> 
> +       for (idx = 0; idx < num; idx++) {
>                 if (qup_i2c_poll_state_i2c_master(qup)) {
>                         ret = -EIO;
>                         goto out;
> @@ -867,10 +1189,17 @@ static int qup_i2c_xfer_v2(struct i2c_adapter *adap,
> 
>                 reinit_completion(&qup->xfer);
> 
> -               if (msgs[idx].flags & I2C_M_RD)
> -                       ret = qup_i2c_read(qup, &msgs[idx]);
> -               else
> -                       ret = qup_i2c_write(qup, &msgs[idx]);
> +               len = msgs[idx].len;

Unused?

> +
> +               if (use_dma) {
> +                       ret = qup_bam_xfer(adap, &msgs[idx]);
> +                       idx = num;

Hacky.

> +               } else {
> +                       if (msgs[idx].flags & I2C_M_RD)
> +                               ret = qup_i2c_read(qup, &msgs[idx]);
> +                       else
> +                               ret = qup_i2c_write(qup, &msgs[idx]);
> +               }
> 
>                 if (ret)
>                         break;
> @@ -943,6 +1272,7 @@ static int qup_i2c_probe(struct platform_device *pdev)
>         int ret, fs_div, hs_div;
>         int src_clk_freq;
>         u32 clk_freq = 100000;
> +       int blocks;
> 
>         qup = devm_kzalloc(&pdev->dev, sizeof(*qup), GFP_KERNEL);
>         if (!qup)
> @@ -963,8 +1293,60 @@ static int qup_i2c_probe(struct platform_device *pdev)
>                 qup->qup_i2c_write_one = qup_i2c_write_one_v2;
>                 qup->qup_i2c_read_one = qup_i2c_read_one_v2;
>                 qup->use_v2_tags = 1;
> +
> +               if (qup_i2c_req_dma(qup))
> +                       goto nodma;

Just return what request DMA functions return?

Regards,
Ivan
