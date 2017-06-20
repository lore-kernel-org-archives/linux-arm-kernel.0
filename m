From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 20 Jun 2017 11:59:38 +0100
Subject: [PATCH] compiler, clang: Add always_inline attribute to inline
In-Reply-To: <f8ee882e9859f24dac24832bfb5ae0f1@codeaurora.org>
References: <20170615155440.GC26471@leverpostej>
 <1497887596-8731-1-git-send-email-psodagud@codeaurora.org>
 <alpine.DEB.2.10.1706191322590.95967@chino.kir.corp.google.com>
 <47bd7df20466d5f7f557ca087b0189cf@codeaurora.org>
 <alpine.DEB.2.10.1706191439090.2360@chino.kir.corp.google.com>
 <f8ee882e9859f24dac24832bfb5ae0f1@codeaurora.org>
Message-ID: <20170620105937.GD28157@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 19, 2017 at 03:19:27PM -0700, Sodagudi Prasad wrote:
> On 2017-06-19 14:42, David Rientjes wrote:
> >Yes, the arch/arm64/include/asm/cmpxchg.h instance appears to need
> >__always_inline as several other functions need __always_inline in
> >arch/arm64/include/*.  It's worth making that change as you
> >suggested in
> >your original patch.
> >
> >The concern, however, is inlining all "inline" functions
> >forcefully.  The
> >only reason this is done for gcc is because of suboptimal inlining
> >decisions in gcc < 4.
> >
> >So the question is whether this is a single instance that can be fixed
> >where clang un-inlining causes problems or whether that instance
> >suggests
> >all possible inline usage for clang absolutely requires __always_inline
> >due to a suboptimal compiler implementation.  I would suggest the
> >former.
> 
> Hi David,
> 
>  I am not 100% sure about the best approach for this problem. We may
> have to
> replace inline with always_inline for all inline functions where
> BUILD_BUG() used.
> 
> So far inline as always_inline for ARM64, if we do not continue same
> settings,
> will there not be any performance differences?
> 
> Hi Will and Mark,
> 
> Please suggest the best solution to this problem. Currently
> __xchg_mb is only having issue
> based on compiler -inline-threshold configuration. But there are
> many other instances
> in arch/arm64/* where BUILD_BUG() used for inline functions and
> which may fail later.

As with my reply to David, my preference would be that we:

1) Align compiler-clang.h with the compiler-gcc.h inlining behaviour, so
   that things work by default.

2) Fix up the arm64 core code (and drivers for architected / common
   peripherals) to use __always_inline where we always require inlining.

3) Have arm64 select CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING, and have
   people test-build configurations with CONFIG_OPTIMIZE_INLINING, with
   both GCC and clang.

4) Fix up drivers, etc, as appropriate.

5) Once that's largely stable, and if there's a benefit, have arm64
   select CONFIG_OPTIMIZE_INLINING by default.

That should avoid undue breakage, while enabling this ASAP.

Thanks,
Mark.
