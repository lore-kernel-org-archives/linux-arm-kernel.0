From: hari.kanigeri@gmail.com (Hari Kanigeri)
Date: Thu, 21 Oct 2010 15:49:10 -0500
Subject: [PATCH 4/7] omap:mailbox-send message in process context
In-Reply-To: <D2943F03B81C9C458E44DFB213905E02010355C35E@dlee04.ent.ti.com>
References: <1287108808-32119-1-git-send-email-h-kanigeri2@ti.com>
	<1287108808-32119-5-git-send-email-h-kanigeri2@ti.com>
	<D2943F03B81C9C458E44DFB213905E02010355C35E@dlee04.ent.ti.com>
Message-ID: <AANLkTi=6fPONRaFmqrWkq8mxZacMCM+9xN9HM9FZJdja@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rene,

Thanks for your comment.


>> @@ -92,20 +92,25 @@ int omap_mbox_msg_send(struct omap_mbox *mbox,
>> ? ? ? mbox_msg_t msg) struct omap_mbox_queue *mq = mbox->txq;
>> ? ? ? int ret = 0, len;
>>
>> - ? ? spin_lock(&mq->lock);
>> + ? ? spin_lock_bh(&mq->lock);
>>
>
> Please check if this scenario looks valid to you, as discussed and depicted
> with Fernando:
>
> Supposing that at this point the hw fifo is full and there are messages in
> the kfifo.
>
>> ? ? ? if (kfifo_avail(&mq->fifo) < sizeof(msg)) {
>> ? ? ? ? ? ? ? ret = -ENOMEM;
>> ? ? ? ? ? ? ? goto out;
>> ? ? ? }
>>
>
> We reach this point.
>
> In this scenario, the DSP or other Core reads a message from the mbox hw fifo.
> The next happens:
> 1.- The not full interrupt is triggered to the MPU.
> 2.- The mbox's ISR schedules the tasklet to write the message.
> 3.- The ISR is left and returns to here (since we still have the bh lock the
> ? ?tasklet won't run).
>
>> + ? ? if (!__mbox_poll_for_space(mbox)) {\
>
> 4.- We check for mbox_fifo_full and we have space. so the message is written.
>
>> + ? ? ? ? ? ? mbox_fifo_write(mbox, msg);
>
> At this point it looks that the FIFO order is lost. We write this message
> before the ones in the kfifo.
>

Good point. I agree.

> A solution for this could be checking if there are messages in the kfifo
> before trying to write directly to the hw fifo, if so, just continue
> scheduling the tasklet.

A change something like this ?

-       if (!__mbox_poll_for_space(mbox)) {
+       if (kfifo_is_empty() && !__mbox_poll_for_space(mbox)) {
                mbox_fifo_write(mbox, msg);

Thank you,
Best regards,
Hari
