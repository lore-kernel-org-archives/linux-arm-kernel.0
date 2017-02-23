From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Thu, 23 Feb 2017 09:40:43 +0530
Subject: [PATCH v20 2/4] mailbox: mediatek: Add Mediatek CMDQ driver
In-Reply-To: <1487733150.15869.11.camel@mtksdaap41>
References: <1483499169-16329-1-git-send-email-hs.liao@mediatek.com>
 <1483499169-16329-3-git-send-email-hs.liao@mediatek.com>
 <CABb+yY23TUB8NpmpiO=cCmVFAVJMqKPfGgX14j+_Yj7tJvMOuQ@mail.gmail.com>
 <1485419833.990.1.camel@mtksdaap41>
 <CABb+yY13VaFpYz6EExvAXLpAqEWDJ4R50WG0DYbXO6iCESbA5A@mail.gmail.com>
 <1486359476.11424.33.camel@mtksdaap41>
 <CABb+yY0jCGqnrMLkkTNoEmLX4jDstWh7-UYhDyKjV-gFOnxpsg@mail.gmail.com>
 <1487733150.15869.11.camel@mtksdaap41>
Message-ID: <CABb+yY2dzcR4fYvrSQK5jemwUSkYVJ8aWEmiE6wstw-Yyqy7bw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 22, 2017 at 8:42 AM, Horng-Shyang Liao <hs.liao@mediatek.com> wrote:
> On Thu, 2017-02-16 at 21:02 +0530, Jassi Brar wrote:
>> On Mon, Feb 6, 2017 at 11:07 AM, Horng-Shyang Liao <hs.liao@mediatek.com> wrote:
>> > Hi Jassi,
>> >
>> > On Wed, 2017-02-01 at 10:52 +0530, Jassi Brar wrote:
>> >> On Thu, Jan 26, 2017 at 2:07 PM, Horng-Shyang Liao <hs.liao@mediatek.com> wrote:
>> >> > Hi Jassi,
>> >> >
>> >> > On Thu, 2017-01-26 at 10:08 +0530, Jassi Brar wrote:
>> >> >> On Wed, Jan 4, 2017 at 8:36 AM, HS Liao <hs.liao@mediatek.com> wrote:
>> >> >>
>> >> >> > diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
>> >> >> > new file mode 100644
>> >> >> > index 0000000..747bcd3
>> >> >> > --- /dev/null
>> >> >> > +++ b/drivers/mailbox/mtk-cmdq-mailbox.c
>> >> >>
>> >> >> ...
>> >> >>
>> >> >> > +static void cmdq_task_exec(struct cmdq_pkt *pkt, struct cmdq_thread *thread)
>> >> >> > +{
>> >> >> > +       struct cmdq *cmdq;
>> >> >> > +       struct cmdq_task *task;
>> >> >> > +       unsigned long curr_pa, end_pa;
>> >> >> > +
>> >> >> > +       cmdq = dev_get_drvdata(thread->chan->mbox->dev);
>> >> >> > +
>> >> >> > +       /* Client should not flush new tasks if suspended. */
>> >> >> > +       WARN_ON(cmdq->suspended);
>> >> >> > +
>> >> >> > +       task = kzalloc(sizeof(*task), GFP_ATOMIC);
>> >> >> > +       task->cmdq = cmdq;
>> >> >> > +       INIT_LIST_HEAD(&task->list_entry);
>> >> >> > +       task->pa_base = dma_map_single(cmdq->mbox.dev, pkt->va_base,
>> >> >> > +                                      pkt->cmd_buf_size, DMA_TO_DEVICE);
>> >> >> >
>> >> >> You seem to parse the requests and responses, that should ideally be
>> >> >> done in client driver.
>> >> >> Also, we are here in atomic context, can you move it in client driver
>> >> >> (before the spin_lock)?
>> >> >> Maybe by adding a new 'pa_base' member as well in 'cmdq_pkt'.
>> >> >
>> >> > will do
>> >
>> > I agree with moving dma_map_single out from spin_lock.
>> >
>> > However, mailbox clients cannot map virtual memory to mailbox
>> > controller's device for DMA.
>> >
>> If DMA is a resource used by MBox to transfer data, then yes the
>> mapping needs to be done in the Mbox controller driver. To map memory
>> outside of spinlock, you could schedule a tasklet in send_data() ?
>
> Hi Jassi,
>
> For CMDQ, the order of CMDQ tasks should be guaranteed.
> However, it seems tasklet cannot ensure this requirement.
>
> Quote from Linux Device Drivers 3rd edition ch7.
> "void tasklet_schedule(struct tasklet_struct *t);
>   Schedule the tasklet for execution. If a tasklet is scheduled again
> before it has a chance to run, it runs only once...."
>
Not sure what bothers you.
If you only add requests to a list, protected by some spinlock, during
send_datam you could always iterate over (submit) requests in the
order you queued them.
