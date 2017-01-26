From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Thu, 26 Jan 2017 10:08:21 +0530
Subject: [PATCH v20 2/4] mailbox: mediatek: Add Mediatek CMDQ driver
In-Reply-To: <1483499169-16329-3-git-send-email-hs.liao@mediatek.com>
References: <1483499169-16329-1-git-send-email-hs.liao@mediatek.com>
 <1483499169-16329-3-git-send-email-hs.liao@mediatek.com>
Message-ID: <CABb+yY23TUB8NpmpiO=cCmVFAVJMqKPfGgX14j+_Yj7tJvMOuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 4, 2017 at 8:36 AM, HS Liao <hs.liao@mediatek.com> wrote:

> diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
> new file mode 100644
> index 0000000..747bcd3
> --- /dev/null
> +++ b/drivers/mailbox/mtk-cmdq-mailbox.c

...

> +static void cmdq_task_exec(struct cmdq_pkt *pkt, struct cmdq_thread *thread)
> +{
> +       struct cmdq *cmdq;
> +       struct cmdq_task *task;
> +       unsigned long curr_pa, end_pa;
> +
> +       cmdq = dev_get_drvdata(thread->chan->mbox->dev);
> +
> +       /* Client should not flush new tasks if suspended. */
> +       WARN_ON(cmdq->suspended);
> +
> +       task = kzalloc(sizeof(*task), GFP_ATOMIC);
> +       task->cmdq = cmdq;
> +       INIT_LIST_HEAD(&task->list_entry);
> +       task->pa_base = dma_map_single(cmdq->mbox.dev, pkt->va_base,
> +                                      pkt->cmd_buf_size, DMA_TO_DEVICE);
>
You seem to parse the requests and responses, that should ideally be
done in client driver.
Also, we are here in atomic context, can you move it in client driver
(before the spin_lock)?
Maybe by adding a new 'pa_base' member as well in 'cmdq_pkt'.

....
> +
> +       cmdq->mbox.num_chans = CMDQ_THR_MAX_COUNT;
> +       cmdq->mbox.ops = &cmdq_mbox_chan_ops;
> +       cmdq->mbox.of_xlate = cmdq_xlate;
> +
> +       /* make use of TXDONE_BY_ACK */
> +       cmdq->mbox.txdone_irq = false;
> +       cmdq->mbox.txdone_poll = false;
> +
> +       for (i = 0; i < ARRAY_SIZE(cmdq->thread); i++) {
>
You mean  i < CMDQ_THR_MAX_COUNT

> +               cmdq->thread[i].base = cmdq->base + CMDQ_THR_BASE +
> +                               CMDQ_THR_SIZE * i;
> +               INIT_LIST_HEAD(&cmdq->thread[i].task_busy_list);
>
You seem the queue mailbox requests in this controller driver? why not
use the mailbox api for that?

> +               init_timer(&cmdq->thread[i].timeout);
> +               cmdq->thread[i].timeout.function = cmdq_thread_handle_timeout;
> +               cmdq->thread[i].timeout.data = (unsigned long)&cmdq->thread[i];
>
Here again... you seem to ignore the polling mechanism provided by the
mailbox api, and implement your own.


> diff --git a/include/linux/mailbox/mtk-cmdq-mailbox.h b/include/linux/mailbox/mtk-cmdq-mailbox.h
> new file mode 100644
> index 0000000..3433c64
> --- /dev/null
> +++ b/include/linux/mailbox/mtk-cmdq-mailbox.h
....
> +
> +struct cmdq_pkt {
> +       void                    *va_base;
>
maybe add 'pa_base' here so you don't have to do dma_map_single() in send_data

> +       size_t                  cmd_buf_size; /* command occupied size */
> +       size_t                  buf_size; /* real buffer size */
> +       struct cmdq_task_cb     cb;
> +};
> +
> +#endif /* __MTK_CMDQ_MAILBOX_H__ */
> --
> 1.9.1
>
