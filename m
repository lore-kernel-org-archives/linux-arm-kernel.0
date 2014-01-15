From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 15 Jan 2014 08:46:04 -0800
Subject: [PATCH v2 2/2] i2c: New bus driver for the QUP I2C controller
In-Reply-To: <1389659437-16406-3-git-send-email-bjorn.andersson@sonymobile.com>
References: <1389659437-16406-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1389659437-16406-3-git-send-email-bjorn.andersson@sonymobile.com>
Message-ID: <20140115164604.GI14405@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/13, Bjorn Andersson wrote:
> +/*
> + * QUP driver for Qualcomm MSM platforms
> + *
> + */

This comment seems redundant, we know what file we're looking at.

> +
> +struct qup_i2c_dev {
> +	struct device		*dev;
> +	void __iomem		*base;
> +	struct pinctrl		*pctrl;

This is unused.

> +	int			irq;
> +	struct clk		*clk;
> +	struct clk		*pclk;
> +	struct i2c_adapter	adap;
> +
> +	int			clk_freq;

This is only ever used in probe, so why do we need to store it
away?

> +	int			clk_ctl;
> +	int			one_bit_t;
> +	int			out_fifo_sz;
> +	int			in_fifo_sz;
> +	int			out_blk_sz;
> +	int			in_blk_sz;
> +	unsigned long		xfer_time;
> +	unsigned long		wait_idle;
> +
> +	struct i2c_msg		*msg;
> +	/* Current possion in user message buffer */

s/possion/position/?

> +	int			pos;
> +	/* Keep number of bytes left to be transmitted */
> +	int			cnt;
> +	/* I2C protocol errors */
> +	u32			bus_err;
> +	/* QUP core errors */
> +	u32			qup_err;
> +	/*
> +	 * maximum bytes that could be send (per iterration). could be

s/iterration/iteration/?

> +	 * equal of fifo size or block size (in block mode)
> +	 */
> +	int			chunk_sz;
> +	struct completion	xfer;
> +};
> +
> +static irqreturn_t qup_i2c_interrupt(int irq, void *dev)
> +{
> +	struct qup_i2c_dev *qup = dev;
> +	u32 bus_err;
> +	u32 qup_err;
> +	u32 opflags;
> +
[...]
> +
> +	if (opflags & QUP_OUT_SVC_FLAG)
> +		writel(QUP_OUT_SVC_FLAG, qup->base + QUP_OPERATIONAL);
> +
> +	if (!(qup->msg->flags == I2C_M_RD))

Should this be?

	if (!(qup->msg->flags & I2C_M_RD))

Otherwise it should be

	if (qup->msg->flags != I2C_M_RD)

> +		return IRQ_HANDLED;
> +
> +	if ((opflags & QUP_MX_INPUT_DONE) || (opflags & QUP_IN_SVC_FLAG))
> +		writel(QUP_IN_SVC_FLAG, qup->base + QUP_OPERATIONAL);
> +
> +done:
> +	qup->qup_err = qup_err;
> +	qup->bus_err = bus_err;
> +	complete(&qup->xfer);
> +	return IRQ_HANDLED;
> +}
> +
> +static int
> +qup_i2c_poll_state(struct qup_i2c_dev *qup, u32 req_state, bool only_valid)
> +{
> +	int retries = 0;
> +	u32 state;
> +
> +	do {
> +		state = readl(qup->base + QUP_STATE);
> +
> +		/*
> +		 * If only valid bit needs to be checked, requested state is
> +		 * 'don't care'
> +		 */

It looks like req_state == 0 means only_valid == true. Can we
drop the only_valid argument to this function?

> +		if (state & QUP_STATE_VALID) {
> +			if (only_valid)
> +				return 0;
> +			if ((req_state & QUP_I2C_MAST_GEN)
> +			    && (state & QUP_I2C_MAST_GEN))
> +				return 0;
> +			if ((state & QUP_STATE_MASK) == req_state)
> +				return 0;
> +		}
> +
> +		if (retries++ == 1000)
> +			udelay(100);
> +
> +	} while (retries != 2000);

Please makes #defines for 1000 and 2000.

> +
> +	return -ETIMEDOUT;
> +}
> +
[...]
> +static void qup_i2c_issue_write(struct qup_i2c_dev *qup, struct i2c_msg *msg)
> +{
> +	u32 addr = msg->addr << 1;
> +	u32 val, qup_tag;
> +	int idx, entries;
> +
> +	if (qup->pos == 0) {
> +		val = QUP_OUT_START | addr;
> +	} else {
> +		/*
> +		 * Avoid setup time issue by adding 1 NOP when number of bytes
> +		 * are more than FIFO/BLOCK size. setup time issue can't appear
> +		 * otherwise since next byte to be written will always be ready
> +		 */
> +		val = (QUP_OUT_NOP | 1);
> +	}
> +
> +	entries = qup->cnt + 1;
> +
> +	if (entries > qup->chunk_sz)
> +		entries = qup->chunk_sz;
> +
> +	qup_tag = QUP_OUT_DATA;
> +
> +	/* Reserve one entry for STOP */
> +	for (idx = 1; idx < (entries - 1); idx++, qup->pos++) {

Unnecessary () here around entries.

> +
> +		if (idx & 1) {
> +			val |= (qup_tag | msg->buf[qup->pos]) << QUP_MSW_SHIFT;
> +			writel(val, qup->base + QUP_OUT_FIFO_BASE);
> +		} else {
> +			val = qup_tag | msg->buf[qup->pos];
> +		}
[...]
> +
> +#ifdef CONFIG_PM

This ifdef is probably wrong considering that you can disable
CONFIG_PM_RUNTIME without disabling CONFIG_PM and then these
runtime PM functions would be unused.

> +static int qup_i2c_pm_suspend_runtime(struct device *device)
> +{
> +	struct qup_i2c_dev *qup = dev_get_drvdata(device);
> +
> +	dev_dbg(device, "pm_runtime: suspending...\n");
> +	qup_i2c_disable_clocks(qup);
> +	return 0;
> +}
> +
> +static int qup_i2c_pm_resume_runtime(struct device *device)
> +{
> +	struct qup_i2c_dev *qup = dev_get_drvdata(device);
> +
> +	dev_dbg(device, "pm_runtime: resuming...\n");
> +	qup_i2c_enable_clocks(qup);
> +	return 0;
> +}
> +
> +static int qup_i2c_suspend(struct device *device)
> +{
> +	dev_dbg(device, "system suspend");
> +	qup_i2c_pm_suspend_runtime(device);
> +	return 0;
> +}
> +
> +static int qup_i2c_resume(struct device *device)
> +{
> +	dev_dbg(device, "system resume");
> +	qup_i2c_pm_resume_runtime(device);
> +	pm_runtime_mark_last_busy(device);
> +	pm_request_autosuspend(device);
> +	return 0;
> +}
> +#endif /* CONFIG_PM */
> +
> +static const struct dev_pm_ops qup_i2c_qup_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(
> +		qup_i2c_suspend,
> +		qup_i2c_resume)
> +	SET_RUNTIME_PM_OPS(
> +		qup_i2c_pm_suspend_runtime,
> +		qup_i2c_pm_resume_runtime,
> +		NULL)
> +};
> +
> +static struct of_device_id qup_i2c_dt_match[] = {

const?

> +	{.compatible = "qcom,i2c-qup"},
> +	{}
> +};

MODULE_DEVICE_TABLE(of, qup_i2c_dt_match)?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
