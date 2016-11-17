From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Thu, 17 Nov 2016 09:10:25 +0530
Subject: [PATCH v1 2/4] mailbox: Add iProc mailbox controller driver
In-Reply-To: <1476817238-1226-3-git-send-email-jonathan.richardson@broadcom.com>
References: <1476817238-1226-1-git-send-email-jonathan.richardson@broadcom.com>
 <1476817238-1226-3-git-send-email-jonathan.richardson@broadcom.com>
Message-ID: <CABb+yY3ga7CgZaRi_5Qu4UXNjGdhuLHM0gZjrwusFSLfCuc5cQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jonathan,

On Wed, Oct 19, 2016 at 12:30 AM, Jonathan Richardson
<jonathan.richardson@broadcom.com> wrote:
> The Broadcom iProc mailbox controller handles all communication with a
> Cortex-M0 MCU processor that provides support for power, clock, and
> reset management.
>
> Tested-by: Jonathan Richardson <jonathan.richardson@broadcom.com>
> Reviewed-by: Jonathan Richardson <jonathan.richardson@broadcom.com>
> Reviewed-by: Vikram Prakash <vikram.prakash@broadcom.com>
> Reviewed-by: Shreesha Rajashekar <shreesha.rajashekar@broadcom.com>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> Signed-off-by: Jonathan Richardson <jonathan.richardson@broadcom.com>
> ---
>  drivers/mailbox/Kconfig             |  10 +
>  drivers/mailbox/Makefile            |   2 +
>  drivers/mailbox/bcm-iproc-mailbox.c | 422 ++++++++++++++++++++++++++++++++++++
>  include/linux/bcm_iproc_mailbox.h   |  32 +++
>
This should be include/linux/mailbox/bcm_iproc_mailbox.h


> +++ b/drivers/mailbox/bcm-iproc-mailbox.c
> @@ -0,0 +1,422 @@
> +/*
> + * Copyright (C) 2016 Broadcom.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation version 2.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/module.h>
> +#include <linux/irq.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/platform_device.h>
> +#include <linux/of_device.h>
> +#include <linux/of.h>
> +#include <linux/of_irq.h>
> +#include <linux/irqchip/chained_irq.h>
> +#include <linux/notifier.h>
> +#include <linux/reboot.h>
> +#include <linux/mailbox_controller.h>
> +#include <linux/mailbox_client.h>
>
Need of mailbox_controller.h & client.h is a bad sign.

> +
> +static int iproc_mbox_send_data_m0_imp(struct iproc_mbox *mbox,
> +       struct iproc_mbox_msg *msg, int max_retries, int poll_period_us)
> +{
> +       unsigned long flags;
> +       u32 val;
> +       int err = 0;
> +       int retries;
> +
> +       spin_lock_irqsave(&mbox->lock, flags);
> +
> +       dev_dbg(mbox->dev, "Send msg to M0: cmd=0x%x, param=0x%x, wait_ack=%d\n",
> +               msg->cmd, msg->param, msg->wait_ack);
> +
> +       writel(msg->cmd, mbox->base + IPROC_CRMU_MAILBOX0_OFFSET);
> +       writel(msg->param, mbox->base + IPROC_CRMU_MAILBOX1_OFFSET);
> +
> +       if (msg->wait_ack) {
> +               err = msg->reply_code = -ETIMEDOUT;
> +               for (retries = 0; retries < max_retries; retries++) {
> +                       val = readl(mbox->base + IPROC_CRMU_MAILBOX0_OFFSET);
> +                       if (val & M0_IPC_CMD_DONE_MASK) {
> +                               /*
> +                                * M0 replied - save reply code and
> +                                * clear error.
> +                                */
> +                               msg->reply_code = (val &
> +                                       M0_IPC_CMD_REPLY_MASK) >>
> +                                       M0_IPC_CMD_REPLY_SHIFT;
> +                               err = 0;
> +                               break;
> +                       }
> +                       udelay(poll_period_us);
> +               }
> +       }
> +
> +       spin_unlock_irqrestore(&mbox->lock, flags);
> +
> +       return err;
> +}
> +
OK, so this is the real message passing voodoo.

> +static void iproc_mbox_aon_gpio_forwarding_enable(struct iproc_mbox *mbox,
> +       bool en)
> +{
> +       struct iproc_mbox_msg msg;
> +       const int max_retries = 5;
> +       const int poll_period_us = 200;
> +
> +       msg.cmd = M0_IPC_M0_CMD_AON_GPIO_FORWARDING_ENABLE;
> +       msg.param = en ? 1 : 0;
> +       msg.wait_ack = true;
> +
> +       iproc_mbox_send_data_m0_imp(mbox, &msg, max_retries, poll_period_us);
> +}
> +
> +static void iproc_mbox_irq_unmask(struct irq_data *d)
> +{
> +       struct iproc_mbox *iproc_mbox = irq_data_get_irq_chip_data(d);
> +
> +       iproc_mbox_aon_gpio_forwarding_enable(iproc_mbox, true);
> +}
> +
> +static void iproc_mbox_irq_mask(struct irq_data *d)
> +{
> +       /* Do nothing - Mask callback is not required, since upon GPIO event,
> +        * M0 disables GPIO forwarding to A9. Hence, GPIO forwarding is already
> +        * disabled  when in mbox irq handler, and no other mbox events from M0
> +        * to A9 are expected until GPIO forwarding is enabled following
> +        * iproc_mbox_irq_unmask()
> +        */
> +}
> +
> +static struct irq_chip iproc_mbox_irq_chip = {
> +       .name = "bcm-iproc-mbox",
> +       .irq_mask = iproc_mbox_irq_mask,
> +       .irq_unmask = iproc_mbox_irq_unmask,
> +};
> +
.... these are simply using the mailbox controllers directly. So you
are actually clubbing a mailbox client (interrupt controller) with the
provider (mailbox) here.

I think you need move the IRQ controller part under drivers/irqchip/
that uses the mailbox api to manage its 'irq lines'.

Thanks.
