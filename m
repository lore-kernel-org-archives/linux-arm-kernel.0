From: john.stultz@linaro.org (John Stultz)
Date: Thu, 02 Jan 2014 12:03:02 -0800
Subject: v3.13-rc6+ regression (ARM board)
In-Reply-To: <CA+55aFyZ0EXYkHd-BhQo6K++qKJVPdGeDbFTVTs3pAPCHFUpOA@mail.gmail.com>
References: <m3mwjhux0e.fsf@t19.piap.pl>	<20131231104511.GA9688@1wt.eu>	<m3txdmu2ez.fsf@t19.piap.pl>	<20140102101455.GG10158@pengutronix.de>	<m3ppoatwn1.fsf@t19.piap.pl>
 <CA+55aFyZ0EXYkHd-BhQo6K++qKJVPdGeDbFTVTs3pAPCHFUpOA@mail.gmail.com>
Message-ID: <52C5C5F6.70803@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/02/2014 11:38 AM, Linus Torvalds wrote:
> On Thu, Jan 2, 2014 at 4:07 AM, Krzysztof Ha?asa <khalasa@piap.pl> wrote:
>> This means these two commits don't like each other:
>>
>>     seqcount: Add lockdep functionality to seqcount/seqlock structures
>>     sched_clock: Use seqcount instead of rolling our own
> Does something like this fix it for you?
>
>   --- a/kernel/time/sched_clock.c
>   +++ b/kernel/time/sched_clock.c
>   @@ -36,6 +36,7 @@ core_param(irqtime, irqtime, int, 0400);
>
>    static struct clock_data cd = {
>           .mult   = NSEC_PER_SEC / HZ,
>   +       .seq = SEQCNT_ZERO(cd.seq),
>    };
>
>    static u64 __read_mostly sched_clock_mask;
>
> (The above is not even compile-tested, because x86 doesn't use
> GENERIC_SCHED_CLOCK. So I did the patch blindly, but I think you get
> the idea..)

Sheesh. Just finishing up holiday email backlog and Linus already has a
fix. :)

This looks like it should fix the issue, and does build for me.

Assuming it works for Krzysztof,

Acked-by: John Stultz <john.stultz@linaro.org>

I'll do another grep pass through -rc6 to make sure no other new
uninitialized seqlock usage was added.

thanks
-john
