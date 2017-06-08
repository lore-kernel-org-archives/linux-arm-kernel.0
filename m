From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 8 Jun 2017 08:21:48 +0200
Subject: [PATCH 46/58] clocksource/drivers: Add a new driver for the
 Atmel ARM TC blocks
In-Reply-To: <20170607210848.GJ2345@mai>
References: <20170530215139.9983-1-alexandre.belloni@free-electrons.com>
 <20170530215139.9983-47-alexandre.belloni@free-electrons.com>
 <20170606152104.GC2345@mai>
 <20170606180559.pkrr7ux2qqnmsd6y@piout.net>
 <20170607141735.GH2345@mai>
 <20170607152750.tksmyf5p3oajbsac@piout.net>
 <20170607210848.GJ2345@mai>
Message-ID: <20170608082148.78bcf1a0@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Wed, 7 Jun 2017 23:08:48 +0200,
Daniel Lezcano <daniel.lezcano@linaro.org> a ?crit :

> On Wed, Jun 07, 2017 at 05:27:50PM +0200, Alexandre Belloni wrote:
> > On 07/06/2017 at 16:17:35 +0200, Daniel Lezcano wrote:  
> > > > You mean you don't like how it is used? Or you don't think having the
> > > > timer full name is useful?  
> > > 
> > > The field is not needed, the only place where it is used is where we affect it.
> > >    
> > 
> > It is used in tcb_clksrc_register:
> > 
> > tc.clksrc.name = tc.name;  
> 
> Yes, but tc.name is only in the scope of the function, so there is no need to
> include this field in the structure, just a working buffer in the function is
> enough.

Hm, do you mean allocating the buffer dynamically and leaking the
resource (not a real leak here, since we're talking about something
that cannot be unregistered) or defining a 'static char name[]' variable
in the function and passing this pointer to clksrc.name? Note
that putting the name var on the stack won't work, because the core
does not seem to duplicate the name, and uses clksrc->name after
tcb_clksrc_register() has returned.

Anyway, I'm not sure dynamically generating the name is really
needed because we only accept a single tcb-clocksource device. We can
just set tc.clksrc.name to "atmel-tcb-clocksource" and we should be
good.
