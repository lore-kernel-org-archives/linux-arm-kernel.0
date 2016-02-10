From: dhdang@apm.com (Duc Dang)
Date: Tue, 9 Feb 2016 19:46:57 -0800
Subject: [PATCH v5 1/3] mailbox: Add support for APM X-Gene platform
 mailbox driver
In-Reply-To: <CANLsYkwp4vJN+LcNm=7Xm=RppFnsPEXSAARS7=g6CZSsk5M5qw@mail.gmail.com>
References: <CABb+yY1cE152ZdfK_aeB8ufG=WfoUVB6BN8kXPphYgMBnpH-GA@mail.gmail.com>
 <cover.1454967957.git.dhdang@apm.com>
 <90cb13a0b4d3817c18c11c183128c08d6458bf8d.1454967957.git.dhdang@apm.com>
 <CANLsYkwp4vJN+LcNm=7Xm=RppFnsPEXSAARS7=g6CZSsk5M5qw@mail.gmail.com>
Message-ID: <CADaLNDktgAnq5VHGj=B0iO9-GnMAamTEVELYuBTVegeL3QZ4Sw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 9, 2016 at 8:40 AM, Mathieu Poirier
<mathieu.poirier@linaro.org> wrote:
> On 8 February 2016 at 15:04, Duc Dang <dhdang@apm.com> wrote:
>> X-Gene mailbox controller provides 8 mailbox channels, with
>> each channel has a dedicated interrupt line.
>>
>> Signed-off-by: Feng Kan <fkan@apm.com>
>> Signed-off-by: Duc Dang <dhdang@apm.com>
>> ---
>> Changes since v4:
>>         - Rebase over v4.5-rc1
>>         - Fix section mistmatch warning by removing
>>         __init in slimpro_mbox_probe declaration
>>         - Correctly print channel number when
>>         there is no IRQ for that channel
>>
>> Changes since v3:
>>         - Rebase over v4.4
>>         - Remove 'id' in slimpro_mbox_chan structure
>>         - Remove small functions that are only called once
>>         and fold them into the other callers
>>         - Remove void* pointer type cast
>>         - Relax the number of mailbox IRQs condition
>>         - Use subsys_initcall to guarantee mailbox driver
>>         will be registered before any other dependent driver
>>         is loaded.
>>
>>  drivers/mailbox/Kconfig                 |   9 ++
>>  drivers/mailbox/Makefile                |   2 +
>>  drivers/mailbox/mailbox-xgene-slimpro.c | 264 ++++++++++++++++++++++++++++++++
>>  3 files changed, 275 insertions(+)
>>  create mode 100644 drivers/mailbox/mailbox-xgene-slimpro.c
>>
>> diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
>> index 546d05f..678e434 100644
>> --- a/drivers/mailbox/Kconfig
>> +++ b/drivers/mailbox/Kconfig
>> @@ -85,4 +85,13 @@ config MAILBOX_TEST
>>           Test client to help with testing new Controller driver
>>           implementations.
>>
>> +config XGENE_SLIMPRO_MBOX
>> +       tristate "APM SoC X-Gene SLIMpro Mailbox Controller"
>> +       depends on ARCH_XGENE
>> +       help
>> +         An implementation of the APM X-Gene Interprocessor Communication
>> +         Mailbox (IPCM) between the ARM 64-bit cores and SLIMpro controller.
>> +         It is used to send short messages between ARM64-bit cores and
>> +         the SLIMpro Management Engine, primarily for PM. Say Y here if you
>> +         want to use the APM X-Gene SLIMpro IPCM support.
>>  endif
>> diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
>> index 92435ef..b602ef8 100644
>> --- a/drivers/mailbox/Makefile
>> +++ b/drivers/mailbox/Makefile
>> @@ -17,3 +17,5 @@ obj-$(CONFIG_ALTERA_MBOX)     += mailbox-altera.o
>>  obj-$(CONFIG_BCM2835_MBOX)     += bcm2835-mailbox.o
>>
>>  obj-$(CONFIG_STI_MBOX)         += mailbox-sti.o
>> +
>> +obj-$(CONFIG_XGENE_SLIMPRO_MBOX) += mailbox-xgene-slimpro.o
>> diff --git a/drivers/mailbox/mailbox-xgene-slimpro.c b/drivers/mailbox/mailbox-xgene-slimpro.c
>> new file mode 100644
>> index 0000000..0ea1eb8
>> --- /dev/null
>> +++ b/drivers/mailbox/mailbox-xgene-slimpro.c
>> @@ -0,0 +1,264 @@
>> +/*
>> + * APM X-Gene SLIMpro MailBox Driver
>> + *
>> + * Copyright (c) 2015, Applied Micro Circuits Corporation
>> + * Author: Feng Kan fkan at apm.com
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License as
>> + * published by the Free Software Foundation; either version 2 of
>> + * the License, or (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
>> + *
>> + */
>> +#include <linux/acpi.h>
>> +#include <linux/delay.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/io.h>
>> +#include <linux/mailbox_controller.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/spinlock.h>
>> +
>> +#define MBOX_CON_NAME                  "slimpro-mbox"
>> +#define MBOX_REG_SET_OFFSET            0x1000
>> +#define MBOX_CNT                       8
>> +#define MBOX_STATUS_AVAIL_MASK         BIT(16)
>> +#define MBOX_STATUS_ACK_MASK           BIT(0)
>> +
>> +/* Configuration and Status Registers */
>> +#define REG_DB_IN              0x00
>> +#define REG_DB_DIN0            0x04
>> +#define REG_DB_DIN1            0x08
>> +#define REG_DB_OUT             0x10
>> +#define REG_DB_DOUT0           0x14
>> +#define REG_DB_DOUT1           0x18
>> +#define REG_DB_STAT            0x20
>> +#define REG_DB_STATMASK                0x24
>> +
>> +struct slimpro_mbox_chan {
>> +       struct device *dev;
>> +       struct mbox_chan *chan;
>> +       void __iomem *reg;
>> +       int irq;
>> +       u32 rx_msg[3];
>> +};
>> +
>> +struct slimpro_mbox {
>> +       struct mbox_controller mb_ctrl;
>> +       struct slimpro_mbox_chan mc[MBOX_CNT];
>> +       struct mbox_chan chans[MBOX_CNT];
>> +};
>
> The above two structure declaration could use kernel style documentation.

