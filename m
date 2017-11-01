From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 1 Nov 2017 17:56:43 +0000
Subject: [PATCH] arm64: write_sysreg asm illegal for aarch32
In-Reply-To: <24cdf320-35e3-76f2-6e07-8b5548ac67a0@android.com>
References: <20171101170014.20931-1-salyzyn@android.com>
 <35cf2062-f27e-16e6-19b1-cae5200d7081@arm.com>
 <24cdf320-35e3-76f2-6e07-8b5548ac67a0@android.com>
Message-ID: <20171101175642.c65f7kngixjndavr@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 01, 2017 at 10:49:00AM -0700, Mark Salyzyn wrote:
> On 11/01/2017 10:14 AM, Robin Murphy wrote:
> > On 01/11/17 16:58, Mark Salyzyn wrote:
> > > Cross compiling to aarch32 (for vdso32) using clang correctly
> > > identifies that (the unused) write_sysreg inline asm directive is
> > > illegal in that architectural context:
> > > 
> > > arch/arm64/include/asm/arch_timer.h: error: invalid input constraint 'rZ' in asm
> > >          write_sysreg(cntkctl, cntkctl_el1);
> > >          ^
> > > arch/arm64/include/asm/sysreg.h: note: expanded from macro 'write_sysreg'
> > >                       : : "rZ" (__val));
> > >                           ^
> > > 
> > > GCC normally checks for correctness everywhere. But uniquely for
> > > unused asm, will optimize out and suppress the error report.
> > It sounds more like some paths are wrong in the compat vDSO build if
> > it's pulling in this header in the first place - nothing in this file is
> > relevant to AArch32.
> > 
> > Robin.
> > 
> And yet, when you CROSS_COMPILE_ARM32 a vdso32, you have no choice but to
> utilize the arm64 headers since they contain all the relevant kernel
> structures and environment.

This itself is the underlying issue.

When building the compat VDSO, we must ensure that we only include
headers that make sense for 32-bit arm.

If the build system can't do that today, we should rework it so that it
can. Anything else cannot be a complete fix.

> asm/arch_timer.h (remember we are using arm instructions to access arch64
> timers)
> 
> linux/time.h (really only for struct timespec())
> 
> asm/processor.h (eg: cpu_relax())
> 
> pull in a _lot_ of architectural related cruft that always somehow picks up
> asm/sysreg.h somewhere in the multitude of includes to fulfill some unused
> inline's needs.

... these are just the particular symptoms this problem results in
today.

Thanks,
Mark.
