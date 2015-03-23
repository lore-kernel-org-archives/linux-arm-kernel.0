From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 23 Mar 2015 09:42:37 +0100
Subject: [PATCH v5 2/3] I2C: mediatek: Add driver for MediaTek I2C
 controller
In-Reply-To: <1426917922-61356-3-git-send-email-eddie.huang@mediatek.com>
References: <1426917922-61356-1-git-send-email-eddie.huang@mediatek.com>
 <1426917922-61356-3-git-send-email-eddie.huang@mediatek.com>
Message-ID: <20150323084237.GG9742@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 21, 2015 at 02:05:21PM +0800, Eddie Huang wrote:
> From: Xudong Chen <xudong.chen@mediatek.com>
> 
> The mediatek SoCs have I2C controller that handle I2C transfer.
> This patch include common I2C bus driver.
> This driver is compatible with I2C controller on mt65xx/mt81xx.
> 
> Signed-off-by: Xudong Chen <xudong.chen@mediatek.com>
> Signed-off-by: Liguo Zhang <liguo.zhang@mediatek.com>
> Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
> ---
>  drivers/i2c/busses/Kconfig      |   9 +
>  drivers/i2c/busses/Makefile     |   1 +
>  drivers/i2c/busses/i2c-mt65xx.c | 705 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 715 insertions(+)
>  create mode 100644 drivers/i2c/busses/i2c-mt65xx.c
> 
> +
> +static void mtk_i2c_clock_disable(struct mtk_i2c *i2c)
> +{
> +	if (i2c->have_pmic)
> +		clk_disable_unprepare(i2c->clk_pmic);
> +
> +	clk_disable_unprepare(i2c->clk_main);
> +	clk_disable_unprepare(i2c->clk_dma);
> +}
> +
> +static inline void mtk_i2c_init_hw(struct mtk_i2c *i2c)

Please let the compiler decide whether to inline this or not.

> +{
> +	mtk_i2c_writew(I2C_SOFT_RST, i2c, OFFSET_SOFTRESET);
> +	/* Set ioconfig */
> +	if (i2c->use_push_pull)
> +		mtk_i2c_writew(I2C_IO_CONFIG_PUSH_PULL, i2c, OFFSET_IO_CONFIG);
> +	else
> +		mtk_i2c_writew(I2C_IO_CONFIG_OPEN_DRAIN, i2c, OFFSET_IO_CONFIG);
> +
> +	if (i2c->platform_compat & COMPAT_MT6577)
> +		mtk_i2c_writew(I2C_DCM_DISABLE, i2c, OFFSET_DCM_EN);
> +
> +	mtk_i2c_writew(i2c->timing_reg, i2c, OFFSET_TIMING);
> +	mtk_i2c_writew(i2c->high_speed_reg, i2c, OFFSET_HS);
> +}
> +

[...]

> +	step_cnt = step_div;
> +	sclk = hclk / (2 * sample_cnt * step_cnt);
> +	if (sclk > khz) {
> +		dev_dbg(i2c->dev, "%s mode: unsupported speed (%ldkhz)\n",
> +			(mode == HS_MODE) ? "HS" : "ST/FT", (long int)khz);
> +		return -ENOTSUPP;
> +	}
> +
> +	step_cnt--;
> +	sample_cnt--;
> +
> +	if (mode == HS_MODE) {

This is the only place where the HS_MODE is actually tested for.
Dropping this enum and using i2c->speed_hz > MAX_FS_MODE_SPEED directly
here would improve readability.

> +		/* Set the hign speed mode register */
> +		i2c->timing_reg = I2C_FS_TIME_INIT_VALUE;
> +		i2c->high_speed_reg = I2C_TIME_DEFAULT_VALUE |
> +			(sample_cnt & I2C_TIMING_SAMPLE_COUNT_MASK) << 12 |
> +			(step_cnt & I2C_TIMING_SAMPLE_COUNT_MASK) << 8;
> +	} else {
> +		i2c->timing_reg =
> +			(sample_cnt & I2C_TIMING_SAMPLE_COUNT_MASK) << 8 |
> +			(step_cnt & I2C_TIMING_STEP_DIV_MASK) << 0;
> +		/* Disable the high speed transaction */
> +		i2c->high_speed_reg = I2C_TIME_CLR_VALUE;
> +	}
> +
> +	return 0;
> +}
> +

[...]

> +	if (i2c->speed_hz > 400000)
> +		control_reg |= I2C_CONTROL_RS;
> +	if (i2c->op == I2C_MASTER_WRRD)
> +		control_reg |= I2C_CONTROL_DIR_CHANGE | I2C_CONTROL_RS;
> +	mtk_i2c_writew(control_reg, i2c, OFFSET_CONTROL);
> +
> +	/* set start condition */
> +	if (i2c->speed_hz <= 100000)
> +		mtk_i2c_writew(I2C_ST_START_CON, i2c, OFFSET_EXT_CONF);
> +	else
> +		mtk_i2c_writew(I2C_FS_START_CON, i2c, OFFSET_EXT_CONF);
> +
> +	if (~control_reg & I2C_CONTROL_RS)
> +		mtk_i2c_writew(I2C_DELAY_LEN, i2c, OFFSET_DELAY_LEN);

