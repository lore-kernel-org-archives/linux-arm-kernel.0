From: mingo@kernel.org (Ingo Molnar)
Date: Fri, 20 Feb 2015 11:52:19 +0100
Subject: [PATCH] clockevents: Add (missing) default case for switch blocks
In-Reply-To: <CAKohpok3r5ZPCqECQQOZeGiFM-w3yesMjZRuj_ky0PxH7ijAXA@mail.gmail.com>
References: <6291e308ab77a480c6b1732e16108c5fe6f66afa.1424412815.git.viresh.kumar@linaro.org>
 <20150220083842.GA20387@gmail.com>
 <20150220084807.GJ21418@twins.programming.kicks-ass.net>
 <20150220093659.GA23469@gmail.com>
 <CAKohpok3r5ZPCqECQQOZeGiFM-w3yesMjZRuj_ky0PxH7ijAXA@mail.gmail.com>
Message-ID: <20150220105219.GA26933@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Viresh Kumar <viresh.kumar@linaro.org> wrote:

> > So why is a 'default' mode needed then? It makes the 
> > addition of new modes to the legacy handler easier, 
> > which looks backwards.
> 
> The requirement was to add another mode ONESHOT_STOPPED 
> [1], to be supported only by the new per-mode callbacks..

Why would a callback need any flag, and why would a flag be 
visible to old legacy callbacks?

> We have got a clear check in core with the patch Peter 
> mentioned above, which doesn't let us call legacy 
> ->set_mode() for the newer modes.
> 
>         if (dev->set_mode) {
>                 /* Legacy callback doesn't support new modes */
>                 if (mode > CLOCK_EVT_MODE_RESUME)
>                        return -ENOSYS;
>                dev->set_mode(mode, dev);
>                return 0;
>         }

So here is where one of your problems comes from: why did 
you add CLOCK_EVT_MODE_RESUME to the interface? Phase it 
out, it's a legacy interface - new callbacks shouldn't need 
any mode flags to begin with.

> > So I'm confused: if we are using proper callbacks (like 
> > my example outlined) , why is a 'mode enum' needed at 
> > all?
> 
> The enum has two uses today:
> 
> - pass mode to the legacy ->set_mode() callback, which 
> isn't required for the new callbacks.

But this is misguided, as per above.

> - flag for clockevent core's internal state machine, 
>   which it would still require. For example, it checks 
>   new-mode != old-mode before changing the mode..

Internal state machine state should be decoupled from any 
interface flags - especially when the interface is legacy.

> I believe the enum is still required for the state 
> machine, even with new per-mode callbacks.

That needs to be fixed first then, before introducing new 
API variants.

Thanks,

	Ingo
