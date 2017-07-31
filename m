From: thor.thayer@linux.intel.com (Thor Thayer)
Date: Mon, 31 Jul 2017 14:40:47 -0500
Subject: [PATCHv5 3/3] i2c: altera: Add Altera I2C Controller driver
In-Reply-To: <20170731133124.smwztpkul2qjy26p@ninjato>
References: <1500309314-18464-1-git-send-email-thor.thayer@linux.intel.com>
 <1500309314-18464-4-git-send-email-thor.thayer@linux.intel.com>
 <20170731133124.smwztpkul2qjy26p@ninjato>
Message-ID: <305220e7-4ae2-ed44-e4ec-2abf9b3c38f0@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

Thank you for reviewing.

On 07/31/2017 08:31 AM, Wolfram Sang wrote:
> Hi Thor,
> 
> thanks for the patches! A few comments and questions from me.
> 
> On Mon, Jul 17, 2017 at 11:35:14AM -0500, thor.thayer at linux.intel.com wrote:
>> From: Thor Thayer <thor.thayer@linux.intel.com>
>>
>> Add driver support for the Altera I2C Controller. The I2C
>> controller is soft IP for use in FPGAs.
>>
>> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
>> ---
>> v2  Remove altr, from fifo-size to agree with bindings.
>>      Change compatible string to "altr,softip-i2c"
>> v3  Add version to compatible string "altr,softip-i2c-v1.0"
>> v4  Add default 100kHz message. Cleanup IRQ error message.
>> v5  Cleanup header usage - remove init.h.
>>      Fix 1 byte RX bug and add convenience function for transfer shared by RX and TX.
>>      Use readl_poll_timeout_atomic() function.
>>      Cache the I2C Interrupt Status Enable Register.
>>      Cleanup of irq_mask by combining into 1 function.
>>      Use i2c_8bit_addr_from_msg() for cleaner xfer_msg implementation.
>>      Restructure altr_i2c_xfer() without arrays and indexes.
>>      Remove redundant assignments.
>>      Remove function calls from inside if() statements.
>>      Convert of_property_read_u32() to device_property_read_u32().
>>      Call i2c_m_read() once in irq.
>> ---
>>   drivers/i2c/busses/Kconfig      |  10 +
>>   drivers/i2c/busses/Makefile     |   1 +
>>   drivers/i2c/busses/i2c-altera.c | 510 ++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 521 insertions(+)

<snip>

>> new file mode 100644
>> index 0000000..e818901
>> --- /dev/null
>> +++ b/drivers/i2c/busses/i2c-altera.c
>> @@ -0,0 +1,510 @@

<snip>

>> +
>> +#define ALTR_I2C_THRESHOLD	0	/* IRQ Threshold at 1 element */
>> +#define ALTR_I2C_DFLT_FIFO_SZ	4
>> +#define ALTR_I2C_TIMEOUT	100000	/* 100ms */
>> +#define ALTR_I2C_XFER_TIMEOUT	(msecs_to_jiffies(250))
>> +
>> +/**
>> + * altr_i2c_dev - I2C device context
>> + * @base: pointer to register struct
>> + * @msg: pointer to current message
>> + * @msg_len: number of bytes transferred in msg
>> + * @msg_err: error code for completed message
>> + * @msg_complete: xfer completion object
>> + * @dev: device reference
>> + * @adapter: core i2c abstraction
>> + * @i2c_clk: clock reference for i2c input clock
>> + * @bus_clk_rate: current i2c bus clock rate
>> + * @buf: ptr to msg buffer for easier use.
>> + * @fifo_size: size of the FIFO passed in.
>> + */
>> +struct altr_i2c_dev {
>> +	void __iomem *base;
>> +	struct i2c_msg *msg;
>> +	size_t msg_len;
>> +	int msg_err;
>> +	struct completion msg_complete;
>> +	struct device *dev;
>> +	struct i2c_adapter adapter;
>> +	struct clk *i2c_clk;
>> +	u32 bus_clk_rate;
>> +	u8 *buf;
>> +	u32 fifo_size;
>> +	u32 isr_mask;
> 
> The last one is not described in the kernel docs.
> 

Whoops. Yes, I will add this.

>> +};
>> +
>> +static void i2c_int_enable(struct altr_i2c_dev *idev, u32 mask, bool enable)
>> +{
>> +	u32 int_en = readl(idev->base + ALTR_I2C_ISER);
>> +
>> +	if (enable)
>> +		idev->isr_mask = int_en | mask;
>> +	else
>> +		idev->isr_mask = int_en & ~mask;
>> +
>> +	writel(idev->isr_mask, idev->base + ALTR_I2C_ISER);
>> +}
>> +
>> +static void i2c_int_clear(struct altr_i2c_dev *idev, u32 mask)
>> +{
>> +	u32 int_en = readl(idev->base + ALTR_I2C_ISR);
>> +
>> +	writel(int_en | mask, idev->base + ALTR_I2C_ISR);
>> +}
> 
> Those two functions would also suit an altr_ prefix.
> 
Yes. I will fix this.

