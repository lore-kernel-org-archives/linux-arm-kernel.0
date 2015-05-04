From: dianders@chromium.org (Doug Anderson)
Date: Mon, 4 May 2015 08:11:10 -0700
Subject: [PATCH] i2c: rk3x: Increase wait timeout to 1 second
In-Reply-To: <20150504083312.GN25193@pengutronix.de>
References: <1430430247-9632-1-git-send-email-dianders@chromium.org>
 <20150504083312.GN25193@pengutronix.de>
Message-ID: <CAD=FV=W1UMOfVCEYAHmsxQfoyXvGRSd63Sw26zEki+A-7G7eiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Uwe,

On Mon, May 4, 2015 at 1:33 AM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
> On Thu, Apr 30, 2015 at 02:44:07PM -0700, Doug Anderson wrote:
>> While it's not sensible for an i2c command to _actually_ need more
>> than 200ms to complete, let's increase the timeout anyway.  Why?  It
>> turns out that if you've got a large number of printks going out to a
>> serial console, interrupts on a CPU can be disabled for hundreds of
>> milliseconds. That's not a great situation to be in to start with
>> (maybe we should put a cap in vprintk_emit()) but it's pretty annoying
>> to start seeing unexplained i2c timeouts.
>>
>> A normal system shouldn't see i2c timeouts anyway, so increasing the
>> timeout should help people debugging without hurting other people
>> excessively.
> Hmm, correct me if I'm wrong: You say that the following can happen:
>
>         rk3x_i2c_xfer calls wait_event_timeout and blocks
>         schedule ... disable_irqs ... xfer complete ... do some work ... enable_irqs
>         control back to i2c driver after timeout elapsed
>         wait_event_timeout returned 0
>
> The documentation of wait_event_timeout tells:
>
>  * Returns:
>  * 0 if the @condition evaluated to %false after the @timeout elapsed,
>  * 1 if the @condition evaluated to %true after the @timeout elapsed,
>  * or the remaining jiffies (at least 1) if the @condition evaluated
>  * to %true before the @timeout elapsed.
>
> Where is the misunderstanding?

Thank you for looking at this!  I will clarify by giving explicit CPU
numbers (this issue can only happen in SMP, I think):

1. CPU1 is running rk3x_i2c_xfer()

2. CPU0 calls vprintk_emit(), which disables all IRQs on CPU0.

3. I2C interrupt is ready but is set to only run on CPU0, where IRQs
are disabled.

4. CPU1 timeout expires.  I2C interrupt is still ready, but CPU0 is
still sitting in the same vprintk_emit()

5. CPU1 sees that no interrupt happened in 200ms, so timeout.


-Doug
