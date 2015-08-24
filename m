From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Mon, 24 Aug 2015 19:04:38 +0200
Subject: [PATCH linux-next v4 5/5] mtd: atmel-quadspi: add driver for
 Atmel QSPI controller
In-Reply-To: <201508241303.52066.marex@denx.de>
References: <cover.1440410236.git.cyrille.pitchen@atmel.com>
 <bf368fc101f38db231131b69eff0863210f2b01c.1440410236.git.cyrille.pitchen@atmel.com>
 <201508241303.52066.marex@denx.de>
Message-ID: <55DB4EA6.9090807@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

Le 24/08/2015 13:03, Marek Vasut a ?crit :
> On Monday, August 24, 2015 at 12:14:00 PM, Cyrille Pitchen wrote:
>> This driver add support to the new Atmel QSPI controller embedded into
>> sama5d2x SoCs. It expects a NOR memory to be connected to the QSPI
>> controller.
>>
>> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
>> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> Hi,
> 
> [...]
> 
>> +/* Register access macros */
> 
> These are functions, not macros :)
> 
> btw is there any reason for these ? I'd say, just put the read*() and
> write*() functions directly into the code and be done with it, it is
> much less confusing.
> 
> Also, why do you use the _relaxed() versions of the functions ?
> 
>> +static inline u32 qspi_readl(struct atmel_qspi *aq, u32 reg)
>> +{
>> +	return readl_relaxed(aq->regs + reg);
>> +}
>> +
>> +static inline void qspi_writel(struct atmel_qspi *aq, u32 reg, u32 value)
>> +{
>> +	writel_relaxed(value, aq->regs + reg);
>> +}
>> +
>> +static inline u16 qspi_readw(struct atmel_qspi *aq, u32 reg)
>> +{
>> +	return readw_relaxed(aq->regs + reg);
>> +}
>> +
>> +static inline void qspi_writew(struct atmel_qspi *aq, u32 reg, u16 value)
>> +{
>> +	writew_relaxed(value, aq->regs + reg);
>> +}
>> +
>> +static inline u8 qspi_readb(struct atmel_qspi *aq, u32 reg)
>> +{
>> +	return readb_relaxed(aq->regs + reg);
>> +}
>> +
>> +static inline void qspi_writeb(struct atmel_qspi *aq, u32 reg, u8 value)
>> +{
>> +	writeb_relaxed(value, aq->regs + reg);
>> +}
> 
> [...]
> 
>> +static int atmel_qspi_run_command(struct atmel_qspi *aq,
>> +				  const struct atmel_qspi_command *cmd)
>> +{
>> +	u32 iar, icr, ifr, sr;
>> +	int err = 0;
>> +
>> +	iar = 0;
>> +	icr = 0;
>> +	ifr = aq->ifr_width | cmd->ifr_tfrtyp;
>> +
>> +	/* Compute instruction parameters */
>> +	if (cmd->enable.bits.instruction) {
>> +		icr |= QSPI_ICR_INST(cmd->instruction);
>> +		ifr |= QSPI_IFR_INSTEN;
>> +	}
>> +
>> +	/* Compute address parameters */
>> +	switch (cmd->enable.bits.address) {
>> +	case 4:
>> +		ifr |= QSPI_IFR_ADDRL;
>> +		/*break;*/ /* fallback to the 24bit address case */
> 
> What's this commented out bit of code for ? :-)

I just wanted to stress out there was no missing "break;".
I've reworded the comment to:
/* No "break" on purpose: fallback to the 24bit address case. */

> 
>> +	case 3:
>> +		iar = (cmd->enable.bits.data) ? 0 : cmd->address;
>> +		ifr |= QSPI_IFR_ADDREN;
>> +		break;
>> +	case 0:
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
> 
> [...]
> 
>> +no_data:
>> +	/* Poll INSTRuction End status */
>> +	sr = qspi_readl(aq, QSPI_SR);
>> +	if (sr & QSPI_SR_INSTRE)
>> +		return err;
>> +
>> +	/* Wait for INSTRuction End interrupt */
>> +	init_completion(&aq->completion);
> 
> You should use reinit_completion() in the code. init_completion()
> should be used only in the probe() function and nowhere else.

Alright. In the next version I'll rename the "completion" member of
struct atmel_qspi into "cmd_completion". Also I'll add another dma_completion
member in this very same structure to replace the local
"struct completion completion" in atmel_qspi_run_dma_transfer().

Then I'll call init_completion() on both cmd_completion and dma_completion only
from atmel_qspi_probe() and reinit_completion() elsewhere.

> 
>> +	aq->pending = 0;
>> +	qspi_writel(aq, QSPI_IER, QSPI_SR_INSTRE);
>> +	if (!wait_for_completion_timeout(&aq->completion,
>> +					 msecs_to_jiffies(1000)))
>> +		err = -ETIMEDOUT;
>> +	qspi_writel(aq, QSPI_IDR, QSPI_SR_INSTRE);
>> +
>> +	return err;
>> +}
> 
> [...]
> 
> Hope this helps :)
> 

Indeed, it does! I still work on the next version of this series to take all your
comments into account.

Best regards,

Cyrille