>> +
>> +static void altr_i2c_core_disable(struct altr_i2c_dev *idev)
>> +{
>> +	u32 tmp = readl(idev->base + ALTR_I2C_CTRL);
>> +
>> +	writel(tmp & ~ALTR_I2C_CTRL_EN, idev->base + ALTR_I2C_CTRL);
>> +}
>> +
>> +static void altr_i2c_core_enable(struct altr_i2c_dev *idev)
>> +{
>> +	u32 tmp = readl(idev->base + ALTR_I2C_CTRL);
>> +
>> +	writel(tmp | ALTR_I2C_CTRL_EN, idev->base + ALTR_I2C_CTRL);
>> +}
>> +
>> +static void altr_i2c_reset(struct altr_i2c_dev *idev)
>> +{
>> +	altr_i2c_core_disable(idev);
>> +	altr_i2c_core_enable(idev);
>> +}
>> +
>> +static void altr_i2c_recover(struct altr_i2c_dev *idev)
>> +{
>> +	altr_i2c_reset(idev);
>> +	/* Clock start bit + 8 bits + stop bit out */
> 
> Really 8? It should be 9 (ACK bit).
> 

Yes, I'll update the comment.

>> +	writel(ALTR_I2C_TFR_CMD_STA | ALTR_I2C_TFR_CMD_STO,
>> +	       idev->base + ALTR_I2C_TFR_CMD);
>> +	altr_i2c_reset(idev);
> 
> Why the second reset?
>

I wanted to start from a known clean condition. The first reset would 
reset the hardware. The 2nd would ensure the hardware is ready after 
clearing the bus. Maybe I'm being overly cautious but I don't have a way 
to check the status of the SDA line.

>> +
>> +	i2c_recover_bus(&idev->adapter);
> 
> This will return an error since you don't have a struct
> i2c_bus_recovery_info defined. This whole recovery looks fishy, maybe it
> should be dropped now and added incrementally?
>

Yes. I'll drop it for now. Thanks.

>> +}
>> +
>> +static inline void altr_i2c_stop(struct altr_i2c_dev *idev)
>> +{
>> +	writel(ALTR_I2C_TFR_CMD_STO, idev->base + ALTR_I2C_TFR_CMD);
>> +}
>> +
>> +static void altr_i2c_init(struct altr_i2c_dev *idev)
>> +{
>> +	u32 divisor = clk_get_rate(idev->i2c_clk) / idev->bus_clk_rate;
>> +	u32 clk_mhz = clk_get_rate(idev->i2c_clk) / 1000000;
>> +	u32 tmp = (ALTR_I2C_THRESHOLD << ALTR_I2C_CTRL_RXT_SHFT) |
>> +		  (ALTR_I2C_THRESHOLD << ALTR_I2C_CTRL_TCT_SHFT);
>> +	u32 t_high, t_low;
>> +
>> +	if (idev->bus_clk_rate <= 100000) {
>> +		tmp &= ~ALTR_I2C_CTRL_BSPEED;
>> +		/* Standard mode SCL 50/50 */
>> +		t_high = divisor * 1 / 2;
>> +		t_low = divisor * 1 / 2;
>> +	} else {
>> +		tmp |= ALTR_I2C_CTRL_BSPEED;
>> +		/* Fast mode SCL 33/66 */
>> +		t_high = divisor * 1 / 3;
>> +		t_low = divisor * 2 / 3;
>> +	}
>> +	writel(tmp, idev->base + ALTR_I2C_CTRL);
>> +
>> +	dev_dbg(idev->dev, "rate=%uHz per_clk=%uMHz -> ratio=1:%u\n",
>> +		idev->bus_clk_rate, clk_mhz, divisor);
>> +
>> +	/* Reset controller */
>> +	altr_i2c_reset(idev);
>> +
>> +	/* SCL High Time */
>> +	writel(t_high, idev->base + ALTR_I2C_SCL_HIGH);
>> +	/* SCL Low Time */
>> +	writel(t_low, idev->base + ALTR_I2C_SCL_LOW);
>> +	/* SDA Hold Time, 300ns */
>> +	writel(div_u64(300 * clk_mhz, 1000), idev->base + ALTR_I2C_SDA_HOLD);
>> +
>> +	/* Mask all master interrupt bits */
>> +	i2c_int_enable(idev, ALTR_I2C_ALL_IRQ, false);
>> +}
>> +
>> +static int i2c_m_rd(const struct i2c_msg *msg)
>> +{
>> +	return (msg->flags & I2C_M_RD) != 0;
>> +}
> 
> I'll leave it to you, but I'd think an extra function doesn't really
> improve readability here.
> 

