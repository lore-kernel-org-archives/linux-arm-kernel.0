From: dzickus@redhat.com (Don Zickus)
Date: Fri, 3 Dec 2010 09:58:03 -0500
Subject: mpcore watchdogs questions
In-Reply-To: <4CF8F702.1070502@stericsson.com>
References: <4CF8F702.1070502@stericsson.com>
Message-ID: <20101203145803.GQ18100@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 03, 2010 at 02:56:18PM +0100, Per Fransson wrote:
> Hi,
> 
> I have some questions regarding the ARM mpcore watchdogs and the kernel
> watchdog API in the case of a Cortex-A9. These local watchdogs
> have two properties which appear to make them less well-suited to the
> existing framework:
> 
> 1) Their clocking is tied to that of the cores, in the sense that the WDs are
>    unclocked if the interrupt controller is. There's nothing we can do
>    about this, but it does mean that they can't be used to watch over a
>    sleeping system and therefore that we don't want the user space kicker to
>    be driven by a timer which will cause a wake-up - not when power
>    management is an issue. In the kernel there are deferred timers to use
>    for these cases, but the kicker doesn't live there.
> 
> 2) They are local to each core, which gives us at least these alternatives:
> 
>     * Use only one of them and...
>         - set the affinity of the user space kicker to the corresponding core, or
>         - let the kicker migrate, but get the message to the correct core in
>           kernel space through IPI
> 
>     * Use all of them and...
>         - One user space kicker per core, or
>         - One user space kicker, but with "cyclic affinity", or
>         - One user-space kicker, but each kick causes all
>           the cores to get the message in kernel space,
>           again using IPIs
> 
> All of the above assumes these local watchdogs should be shoe-horned into the
> existing framework in the first place. Should they? Another alternative is to
> somehow use them to watch over the lockup detectors in
> 
>     kernel/{softlockup,watchdog}.c
> 
> Maybe there are other options as well.

I am not entirely sure what you are looking for, but the
kernel/{softlockup,watchdog}.c takes a different approach to a normal
watchdog.  Normal watchdogs have somebody kick them so they stay asleep,
with the intention that if they wake up bad things happened.

The hard/soft lockup detector will always wake up at a periodic rate and
check to see if they system has progressed since the last check.
Unfortunately, because of its periodic rate, it will cause wakeup events
(though every 60 seconds isn't that bad is it? :-) ), except for the
hardlockup case which uses the NMI.  That is tied to cpu activity and
won't fire an NMI if the cpu is sleeping.

There have been talks about trying to tie the hrtimer and the kthread to
the power management layer with the idea that if the system is sleeping
there is no need to increment interrupt stats (using hrtimer) or check
process usage (using the kthread).  That would cut down the number of
wakeups.

Cheers,
Don
