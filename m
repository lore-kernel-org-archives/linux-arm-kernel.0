From: iivanov@mm-sol.com (Ivan T. Ivanov)
Date: Wed, 25 Mar 2015 14:24:23 +0200
Subject: [PATCH 2/6] i2c: qup: Add V2 tags support
In-Reply-To: <1426268992-19298-3-git-send-email-sricharan@codeaurora.org>
References: <1426268992-19298-1-git-send-email-sricharan@codeaurora.org>
 <1426268992-19298-3-git-send-email-sricharan@codeaurora.org>
Message-ID: <1427286263.25053.18.camel@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Sricharan,

On Fri, 2015-03-13 at 23:19 +0530, Sricharan R wrote:
> From: Andy Gross <agross@codeaurora.org>
> 
> QUP from version 2.1.1 onwards, supports a new format of
> i2c command tags. Tag codes instructs the controller to
> perform a operation like read/write. This new tagging version
> supports bam dma and transfers of more than 256 bytes without 'stop'
> in between. Adding the support for the same.
> 
> For each block a data_write/read tag and data_len tag is added to
> the output fifo. For the final block of data write_stop/read_stop
> tag is used.
> 
> Signed-off-by: Andy Gross <agross@codeaurora.org>
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> ---
>  drivers/i2c/busses/i2c-qup.c | 342 ++++++++++++++++++++++++++++++++++++++-----
> 

<snip>

> +#define I2C_QUP_CLK_MAX_FREQ           3400000

unused?

> +
>  /* Status, Error flags */
>  #define I2C_STATUS_WR_BUFFER_FULL      BIT(0)
>  #define I2C_STATUS_BUS_ACTIVE          BIT(8)
> @@ -99,6 +117,11 @@
> 
>  #define QUP_READ_LIMIT                 256
> 
> +struct qup_i2c_config {
> +       int tag_ver;
> +       int max_freq;
> +};
> +

Do you really need this one. It is referenced only during probe, 
but information contained in is already available by other means.


