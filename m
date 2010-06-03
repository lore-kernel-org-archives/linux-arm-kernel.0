From: ryan@bluewatersys.com (Ryan Mallon)
Date: Fri, 04 Jun 2010 11:33:35 +1200
Subject: Heads up: Linus plans to kill ARM defconfigs
In-Reply-To: <alpine.LFD.2.00.1006031829020.24526@xanadu.home>
References: <20100603192459.GA9169@n2100.arm.linux.org.uk>
	<4C0818F9.9070008@bluewatersys.com>
	<alpine.LFD.2.00.1006031829020.24526@xanadu.home>
Message-ID: <4C083BCF.2060500@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas Pitre wrote:
> On Fri, 4 Jun 2010, Ryan Mallon wrote:
> 
>> Is it worth being a bit proactive and getting rid of some of them in
>> advance? Things like spear3[012]0_defconfig are basically identically
>> except for the board type. Combining all three of those would remove
>> 1500 lines of code.
> 
> Please go ahead with a patch.

Hmm, not as easy as I thought. The three boards cannot be built into a
single kernel since the arch/arm/mach-spear3xx/spear3[012]0.c files all
extern a bunch of structs which have naming conflicts.

It does look possible to rewrite that code so that all three boards can
be built into a single kernel. I can try and put together a patch, but I
don't have any hardware to test with.

The at91 is actually in a similar state, where only one of the
at91sam9260, at91sam9g45, etc can be selected. Again, it should be
possible to rework the code so that most of the different cpus can be
built into a single kernel. I'm sure other mach's are in a simliar
state. Fixing these where possible would allow us to have single
defconfigs per mach directory and reduce code churn, which is what Linus
is really complaining about.

>> Basically reduce down to one or two defconfigs for each mach directory
>> which include as many boards and drivers as possible. People wanting
>> more tailored configs can do that in their own trees.
> 
> This actually should have been the plan from the start.  See for example 
> orion5x_defconfig which currently already supports 23 machines.

It seems that in a few cases at least the problem is really that all of
the boards for a mach directory cannot be compiled into one kernel.
Fixing that would be a useful goal.

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
