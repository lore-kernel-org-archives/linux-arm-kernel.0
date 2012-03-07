From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 7 Mar 2012 16:37:50 +0000
Subject: soft lockup on omap3 (dm3730)
In-Reply-To: <CAGGh5h3OQTniXbm8iUYGM+2oi+zzd1F6BxDKzN5epA89+i_7nQ@mail.gmail.com>
References: <CAGGh5h3OQTniXbm8iUYGM+2oi+zzd1F6BxDKzN5epA89+i_7nQ@mail.gmail.com>
Message-ID: <20120307163750.GC18787@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 07, 2012 at 05:16:35PM +0100, jean-philippe francois wrote:
> Is the backtrace pointing to this offset because soft_lockup can only
> detect lockups at the output of critical sections ?

Correct - soft lockups on ARM can only be detected when hardware
interrupts are enabled.  Any region which masks hard interrupts
effectively prevents the soft lockup detector firing should
execution get stuck inside such a region.

> I don't know how to progress on this problem, any hint is welcome.
> 
> int omap3isp_video_queue_streamon(struct isp_video_queue *queue)
> {
>        struct isp_video_buffer *buf;
>        unsigned long flags;
> 
>        mutex_lock(&queue->lock);
> 
>        if (queue->streaming)
>                goto done;
> 
>        queue->streaming = 1;
> 
>        spin_lock_irqsave(&queue->irqlock, flags);
>        list_for_each_entry(buf, &queue->queue, stream) {
>                printk(KERN_INFO "inside list_for_each\n");
>                queue->ops->buffer_queue(buf);
>        }
>        spin_unlock_irqrestore(&queue->irqlock, flags);  <---- soft lockup
> says this is the culprit.

My guess is something inside buffer_queue() is responsible.  If things
get stuck for quite a period of time, the only thing I can suggest is
using printk() based debugging to try and find where things get stuck.
