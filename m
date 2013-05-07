From: will.deacon@arm.com (Will Deacon)
Date: Tue, 7 May 2013 13:54:11 +0100
Subject: [RFC PATCH] implement read_cpuid_ext for v7-M (Was: Re: [PATCHv2
 2/3] ARM: Detect support for SDIV/UDIV from ISAR0) register
In-Reply-To: <20130507124013.GM23285@pengutronix.de>
References: <1363631337-13816-1-git-send-email-sboyd@codeaurora.org>
 <1363631337-13816-3-git-send-email-sboyd@codeaurora.org>
 <20130418091019.GA21099@pengutronix.de>
 <20130506093059.GH23285@pengutronix.de>
 <20130507092209.GD25387@mudshark.cambridge.arm.com>
 <5188DDDC.1000201@arm.com> <20130507124013.GM23285@pengutronix.de>
Message-ID: <20130507125411.GA26694@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 07, 2013 at 01:40:13PM +0100, Uwe Kleine-K?nig wrote:
> On Tue, May 07, 2013 at 11:56:28AM +0100, Jonathan Austin wrote:
> > For V7M we have something called CPUID Base Register, not MIDR - the
> > layout looks the same though. That's the only one of the CPUID_X
> > that we have, but it is never requested directly - only via
> > read_cpuid_id (this is to support a hardcoded cpuid from kconfig) so
> > what Uwe's got does work, though I agree that it'd be much nicer to
> > implement the underlying function and have the accessor general for
> > both AR and M.
> The current state (that is next + the patch from this thread) is:
> 
> #ifdef CONFIG_CPU_CP15
> 	define read_cpuid and read_cpuid_ext using mrc p15
> 	read_cpuid_id = read_cpuid(CPUID_ID)
> #elif defined (CONFIG_CPU_V7M)
> 	read_cpuid returns 0 (with a warning)
> 	read_cpuid_ext reads from SCB
> 	read_cpuid_id reads from V7M_SCB_CPUID
> #else
> 	read_cpuid and read_cpuid_ext return 0 (with a warning)
> 	read_cpuid_id returns CONFIG_PROCESSOR_ID (a bit simplified)
> #endif
> 
> Now, what is the "underlying function" that should be used to implement
> which accessor? I assume you want to have
> 
> 	read_cpuid_id = read_cpuid(CPUID_ID)
> 
> on v7-M, too? So what is the suggestion for read_cpuid?:
> 
> 	if (reg == CPUID_ID)
> 		return readl(V7M_SCB_CPUID);
> 	else
> 		return 0;

Yes, either switch on the reg or define CPUID_ID to be V7M_SCB_CPUID for
v7m, then just do the readl in read_cpuid. I'm not sure the warnings add
much (we can do read_cpuid(random integer) with cp15 and it will blindly
construct the mrc).

> That doesn't make much sense in my eyes. If I got you wrong, please give
> more details.

I'm just suggesting that we try and keep the functions similar between v7m and
cp15 where there isn't a good reason not to.

Up to you.

Will
