From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 7 Jun 2017 17:27:50 +0200
Subject: [PATCH 46/58] clocksource/drivers: Add a new driver for the
 Atmel ARM TC blocks
In-Reply-To: <20170607141735.GH2345@mai>
References: <20170530215139.9983-1-alexandre.belloni@free-electrons.com>
 <20170530215139.9983-47-alexandre.belloni@free-electrons.com>
 <20170606152104.GC2345@mai>
 <20170606180559.pkrr7ux2qqnmsd6y@piout.net>
 <20170607141735.GH2345@mai>
Message-ID: <20170607152750.tksmyf5p3oajbsac@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/06/2017 at 16:17:35 +0200, Daniel Lezcano wrote:
> > You mean you don't like how it is used? Or you don't think having the
> > timer full name is useful?
> 
> The field is not needed, the only place where it is used is where we affect it.
>  

It is used in tcb_clksrc_register:

tc.clksrc.name = tc.name;

> > The main reason is that RobH doesn't want to have the use (clocksource
> > or clockevent) of the timer in the DT so when probing a timer, I need to
> > know whether I already have a clocksource to decide when it is time to
> > register a clockevent.
> 
> Yes, we had this discussion some weeks ago.
> 
> This registered hack forces the DT to define first the clocksource, then the
> clockevent.
> 
> So, I suggest you fold the timer definition into a single one like the other
> drivers.

I was going to agree but this is not flexible enough because the
quadrature decoder always uses the first two channels. So on some
products, we may have:
 - TCB0:
   o channels 0,1: qdec
   o channel 2: clocksource

 - TCB1:
   o channels 0,1: qdec
   o channel 2: clockevent

This avoids wasting TCB channels.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
