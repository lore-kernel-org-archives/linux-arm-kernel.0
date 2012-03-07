From: jp.francois@cynove.com (jean-philippe francois)
Date: Wed, 7 Mar 2012 17:16:35 +0100
Subject: soft lockup on omap3 (dm3730)
Message-ID: <CAGGh5h3OQTniXbm8iUYGM+2oi+zzd1F6BxDKzN5epA89+i_7nQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I have a custom board using a dm3730 processor, on which I
am running a 3.2.0 kernel.

There is also a cmos sensor (aptina MT9J). When I use yavta
to capture video, it will always work on the first capture, but if
yavta is stopped, and then restarted, it will often get stuck in the
below function

spinlock, mutex and list manipulation debug options are on, but catch nothing.
The printk get printed, and the number of step in the loop is equal to
the number
of queued buffer.

According to the offset in the backtrace, the soft_lockup is either
in spin_unlock_irqrestore if spinlock debugging is activated, or
on the "msr CPSR_c"  instruction if spinlock debugging is not activated.

Is the backtrace pointing to this offset because soft_lockup can only
detect lockups at the output of critical sections ?

I don't know how to progress on this problem, any hint is welcome.

int omap3isp_video_queue_streamon(struct isp_video_queue *queue)
{
       struct isp_video_buffer *buf;
       unsigned long flags;

       mutex_lock(&queue->lock);

       if (queue->streaming)
               goto done;

       queue->streaming = 1;

       spin_lock_irqsave(&queue->irqlock, flags);
       list_for_each_entry(buf, &queue->queue, stream) {
               printk(KERN_INFO "inside list_for_each\n");
               queue->ops->buffer_queue(buf);
       }
       spin_unlock_irqrestore(&queue->irqlock, flags);  <---- soft lockup
says this is the culprit.

done:
       mutex_unlock(&queue->lock);
       return 0;
}
