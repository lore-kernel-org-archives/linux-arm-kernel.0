From: manabian@gmail.com (Joachim Eastwood)
Date: Mon, 4 May 2015 23:29:47 +0200
Subject: [PATCH 1/2] reset: add driver for lpc18xx rgu
In-Reply-To: <1430726427.3722.15.camel@pengutronix.de>
References: <1430173843-11648-1-git-send-email-manabian@gmail.com>
 <1430173843-11648-2-git-send-email-manabian@gmail.com>
 <1430726427.3722.15.camel@pengutronix.de>
Message-ID: <CAGhQ9VzBEmTSQU9cz3XoPnh3Lz1rJrbWowp-N9YK6F-DH8ir4Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 May 2015 at 10:00, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> Hi Joachim,
>
> thank you for the patch! Some comments below:
>
> Am Dienstag, den 28.04.2015, 00:30 +0200 schrieb Joachim Eastwood:
>> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
>> ---
>>  drivers/reset/Makefile        |   1 +
>>  drivers/reset/reset-lpc18xx.c | 260 ++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 261 insertions(+)
>>  create mode 100644 drivers/reset/reset-lpc18xx.c
>>
>> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
>> index 157d421f755b..1d41feeb2dce 100644
>> --- a/drivers/reset/Makefile
>> +++ b/drivers/reset/Makefile
>> @@ -1,4 +1,5 @@
>>  obj-$(CONFIG_RESET_CONTROLLER) += core.o
>> +obj-$(CONFIG_ARCH_LPC18XX) += reset-lpc18xx.o
>>  obj-$(CONFIG_ARCH_SOCFPGA) += reset-socfpga.o
>>  obj-$(CONFIG_ARCH_BERLIN) += reset-berlin.o
>>  obj-$(CONFIG_ARCH_SUNXI) += reset-sunxi.o
>> diff --git a/drivers/reset/reset-lpc18xx.c b/drivers/reset/reset-lpc18xx.c
>> new file mode 100644
>> index 000000000000..9564d78ab9d2
>> --- /dev/null
>> +++ b/drivers/reset/reset-lpc18xx.c
>> @@ -0,0 +1,260 @@
>> +/*
>> + * Reset driver for NXP LPC18xx/43xx Reset Generation Unit (RGU).
>> + *
>> + * Copyright (C) 2014 Joachim Eastwood <manabian@gmail.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/delay.h>
>> +#include <linux/err.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/reboot.h>
>> +#include <linux/reset-controller.h>
>> +#include <linux/slab.h>
>> +#include <linux/types.h>
>> +
>> +#include <asm/system_misc.h>
>
> Are all of these necessary? I don't see why of_address.h and
> system_misc.h are included, for example.

You are right, I'll clean them up.

>> +/* LPC18xx RGU registers */
>> +#define LPC18XX_RGU_CTRL0            0x100
>> +#define LPC18XX_RGU_CTRL1            0x104
>> +#define LPC18XX_RGU_ACTIVE_STATUS0   0x150
>> +#define LPC18XX_RGU_ACTIVE_STATUS1   0x154
>> +
>> +#define LPC18XX_RGU_RESETS_PER_REG   32
>> +
>> +/* Internal reset outputs */
>> +#define LPC18XX_RGU_CORE_RST 0
>> +#define LPC18XX_RGU_M0SUB_RST        12
>> +#define LPC18XX_RGU_M0APP_RST        56
>
> In the LPC18xx User Manual these are marked as reserved, I think using
> the LPC43XX_ prefix here could avoid confusion. Or are there also
> LPC18xx that have these reset lines?

No, they are only used on the 43xx series. I'll change the prefix.

I'll also add some comments in the DT doc on which reset lines that
are available on the different devices.