OK. I'd seen others using it elsewhere and wanted to stay with 
convention but I'll just handle it directly. Thanks.

>> +
>> +/**
>> + * altr_i2c_transfer - On the last byte to be transmitted, send
>> + * a Stop bit on the last byte.
>> + */
>> +static void altr_i2c_transfer(struct altr_i2c_dev *idev, u32 data)
>> +{
>> +	/* On the last byte to be transmitted, send STOP */
>> +	if (idev->msg_len == 1)
>> +		data |= ALTR_I2C_TFR_CMD_STO;
>> +	if (idev->msg_len > 0)
>> +		writel(data, idev->base + ALTR_I2C_TFR_CMD);
>> +}
>> +
>> +/**
>> + * altr_i2c_empty_rx_fifo - Fetch data from RX FIFO until end of
>> + * transfer. Send a Stop bit on the last byte.
>> + */
>> +static void altr_i2c_empty_rx_fifo(struct altr_i2c_dev *idev)
>> +{
>> +	size_t rx_fifo_avail = readl(idev->base + ALTR_I2C_RX_FIFO_LVL);
>> +	int bytes_to_transfer = min(rx_fifo_avail, idev->msg_len);
>> +
>> +	while (bytes_to_transfer-- > 0) {
>> +		*idev->buf++ = readl(idev->base + ALTR_I2C_RX_DATA);
>> +		idev->msg_len--;
>> +		altr_i2c_transfer(idev, 0);
>> +	}
>> +}
>> +
>> +/**
>> + * altr_i2c_fill_tx_fifo - Fill TX FIFO from current message buffer.
>> + * @return: Number of bytes left to transfer.
>> + */
>> +static int altr_i2c_fill_tx_fifo(struct altr_i2c_dev *idev)
>> +{
>> +	size_t tx_fifo_avail = idev->fifo_size - readl(idev->base +
>> +						       ALTR_I2C_TC_FIFO_LVL);
>> +	int bytes_to_transfer = min(tx_fifo_avail, idev->msg_len);
>> +	int ret = idev->msg_len - bytes_to_transfer;
>> +
>> +	while (bytes_to_transfer-- > 0) {
>> +		altr_i2c_transfer(idev, *idev->buf++);
>> +		idev->msg_len--;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static irqreturn_t altr_i2c_isr(int irq, void *_dev)
>> +{
>> +	int ret, read;
>> +	struct altr_i2c_dev *idev = _dev;
>> +	/* Read IRQ status but only interested in Enabled IRQs. */
>> +	u32 status = readl(idev->base + ALTR_I2C_ISR) & idev->isr_mask;
>> +
>> +	if (!idev->msg) {
>> +		dev_warn(idev->dev, "unexpected interrupt\n");
>> +		goto out;
> 
> Won't you get an interrupt storm if you don't use any i2c_int_clear()?
> 

Yes. I missed that. Thanks.

>> +	}
>> +	read = i2c_m_rd(idev->msg);
>> +
>> +	/* handle Lost Arbitration */
>> +	if (unlikely(status & ALTR_I2C_ISR_ARB)) {
>> +		dev_err(idev->dev, "%s: arbitration lost\n", __func__);
> 
> Drop the message, it is not an error, but a to be expected bus condition
> in multi-master setups.

OK. Thanks.

> 
>> +		i2c_int_clear(idev, ALTR_I2C_ISR_ARB);
>> +		idev->msg_err = -EAGAIN;
>> +		goto complete;
>> +	}
>> +
>> +	if (unlikely(status & ALTR_I2C_ISR_NACK)) {
>> +		dev_dbg(idev->dev, "%s: could not get ACK\n", __func__);
>> +		idev->msg_err = -ENXIO;
>> +		i2c_int_clear(idev, ALTR_I2C_ISR_NACK);
>> +		altr_i2c_stop(idev);
>> +		goto complete;
>> +	}
>> +
>> +	/* handle RX FIFO Overflow */
>> +	if (read && unlikely(status & ALTR_I2C_ISR_RXOF)) {
>> +		altr_i2c_empty_rx_fifo(idev);
>> +		i2c_int_clear(idev, ALTR_I2C_ISR_RXRDY);
>> +		altr_i2c_stop(idev);
>> +		dev_err(idev->dev, "%s: RX FIFO Overflow\n", __func__);
>> +		goto complete;
>> +	}
>> +
>> +	/* RX FIFO needs service? */
>> +	if (read && (status & ALTR_I2C_ISR_RXRDY)) {
>> +		altr_i2c_empty_rx_fifo(idev);
>> +		i2c_int_clear(idev, ALTR_I2C_ISR_RXRDY);
>> +		if (!idev->msg_len)
>> +			goto complete;
>> +
>> +		goto out;
>> +	}
>> +
>> +	/* TX FIFO needs service? */
>> +	if (!read && (status & ALTR_I2C_ISR_TXRDY)) {
>> +		i2c_int_clear(idev, ALTR_I2C_ISR_TXRDY);
>> +		if (!altr_i2c_fill_tx_fifo(idev))
>> +			goto complete;
>> +
>> +		goto out;
> 
> A bit too much goto in here for my taste. What about using a boolean
> 'complete' variable which gets set or cleared and have an 'if
> (complete)' at the end of this routine?
> 

I want to exit immediately on an error - without checking any further 
errors or RX or TX. Maybe a switch/case statement would be better.

Yes, the boolean would be cleaner. I will look at better ways to handle 
the sequence.  Andy's last comment indicated something similar. Thanks.

>> +	}
>> +
>> +complete:
>> +	/* Wait for the Core to finish */
>> +	ret = readl_poll_timeout_atomic(idev->base + ALTR_I2C_STATUS, status,
>> +					((status & ALTR_I2C_STAT_CORE) == 0),
>> +					1, ALTR_I2C_TIMEOUT);
> 
> Why do you need this polling in an interrupt?
> 

I wanted to wait for completion before marking it as complete. As you 
point out, this isn't appropriate in an interrupt handler. I will look 
at this again. Thanks for pointing this out.

> 
>> +	if (ret)
>> +		dev_err(idev->dev, "%s: message timeout\n", __func__);
>> +	i2c_int_enable(idev, ALTR_I2C_ALL_IRQ, false);
>> +	i2c_int_clear(idev, ALTR_I2C_ALL_IRQ);
>> +	complete(&idev->msg_complete);
>> +	dev_dbg(idev->dev, "%s: Message Complete\n", __func__);
>> +
>> +out:
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static int altr_i2c_xfer_msg(struct altr_i2c_dev *idev, struct i2c_msg *msg)
>> +{
>> +	u32 imask = ALTR_I2C_ISR_RXOF | ALTR_I2C_ISR_ARB | ALTR_I2C_ISR_NACK;
>> +	unsigned long time_left;
>> +	u32 value;
>> +	u8 addr = i2c_8bit_addr_from_msg(msg);
>> +
>> +	idev->msg = msg;
>> +	idev->msg_len = msg->len;
>> +	idev->buf = msg->buf;
>> +	idev->msg_err = 0;
>> +	reinit_completion(&idev->msg_complete);
>> +	altr_i2c_core_enable(idev);
>> +
>> +	/* Make sure RX FIFO is empty */
>> +	do {
>> +		readl(idev->base + ALTR_I2C_RX_DATA);
>> +	} while (readl(idev->base + ALTR_I2C_RX_FIFO_LVL));
>> +
>> +	writel(ALTR_I2C_TFR_CMD_STA | addr, idev->base + ALTR_I2C_TFR_CMD);
>> +
>> +	if (i2c_m_rd(msg)) {
>> +		imask |= ALTR_I2C_ISER_RXOF_EN | ALTR_I2C_ISER_RXRDY_EN;
>> +		i2c_int_enable(idev, imask, true);
>> +		/* write the first byte to start the RX */
>> +		altr_i2c_transfer(idev, 0);
>> +	} else {
>> +		imask |= ALTR_I2C_ISR_TXRDY;
>> +		i2c_int_enable(idev, imask, true);
>> +		altr_i2c_fill_tx_fifo(idev);
>> +	}
>> +
>> +	time_left = wait_for_completion_timeout(&idev->msg_complete,
>> +						ALTR_I2C_XFER_TIMEOUT);
>> +	i2c_int_enable(idev, imask, false);
>> +
>> +	value = readl(idev->base + ALTR_I2C_STATUS) & ALTR_I2C_STAT_CORE;
>> +	if (value)
>> +		dev_err(idev->dev, "%s: Core Status not IDLE...\n", __func__);
> 
> __func__ with dev_* is 99,9% superfluous.
> 

I will remove this and the other ones above. Andy indicated this as well.

>> +
>> +	if (time_left == 0) {
>> +		idev->msg_err = -ETIMEDOUT;
>> +		dev_err(idev->dev, "%s: Transaction timed out.\n", __func__);
> 
> No error message here. This can happen when an EEPROM is currently
> erasing.
> 

OK.

>> +		altr_i2c_recover(idev);
> 
> And no need to reset the bus! Only if SDA is stuck low.
> 

OK. Unfortunately, we can't check the state of the SDA line so I was 
being extra cautious. I will remove it.

>> +	}
>> +
>> +	if (unlikely(idev->msg_err) && idev->msg_err != -ENXIO)
>> +		altr_i2c_init(idev);
> 
> Why do you need to reinit on NACK?
> 

OK. Thanks.

>> +
>> +	altr_i2c_core_disable(idev);
>> +
>> +	return idev->msg_err;
>> +}
>> +
>> +static int
>> +altr_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
>> +{
>> +	struct altr_i2c_dev *idev = i2c_get_adapdata(adap);
>> +	int i, ret;
>> +
>> +	for (i = 0; i < num; i++) {
>> +		ret = altr_i2c_xfer_msg(idev, msgs++);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +	return num;
>> +}
>> +
>> +static u32 altr_i2c_func(struct i2c_adapter *adap)
>> +{
>> +	return I2C_FUNC_I2C;
>> +}
> 
> No emulated SMBUS?
> 

I was focusing on I2C and wasn't sure about SMBus (particularly the 
minimum clock speed). SMBus could be added later but would require some 
IP changes.

<snip>
