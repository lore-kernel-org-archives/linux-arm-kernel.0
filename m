From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Tue, 8 Mar 2016 01:31:35 +0700
Subject: [PATCH V2 2/2] mailbox: Introduce TI message manager driver
In-Reply-To: <56D987FF.1040607@ti.com>
References: <1456525452-30638-1-git-send-email-nm@ti.com>
 <1456525452-30638-3-git-send-email-nm@ti.com>
 <CABb+yY1hK4T6KAQcqNKF3D_pkLCcDVN=+T18ueV35jXbpLR+kg@mail.gmail.com>
 <56D987FF.1040607@ti.com>
Message-ID: <CABb+yY1a-6V=9C+di7ZdQHDQG_M_jbYshoLqxaLiCZTqM4TfHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 4, 2016 at 8:05 PM, Nishanth Menon <nm@ti.com> wrote:
> Hi Jassi,
>
> Thanks for reviewing the patch.
> On 03/03/2016 11:18 PM, Jassi Brar wrote:
>
> [...]
>
>>>
>>>  drivers/mailbox/Kconfig     |  11 +
>>>  drivers/mailbox/Makefile    |   2 +
>>>  drivers/mailbox/ti-msgmgr.c | 657
>
>> Do you want to call it something more specific than 'msgmgr from TI'?
>> Maybe its about Keystone, like mailbox-keystone.c ?
>
> Here is the rationale for choosing the name:
> There are more than 1 IPC in TI SoCs and even within Keystone SoC.
> Further, it is indeed called message manager hardware block and used
> across multiple SoC families (even though it is originated by keystone
> architecture). we do have a reuse of the omap-mailbox in a future
> keystone device (in addition to message manager), so using ti-mailbox is
> more appropriate for omap-mailbox, but anyways.. further renaming this
> as keystone-mailbox will confuse poor users when the new SoC comes in..
>
> We do have a lot of cross pollination of hardware blocks across TI
> architectures, and "keystone-" prefix does not really fit the usage.
> hence the usage of vendor-hardwareblock name.
>
OK, I leave that to you to call it whatever you think is right.

>>
>>> +#include <linux/module.h>
>>> +#include <linux/of_device.h>
>>> +#include <linux/of.h>
>>> +#include <linux/of_irq.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/ti-msgmgr.h>
>>>
>> This seems a bit bold. I think  include/linux/soc/ti/ is the right place.
>
> Sure, I can. Since I followed c, Would you
> suggest all files such as include/linux/omap* be moved to
> include/linux/soc/ti/ ? I guess that is not pertinent to this specific
> patch, but I am curious..
>
include/linux/omap-mailbox.h predates mailbox api.
But yes, I do think include/linux is not the right place for platform
specific headers. include/linux/soc/ is.

>
>>> +       /* Do I actually have messages to read? */
>>> +       msg_count = ti_msgmgr_queue_get_num_messages(qinst);
>>> +       if (!msg_count) {
>>> +               /* Shared IRQ? */
>>> +               dev_dbg(dev, "Spurious event - 0 pending data!\n");
>>> +               return IRQ_NONE;
>>> +       }
>>> +
>>> +       /*
>>> +        * I have no idea about the protocol being used to communicate with the
>>> +        * remote producer - 0 could be valid data, so I wont make a judgement
>>> +        * of how many bytes I should be reading. Let the client figure this
>>> +        * out.. I just read the full message and pass it on..
>>> +        */
>> Exactly. And similarly when you send data, you should not have more
>> than one message in transit. Now please see my note in
>> ti_msgmgr_send_data()
>>
>>
>>> +static int ti_msgmgr_send_data(struct mbox_chan *chan, void *data)
>>> +{
>>> +       struct device *dev = chan->mbox->dev;
>>> +       struct ti_msgmgr_inst *inst = dev_get_drvdata(dev);
>>> +       const struct ti_msgmgr_desc *desc;
>>> +       struct ti_queue_inst *qinst = chan->con_priv;
>>> +       int msg_count, num_words, trail_bytes;
>>> +       struct ti_msgmgr_message *message = data;
>>> +       void __iomem *data_reg;
>>> +       u32 *word_data;
>>> +
>>> +       if (WARN_ON(!inst)) {
>>> +               dev_err(dev, "no platform drv data??\n");
>>> +               return -EINVAL;
>>> +       }
>>> +       desc = inst->desc;
>>> +
>>> +       if (desc->max_message_size < message->len) {
>>> +               dev_err(dev, "Queue %s message length %d > max %d\n",
>>> +                       qinst->name, message->len, desc->max_message_size);
>>> +               return -EINVAL;
>>> +       }
>>> +
>>> +       /* Are we able to send this or not? */
>>> +       msg_count = ti_msgmgr_queue_get_num_messages(qinst);
>>> +       if (msg_count >= desc->max_messages) {
>>> +               dev_warn(dev, "Queue %s is full (%d messages)\n", qinst->name,
>>> +                        msg_count);
>>> +               return -EBUSY;
>>> +       }
>> This seems fishy. mailbox api always submit 1 'complete' message to be
>> sent and checks for completion by last_tx_done() before calling
>> send_data() again. Controller drivers are not supposed to queue
>> messages - mailbox core does. So you should never be unable to send a
>> message.
>
>
> OK-> to explain this, few reasons: (queue messages check and usage of
> last_tx_done are kind of intertwined answer..
> a) we need to remember that the message manager has a shared RAM.
> multiple transmitter over other queues can be sharing the same.
> unfortunately, we dont get a threshold kind of interrupt or status that
> I am able to exploit in the current incarnation of the solution. The
> best we can do in the full system is to constrain the number of messages
> that are max pending simultaneously in each of the queue from various
> transmitters in the SoC.
> b) last_tx_done() is checked if TXDONE_BY_POLL, not if TXDONE_BY_ACK
> right? which is how this'd work since txdone_poll is false -> that is
> how we want this mechanism to work once the far end is ready for next
> message, it acks. I do see your point about being tied to protocol - I
> dont like it either.. in fact, I'd prefer that client registration
> mention what kind of handshaking is necessary, but: a) that is not how
> mailbox framework is constructed at the moment(we state txdone_poll at
> mailbox registration, not at client usage) and b) I have no real need
> for multiple clients to users of message manager who actually need
> non-ACK usage - even for the foreseeable future (at least 1 next
> generation of SoC) - if such a need does arise in the future, I will
> have to rework framework and make this capability at the registration
> time of the client - allowing each client path to use different
> mechanisms on hardware such as these that need it.
> c) message manager can actually queue more than one message(depending on
> client capability). Even though, at this point, we are not really
> capable of doing it(again from what I can see for immediate future),
> mailbox framework by checking last_tx_done forces a single message
> sequencing - which is not really exploiting the capability of the
> hardware - in theory, we should be able to queue max num messages, hit
> cpuidle and snooze away while the remote entity chomp away data at it's
> own pace and finally give us a notification back - but again, we can
> argue it is indeed protocol dependent, so setting txdone_poll to false
> actually enables that to be done in user. Again - i have no immediate
> need for any queued multiple transfer needs yet.. even if i need to, in
> the future, it can easily be done by the client by maintaining code as
> is - txdone_poll is false.
>
All I suggest is that the controller does not queue more than 1
message at a time, which means the controller driver allows for
maximum possible resources taken by a message.
The buffering is already done by the core, and if for your 'batch
dispatch' thing the client could simply flush them to remote by
pretending it got the ack (which is no worse than simply sending all
messages to remote without caring if the first was successful or not).


