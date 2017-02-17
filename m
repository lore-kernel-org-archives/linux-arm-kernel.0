From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Fri, 17 Feb 2017 11:50:26 +0530
Subject: [PATCH v4 2/3] mailbox: Add iProc mailbox controller driver
In-Reply-To: <1485463082-27067-3-git-send-email-jonathan.richardson@broadcom.com>
References: <1485463082-27067-1-git-send-email-jonathan.richardson@broadcom.com>
 <1485463082-27067-3-git-send-email-jonathan.richardson@broadcom.com>
Message-ID: <CABb+yY0rmAFutskhVkQ926QfsvtJ-WnXrQc=+PQNg=7NZEXC+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 27, 2017 at 2:08 AM, Jonathan Richardson
<jonathan.richardson@broadcom.com> wrote:

> +static int iproc_mbox_send_data_m0(struct mbox_chan *chan, void *data)
> +{
> +       struct iproc_mbox *mbox = dev_get_drvdata(chan->mbox->dev);
> +       struct iproc_mbox_msg *msg = (struct iproc_mbox_msg *)data;
> +               unsigned long flags;
> +       int err = 0;
> +       const int poll_period_us = 5;
> +       const int max_retries = (MAX_M0_TIMEOUT_MS * 1000) / poll_period_us;
> +
> +       if (!msg)
> +               return -EINVAL;
> +
> +       spin_lock_irqsave(&mbox->lock, flags);
> +
> +       dev_dbg(mbox->dev, "Send msg to M0: cmd=0x%x, param=0x%x, wait_ack=%d\n",
> +               msg->cmd, msg->param, msg->wait_ack);
> +
prints should be outside the spinlocks.

> +       writel(msg->cmd, mbox->base + IPROC_CRMU_MAILBOX0_OFFSET);
> +       writel(msg->param, mbox->base + IPROC_CRMU_MAILBOX1_OFFSET);
> +
> +       if (msg->wait_ack) {
> +               int retries;
> +
move poll_period_us and max_retries in here or just define' them

> +               err = msg->reply_code = -ETIMEDOUT;
> +               for (retries = 0; retries < max_retries; retries++) {
> +                       u32 val = readl(
> +                               mbox->base + IPROC_CRMU_MAILBOX0_OFFSET);
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
>
potentially 2ms inside spin_lock_irqsave. Alternative is to implement
a simple 'peek_data' and call it for requests with 'wait_ack'
