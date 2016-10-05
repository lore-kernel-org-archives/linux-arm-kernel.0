From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Wed, 5 Oct 2016 09:07:54 +0530
Subject: [PATCH v14 2/4] CMDQ: Mediatek CMDQ driver
In-Reply-To: <1475636064.21937.25.camel@mtksdaap41>
References: <1473039885-24009-1-git-send-email-hs.liao@mediatek.com>
 <1473039885-24009-3-git-send-email-hs.liao@mediatek.com>
 <1475204778.13398.28.camel@mtksdaap41>
 <1475225778.25044.35.camel@mtksdaap41> <1475226691.13398.35.camel@mtksdaap41>
 <1475228829.3658.1.camel@mtksdaap41> <1475636064.21937.25.camel@mtksdaap41>
Message-ID: <CAJe_ZhcXw1-MOEiiix5VTtKEVr9Z23s_OyikboDYCd0RQwS5pg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 October 2016 at 08:24, Horng-Shyang Liao <hs.liao@mediatek.com> wrote:
> On Fri, 2016-09-30 at 17:47 +0800, Horng-Shyang Liao wrote:
>> On Fri, 2016-09-30 at 17:11 +0800, CK Hu wrote:

>
> After I trace mailbox driver, I realize that CMDQ driver cannot use
> tx_done.
>
> CMDQ clients will flush many tasks into CMDQ driver, and then CMDQ
> driver will apply these tasks into GCE HW "immediately". These tasks,
> which are queued in GCE HW, may not execute immediately since they
> may need to wait event(s), e.g. vsync.
>
> However, in mailbox driver, mailbox uses a software buffer to queue
> sent messages. It only sends next message until previous message is
> done. This cannot fulfill CMDQ's requirement.
>
I understand
 a) GCE HW can internally queue many tasks in some 'FIFO'
 b) Execution of some task may have to wait until some external event
occurs (like vsync)
 c) GCE does not generate irq/flag for each task executed (?)

If so, may be your tx_done should return 'true' so long as the GCE HW
can accept tasks in its 'FIFO'. For mailbox api, any task that is
queued on GCE, is assumed to be transmitted.

> Quote some code from mailbox driver. Please notice "active_req" part.
>
> static void msg_submit(struct mbox_chan *chan)
> {
>         ...
>         if (!chan->msg_count || chan->active_req)
>                 goto exit;
>         ...
>         err = chan->mbox->ops->send_data(chan, data);
>         if (!err) {
>                 chan->active_req = data;
>                 chan->msg_count--;
>         }
>         ...
> }
>
> static void tx_tick(struct mbox_chan *chan, int r)
> {
>         ...
>         spin_lock_irqsave(&chan->lock, flags);
>         mssg = chan->active_req;
>         chan->active_req = NULL;
>         spin_unlock_irqrestore(&chan->lock, flags);
>         ...
> }
>
> Current workable CMDQ driver uses mbox_client_txdone() to prevent
> this issue, and then uses self callback functions to handle done tasks.
>
> int cmdq_task_flush_async(struct cmdq_client *client, struct cmdq_task
> *task, cmdq_async_flush_cb cb, void *data)
> {
>         ...
>         mbox_send_message(client->chan, task);
>         /* We can send next task immediately, so just call txdone. */
>         mbox_client_txdone(client->chan, 0);
>         ...
> }
>
> Another solution is to use rx_callback; i.e. CMDQ mailbox controller
> call mbox_chan_received_data() when CMDQ task is done. But, this may
> violate the design of mailbox. What do you think?
>
If my point (c) above does not hold, maybe look at implementing
tx_done() callback and submit next task from the callback of last
done.
