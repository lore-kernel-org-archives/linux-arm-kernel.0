From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 20 Feb 2015 15:42:41 +0530
Subject: [PATCH] clockevents: Add (missing) default case for switch blocks
In-Reply-To: <20150220093659.GA23469@gmail.com>
References: <6291e308ab77a480c6b1732e16108c5fe6f66afa.1424412815.git.viresh.kumar@linaro.org>
 <20150220083842.GA20387@gmail.com>
 <20150220084807.GJ21418@twins.programming.kicks-ass.net>
 <20150220093659.GA23469@gmail.com>
Message-ID: <CAKohpok3r5ZPCqECQQOZeGiFM-w3yesMjZRuj_ky0PxH7ijAXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 February 2015 at 15:06, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Peter Zijlstra <peterz@infradead.org> wrote:
>
>> > So this whole approach looks fragile for several reasons:
>> >
>> >    - 'mode setting' callbacks are just bad by design
>> >      because they mix several functions into the same entry
>> >      point, complicating the handler functions
>> >      unnecessarily. We should reduce complexity, not expand
>> >      on it.
>> >
>> >    - now by adding 'default' you hide from drivers the
>> >      ability to easily discover whether it has been updated
>> >      to some new core clockevents mode setting feature or
>> >      not.
>>
>> So this patch was a follow on from bd624d75db21
>> ("clockevents: Introduce mode specific callbacks").
>>
>> That patch changes the set_mode() interface; and provides
>> per mode functions.

Thanks Peter ..

> So why is a 'default' mode needed then? It makes the
> addition of new modes to the legacy handler easier, which
> looks backwards.

The requirement was to add another mode ONESHOT_STOPPED [1],
to be supported only by the new per-mode callbacks..

We have got a clear check in core with the patch Peter mentioned above,
which doesn't let us call legacy ->set_mode() for the newer modes.

        if (dev->set_mode) {
                /* Legacy callback doesn't support new modes */
                if (mode > CLOCK_EVT_MODE_RESUME)
                       return -ENOSYS;
               dev->set_mode(mode, dev);
               return 0;
        }


The intention of adding a 'default' case (which is already present in most
of clockevents drivers) here was to make compiler happy and that's
why the commit logs mentioned this:

"
    The rationale behind only adding a 'break' was that the default case *will
    never* be hit during execution of code.
"

>> New (and updated) drivers should not use ->set_mode()
>> anymore, but it was felt that we do not want to go do
>> flag day changes.
>
> I fully agree that we don't want flag day changes, but make
> it really apparent that it's an obsolete interface:
>
>   - rename it to set_mode_obsolete()
>
>   - try to convert as many of the easy cases as possible -
>     the overwhelming majority of mode setting functions
>     look reasonably simple.

Yes, we can do that..

>   - get rid of the mode enum in the core, and rename the
>     mode bits to CLOCK_EVT_MODE_OBSOLETE_XXX.

> So I'm confused: if we are using proper callbacks (like my
> example outlined) , why is a 'mode enum' needed at all?

The enum has two uses today:

- pass mode to the legacy ->set_mode() callback, which isn't
required for the new callbacks.

- flag for clockevent core's internal state machine, which it would
still require. For example, it checks new-mode != old-mode before
changing the mode..

I believe the enum is still required for the state machine, even with
new per-mode callbacks.

--
viresh

[1] https://lkml.org/lkml/2014/5/9/508
