From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 7 May 2013 14:40:13 +0200
Subject: [RFC PATCH] implement read_cpuid_ext for v7-M (Was: Re: [PATCHv2
 2/3] ARM: Detect support for SDIV/UDIV from ISAR0) register
In-Reply-To: <5188DDDC.1000201@arm.com>
References: <1363631337-13816-1-git-send-email-sboyd@codeaurora.org>
 <1363631337-13816-3-git-send-email-sboyd@codeaurora.org>
 <20130418091019.GA21099@pengutronix.de>
 <20130506093059.GH23285@pengutronix.de>
 <20130507092209.GD25387@mudshark.cambridge.arm.com>
 <5188DDDC.1000201@arm.com>
Message-ID: <20130507124013.GM23285@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 07, 2013 at 11:56:28AM +0100, Jonathan Austin wrote:
> Hi Will,
> 
> On 07/05/13 10:22, Will Deacon wrote:
> >On Mon, May 06, 2013 at 10:30:59AM +0100, Uwe Kleine-K?nig wrote:
> 
> >>+
> >>+#define read_cpuid(reg)							\
> >>+	({								\
> >>+		WARN_ON_ONCE(1);					\
> >>+		0;							\
> >>+	})
> >
> >We do have an MIDR in PMSAv7 (not to be confused with MPIDR), so why not read
> >that here?
> We don't need to add/remove anything for PMSAv7 as that's already
> implemented...
> 
> For V7M we have something called CPUID Base Register, not MIDR - the
> layout looks the same though. That's the only one of the CPUID_X
> that we have, but it is never requested directly - only via
> read_cpuid_id (this is to support a hardcoded cpuid from kconfig) so
> what Uwe's got does work, though I agree that it'd be much nicer to
> implement the underlying function and have the accessor general for
> both AR and M.
The current state (that is next + the patch from this thread) is:

#ifdef CONFIG_CPU_CP15
	define read_cpuid and read_cpuid_ext using mrc p15
	read_cpuid_id = read_cpuid(CPUID_ID)
#elif defined (CONFIG_CPU_V7M)
	read_cpuid returns 0 (with a warning)
	read_cpuid_ext reads from SCB
	read_cpuid_id reads from V7M_SCB_CPUID
#else
	read_cpuid and read_cpuid_ext return 0 (with a warning)
	read_cpuid_id returns CONFIG_PROCESSOR_ID (a bit simplified)
#endif

Now, what is the "underlying function" that should be used to implement
which accessor? I assume you want to have

	read_cpuid_id = read_cpuid(CPUID_ID)

on v7-M, too? So what is the suggestion for read_cpuid?:

	if (reg == CPUID_ID)
		return readl(V7M_SCB_CPUID);
	else
		return 0;
	
That doesn't make much sense in my eyes. If I got you wrong, please give
more details.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
