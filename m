From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 26 Apr 2011 08:42:16 +0200
Subject: [PATCH 05/14] at91: use structure to store the current soc
In-Reply-To: <4DB64DC3.70609@bluewatersys.com>
References: <20110425180847.GA12904@game.jcrosoft.org>
	<1303756284-26529-5-git-send-email-plagnioj@jcrosoft.com>
	<4DB5F0C7.2070903@bluewatersys.com>
	<20110426042131.GD12904@game.jcrosoft.org>
	<4DB64DC3.70609@bluewatersys.com>
Message-ID: <20110426064216.GJ12904@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >> I haven't looked at the subsequent patches yet to see if this patch
> >> simplifies things later but it seems that this just adds more lines of
> >> code by having two copies of the each of the cpu_is_xxx macros (the
> >> __cpu_is_xxx version which reads the register, and the cpu_is_xxx
> >> version which reads the shadow value)?
> >>
> >> What is the reasoning behind shadowing the cpu type rather than reading
> >> the registers? The cpu detection macros are mostly used at
> >> initialisation and device probe time, so they don't necessarily need to
> >> be fast.
> >>
> >> If this eventually reduces code size then I think it is useful, but
> >> otherwise I'm not sure I see the point?
> > It's on purpose as the dbgu physical address is not at the same place
> > so read the other register really does not impact the chip but if we do it
> > later duting the boot or the life to the kernel it's an other story
> >
> > so the split between __cpu_is and cpu_is is necessarly
> 
> I don't understand. The at91_initialize function sets cpu_id using the
> __cpu_is macros, and the cpu_is macros check cpu_id to determine the cpu
> type. So the __cpu_is and cpu_is macros are functionally equivalent
> except that the former uses register reads and the latter reads a shadow
> value. i.e. the cpu_is macros are just indirectly using the __cpu_is macros.
> 
> If the register offsets are different between the various platforms then
> this won't work anyway since the __cpu_is macros cannot be generic.
yes it's for now we can use one soc at a time I'm working to remove those
issue and make then soc specific
before doint this I need to fix pm, interrupt, earlyprintk, ll_debug, etc...

for gpio and timers it's already fix so one by one and it will be clean
in those 2 we can now specify on the soc the resource so we do not need to
have the same AT91_PIOx, AT91_ST and AT91_PIT for all soc
they can have their own.

When this cleanup will be finished we will have
AT91SAM9263_PIOx AT91SAM9263_PIT etc...
and only common define when they are really common
> 
> > all of this work is in preparation to allow multiple soc in the same kernel
> > that's also why I map the system controller the same way on all at91 arm9
> 
> If the __cpu_is macros, which read the registers directly, remain then I
> don't see how this can be generic between the various SoCs?
because they will be use only at the begenning before any drivers or other ip
enable so we can use them later it will not be the case anymore

Best Regards,
J.
