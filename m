From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 14 Dec 2017 21:37:15 +0100
Subject: [PATCH 1/3] dt-bindings: chosen: Add clocksource and clockevent
 selection
In-Reply-To: <20171214210120.6b436e0d@bbrezillon>
References: <20171213185313.20017-1-alexandre.belloni@free-electrons.com>
 <20171213185313.20017-2-alexandre.belloni@free-electrons.com>
 <CAL_JsqLm5n6s=cr2hBZp4H9pDPKHUOPWs94JMWYFYJ3hsMMxZQ@mail.gmail.com>
 <20171214210120.6b436e0d@bbrezillon>
Message-ID: <20171214213715.4e0bdb44@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 14 Dec 2017 21:01:20 +0100
Boris Brezillon <boris.brezillon@free-electrons.com> wrote:

> Hi Rob,
> 
> On Wed, 13 Dec 2017 16:57:50 -0600
> Rob Herring <robh+dt@kernel.org> wrote:
> 
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
> better resolution or one that wraps less often. In the end it's all
> about how the user plans to use its system, and this has to be
> described somehow. Assuming that the software can decide by itself
> which timer should be used or how many of them should be chained is
> just an utopia.
> 
> >   
> > > Until now, multiple strategies have been used to solve that:
> > >  - use Kconfig option as MXC_USE_EPIT or ATMEL_TCB_CLKSRC_BLOCK    
> > 
> > Compile time probably means only one option is really used.  
> 
> Compile time selection prevents using the same kernel for different
> boards (in other words, no multi-v7), so not really an option here.
> 
> >   
> > >  - use a kernel parameter as the "clocksource" early_param in mach-omap2    
> > 
> > Yeah, OMAP was one of the previous times this came up and also
> > attempted something like this. This parameter predates selecting
> > timers based on features described in DT. Look at commit
> > 2eb03937df3ebc (ARM: OMAP3: Update clocksource timer selection).  
> 
> Then, would you accept to have a property saying that a specific timer
> is a free-running timer (suitable for clocksource) or a programmable
> timer (suitable for clkevent)? Or are you saying that you don't like the
> way timers are differentiated on omap?
> 
> >   
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
> 
> So really, we need a way to assign a specific timer to a specific
> feature. You've refused the different proposals we made so far, so
> what's your alternative? I mean a real alternative that solve the "an
> auto-selected timer might be claimed by another driver at some point"
> problem.

Okay, it seems I was wrong, you already agreed on a generic
atmel,tcb-timer compatible [1], so it seems the only thing we're missing
is a way to assign a timer to a clocksource or a clkevent.

[1]https://patchwork.kernel.org/patch/9755341/
