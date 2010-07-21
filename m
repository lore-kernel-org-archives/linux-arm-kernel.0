From: maz@misterjones.org (Marc Zyngier)
Date: Wed, 21 Jul 2010 10:12:33 +0100
Subject: [PATCH v3] gpio: sx150x: Add Semtech I2C sx150x gpio expander
	driver.
In-Reply-To: <1279660063-29449-1-git-send-email-gbean@codeaurora.org>
References: <1279660063-29449-1-git-send-email-gbean@codeaurora.org>
Message-ID: <20100721101233.42b22faf@taxman.wild-wind.fr.eu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 20 Jul 2010 14:07:43 -0700
Gregory Bean <gbean@codeaurora.org> wrote:

Gregory,

> Add support for Semtech SX150-series I2C GPIO expanders.
> Compatible models include:
> 
> 8 bits:  sx1508q
> 16 bits: sx1509q
> 
> Signed-off-by: Gregory Bean <gbean@codeaurora.org>

> +static int sx150x_irq_set_type(unsigned int irq, unsigned int flow_type)
> +{
> +	struct irq_chip *ic = get_irq_chip(irq);
> +	struct sx150x_chip *chip;
> +	unsigned n, val = 0;
> +
> +	if (flow_type & (IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW))
> +		return -EINVAL;
> +
> +	chip = container_of(ic, struct sx150x_chip, irq_chip);
> +	n = irq - chip->irq_base;
> +
> +	if (flow_type & IRQ_TYPE_EDGE_RISING)
> +		val |= 0x1;
> +	if (flow_type & IRQ_TYPE_EDGE_FALLING)
> +		val |= 0x2;
> +
> +	mutex_lock(&chip->mutex);
> +	chip->irq_sense &= ~(3UL << (n * 2));
> +	chip->irq_sense |= val << (n * 2);
> +	if (!(irq_to_desc(irq)->status & IRQ_MASKED))
> +		sx150x_write_cfg(chip, n, 2, chip->dev_cfg->reg_sense, val);
> +	mutex_unlock(&chip->mutex);
> +
> +	return 0;
> +}

Several problems here:
* This can be called from request_threaded irq(), which means the mutex
  is already taken (via the bus_lock method).
* On the same path, __setup_irq will disable local interrupts before
  calling this function. Bad things will happen if your I2C controller
  wants to sleep. pca953x had the same problem, see
  a2cb9aeb3c9b2475955cec328487484034f414e4 for a potential solution.

> +static irqreturn_t sx150x_irq_thread_fn(int irq, void *dev_id)
> +{
> +	struct sx150x_chip *chip = (struct sx150x_chip *)dev_id;
> +	unsigned nhandled = 0;
> +	unsigned sub_irq;
> +	unsigned n;
> +	s32 err;
> +	u8 val;
> +	int i;
> +
> +	mutex_lock(&chip->mutex);

This looks wrong... The whole purpose of the genirq framework is that it
takes care of most of the locking for you if you provide the
bus_lock/unlock methods. You should only use direct locking to protect
against races from the gpiolib framework.

> +	for (i = (chip->dev_cfg->ngpios / 8) - 1; i >= 0; --i) {
> +		err = sx150x_i2c_read(chip->client,
> +				      chip->dev_cfg->reg_irq_src - i,
> +				      &val);
> +		if (err < 0)
> +			continue;
> +
> +		sx150x_i2c_write(chip->client,
> +				chip->dev_cfg->reg_irq_src - i,
> +				val);
> +		for (n = 0; n < 8; ++n) {
> +			if (val & (1 << n)) {
> +				sub_irq = chip->irq_base + (i * 8) + n;
> +				handle_nested_irq(sub_irq);
> +				++nhandled;
> +			}
> +		}
> +	}
> +	mutex_unlock(&chip->mutex);
> +
> +	return (nhandled > 0 ? IRQ_HANDLED : IRQ_NONE);
> +}
> +

Cheers,

	M.
-- 
Enforcement officers may use a hand-held detection device to measure
both the direction and the strength of a TV signal. This makes it easy
for us to locate TV receiving equipment in even the hardest-to-reach
places.
