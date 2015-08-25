From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Tue, 25 Aug 2015 12:17:37 +0200
Subject: [PATCH linux-next v4 5/5] mtd: atmel-quadspi: add driver for
 Atmel QSPI controller
In-Reply-To: <201508241303.52066.marex@denx.de>
References: <cover.1440410236.git.cyrille.pitchen@atmel.com>
 <bf368fc101f38db231131b69eff0863210f2b01c.1440410236.git.cyrille.pitchen@atmel.com>
 <201508241303.52066.marex@denx.de>
Message-ID: <55DC40C1.3050405@atmel.com>
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

If you don't mind, I'd rather keep some of these inline functions. I have
no strong justification, it's more a personal taste: it makes lines
shorter as it avoids the need to add "->regs + ".
Also it makes the code consistent with other Atmel drivers which already
use such wrappers.

However I'll fix the comment and remove the byte and word versions, which
are not used. So only qspi_readl() and qspi_writel() are left.

Does it sound good to you?

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
> Hope this helps :)
> 

Best regards,

Cyrille
