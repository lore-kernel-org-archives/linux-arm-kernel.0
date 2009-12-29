From: jamie@jamieiles.com (Jamie Iles)
Date: Tue, 29 Dec 2009 16:32:52 +0000
Subject: Perf Event support for ARMv7 (was: Re: [PATCH 5/5]
	arm/perfevents: implement perf event support for ARMv6)
In-Reply-To: <200912291452.16856.jpihet@mvista.com>
References: <1260875712-29712-1-git-send-email-jamie.iles@picochip.com>
	<200912221751.39662.jpihet@mvista.com>
	<20091228075748.GC20039@elte.hu>
	<200912291452.16856.jpihet@mvista.com>
Message-ID: <20091229163252.GA12409@gallagher>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean,

On Tue, Dec 29, 2009 at 02:52:16PM +0100, Jean Pihet wrote:
> Ingo, Jamie,
> 
> On Monday 28 December 2009 08:57:48 Ingo Molnar wrote:
> > * Jean Pihet <jpihet@mvista.com> wrote:
> > > The code is for review, it has been checked, compiled and boot tested on
> > > OMAP3 (Cortex-A8). Unfortunately I am still facing some cross compilation
> > > problems of the tools/perf utility.
> >
> > Have you managed to solve these cross-compilation problems? If yes, it
> > would be nice to merge the fixes into upstream perf.
> Yes I got them resolved but I needed to make a few changes:
> - -Werror removed from the CFLAGS definition in tools/perf/Makefile. Without 
> the change the compilation stops after a warning about include paths.
I've found that for the embedded platform I'm working on I need to build with
NO_LIBPERL=1 otherwise the local include paths are used for perl. Obviously
perl scripting will not be available.
> - the rmb() macro in tools/perf/perf.h prevents the compilation. I changed it 
> to the definition from arch/arm/include/asm/system.h (asm 
> volatile("":::"memory")). Where is the original definition from? Why is it 
> specific to perf_events?
I took this definition of rmb() from arch/arm/kernel/entry-armv.S. This gives
a CPU independent way of a real memory barrier. This compiles with the latest
codesourcery toolchain and 2009q1.

[snip]
> I tested the ARMv7 code on the Cortex-A8 processor. The code looks fine but 
> when I load the CPU I am running into spinlock recursion problems (in 
> perf_ctx_adjust_freq).
> Does those problem happen on ARMv6 as well?
I haven't seen this on ARMv6 but perhaps I've been getting lucky...

Jamie