>>
>>> +       /*
>>> +        * NOTE about register access involved here:
>>> +        * the hardware block is implemented with 32bit access operations and no
>>> +        * support for data splitting.  We don't want the hardware to misbehave
>>> +        * with sub 32bit access - For example: if the last register write is
>>> +        * split into byte wise access, it can result in the queue getting
>>> +        * stuck or dummy messages being transmitted or indeterminate behavior.
>>> +        * The same can occur if out of order operations take place.
>>> +        * Hence, we do not use memcpy_toio or ___iowrite32_copy here, instead
>>> +        * we use writel which ensures the sequencing we need.
>>> +        */
>> .... deja-vu ?
>
> Tell me about it.. but then, surprises like these do pop in once in a
> while.. sigh..
>
I meant you have same para for read() , so maybe omit this one.

>>> +
>>> +/* Keystone K2G SoC integration details */
>>> +static const struct ti_msgmgr_valid_queue_desc k2g_valid_queues[] = {
>>> +       {.queue_id = 0, .proxy_id = 0, .is_tx = true,},
>>> +       {.queue_id = 1, .proxy_id = 0, .is_tx = true,},
>>> +       {.queue_id = 2, .proxy_id = 0, .is_tx = true,},
>>> +       {.queue_id = 3, .proxy_id = 0, .is_tx = true,},
>>> +       {.queue_id = 5, .proxy_id = 2, .is_tx = false,},
>>> +       {.queue_id = 56, .proxy_id = 1, .is_tx = true,},
>>> +       {.queue_id = 57, .proxy_id = 2, .is_tx = false,},
>>> +       {.queue_id = 58, .proxy_id = 3, .is_tx = true,},
>>> +       {.queue_id = 59, .proxy_id = 4, .is_tx = true,},
>>> +       {.queue_id = 60, .proxy_id = 5, .is_tx = true,},
>>> +       {.queue_id = 61, .proxy_id = 6, .is_tx = true,},
>>> +};
>>> +
>>> +static const struct ti_msgmgr_desc k2g_desc = {
>>> +       .queue_count = 64,
>>> +       .max_message_size = 64,
>>> +       .max_messages = 128,
>>> +       .q_slices = 1,
>>> +       .q_proxies = 1,
>>> +       .data_first_reg = 16,
>>> +       .data_last_reg = 31,
>>> +       .tx_polled = false,
>>> +       .valid_queues = k2g_valid_queues,
>>> +       .num_valid_queues = ARRAY_SIZE(k2g_valid_queues),
>>> +};
>> If these parameters are very configurable, maybe they should be in DT?
>
> These are SoC integration specific data. based on DT, we will only have
> SoC specific compatible property in DT. Since  the data is tied to SoC
> integration, there is no benefit of keeping these in DT.
>
Well, yes if the numbers don't change with very often.

Thanks.
