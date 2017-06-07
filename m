From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 7 Jun 2017 23:08:48 +0200
Subject: [PATCH 46/58] clocksource/drivers: Add a new driver for the
 Atmel ARM TC blocks
In-Reply-To: <20170607152750.tksmyf5p3oajbsac@piout.net>
References: <20170530215139.9983-1-alexandre.belloni@free-electrons.com>
 <20170530215139.9983-47-alexandre.belloni@free-electrons.com>
 <20170606152104.GC2345@mai>
 <20170606180559.pkrr7ux2qqnmsd6y@piout.net>
 <20170607141735.GH2345@mai>
 <20170607152750.tksmyf5p3oajbsac@piout.net>
Message-ID: <20170607210848.GJ2345@mai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 07, 2017 at 05:27:50PM +0200, Alexandre Belloni wrote:
> On 07/06/2017 at 16:17:35 +0200, Daniel Lezcano wrote:
> > > You mean you don't like how it is used? Or you don't think having the
> > > timer full name is useful?
> > 
> > The field is not needed, the only place where it is used is where we affect it.
> >  
> 
> It is used in tcb_clksrc_register:
> 
> tc.clksrc.name = tc.name;

Yes, but tc.name is only in the scope of the function, so there is no need to
include this field in the structure, just a working buffer in the function is
enough.
 
> > > The main reason is that RobH doesn't want to have the use (clocksource
> > > or clockevent) of the timer in the DT so when probing a timer, I need to
> > > know whether I already have a clocksource to decide when it is time to
> > > register a clockevent.
> > 
> > Yes, we had this discussion some weeks ago.
> > 
> > This registered hack forces the DT to define first the clocksource, then the
> > clockevent.
> > 
> > So, I suggest you fold the timer definition into a single one like the other
> > drivers.
> 
> I was going to agree but this is not flexible enough because the
> quadrature decoder always uses the first two channels. So on some
> products, we may have:
>  - TCB0:
>    o channels 0,1: qdec
>    o channel 2: clocksource
> 
>  - TCB1:
>    o channels 0,1: qdec
>    o channel 2: clockevent
> 
> This avoids wasting TCB channels.

Ok. In this case you can check if the interrupt is specified for the node, if
yes, then it is a clockevent.

-- 

 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
