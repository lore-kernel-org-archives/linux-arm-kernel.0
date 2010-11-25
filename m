From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu, 25 Nov 2010 10:26:28 +0800
Subject: [PATCH 4/7] i2c/pxa2xx: add support for shared IRQ handler
In-Reply-To: <1290633617-15311-5-git-send-email-bigeasy@linutronix.de>
References: <1290633617-15311-1-git-send-email-bigeasy@linutronix.de>
	<1290633617-15311-5-git-send-email-bigeasy@linutronix.de>
Message-ID: <AANLkTik11gr1fg=vht2FYBpDZBBhxLXezS8ih752xj=5@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 25, 2010 at 5:20 AM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> Sodaville has three of them on a single IRQ. IRQF_DISABLED is removed
> because it is a NOP allready and scheduled for removal.
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Dirk Brandewie <dirk.brandewie@gmail.com>
> ---
> ?drivers/i2c/busses/i2c-pxa.c | ? 10 ++++++++--
> ?1 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
> index dc66fde..7647361 100644
> --- a/drivers/i2c/busses/i2c-pxa.c
> +++ b/drivers/i2c/busses/i2c-pxa.c
> @@ -905,11 +905,17 @@ static void i2c_pxa_irq_rxfull(struct pxa_i2c *i2c, u32 isr)
> ? ? ? ?writel(icr, _ICR(i2c));
> ?}
>
> +#define VALID_INT_SOURCE ? ? ? (ISR_SSD | ISR_ALD | ISR_ITE | ISR_IRF | \
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ISR_SAD | ISR_BED)
> ?static irqreturn_t i2c_pxa_handler(int this_irq, void *dev_id)
> ?{
> ? ? ? ?struct pxa_i2c *i2c = dev_id;
> ? ? ? ?u32 isr = readl(_ISR(i2c));
>
> + ? ? ? isr &= VALID_INT_SOURCE;
> + ? ? ? if (!isr)
> + ? ? ? ? ? ? ? return IRQ_NONE;
> +

If you return at here, the valid interrupt status event won't be
cleared in IRQ handler. So I2C interrupt handler will be triggered at
next time.

> ? ? ? ?if (i2c_debug > 2 && 0) {
> ? ? ? ? ? ? ? ?dev_dbg(&i2c->adap.dev, "%s: ISR=%08x, ICR=%08x, IBMR=%02x\n",
> ? ? ? ? ? ? ? ? ? ? ? ?__func__, isr, readl(_ICR(i2c)), readl(_IBMR(i2c)));
> @@ -924,7 +930,7 @@ static irqreturn_t i2c_pxa_handler(int this_irq, void *dev_id)
> ? ? ? ?/*
> ? ? ? ? * Always clear all pending IRQs.
> ? ? ? ? */
> - ? ? ? writel(isr & (ISR_SSD|ISR_ALD|ISR_ITE|ISR_IRF|ISR_SAD|ISR_BED), _ISR(i2c));
> + ? ? ? writel(isr, _ISR(i2c));
>
> ? ? ? ?if (isr & ISR_SAD)
> ? ? ? ? ? ? ? ?i2c_pxa_slave_start(i2c, isr);
> @@ -1062,7 +1068,7 @@ static int i2c_pxa_probe(struct platform_device *dev)
> ? ? ? ? ? ? ? ?i2c->adap.algo = &i2c_pxa_pio_algorithm;
> ? ? ? ?} else {
> ? ? ? ? ? ? ? ?i2c->adap.algo = &i2c_pxa_algorithm;
> - ? ? ? ? ? ? ? ret = request_irq(irq, i2c_pxa_handler, IRQF_DISABLED,
> + ? ? ? ? ? ? ? ret = request_irq(irq, i2c_pxa_handler, IRQF_SHARED,
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?i2c->adap.name, i2c);
> ? ? ? ? ? ? ? ?if (ret)
> ? ? ? ? ? ? ? ? ? ? ? ?goto ereqirq;
> --
> 1.7.3.2
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