>  struct qup_i2c_dev {
>         struct device*dev;
>         void __iomem*base;
> @@ -112,9 +135,20 @@ struct qup_i2c_dev {
>         int     in_fifo_sz;
>         int     out_blk_sz;
>         int     in_blk_sz;
> -
> +       int     blocks;
> +       u8      *block_tag_len;
> +       int     *block_data_len;

Maybe these could be organized in struct?

<snip>

> 
> +static void qup_i2c_create_tag_v2(struct qup_i2c_dev *qup,
> +                                               struct i2c_msg *msg)
> +{
> +       u16 addr = (msg->addr << 1) | ((msg->flags & I2C_M_RD) == I2C_M_RD);
> +       int len = 0, prev_len = 0;
> +       int blocks = 0;
> +       int rem;
> +       int block_len = 0;
> +       int data_len;
> +
> +       qup->block_pos = 0;
> +       qup->pos = 0;
> +       qup->blocks = (msg->len + QUP_READ_LIMIT - 1) / (QUP_READ_LIMIT);

Braces around QUP_READ_LIMIT are not needed.

> +       rem = msg->len % QUP_READ_LIMIT;
> +
> +       /* 2 tag bytes for each block + 2 extra bytes for first block */
> +       qup->tags = kzalloc((qup->blocks << 1) + 2, GFP_KERNEL);

Don't play tricks with shifts, just use multiplication.

> +       qup->block_tag_len = kzalloc(qup->blocks, GFP_KERNEL);
> +       qup->block_data_len = kzalloc(sizeof(int) * qup->blocks, GFP_KERNEL);

Better use sizeof(*qup->block_data_len).

> +
> +       while (blocks < qup->blocks) {
> +               /* 0 is used to specify a READ_LIMIT of 256 bytes */
> +               data_len = (blocks < (qup->blocks - 1)) ? 0 : rem;
> +
> +               /* Send START and ADDR bytes only for the first block */
> +               if (!blocks) {
> +                       qup->tags[len++] = QUP_TAG_V2_START;
> +
> +                       if (qup->is_hs) {
> +                               qup->tags[len++] = QUP_TAG_V2_HS;
> +                               qup->tags[len++] = QUP_TAG_V2_START;

Is this second QUP_TAG_V2_START intentional?

> +                       }
> +
> +                       qup->tags[len++] = addr & 0xff;
> +                       if (msg->flags & I2C_M_TEN)
> +                               qup->tags[len++] = addr >> 8;
> +               }
> +
> +               /* Send _STOP commands for the last block */
> +               if (blocks == (qup->blocks - 1)) {
> +                       if (msg->flags & I2C_M_RD)
> +                               qup->tags[len++] = QUP_TAG_V2_DATARD_STOP;
> +                       else
> +                               qup->tags[len++] = QUP_TAG_V2_DATAWR_STOP;
> +               } else {
> +                       if (msg->flags & I2C_M_RD)
> +                               qup->tags[len++] = QUP_TAG_V2_DATARD;
> +                       else
> +                               qup->tags[len++] = QUP_TAG_V2_DATAWR;
> +               }
> +
> +               qup->tags[len++] = data_len;
> +               block_len = len - prev_len;
> +               prev_len = len;
> +               qup->block_tag_len[blocks] = block_len;
> +
> +               if (!data_len)
> +                       qup->block_data_len[blocks] = QUP_READ_LIMIT;
> +               else
> +                       qup->block_data_len[blocks] = data_len;
> +
> +               qup->tags_pos = 0;
> +               blocks++;
> +       }
> +
> +       qup->tx_tag_len = len;
> +
> +       if (msg->flags & I2C_M_RD)
> +               qup->rx_tag_len = (qup->blocks << 1);

here again.

> +       else
> +               qup->rx_tag_len = 0;
> +}
> +
> +static u32 qup_i2c_xfer_data(struct qup_i2c_dev *qup, int len,
> +                                                               u8 *buf, int last)
> +{

I think that xfer is too vague in this case, prefer write or send.

> +       static u32 val, idx;

static? please fix.

> +       u32  t, rem, pos = 0;
> +
> +       rem = len - pos + idx;
> +
> +       while (rem) {
> +               if (qup_i2c_wait_ready(qup, QUP_OUT_FULL, 0, 4)) {
> +                       dev_err(qup->dev, "timeout for fifo out full");
> +                       break;
> +               }
> +
> +               t = (rem >= 4) ? 4 : rem;
> +
> +               while (idx < t)
> +                       val |= buf[pos++] << (idx++ << 3);

here again, multiplication or shift?

> +
> +               if (t == 4) {
> +                       writel(val, qup->base + QUP_OUT_FIFO_BASE);
> +                       idx = val = 0;
> +               }
> +
> +               rem = len - pos;
> +       }
> +

What will happen if they are less than 4 bytes to send?

> +       if (last) {
> +               writel(val, qup->base + QUP_OUT_FIFO_BASE);
> +               idx = val = 0;
> +       }
> +
> +       return 0;
> +}
> +
> 

<snip>

> 
> -static void qup_i2c_issue_read(struct qup_i2c_dev *qup, struct i2c_msg *msg)
> +static void qup_i2c_issue_read_v1(struct qup_i2c_dev *qup, struct
> +                                               i2c_msg *msg)

Please, move struct on the same line as i2c_msg.

>  {
>         u32 addr, len, val;
> 
> @@ -395,24 +576,33 @@ static void qup_i2c_issue_read(struct qup_i2c_dev *qup, struct i2c_msg *msg)
>         /* 0 is used to specify a length 256 (QUP_READ_LIMIT) */
>         len = (msg->len == QUP_READ_LIMIT) ? 0 : msg->len;
> 
> -       val = ((QUP_TAG_REC | len) << QUP_MSW_SHIFT) | QUP_TAG_START | addr;
> +       val = ((QUP_TAG_REC | len) << QUP_MSW_SHIFT) | QUP_TAG_START |
> +                       addr;

Unrelated change?

>         writel(val, qup->base + QUP_OUT_FIFO_BASE);
>  }
> 
> 

<snip>

> 
> +static void qup_i2c_read_fifo_v2(struct qup_i2c_dev *qup, struct
> +                                       i2c_msg *msg)
> +{
> +       u32 val;
> +       int idx;
> +       int pos = 0;

> +       int total = qup->block_data_len[qup->block_pos] + 2;

Could we  have at least comment what is this +2?

<snip>

> +
> +static void qup_i2c_read_fifo(struct qup_i2c_dev *qup, struct i2c_msg
> +                                                                       *msg)

Bad indent? 

<snip>


> +static const struct qup_i2c_config configs[] = {
> +       { 0, 400000, },
> +       { 1, 3400000, },
> +};
> +
> +static const struct of_device_id qup_i2c_dt_match[] = {
> +       { .compatible = "qcom,i2c-qup-v1.1.1", .data = &configs[0] },
> +       { .compatible = "qcom,i2c-qup-v2.1.1", .data = &configs[1] },
> +       { .compatible = "qcom,i2c-qup-v2.2.1", .data = &configs[1] },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, qup_i2c_dt_match);
> +
>  static void qup_i2c_disable_clocks(struct qup_i2c_dev *qup)
>  {
>         u32 config;
> @@ -579,6 +837,8 @@ static int qup_i2c_probe(struct platform_device *pdev)
>         int ret, fs_div, hs_div;
>         int src_clk_freq;
>         u32 clk_freq = 100000;
> +       const struct qup_i2c_config *config;
> +       const struct of_device_id *of_id;
> 
>         qup = devm_kzalloc(&pdev->dev, sizeof(*qup), GFP_KERNEL);
>         if (!qup)
> @@ -590,8 +850,15 @@ static int qup_i2c_probe(struct platform_device *pdev)
> 
>         of_property_read_u32(node, "clock-frequency", &clk_freq);
> 
> -       /* We support frequencies up to FAST Mode (400KHz) */
> -       if (!clk_freq || clk_freq > 400000) {
> +       of_id = of_match_node(qup_i2c_dt_match, node);
> +       if (!of_id)
> +               return -EINVAL;

this could not happen.

> +
> +       config = of_id->data;
> +       qup->use_v2_tags = !!config->tag_ver;
> +
> +       /* We support frequencies up to HIGH SPEED Mode (3400KHz) */
> +       if (!clk_freq || clk_freq > config->max_freq) {

Looks like if controller is v > 1 it supports I2C_QUP_CLK_MAX_FREQ.
I don't see need for struct qup_i2c_config.

Regards,
Ivan
