From: jp.francois@cynove.com (jean-philippe francois)
Date: Thu, 8 Mar 2012 09:26:19 +0100
Subject: soft lockup on omap3 (dm3730)
In-Reply-To: <20120307163750.GC18787@n2100.arm.linux.org.uk>
References: <CAGGh5h3OQTniXbm8iUYGM+2oi+zzd1F6BxDKzN5epA89+i_7nQ@mail.gmail.com>
 <20120307163750.GC18787@n2100.arm.linux.org.uk>
Message-ID: <CAGGh5h3AtiuFuU0OY1FpPre6hyGKTSTEc=S6hkf2hAr=6LAehg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 7 mars 2012 17:37, Russell King - ARM Linux
<linux@arm.linux.org.uk> a ?crit :
> On Wed, Mar 07, 2012 at 05:16:35PM +0100, jean-philippe francois wrote:
>> Is the backtrace pointing to this offset because soft_lockup can only
>> detect lockups at the output of critical sections ?
>
> Correct - soft lockups on ARM can only be detected when hardware
> interrupts are enabled. ?Any region which masks hard interrupts
> effectively prevents the soft lockup detector firing should
> execution get stuck inside such a region.

But then, how is the soft lockup detector able to break this hard lockup ?
 Without soft / hard lockup detection configured, the loop
runs forever. Anyway, Thanks for the suggestion, I will try to printk  my way
out of this problem.

>
>> I don't know how to progress on this problem, any hint is welcome.
>>
>> int omap3isp_video_queue_streamon(struct isp_video_queue *queue)
>> {
>> ? ? ? ?struct isp_video_buffer *buf;
>> ? ? ? ?unsigned long flags;
>>
>> ? ? ? ?mutex_lock(&queue->lock);
>>
>> ? ? ? ?if (queue->streaming)
>> ? ? ? ? ? ? ? ?goto done;
>>
>> ? ? ? ?queue->streaming = 1;
>>
>> ? ? ? ?spin_lock_irqsave(&queue->irqlock, flags);
>> ? ? ? ?list_for_each_entry(buf, &queue->queue, stream) {
>> ? ? ? ? ? ? ? ?printk(KERN_INFO "inside list_for_each\n");
>> ? ? ? ? ? ? ? ?queue->ops->buffer_queue(buf);
>> ? ? ? ?}
>> ? ? ? ?spin_unlock_irqrestore(&queue->irqlock, flags); ?<---- soft lockup
>> says this is the culprit.
>
> My guess is something inside buffer_queue() is responsible. ?If things
> get stuck for quite a period of time, the only thing I can suggest is
> using printk() based debugging to try and find where things get stuck.
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
