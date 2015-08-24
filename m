From: marex@denx.de (Marek Vasut)
Date: Mon, 24 Aug 2015 13:03:51 +0200
Subject: [PATCH linux-next v4 5/5] mtd: atmel-quadspi: add driver for
 Atmel QSPI controller
In-Reply-To: <bf368fc101f38db231131b69eff0863210f2b01c.1440410236.git.cyrille.pitchen@atmel.com>
References: <cover.1440410236.git.cyrille.pitchen@atmel.com>
 <bf368fc101f38db231131b69eff0863210f2b01c.1440410236.git.cyrille.pitchen@atmel.com>
Message-ID: <201508241303.52066.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, August 24, 2015 at 12:14:00 PM, Cyrille Pitchen wrote:
> This driver add support to the new Atmel QSPI controller embedded into
> sama5d2x SoCs. It expects a NOR memory to be connected to the QSPI
> controller.
> 
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Hi,

[...]

> +/* Register access macros */

These are functions, not macros :)

btw is there any reason for these ? I'd say, just put the read*() and
write*() functions directly into the code and be done with it, it is
much less confusing.

Also, why do you use the _relaxed() versions of the functions ?

> +static inline u32 qspi_readl(struct atmel_qspi *aq, u32 reg)
> +{
> +	return readl_relaxed(aq->regs + reg);
> +}
> +
> +static inline void qspi_writel(struct atmel_qspi *aq, u32 reg, u32 value)
> +{
> +	writel_relaxed(value, aq->regs + reg);
> +}
> +
> +static inline u16 qspi_readw(struct atmel_qspi *aq, u32 reg)
> +{
> +	return readw_relaxed(aq->regs + reg);
> +}
> +
> +static inline void qspi_writew(struct atmel_qspi *aq, u32 reg, u16 value)
> +{
> +	writew_relaxed(value, aq->regs + reg);
> +}
> +
> +static inline u8 qspi_readb(struct atmel_qspi *aq, u32 reg)
> +{
> +	return readb_relaxed(aq->regs + reg);
> +}
> +
> +static inline void qspi_writeb(struct atmel_qspi *aq, u32 reg, u8 value)
> +{
> +	writeb_relaxed(value, aq->regs + reg);
> +}

[...]

> +static int atmel_qspi_run_command(struct atmel_qspi *aq,
> +				  const struct atmel_qspi_command *cmd)
> +{
> +	u32 iar, icr, ifr, sr;
> +	int err = 0;
> +
> +	iar = 0;
> +	icr = 0;
> +	ifr = aq->ifr_width | cmd->ifr_tfrtyp;
> +
> +	/* Compute instruction parameters */
> +	if (cmd->enable.bits.instruction) {
> +		icr |= QSPI_ICR_INST(cmd->instruction);
> +		ifr |= QSPI_IFR_INSTEN;
> +	}
> +
> +	/* Compute address parameters */
> +	switch (cmd->enable.bits.address) {
> +	case 4:
> +		ifr |= QSPI_IFR_ADDRL;
> +		/*break;*/ /* fallback to the 24bit address case */

What's this commented out bit of code for ? :-)

> +	case 3:
> +		iar = (cmd->enable.bits.data) ? 0 : cmd->address;
> +		ifr |= QSPI_IFR_ADDREN;
> +		break;
> +	case 0:
> +		break;
> +	default:
> +		return -EINVAL;
> +	}

[...]

> +no_data:
> +	/* Poll INSTRuction End status */
> +	sr = qspi_readl(aq, QSPI_SR);
> +	if (sr & QSPI_SR_INSTRE)
> +		return err;
> +
> +	/* Wait for INSTRuction End interrupt */
> +	init_completion(&aq->completion);

You should use reinit_completion() in the code. init_completion()
should be used only in the probe() function and nowhere else.

> +	aq->pending = 0;
> +	qspi_writel(aq, QSPI_IER, QSPI_SR_INSTRE);
> +	if (!wait_for_completion_timeout(&aq->completion,
> +					 msecs_to_jiffies(1000)))
> +		err = -ETIMEDOUT;
> +	qspi_writel(aq, QSPI_IDR, QSPI_SR_INSTRE);
> +
> +	return err;
> +}

[...]

Hope this helps :)
