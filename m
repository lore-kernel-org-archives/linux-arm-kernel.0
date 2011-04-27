From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 27 Apr 2011 03:27:07 +0200
Subject: [PATCH 05/14] at91: use structure to store the current soc
In-Reply-To: <4DB75FA8.10207@bluewatersys.com>
References: <20110425180847.GA12904@game.jcrosoft.org>
	<1303756284-26529-5-git-send-email-plagnioj@jcrosoft.com>
	<4DB5F0C7.2070903@bluewatersys.com>
	<20110426042131.GD12904@game.jcrosoft.org>
	<4DB64DC3.70609@bluewatersys.com>
	<20110426064216.GJ12904@game.jcrosoft.org>
	<4DB7299D.80308@bluewatersys.com>
	<20110426234514.GC29103@game.jcrosoft.org>
	<4DB75FA8.10207@bluewatersys.com>
Message-ID: <20110427012707.GD29103@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >>
> >> This way the cpu detection code is much clearer and easier to read and
> >> only one set of __cpu_is macros are needed. The values for
> >> ARCH_ID_AT91RM9200, etc can be moved into soc.c since they are not
> >> needed elsewhere.
> > This will never work you do not listen
> >
> > the DBUG is at DIFFERENT base address on the AT91
> > you need to check them one by one
> >
> > I keep the structure to keep more imformation inside and do not want to be
> > limited by a 32bit and complex encoding to maintain
> >
> > Best Regards,
> > J.
> You can only be running one machine at a time. Are you implying that
> this change breaks at91_sys_read in such a way that it reads the wrong
> registers? If so, then its definitely a NAK.
Certernly not ALL of the current work is too allow in a UNIQUE kernel to have
all the atmel inside and other vendors and boards in the same kernel

and for at91_sys_read it's not a big deal as I'm going to drop it at the end
the timers does not use it anymore and the other drivers will update also one
by one
> 
> Your patch does this:
> 
> static inline unsigned long at91_cpu_identify(void)
> {
> 	return (at91_sys_read(AT91_DBGU_CIDR) & ~AT91_CIDR_VERSION);
> }
> 
Yeah as I said already I need to fix a lots of place and I do it step by step
so for now on I do not update the at91_cpu_identify & co but I will in time
> ...
> 
> #ifdef CONFIG_ARCH_AT91RM9200
> #define __cpu_is_at91rm9200()	(at91_cpu_identify() == ARCH_ID_AT91RM9200)
> #else
> #define __cpu_is_at91rm9200()	(0)
> #endif
> 
> ...
> 
> void __init at91_initialize(unsigned long main_clock)
> {
> 	...
> 	if (__cpu_is_at91rm9200()) {
> 		cpu_id.is_at91rm9200_soc;
> 		current_soc = at91rm9200_soc;
> 	}
> 	...
> }
> 
> 
> So at91_initialize calls the __cpu_is macros, which in turn read the
> AT91_DBGU registers via at91_sys_read. What I am proposing above is to
> replace the massive collection of if statements with a simpler switch
> statement and replacing the __cpu_is macros with direct register reads
> via at91_sys_read, which results in far less code and more readable
> code. If your version works, then how can mine not?
Because It will never allow you to have a __cpu_is_ soc specific
which is the goal here

Best Regards,
J.