Can you please clarify or give an example? I looked into several files
in drivers/mailbox/ and drivers/irqchip but could not find what I need
to tweak.

>
>> +
>> +static void mb_chan_send_msg(struct slimpro_mbox_chan *mb_chan, u32 *msg)
>> +{
>> +       writel(msg[1], mb_chan->reg + REG_DB_DOUT0);
>> +       writel(msg[2], mb_chan->reg + REG_DB_DOUT1);
>> +       writel(msg[0], mb_chan->reg + REG_DB_OUT);
>> +}
>> +
>> +static void mb_chan_recv_msg(struct slimpro_mbox_chan *mb_chan)
>> +{
>> +       mb_chan->rx_msg[1] = readl(mb_chan->reg + REG_DB_DIN0);
>> +       mb_chan->rx_msg[2] = readl(mb_chan->reg + REG_DB_DIN1);
>> +       mb_chan->rx_msg[0] = readl(mb_chan->reg + REG_DB_IN);
>> +}
>
> Is there a requirement that operations in the above two functions be
> ordered?  If not significant gains could be achieved by using
> writel/readl_relaxed().  Same comment for the rest of this driver.

The 'writes' need to be in order as writing to REG_DB_OUT will trigger
interrupt, so I want the other 2 'writes' complete before it.

After the receiver get the message, it will clear door bell available
interrupt request, this will also trigger a door bell acknowledge
interrupt. So the 'read' to get the message and the 'write' to clear
the door bell available interrupt must be in order as well.