speed <= 400000 here to make this more obvious?

> +
> +	addr_reg = msgs->addr << 1;
> +	if (i2c->op == I2C_MASTER_RD)
> +		addr_reg |= 0x1;
> +	mtk_i2c_writew(addr_reg, i2c, OFFSET_SLAVE_ADDR);
> +
> +	/* Clear interrupt status */
> +	mtk_i2c_writew(I2C_HS_NACKERR | I2C_ACKERR | I2C_TRANSAC_COMP,
> +		i2c, OFFSET_INTR_STAT);
> +	mtk_i2c_writew(I2C_FIFO_ADDR_CLR, i2c, OFFSET_FIFO_ADDR_CLR);
> +
> +	/* Enable interrupt */
> +	mtk_i2c_writew(I2C_HS_NACKERR | I2C_ACKERR | I2C_TRANSAC_COMP,
> +		i2c, OFFSET_INTR_MASK);

Why do you enable/disable interrupts for each transfer? Enabling them
once and just acknowledge them in the interrupt handler should be
enough.

> +	if (!i2c->trans_stop && tmo == 0) {
> +		dev_dbg(i2c->dev, "addr: %x, transfer timeout\n", msgs->addr);
> +		mtk_i2c_init_hw(i2c);
> +		return -ETIMEDOUT;
> +	}
> +
> +	spin_lock(&i2c->irqlock);
> +	irqstat = i2c->irq_stat;
> +	spin_unlock(&i2c->irqlock);

A plain spin_lock can't protect you against the interrupt handler, see
https://www.kernel.org/pub/linux/kernel/people/rusty/kernel-locking/c214.html.
You need at least spin_lock_irq().

Anyway, I think this spin_lock can be removed since it only protects the
irq_stat variable. This is written only in the interrupt handler and
then tested for in thread context. The thread waits for the interrupt
handler to be finished anyway.

> +static irqreturn_t mtk_i2c_irq(int irqno, void *dev_id)
> +{
> +	struct mtk_i2c *i2c = dev_id;
> +
> +	/* Clear interrupt mask */
> +	mtk_i2c_writew(~(I2C_HS_NACKERR | I2C_ACKERR | I2C_TRANSAC_COMP),
> +		i2c, OFFSET_INTR_MASK);
> +
> +	spin_lock(&i2c->irqlock);
> +	i2c->irq_stat = mtk_i2c_readw(i2c, OFFSET_INTR_STAT);
> +	i2c->trans_stop = true;

A struct completion seems more what you want here. This makes the
trans_stop variable unnecessary (it contains no information anyway).

See the tegra driver as an example.

> +	spin_unlock(&i2c->irqlock);
> +	mtk_i2c_writew(I2C_HS_NACKERR | I2C_ACKERR
> +			| I2C_TRANSAC_COMP, i2c, OFFSET_INTR_STAT);
> +	wake_up(&i2c->wait);
> +
> +	return IRQ_HANDLED;
> +}
> +

[...]

> +static int mtk_i2c_probe(struct platform_device *pdev)
> +{
> +	int ret = 0;
> +	struct mtk_i2c *i2c;
> +	struct clk *clk;
> +	unsigned int clk_src_in_hz;
> +	unsigned int clk_src_div;
> +	struct resource *res;
> +
> +	i2c = devm_kzalloc(&pdev->dev, sizeof(struct mtk_i2c), GFP_KERNEL);

sizeof(*i2c) instead. This will make it harder to allocate the memory
for a wrong struct size.

> +	if (i2c == NULL)
> +		return -ENOMEM;
> +
> +	ret = mtk_i2c_parse_dt(pdev->dev.of_node, i2c, &clk_src_div);
> +	if (ret)
> +		return -EINVAL;
> +
> +	i2c->platform_compat = mtk_get_device_prop(pdev);
> +	if (i2c->have_pmic && (i2c->platform_compat & COMPAT_MT6577))
> +		return -EINVAL;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +
> +	i2c->base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(i2c->base))
> +		return PTR_ERR(i2c->base);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +
> +	i2c->pdmabase = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(i2c->pdmabase))
> +		return PTR_ERR(i2c->pdmabase);
> +
> +	i2c->irqnr = platform_get_irq(pdev, 0);
> +	if (i2c->irqnr <= 0)
> +		return -EINVAL;

i2c->irqnr is never used outside this function, so you can drop it from
struct mtk_i2c and make this a local variable.

Contrary to what Uwe said this variable should be a signed variable
because platform_get_irq() returns a signed integer which may contain a
negative error code. This will never be catched if you use an unsigned
variable.

Also you should forward the error instead of returning -EINVAL.

> +static int mtk_i2c_remove(struct platform_device *pdev)
> +{
> +	struct mtk_i2c *i2c = platform_get_drvdata(pdev);
> +
> +	i2c_del_adapter(&i2c->adap);
> +	platform_set_drvdata(pdev, NULL);

This is unnecessary. This pointer is unused when no driver is bound to
the device and no driver will expect it to be valid in probe().

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
