From: john.stultz@linaro.org (John Stultz)
Date: Mon, 17 Feb 2014 10:13:54 -0800
Subject: [PATCH] sched_clock: Prevent callers from seeing half-updated data
In-Reply-To: <20140211064924.GA14769@codeaurora.org>
References: <52F524A3.3070400@linaro.org>
 <1391806139-20116-1-git-send-email-sboyd@codeaurora.org>
 <20140207222237.GF12815@codeaurora.org> <52F55E14.9080609@linaro.org>
 <20140211064924.GA14769@codeaurora.org>
Message-ID: <53025162.6020700@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/10/2014 10:49 PM, Stephen Boyd wrote:
> On 02/07, John Stultz wrote:
>> On 02/07/2014 02:22 PM, Stephen Boyd wrote:
>>> On 02/07, Stephen Boyd wrote:
>>>> If two sched_clock sources are registered we may end up in a
>>>> situation where a call to sched_clock() may be accessing the
>>>> epoch cycle count for the old counter and the cycle count for the
>>>> new counter. This can lead to confusing results where
>>>> sched_clock() values jump and then are reset to 0 (due to the way
>>>> the registration function forces the epoch_ns to be 0). Fix this
>>>> by reorganizing the registration function to hold the seqlock for
>>>> as short a time as possible while we update the clock_data
>>>> structure for a new counter and stop resetting the epoch_ns count
>>>> to 0.
>>> Hmm.. This won't properly accumulate time. We need to put
>>> whatever time has elapsed into epoch_ns when we register the new
>>> counter for this to work. I don't have a board with this
>>> configuration but I'll send a v2 that should fix this. Hopefully
>>> Will can test it.
>> Also maybe clarify in the commit message that this is a result of not
>> having the necessary locking in place in the registration code (likely
>> due to it not really being required in the single clock case), just so
>> Ingo and others have some more context as to why this is needed now and
>> wasn't hit before.
>>
> Hmph... I already sent v2 before you replied. Is the commit text
> good enough? I do mention that this is about two sched_clock
> sources being registered.

I'll tweak the commit message a bit make this point more clear.

thanks
-john
