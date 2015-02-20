From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 20 Feb 2015 09:48:07 +0100
Subject: [PATCH] clockevents: Add (missing) default case for switch blocks
In-Reply-To: <20150220083842.GA20387@gmail.com>
References: <6291e308ab77a480c6b1732e16108c5fe6f66afa.1424412815.git.viresh.kumar@linaro.org>
 <20150220083842.GA20387@gmail.com>
Message-ID: <20150220084807.GJ21418@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 20, 2015 at 09:38:42AM +0100, Ingo Molnar wrote:
> 
> * Viresh Kumar <viresh.kumar@linaro.org> wrote:
> 
> > Many clockevent drivers are using a switch block for handling modes in their
> > ->set_mode() callback. Some of these do not have a 'default' case and adding a
> > new mode in the 'enum clock_event_mode', starts giving following warnings for
> > these platforms about unhandled modes (e.g. XXX).
> > 
> > 	warning: enumeration value ?XXX? not handled in switch [-Wswitch]
> > 
> > This patch adds default cases for them.
> > 
> > In order to keep things simple, add following to the switch blocks:
> > 
> > 	default:
> > 		break;
> > 
> > This can lead to different behavior for individual cases.
> > 
> > 1) Some of the drivers don't have any special stuff in their ->set_mode()
> >    callback before or after the switch blocks. And so this default case would
> >    simply return for them without any updates to the clockevent device.
> > 
> > 2) But in some cases, the clockevent device is disabled/stopped as soon as we
> >    enter the ->set_mode() callback and is enabled within the switch block or
> >    after it. And the clockevent device *may* stay disabled for default case.
> 
> So this whole approach looks fragile for several reasons:
> 
>    - 'mode setting' callbacks are just bad by design
>      because they mix several functions into the same entry
>      point, complicating the handler functions 
>      unnecessarily. We should reduce complexity, not expand 
>      on it.
> 
>    - now by adding 'default' you hide from drivers the
>      ability to easily discover whether it has been updated
>      to some new core clockevents mode setting feature or
>      not.

So this patch was a follow on from bd624d75db21 ("clockevents: Introduce
mode specific callbacks").

That patch changes the set_mode() interface; and provides per mode
functions.

New (and updated) drivers should not use ->set_mode() anymore, but it
was felt that we do not want to go do flag day changes.

And it allows for adding optional modes; not every driver needs to go
implement all mode functions if there is a sane default action.

But it does mean we need to be able to add values to the enum.
