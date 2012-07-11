From: dinguyen@altera.com (Dinh Nguyen)
Date: Wed, 11 Jul 2012 16:19:39 -0500
Subject: [PATCH v5] clocksource: dw_apb_timer: Add common DTS glue for
 dw_apb_timer
In-Reply-To: <20120711210837.GA32489@elf.ucw.cz>
References: <1342037596-17710-1-git-send-email-dinguyen@altera.com>
 <20120711210837.GA32489@elf.ucw.cz>
Message-ID: <1342041579.19608.6.camel@dinguyen-VirtualBox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-07-11 at 23:08 +0200, Pavel Machek wrote:
> Hi!
> 
> > From: Dinh Nguyen <dinguyen@altera.com>
> 
> Not that it matters, but it should probably be from: me, since I did
> the original version...

I apologize, I just took over the next day since my submission for
Altera's socfpga port is dependent on this. 

> 
> > Make a common device tree glue for clocksource/dw_apb_timer.
> > Move mach-picoxcell/time.c to be a generic device tree application
> > of the dw_apb_timer.
> > 
> > Configure mach-picoxcell to use the dw_apb_timer_of device tree
> > implementation in drivers/clocksource.
> 
> > @@ -25,11 +32,12 @@ static void timer_get_base_and_rate(struct device_node *np,
> >  	if (!*base)
> >  		panic("Unable to map regs for %s", np->name);
> >  
> > -	if (of_property_read_u32(np, "clock-freq", rate))
> > -		panic("No clock-freq property for %s", np->name);
> > +	if (of_property_read_u32(np, "clock-freq", rate) &&
> > +		of_property_read_u32(np, "clock-frequency", rate))
> > +		panic("No clock-frequency property for %s", np->name);
> >  }
> >  
> 
> But this should be ||, not &&, I guess.

Actually the way the code was written, it should be &&. Since
of_property_read_u32 returns 0 for success, doing an OR will fail if 1
of the conditions is true. We only want to fail if both conditions fail.

Dinh
> 
> Thanks for the patch,
> 									Pavel
> 
