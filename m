From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 9 Sep 2014 12:35:32 +0200 (CEST)
Subject: [RFC PATCH v2] clockevents: re-calculate event when cpu enter idle
In-Reply-To: <1409793933-29938-1-git-send-email-leoy@marvell.com>
References: <1409793933-29938-1-git-send-email-leoy@marvell.com>
Message-ID: <alpine.DEB.2.10.1409091223160.11037@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 4 Sep 2014, Leo Yan wrote:

This changelog is pretty uncomprehensible, but I can see what you are
trying to solve.

> Below flow will have the redundant interrupts for broadcast timer:
> 
> 1. Process A starts a hrtimer with 100ms timeout, then Process A will
>    wait on the waitqueue to sleep;
> 2. The CPU which Process A runs on will enter idle and call notify
>    CLOCK_EVT_NOTIFY_BROADCAST_ENTER, so the CPU will shutdown its local
>    and set broadcast timer's next event with delta for 100ms timeout;
> 3. After 70ms later, the CPU is waken up by other peripheral's interrupt
>    and Process A will be waken up as well; Process A will cancel the hrtimer
>    at this point, kernel will remove the timer event from the event queue
>    but it will not really disable broadcast timer;
> 4. So after 30ms later, the broadcast timer interrupt will be triggered
>    even though the timer has been cancelled by s/w in step 3.
> 
> To fix this issue, in theory cpu can check this situation when the cpu
> enter and exit idle; So it can iterate the related idle cpus to calculate
> the correct broadcast event value.
> 
> But with upper method, it has the side effect. Due the cpu enter and exit
> idle state very frequently in short time, so can optimize to only calculate
> the correct state only when the cpu join into broadcast timer and set the
> next event after calculate a different event compare to previous time.

And you inflict this unconditionally on every invocation of broadcast
enter, if the cpu is not the one which has the first expiring timer.

What's the point of doing a full scan unconditionally just to catch an
obscure corner case like you describe above? That's just stupid and
while it might be a non issue on your quadcore ARM it's going to be a
pain on larger mostly idle machines.

So unconditially forcing the scan on everyone to deal with some corner
case is not going to happen.

Thanks,

	tglx