Regards,
Duc Dang.
>
> Thanks,
> Mathieu
>
>> +
>> +static int mb_chan_status_ack(struct slimpro_mbox_chan *mb_chan)
>> +{
>> +       u32 val = readl(mb_chan->reg + REG_DB_STAT);
>> +
>> +       if (val & MBOX_STATUS_ACK_MASK) {
>> +               writel(MBOX_STATUS_ACK_MASK, mb_chan->reg + REG_DB_STAT);
>> +               return 1;
>> +       }
>> +       return 0;
>> +}
>> +
>> +static int mb_chan_status_avail(struct slimpro_mbox_chan *mb_chan)
>> +{
>> +       u32 val = readl(mb_chan->reg + REG_DB_STAT);
>> +
>> +       if (val & MBOX_STATUS_AVAIL_MASK) {
>> +               mb_chan_recv_msg(mb_chan);
>> +               writel(MBOX_STATUS_AVAIL_MASK, mb_chan->reg + REG_DB_STAT);
>> +               return 1;
>> +       }
>> +       return 0;
>> +}
>> +
>> +static irqreturn_t slimpro_mbox_irq(int irq, void *id)
>> +{
>> +       struct slimpro_mbox_chan *mb_chan = id;
>> +
>> +       if (mb_chan_status_ack(mb_chan))
>> +               mbox_chan_txdone(mb_chan->chan, 0);
>> +
>> +       if (mb_chan_status_avail(mb_chan))
>> +               mbox_chan_received_data(mb_chan->chan, mb_chan->rx_msg);
>> +
>> +       return IRQ_HANDLED;
>> +}
>> +
>> +static int slimpro_mbox_send_data(struct mbox_chan *chan, void *msg)
>> +{
>> +       struct slimpro_mbox_chan *mb_chan = chan->con_priv;
>> +
>> +       mb_chan_send_msg(mb_chan, msg);
>> +       return 0;
>> +}
>> +
>> +static int slimpro_mbox_startup(struct mbox_chan *chan)
>> +{
>> +       struct slimpro_mbox_chan *mb_chan = chan->con_priv;
>> +       int rc;
>> +       u32 val;
>> +
>> +       rc = devm_request_irq(mb_chan->dev, mb_chan->irq, slimpro_mbox_irq, 0,
>> +                             MBOX_CON_NAME, mb_chan);
>> +       if (unlikely(rc)) {
>> +               dev_err(mb_chan->dev, "failed to register mailbox interrupt %d\n",
>> +                       mb_chan->irq);
>> +               return rc;
>> +       }
>> +
>> +       /* Enable HW interrupt */
>> +       writel(MBOX_STATUS_ACK_MASK | MBOX_STATUS_AVAIL_MASK,
>> +              mb_chan->reg + REG_DB_STAT);
>> +       /* Unmask doorbell status interrupt */
>> +       val = readl(mb_chan->reg + REG_DB_STATMASK);
>> +       val &= ~(MBOX_STATUS_ACK_MASK | MBOX_STATUS_AVAIL_MASK);
>> +       writel(val, mb_chan->reg + REG_DB_STATMASK);
>> +
>> +       return 0;
>> +}
>> +
>> +static void slimpro_mbox_shutdown(struct mbox_chan *chan)
>> +{
>> +       struct slimpro_mbox_chan *mb_chan = chan->con_priv;
>> +       u32 val;
>> +
>> +       /* Mask doorbell status interrupt */
>> +       val = readl(mb_chan->reg + REG_DB_STATMASK);
>> +       val |= (MBOX_STATUS_ACK_MASK | MBOX_STATUS_AVAIL_MASK);
>> +       writel(val, mb_chan->reg + REG_DB_STATMASK);
>> +
>> +       devm_free_irq(mb_chan->dev, mb_chan->irq, mb_chan);
>> +}
>> +
>> +static struct mbox_chan_ops slimpro_mbox_ops = {
>> +       .send_data = slimpro_mbox_send_data,
>> +       .startup = slimpro_mbox_startup,
>> +       .shutdown = slimpro_mbox_shutdown,
>> +};
>> +
>> +static int slimpro_mbox_probe(struct platform_device *pdev)
>> +{
>> +       struct slimpro_mbox *ctx;
>> +       struct resource *regs;
>> +       void __iomem *mb_base;
>> +       int rc;
>> +       int i;
>> +
>> +       ctx = devm_kzalloc(&pdev->dev, sizeof(struct slimpro_mbox), GFP_KERNEL);
>> +       if (IS_ERR(ctx))
>> +               return PTR_ERR(ctx);
>> +
>> +       platform_set_drvdata(pdev, ctx);
>> +
>> +       regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +       mb_base = devm_ioremap(&pdev->dev, regs->start, resource_size(regs));
>> +       if (IS_ERR(mb_base))
>> +               return PTR_ERR(mb_base);
>> +
>> +       /* Setup mailbox links */
>> +       for (i = 0; i < MBOX_CNT; i++) {
>> +               ctx->mc[i].irq = platform_get_irq(pdev, i);
>> +               if (ctx->mc[i].irq < 0) {
>> +                       if (i == 0) {
>> +                               dev_err(&pdev->dev, "no available IRQ\n");
>> +                               return -EINVAL;
>> +                       }
>> +                       dev_info(&pdev->dev, "no IRQ for channel %d\n", i);
>> +                       break;
>> +               }
>> +
>> +               ctx->mc[i].dev = &pdev->dev;
>> +               ctx->mc[i].reg = mb_base + i * MBOX_REG_SET_OFFSET;
>> +               ctx->mc[i].chan = &ctx->chans[i];
>> +               ctx->chans[i].con_priv = &ctx->mc[i];
>> +       }
>> +
>> +       /* Setup mailbox controller */
>> +       ctx->mb_ctrl.dev = &pdev->dev;
>> +       ctx->mb_ctrl.chans = ctx->chans;
>> +       ctx->mb_ctrl.txdone_irq = true;
>> +       ctx->mb_ctrl.ops = &slimpro_mbox_ops;
>> +       ctx->mb_ctrl.num_chans = i;
>> +
>> +       rc = mbox_controller_register(&ctx->mb_ctrl);
>> +       if (rc) {
>> +               dev_err(&pdev->dev,
>> +                       "APM X-Gene SLIMpro MailBox register failed:%d\n", rc);
>> +               return rc;
>> +       }
>> +
>> +       dev_info(&pdev->dev, "APM X-Gene SLIMpro MailBox registered\n");
>> +       return 0;
>> +}
>> +
>> +static int slimpro_mbox_remove(struct platform_device *pdev)
>> +{
>> +       struct slimpro_mbox *smb = platform_get_drvdata(pdev);
>> +
>> +       mbox_controller_unregister(&smb->mb_ctrl);
>> +       return 0;
>> +}
>> +
>> +static const struct of_device_id slimpro_of_match[] = {
>> +       {.compatible = "apm,xgene-slimpro-mbox" },
>> +       { },
>> +};
>> +MODULE_DEVICE_TABLE(of, slimpro_of_match);
>> +
>> +#ifdef CONFIG_ACPI
>> +static const struct acpi_device_id slimpro_acpi_ids[] = {
>> +       {"APMC0D01", 0},
>> +       {}
>> +};
>> +MODULE_DEVICE_TABLE(acpi, slimpro_acpi_ids);
>> +#endif
>> +
>> +static struct platform_driver slimpro_mbox_driver = {
>> +       .probe  = slimpro_mbox_probe,
>> +       .remove = slimpro_mbox_remove,
>> +       .driver = {
>> +               .name = "xgene-slimpro-mbox",
>> +               .of_match_table = of_match_ptr(slimpro_of_match),
>> +               .acpi_match_table = ACPI_PTR(slimpro_acpi_ids)
>> +       },
>> +};
>> +
>> +static int __init slimpro_mbox_init(void)
>> +{
>> +       return platform_driver_register(&slimpro_mbox_driver);
>> +}
>> +
>> +static void __exit slimpro_mbox_exit(void)
>> +{
>> +       platform_driver_unregister(&slimpro_mbox_driver);
>> +}
>> +
>> +subsys_initcall(slimpro_mbox_init);
>> +module_exit(slimpro_mbox_exit);
>> +
>> +MODULE_DESCRIPTION("APM X-Gene SLIMpro Mailbox Driver");
>> +MODULE_LICENSE("GPL");
>> --
>> 1.9.1
>>
