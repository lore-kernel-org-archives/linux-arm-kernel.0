From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Wed, 1 Feb 2017 10:52:12 +0530
Subject: [PATCH v20 2/4] mailbox: mediatek: Add Mediatek CMDQ driver
In-Reply-To: <1485419833.990.1.camel@mtksdaap41>
References: <1483499169-16329-1-git-send-email-hs.liao@mediatek.com>
 <1483499169-16329-3-git-send-email-hs.liao@mediatek.com>
 <CABb+yY23TUB8NpmpiO=cCmVFAVJMqKPfGgX14j+_Yj7tJvMOuQ@mail.gmail.com>
 <1485419833.990.1.camel@mtksdaap41>
Message-ID: <CABb+yY13VaFpYz6EExvAXLpAqEWDJ4R50WG0DYbXO6iCESbA5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 26, 2017 at 2:07 PM, Horng-Shyang Liao <hs.liao@mediatek.com> wrote:
> Hi Jassi,
>
> On Thu, 2017-01-26 at 10:08 +0530, Jassi Brar wrote:
>> On Wed, Jan 4, 2017 at 8:36 AM, HS Liao <hs.liao@mediatek.com> wrote:
>>
>> > diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
>> > new file mode 100644
>> > index 0000000..747bcd3
>> > --- /dev/null
>> > +++ b/drivers/mailbox/mtk-cmdq-mailbox.c
>>
>> ...
>>
>> > +static void cmdq_task_exec(struct cmdq_pkt *pkt, struct cmdq_thread *thread)
>> > +{
>> > +       struct cmdq *cmdq;
>> > +       struct cmdq_task *task;
>> > +       unsigned long curr_pa, end_pa;
>> > +
>> > +       cmdq = dev_get_drvdata(thread->chan->mbox->dev);
>> > +
>> > +       /* Client should not flush new tasks if suspended. */
>> > +       WARN_ON(cmdq->suspended);
>> > +
>> > +       task = kzalloc(sizeof(*task), GFP_ATOMIC);
>> > +       task->cmdq = cmdq;
>> > +       INIT_LIST_HEAD(&task->list_entry);
>> > +       task->pa_base = dma_map_single(cmdq->mbox.dev, pkt->va_base,
>> > +                                      pkt->cmd_buf_size, DMA_TO_DEVICE);
>> >
>> You seem to parse the requests and responses, that should ideally be
>> done in client driver.
>> Also, we are here in atomic context, can you move it in client driver
>> (before the spin_lock)?
>> Maybe by adding a new 'pa_base' member as well in 'cmdq_pkt'.
>
> will do
>
>> ....
>> > +
>> > +       cmdq->mbox.num_chans = CMDQ_THR_MAX_COUNT;
>> > +       cmdq->mbox.ops = &cmdq_mbox_chan_ops;
>> > +       cmdq->mbox.of_xlate = cmdq_xlate;
>> > +
>> > +       /* make use of TXDONE_BY_ACK */
>> > +       cmdq->mbox.txdone_irq = false;
>> > +       cmdq->mbox.txdone_poll = false;
>> > +
>> > +       for (i = 0; i < ARRAY_SIZE(cmdq->thread); i++) {
>> >
>> You mean  i < CMDQ_THR_MAX_COUNT
>
> will do
>
>> > +               cmdq->thread[i].base = cmdq->base + CMDQ_THR_BASE +
>> > +                               CMDQ_THR_SIZE * i;
>> > +               INIT_LIST_HEAD(&cmdq->thread[i].task_busy_list);
>> >
>> You seem the queue mailbox requests in this controller driver? why not
>> use the mailbox api for that?
>>
>> > +               init_timer(&cmdq->thread[i].timeout);
>> > +               cmdq->thread[i].timeout.function = cmdq_thread_handle_timeout;
>> > +               cmdq->thread[i].timeout.data = (unsigned long)&cmdq->thread[i];
>> >
>> Here again... you seem to ignore the polling mechanism provided by the
>> mailbox api, and implement your own.
>
> The queue is used to record the tasks which are flushed into CMDQ
> hardware (GCE). We are handling time critical tasks, so we have to
> queue them in GCE rather than a software queue (e.g. mailbox buffer).
> Let me use display as an example. Many display tasks are flushed into
> CMDQ to wait next vsync event. When vsync event is triggered by display
> hardware, GCE needs to process all flushed tasks "within vblank" to
> prevent garbage on screen. This is all done by GCE (without CPU)
> to fulfill time critical requirement. After GCE finish its work,
> it will generate interrupts, and then CMDQ driver will let clients know
> which tasks are done.
>
Does the GCE provide any 'lock' to prevent modifying (by adding tasks
to) the GCE h/w buffer when it is processing it at vsync?  Otherwise
there maybe race/error. If there is such a 'lock' flag/irq, that could
help here. However, you are supposed to know your h/w better, so I
will accept this implementation assuming it can't be done any better.

Please address other comments and resubmit.

Thanks
