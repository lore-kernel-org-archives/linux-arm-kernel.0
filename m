From: iivanov@mm-sol.com (Ivan T. Ivanov)
Date: Wed, 25 Mar 2015 15:10:56 +0200
Subject: [PATCH 3/6] i2c: qup: Add bam dma capabilities
In-Reply-To: <1426268992-19298-4-git-send-email-sricharan@codeaurora.org>
References: <1426268992-19298-1-git-send-email-sricharan@codeaurora.org>
 <1426268992-19298-4-git-send-email-sricharan@codeaurora.org>
Message-ID: <1427289056.25053.21.camel@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Sricharan,

On Fri, 2015-03-13 at 23:19 +0530, Sricharan R wrote:


>  #define QUP_I2C_MASTER_GEN     0x408
> +#define QUP_I2C_MASTER_CONFIG  0x408
> 

Unused.

>  #define QUP_READ_LIMIT                 256
> +#define MX_TX_RX_LEN                   SZ_64K
> +#define MX_BLOCKS                      (MX_TX_RX_LEN / QUP_READ_LIMIT)
> +
> +#define TOUT_MAX                       300 /* Max timeout for 32k tx/tx */
> 

seconds, muliseconds?

>  struct qup_i2c_config {
>         int tag_ver;
>         int max_freq;
>  };
> 
> +struct tag {

Please use consistent naming convention.

> +       u8 *start;
> +       dma_addr_t addr;
> +};
> +
>  struct qup_i2c_dev {
>         struct device*dev;
>         void __iomem*base;
> @@ -157,9 +181,35 @@ struct qup_i2c_dev {
>         /* QUP core errors */
>         u32     qup_err;
> 
> +       /* dma parameters */
> +       bool    is_dma;
> +       struct  dma_pool *dpool;
> +       struct  tag start_tag;
> +       struct  tag scratch_tag;
> +       struct  tag footer_tag;
> +       struct  dma_chan *dma_tx;
> +       struct  dma_chan *dma_rx;
> +       struct  scatterlist *sg_tx;
> +       struct  scatterlist *sg_rx;
> +       dma_addr_tsg_tx_phys;
> +       dma_addr_tsg_rx_phys;

Maybe these could be organized in structure per direction.

> +
>         struct completionxfer;
>  };
> 
> +struct i2c_bam_xfer {

Unused.

> +       struct qup_i2c_dev *qup;
> +       u32 start_len;
> +
> +       u32 rx_nents;
> +       u32 tx_nents;
> +
> +       struct dma_async_tx_descriptor *tx_desc;
> +       dma_cookie_t tx_cookie;
> +       struct dma_async_tx_descriptor *rx_desc;
> +       dma_cookie_t rx_cookie;

structure per direction.

> +};
> +
> 

> +static void bam_i2c_callback(void *data)
> +{

Please use consistent naming, here and bellow.

> +       struct qup_i2c_dev *qup = data;
> +
> +       complete(&qup->xfer);
> +}
> +
> +static int get_start_tag(u8 *tag, struct i2c_msg *msg, int first, int last,
> +                       int blen)
> +{
> +       u8 addr = (msg->addr << 1) | ((msg->flags & I2C_M_RD) == I2C_M_RD);
> +       u8 op;
> +       int len = 0;
> +
> +       /* always issue stop for each read block */
> +       if (last) {
> +               if (msg->flags & I2C_M_RD)
> +                       op = QUP_TAG_V2_DATARD_STOP;
> +               else
> +                       op = QUP_TAG_V2_DATAWR_STOP;
> +       } else {
> +               if (msg->flags & I2C_M_RD)
> +                       op = QUP_TAG_V2_DATARD;
> +               else
> +                       op = QUP_TAG_V2_DATAWR;
> +       }
> +
> +       if (msg->flags & I2C_M_TEN) {
> +               len += 5;
> +               tag[0] = QUP_TAG_V2_START;
> +               tag[1] = addr;
> +               tag[2] = op;
> +               tag[3] = blen;
> +
> +               if (msg->flags & I2C_M_RD && last) {
> +                       len += 2;
> +                       tag[4] = QUP_BAM_INPUT_EOT;
> +                       tag[5] = QUP_BAM_FLUSH_STOP;
> +               }
> +       } else {
> +               if (first) {
> +                       tag[len++] = QUP_TAG_V2_START;
> +                       tag[len++] = addr;
> +               }
> +
> +               tag[len++] = op;
> +               tag[len++] = blen;
> +
> +               if (msg->flags & I2C_M_RD & last) {
> +                       tag[len++] = QUP_BAM_INPUT_EOT;
> +                       tag[len++] = QUP_BAM_FLUSH_STOP;
> +               }
> +       }
> +
> +       return len;
> +}

Maybe could be split to 2 functions?

> -static const struct i2c_algorithm qup_i2c_algo = {
> +static struct i2c_algorithm qup_i2c_algo = {

Why?

>         .master_xfer= qup_i2c_xfer,
>         .functionality= qup_i2c_func,
>  };
> @@ -839,6 +1136,7 @@ static int qup_i2c_probe(struct platform_device *pdev)
>         u32 clk_freq = 100000;
>         const struct qup_i2c_config *config;
>         const struct of_device_id *of_id;
> +       int blocks;
> 
>         qup = devm_kzalloc(&pdev->dev, sizeof(*qup), GFP_KERNEL);
>         if (!qup)
> @@ -875,6 +1173,53 @@ static int qup_i2c_probe(struct platform_device *pdev)
>                 return qup->irq;
>         }
> 
> +       if (of_device_is_compatible(pdev->dev.of_node, "qcom,i2c-qup-v2.1.1") ||
> +               of_device_is_compatible(pdev->dev.of_node,
> +                       "qcom,i2c-qup-v2.2.1")) {

Logic will be simpler if you check just for version 1 of the controller.

> +               qup->dma_rx = dma_request_slave_channel(&pdev->dev, "bam-rx");
> +

Please use dma_request_slave_channel_reason.

As Andy noted, please use just "rx", "tx"

> +               if (!qup->dma_rx)
> +                       return -EPROBE_DEFER;

Don't mask other errors, here and bellow. DMA support should be optional.

>                 dev_err(qup->dev, "Could not get core clock\n");
> @@ -989,6 +1334,14 @@ static int qup_i2c_remove(struct platform_device *pdev)
>  {
>         struct qup_i2c_dev *qup = platform_get_drvdata(pdev);
> 
> +       dma_pool_free(qup->dpool, qup->start_tag.start,
> +                                                               qup->start_tag.addr);
> +       dma_pool_free(qup->dpool, qup->scratch_tag.start,
> +                                                               qup->scratch_tag.addr);
> +       dma_pool_free(qup->dpool, qup->footer_tag.start,
> +                                                               qup->footer_tag.addr);
> +       dma_pool_destroy(qup->dpool);

Only if is_dma, right?

DMA mapping code omitted from review. I don't understand it well enough, sorry.

Regards,
Ivan
