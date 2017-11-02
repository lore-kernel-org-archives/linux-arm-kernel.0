From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 2 Nov 2017 10:08:10 +0000
Subject: [PATCH] arm64: write_sysreg asm illegal for aarch32
In-Reply-To: <caa10a1c-b834-3a08-b425-ba8d2ca7a9b0@android.com>
References: <20171101170014.20931-1-salyzyn@android.com>
 <35cf2062-f27e-16e6-19b1-cae5200d7081@arm.com>
 <24cdf320-35e3-76f2-6e07-8b5548ac67a0@android.com>
 <20171101175642.c65f7kngixjndavr@lakrids.cambridge.arm.com>
 <ba7f7072-88e5-92ee-f573-4282b6a082d4@android.com>
 <caa10a1c-b834-3a08-b425-ba8d2ca7a9b0@android.com>
Message-ID: <20171102100810.bdpzy6f4spuqtbfz@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 01, 2017 at 01:32:50PM -0700, Mark Salyzyn wrote:
> On 11/01/2017 11:16 AM, Mark Salyzyn wrote:
> > On 11/01/2017 10:56 AM, Mark Rutland wrote:
> > > On Wed, Nov 01, 2017 at 10:49:00AM -0700, Mark Salyzyn wrote:
> > > > On 11/01/2017 10:14 AM, Robin Murphy wrote:
> > > > > On 01/11/17 16:58, Mark Salyzyn wrote:
> > > > > > Cross compiling to aarch32 (for vdso32) using clang correctly
> > > > > > identifies that (the unused) write_sysreg inline asm directive is
> > > > > > illegal in that architectural context:
> > > > > > 
> > > > > > arch/arm64/include/asm/arch_timer.h: error: invalid
> > > > > > input constraint 'rZ' in asm
> > > > > > ????????? write_sysreg(cntkctl, cntkctl_el1);
> > > > > > ????????? ^
> > > > > > arch/arm64/include/asm/sysreg.h: note: expanded from
> > > > > > macro 'write_sysreg'
> > > > > > ?????????????????????? : : "rZ" (__val));
> > > > > > ?????????????????????????? ^
> > > > > > 
> > > > > > GCC normally checks for correctness everywhere. But uniquely for
> > > > > > unused asm, will optimize out and suppress the error report.
> > > > > It sounds more like some paths are wrong in the compat vDSO build if
> > > > > it's pulling in this header in the first place - nothing in
> > > > > this file is
> > > > > relevant to AArch32.
> > > > > 
> > > > > Robin.
> > > > > 
> > > > And yet, when you CROSS_COMPILE_ARM32 a vdso32, you have no
> > > > choice but to
> > > > utilize the arm64 headers since they contain all the relevant kernel
> > > > structures and environment.
> > > This itself is the underlying issue.
> > > 
> > > When building the compat VDSO, we must ensure that we only include
> > > headers that make sense for 32-bit arm.
> > > 
> > > If the build system can't do that today, we should rework it so that it
> > > can. Anything else cannot be a complete fix.

> > Ok, will attack it and see just how bad the scale is...

> Scoped, not as bad as I thought, but there is some open-coded evilness to
> fix:
> 
> 1) linux/jiffies.h can not be included, replace with open coding:

[...]

> 2) linux/hrtimer.h can not be included, replace with open coding (must have
> above to work):

[...]

> 3) asm/processor.h can not be included, replace with open coding:

[...]

> 4) linux/time.h can not be included, replace with open coding:

[...]

Evidently I was not sufficiently clear.

I don't think that we should try to bodge the #include directives to try
to avoid including 64-bit headers. The above changes might work today,
but they're *extremely* fragile.

When I said that we should rework the build system above, I mean we
should rework the Makefile logic to pass the 32-bit include paths into
the compat vdso. That way, we can include the usual set of headers, as
we'll pick up the 32-bit headers.

We might have to have separate native/compat vdso data pages to make
sure that the types align, but that's not the end of the world...

Thanks,
Mark.
