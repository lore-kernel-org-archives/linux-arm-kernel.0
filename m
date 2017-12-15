From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 15 Dec 2017 11:40:04 +0000
Subject: [PATCH 1/3] dt-bindings: chosen: Add clocksource and clockevent
 selection
In-Reply-To: <20171214210120.6b436e0d@bbrezillon>
References: <20171213185313.20017-1-alexandre.belloni@free-electrons.com>
 <20171213185313.20017-2-alexandre.belloni@free-electrons.com>
 <CAL_JsqLm5n6s=cr2hBZp4H9pDPKHUOPWs94JMWYFYJ3hsMMxZQ@mail.gmail.com>
 <20171214210120.6b436e0d@bbrezillon>
Message-ID: <20171215114004.l4lbqa6xibliwjyh@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Dec 14, 2017 at 09:01:20PM +0100, Boris Brezillon wrote:
> On Wed, 13 Dec 2017 16:57:50 -0600
> Rob Herring <robh+dt@kernel.org> wrote:
> > On Wed, Dec 13, 2017 at 12:53 PM, Alexandre Belloni
> > <alexandre.belloni@free-electrons.com> wrote:

> > > The clocksource and clockevent timer are probed early in the boot process.
> > > At that time it is difficult for linux to know whether a particular timer
> > > can be used as the clocksource or the clockevent or by another driver,
> > > especially when they are all identical or have similar features.  
> > 
> > If all identical, then it shouldn't matter. "similar" means some
> > difference. Describe those differences.
> 
> We had this discussion already. Those timers might be connected to
> external pins and may serve the role of PWM generators or capture
> devices. We can also chain timers and provide a clocksource with a
> better resolution or one that wraps less often. 

Could you elaborate on the chaining case? I haven't encountered that,
and at the moment I'm not sure I follow how that works.

> > >  - registering the first seen timer as a clockevent and the second one as
> > >  a clocksource as in rk_timer_init or dw_apb_timer_init
> > >
> > > Add a linux,clocksource and a linux,clockevent node in chosen with a timer
> > > property pointing to the timer to use. Other properties, like the targeted
> > > precision may be added later.  
> > 
> > Open ended expansion of this does not help convince me it is needed.
> 
> It's not an open ended expansion, we're just trying to find a way to
> describe which timer blocks should be used as free running timers
> (clksource) and which one should be used as programmable timers
> (clkevent). Automatically selecting timer blocks to assign to the
> clkevent or clocksource is not so easy (as has been explained earlier)
> because at the time the system registers its clksource/clkevent devices
> we might not have all the necessary information to know which timer
> blocks will be reserved for other usage later on. The use case I have
> in mind is DT overlays, where one of the overlay is using a timer as a
> PWM generator. If the clkevent or clksource has already claimed the
> timer connected to the pins the overlay is using, then we're screwed,
> and there's no way the system can know that ahead of time except by
> pre-assigning a timer to the clksource or clkevent feature.

I guess that might work for the boot-time overlay case, where the user
knows ahead-of-time that there will be a conflict for resources, but
that doesn't help with the dynamic overlay case, since the user can't
know what conflicts there will be.

Can we attempt to unregister the clock device in that case, when the PWM
is requested? If the timekeeping core can select another device, then
we're free to use this one as a PWM. If not, then we're stuck anyway.

Thanks,
Mark.
