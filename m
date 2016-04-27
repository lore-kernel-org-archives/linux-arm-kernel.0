From: stefan@agner.ch (Stefan Agner)
Date: Wed, 27 Apr 2016 00:28:10 -0700
Subject: [PATCH 1/2] clk: imx: do not sleep if IRQ's are still disabled
In-Reply-To: <CAOMZO5BeAxPLerGMkaadkEZusW8wHkO5P6SiZeHOCKWstHUTSA@mail.gmail.com>
References: <1454107764-19876-1-git-send-email-stefan@agner.ch>
 <20160421034520.GA19965@shlinux2.ap.freescale.net>
 <20160426012341.GB8870@tiger>
 <CAA+hA=QTNEAaMfjJoMMO5gPR8VPYBWYx=HZgjngUFJK4LxMp=g@mail.gmail.com>
 <1461663072.7839.17.camel@pengutronix.de>
 <CAA+hA=SSQJPbzbhCY7O8JaxiUgMDjG2ATQXsCW-X5zc2inC6kw@mail.gmail.com>
 <CAA+hA=Q5Un7Sib5QEvK4H2PH5qrySAkRR+=ofuaKxX_PCuT-Yw@mail.gmail.com>
 <20160427015835.GE30692@tiger>
 <CAA+hA=SNp7bQZSUp5R5v9BfXMffS-4-msv12G5UAQJTxUMKW=A@mail.gmail.com>
 <CAOMZO5BeAxPLerGMkaadkEZusW8wHkO5P6SiZeHOCKWstHUTSA@mail.gmail.com>
Message-ID: <1f10ab4830032858bc4d6174528f18e8@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-04-26 19:56, Fabio Estevam wrote:
> On Tue, Apr 26, 2016 at 11:45 PM, Dong Aisheng <dongas86@gmail.com> wrote:
> 
>>> We need to firstly understand why this is happening.  The .prepare hook
>>> is defined to be non-atomic context, and so that we call sleep function
>>> in there.  We did everything right.  Why are we getting the warning?  If
>>> I'm correct, this warning only happens on i.MX7D.  Why is that?
>>>
>>
>> This is mainly caused by during kernel early booting, there's only one init idle
>> task running.
>> See:
>> void __init sched_init(void)
>> {
>> .....
>>         /*
>>          * Make us the idle thread. Technically, schedule() should not be
>>          * called from this thread, however somewhere below it might be,
>>          * but because we are the idle thread, we just pick up running again
>>          * when this runqueue becomes "idle".
>>          */
>>         init_idle(current, smp_processor_id());
>> ...
>> }
>>
>> And the idle sched class indicates it's not valid to schedule for idle task.
>> const struct sched_class idle_sched_class = {
>>         /* .next is NULL */
>>         /* no enqueue/yield_task for idle tasks */
>>
>>         /* dequeue is not valid, we print a debug message there: */
>>         .dequeue_task           = dequeue_task_idle,
>> ...........
>>
>> }
>>
>> /*
>>  * It is not legal to sleep in the idle task - print a warning
>>  * message if some code attempts to do it:
>>  */
>> static void
>> dequeue_task_idle(struct rq *rq, struct task_struct *p, int flags)
>> {
>>         raw_spin_unlock_irq(&rq->lock);
>>         printk(KERN_ERR "bad: scheduling from the idle thread!\n");
>>         dump_stack();
>>         raw_spin_lock_irq(&rq->lock);
>> }
>>
>>
>> Below is the full log of imx7d booting FYI.
> 
> This does not answer Shawn's question: why do we see this only on mx7d?

I was wondering that too.... My theory is that either on i.MX 6 the
clocks enable almost instantly leading to no sleep, or they are just
bootloader/firmware on...?

--
Stefan