>> +
>> +struct lpc18xx_rgu_data {
>> +     struct reset_controller_dev rcdev;
>> +     struct clk *clk_delay;
>> +     struct clk *clk_reg;
>> +     void __iomem *base;
>> +     spinlock_t lock;
>> +     u32 delay_us;
>> +};
>> +
>> +#define to_rgu_data(rcdev) container_of(rcdev, struct lpc18xx_rgu_data, rcdev)
>> +
>> +static void __iomem *rgu_base;
>> +
>> +static int lpc18xx_rgu_restart(struct notifier_block *this, unsigned long mode,
>> +                            void *cmd)
>> +{
>> +     writel(BIT(LPC18XX_RGU_CORE_RST), rgu_base + LPC18XX_RGU_CTRL0);
>> +     mdelay(2000);
>> +
>> +     pr_emerg("%s: unable to restart system\n", __func__);
>> +
>> +     return NOTIFY_DONE;
>> +}
>> +
>> +static struct notifier_block lpc18xx_rgu_restart_nb = {
>> +     .notifier_call = lpc18xx_rgu_restart,
>> +     .priority = 192,
>> +};
>> +
>> +/*
>> + * The LPC18xx RGU has mostly self-deasserting resets except for the
>> + * two reset lines going to the internal Cortex-M0 cores.
>> + *
>> + * To prevent the M0 cores from accidentally getting deasserting the
>
> "To prevent the M0 core resets from accidentally getting deasserted" ?

That sounds better. I'll use it in the next version.

>> + * status register must be check and bits in control register set to
>> + * preserve the state.
>> + */
>> +static void lpc18xx_rgu_setclear_reset(struct reset_controller_dev *rcdev,
>> +                                    unsigned long id, bool set)
>> +{
>> +     struct lpc18xx_rgu_data *rc = to_rgu_data(rcdev);
>> +     u32 stat_offset = LPC18XX_RGU_ACTIVE_STATUS0;
>> +     u32 ctrl_offset = LPC18XX_RGU_CTRL0;
>> +     unsigned long flags;
>> +     u32 stat, rst_bit;
>> +
>> +     stat_offset += (id / LPC18XX_RGU_RESETS_PER_REG) * sizeof(u32);
>> +     ctrl_offset += (id / LPC18XX_RGU_RESETS_PER_REG) * sizeof(u32);
>> +     rst_bit = 1 << (id % LPC18XX_RGU_RESETS_PER_REG);
>> +
>> +     spin_lock_irqsave(&rc->lock, flags);
>> +     stat = ~readl(rc->base + stat_offset);
>> +     if (set)
>> +             writel(stat | rst_bit, rc->base + ctrl_offset);
>> +     else
>> +             writel(stat & ~rst_bit, rc->base + ctrl_offset);
>> +     spin_unlock_irqrestore(&rc->lock, flags);
>> +}
>> +
>> +static int lpc18xx_rgu_reset(struct reset_controller_dev *rcdev,
>> +                          unsigned long id)
>> +{
>> +     struct lpc18xx_rgu_data *rc = to_rgu_data(rcdev);
>> +
>> +     lpc18xx_rgu_setclear_reset(rcdev, id, true);
>> +     udelay(rc->delay_us);
>> +
>> +     return 0;
>> +}
>
> This is missing a deassert for the M0 resets, see below.
>
>> +
>> +static int lpc18xx_rgu_assert(struct reset_controller_dev *rcdev,
>> +                           unsigned long id)
>> +{
>> +     return lpc18xx_rgu_reset(rcdev, id);
>> +}
>
> lpc18xx_rgu_assert shouldn't include the delay. Could you have
> lpc18xx_rgu_assert call lpc18xx_rgu_setclear_reset directly?

I agree. I'll change it.

> Let lpc18xx_rgu_reset then call lpc18xx_rgu_assert, udelay, and
> lpc18xx_rgu_deassert.

Ok, that does indeed sound like a better call chain. I'll reorganize
the code a bit.

> Or could you wait for the active status bit to
> clear instead of the fixed delay for the self-clearing resets?

I am not sure. The manual explicitly mentions a software delay.

>From manual:
  Remark: The reset delay is counted in IRC clock cycles. If the
  core frequency CCLK is much higher than the IRC frequency, add
  a software delay of fCCLK/fIRC clock cycles between resetting
  and accessing any of the peripheral blocks.

So I think it's best to keep using the delay.

>> +/* Only M0 cores require explicit reset deassert */
>> +static int lpc18xx_rgu_deassert(struct reset_controller_dev *rcdev,
>> +                             unsigned long id)
>> +{
>> +     switch (id) {
>> +     case LPC18XX_RGU_M0SUB_RST:
>> +     case LPC18XX_RGU_M0APP_RST:
>> +             lpc18xx_rgu_setclear_reset(rcdev, id, false);
>> +     }
>> +
>> +     return 0;
>> +}
>
> If writing 0 to the self-clearing reset bits does nothing,
> lpc18xx_rgu_setclear_reset(... false) could be called unconditionally.

I added the check to document that the M0 reset are special. The next
version of the patch set will move it around a bit. If you still don't
like it can remove it then.


Thanks for your time reviewing.

regards,
Joachim Eastwood
