From: mingo@kernel.org (Ingo Molnar)
Date: Fri, 20 Feb 2015 10:36:59 +0100
Subject: [PATCH] clockevents: Add (missing) default case for switch blocks
In-Reply-To: <20150220084807.GJ21418@twins.programming.kicks-ass.net>
References: <6291e308ab77a480c6b1732e16108c5fe6f66afa.1424412815.git.viresh.kumar@linaro.org>
 <20150220083842.GA20387@gmail.com>
 <20150220084807.GJ21418@twins.programming.kicks-ass.net>
Message-ID: <20150220093659.GA23469@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> > So this whole approach looks fragile for several reasons:
> > 
> >    - 'mode setting' callbacks are just bad by design
> >      because they mix several functions into the same entry
> >      point, complicating the handler functions 
> >      unnecessarily. We should reduce complexity, not expand 
> >      on it.
> > 
> >    - now by adding 'default' you hide from drivers the
> >      ability to easily discover whether it has been updated
> >      to some new core clockevents mode setting feature or
> >      not.
> 
> So this patch was a follow on from bd624d75db21 
> ("clockevents: Introduce mode specific callbacks").
> 
> That patch changes the set_mode() interface; and provides 
> per mode functions.

So why is a 'default' mode needed then? It makes the 
addition of new modes to the legacy handler easier, which 
looks backwards.

> New (and updated) drivers should not use ->set_mode() 
> anymore, but it was felt that we do not want to go do 
> flag day changes.

I fully agree that we don't want flag day changes, but make 
it really apparent that it's an obsolete interface:

  - rename it to set_mode_obsolete()

  - try to convert as many of the easy cases as possible - 
    the overwhelming majority of mode setting functions 
    look reasonably simple.

  - get rid of the mode enum in the core, and rename the 
    mode bits to CLOCK_EVT_MODE_OBSOLETE_XXX.

etc.

> And it allows for adding optional modes; not every driver 
> needs to go implement all mode functions if there is a 
> sane default action.
> 
> But it does mean we need to be able to add values to the 
> enum.

So I'm confused: if we are using proper callbacks (like my 
example outlined) , why is a 'mode enum' needed at all?

Thanks,

	Ingo
