From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Fri, 4 Mar 2016 10:48:22 +0530
Subject: [PATCH V2 2/2] mailbox: Introduce TI message manager driver
In-Reply-To: <1456525452-30638-3-git-send-email-nm@ti.com>
References: <1456525452-30638-1-git-send-email-nm@ti.com>
 <1456525452-30638-3-git-send-email-nm@ti.com>
Message-ID: <CABb+yY1hK4T6KAQcqNKF3D_pkLCcDVN=+T18ueV35jXbpLR+kg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 27, 2016 at 3:54 AM, Nishanth Menon <nm@ti.com> wrote:
> Support for TI Message Manager Module. This hardware block manages a
> bunch of hardware queues meant for communication between processor
> entities.
>
> Clients sitting on top of this would manage the required protocol
> for communicating with the counterpart entities.
>
> For more details on TI Message Manager hardware block, see documentation
> that will is available here: http://www.ti.com/lit/ug/spruhy8/spruhy8.pdf
> Chapter 8.1(Message Manager)
>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> V2: Changes since V1:
>         - Major refactoring of code for binding changes
>         - moved list of valid K2G queueus into driver
>         - split up probe into sub functions for easier maintenance
>
> V1: https://patchwork.kernel.org/patch/8237171/
>
>  drivers/mailbox/Kconfig     |  11 +
>  drivers/mailbox/Makefile    |   2 +
>  drivers/mailbox/ti-msgmgr.c | 657
Do you want to call it something more specific than 'msgmgr from TI'?
Maybe its about Keystone, like mailbox-keystone.c ?


> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/of.h>
> +#include <linux/of_irq.h>
> +#include <linux/platform_device.h>
> +#include <linux/ti-msgmgr.h>
>
This seems a bit bold. I think  include/linux/soc/ti/ is the right place.


> +       /* Do I actually have messages to read? */
> +       msg_count = ti_msgmgr_queue_get_num_messages(qinst);
> +       if (!msg_count) {
> +               /* Shared IRQ? */
> +               dev_dbg(dev, "Spurious event - 0 pending data!\n");
> +               return IRQ_NONE;
> +       }
> +
> +       /*
> +        * I have no idea about the protocol being used to communicate with the
> +        * remote producer - 0 could be valid data, so I wont make a judgement
> +        * of how many bytes I should be reading. Let the client figure this
> +        * out.. I just read the full message and pass it on..
> +        */
Exactly. And similarly when you send data, you should not have more
than one message in transit. Now please see my note in
ti_msgmgr_send_data()


> +static int ti_msgmgr_send_data(struct mbox_chan *chan, void *data)
> +{
> +       struct device *dev = chan->mbox->dev;
> +       struct ti_msgmgr_inst *inst = dev_get_drvdata(dev);
> +       const struct ti_msgmgr_desc *desc;
> +       struct ti_queue_inst *qinst = chan->con_priv;
> +       int msg_count, num_words, trail_bytes;
> +       struct ti_msgmgr_message *message = data;
> +       void __iomem *data_reg;
> +       u32 *word_data;
> +
> +       if (WARN_ON(!inst)) {
> +               dev_err(dev, "no platform drv data??\n");
> +               return -EINVAL;
> +       }
> +       desc = inst->desc;
> +
> +       if (desc->max_message_size < message->len) {
> +               dev_err(dev, "Queue %s message length %d > max %d\n",
> +                       qinst->name, message->len, desc->max_message_size);
> +               return -EINVAL;
> +       }
> +
> +       /* Are we able to send this or not? */
> +       msg_count = ti_msgmgr_queue_get_num_messages(qinst);
> +       if (msg_count >= desc->max_messages) {
> +               dev_warn(dev, "Queue %s is full (%d messages)\n", qinst->name,
> +                        msg_count);
> +               return -EBUSY;
> +       }
This seems fishy. mailbox api always submit 1 'complete' message to be
sent and checks for completion by last_tx_done() before calling
send_data() again. Controller drivers are not supposed to queue
messages - mailbox core does. So you should never be unable to send a
message.


> +       /*
> +        * NOTE about register access involved here:
> +        * the hardware block is implemented with 32bit access operations and no
> +        * support for data splitting.  We don't want the hardware to misbehave
> +        * with sub 32bit access - For example: if the last register write is
> +        * split into byte wise access, it can result in the queue getting
> +        * stuck or dummy messages being transmitted or indeterminate behavior.
> +        * The same can occur if out of order operations take place.
> +        * Hence, we do not use memcpy_toio or ___iowrite32_copy here, instead
> +        * we use writel which ensures the sequencing we need.
> +        */
.... deja-vu ?


> +
> +/* Keystone K2G SoC integration details */
> +static const struct ti_msgmgr_valid_queue_desc k2g_valid_queues[] = {
> +       {.queue_id = 0, .proxy_id = 0, .is_tx = true,},
> +       {.queue_id = 1, .proxy_id = 0, .is_tx = true,},
> +       {.queue_id = 2, .proxy_id = 0, .is_tx = true,},
> +       {.queue_id = 3, .proxy_id = 0, .is_tx = true,},
> +       {.queue_id = 5, .proxy_id = 2, .is_tx = false,},
> +       {.queue_id = 56, .proxy_id = 1, .is_tx = true,},
> +       {.queue_id = 57, .proxy_id = 2, .is_tx = false,},
> +       {.queue_id = 58, .proxy_id = 3, .is_tx = true,},
> +       {.queue_id = 59, .proxy_id = 4, .is_tx = true,},
> +       {.queue_id = 60, .proxy_id = 5, .is_tx = true,},
> +       {.queue_id = 61, .proxy_id = 6, .is_tx = true,},
> +};
> +
> +static const struct ti_msgmgr_desc k2g_desc = {
> +       .queue_count = 64,
> +       .max_message_size = 64,
> +       .max_messages = 128,
> +       .q_slices = 1,
> +       .q_proxies = 1,
> +       .data_first_reg = 16,
> +       .data_last_reg = 31,
> +       .tx_polled = false,
> +       .valid_queues = k2g_valid_queues,
> +       .num_valid_queues = ARRAY_SIZE(k2g_valid_queues),
> +};
If these parameters are very configurable, maybe they should be in DT?

Thanks.
