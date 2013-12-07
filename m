From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 7 Dec 2013 05:52:34 +0100
Subject: [PATCH] ARM: clean-up common multi-platform kconfig options
In-Reply-To: <CAL_JsqJmwPwVmNzibr8S-RH8ibwCzXVFMdJA-STPTHG+H0113w@mail.gmail.com>
References: <1386262722-26016-1-git-send-email-robherring2@gmail.com>
 <201312061741.33427.arnd@arndb.de>
 <CAL_JsqJmwPwVmNzibr8S-RH8ibwCzXVFMdJA-STPTHG+H0113w@mail.gmail.com>
Message-ID: <201312070552.34537.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 06 December 2013, Rob Herring wrote:
> On Fri, Dec 6, 2013 at 10:41 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> >>
> >> We should be able to boot an SMP kernel on it whether or not the
> >> platform has SMP support added, right?
> >
> > Yes, although I don't think anyone has ever tried to boot a UP_ON_SMP
> > kernel on ARMv5 or earlier. We don't allow that combination at the
> > moment, and it would be pointless.
> 
> I meant an SMP capable platform (v6K+ h/w) should boot an SMP kernel
> build whether or not that platform has added smp_ops yet.

Yes, absolutely.

> >> Practically every v6 platform selects v6K. We should probably default
> >> to V6K for ARCH_MULTI_V6 and let platforms select CPU_V6 instead if
> >> needed. I believe that will give the v6 versions of code only as
> >> needed and will give better versions of code if only v6K is selected.
> >> imx31 is one that doesn't select v6K, but only very early revs did not
> >> have v6K version of the 1136. I don't think any of those parts went
> >> into production (maybe into the original Zune?).
> >
> > Interesting, I had no idea that plain ARMv6 was this rare.
> 
> What I said is not quite right. I think the correct statement is most
> of ARM11 (1136 r1px and 1176) is v6K but without the SMP extensions.
> AFAICT, only ARM11 MPCore is full v6K. The 1136 and 1176 do have
> clrex, double/half/byte exclusives, TEX remapping, and thread ID regs,
> but do not have sev and wfe/wfi instructions. SMP_ON_UP should be
> enough to handle the sev/wfe instruction differences. So I still think
> we really want to be selecting CPU_V6K by default.

For all I can tell, sev, wfe and wfi are only used in SMP code or in
code that is specific to ARMv7 based platforms we know support it, so
no runtime SMP_ON_UP logic would be necessary at this point.

We have a number of platforms that currently select CPU_V6 but not CPU_V6K:

ARCH_S3C64XX (arm1176)
ARCH_S5P64X0 (arm1176)
ARCH_BCM2835 (arm1176)
ARCH_DAVINCI_TNETV107X (arm1176)
SOC_IMX31 (arm1136)
ARCH_MSM7X00A (arm1136r1p2)
ARCH_OMAP2 (arm1136)
MACH_REALVIEW_PB1176 (arm1176)
ARCH_WM8750 (arm1176)

According to what you say about 1136r1px and 1176, it looks like most
of them are actually wrong and should select CPU_V6K instead. MSM
is probably safe with V6K as we only support one board (trout)
and it's r1p2 according to 
http://forum.xda-developers.com/showthread.php?p=5575605.
IMX31 is ok as well according to what you said earlier, which
basically leaves OMAP2. All /proc/cpuinfo references I found for
omap are actually r0p2, r0p5 or r0p6, so those would be v6.

This should be an exhaustive list of differences between V6 and V6K
that we have in the kernel:

ARM_ERRATA_326103 -- only relevant for 1136r0, but never enabled
ARM_ERRATA_364296 -- only relevant for 1136r0, but never enabled
TLS_REG_EMUL      -- only needed for pre-V6K
CPU_USE_DOMAINS   -- only enabled for V6 but not if V6K or V7 are on
SWP_EMULATE       -- only available with !CPU_USE_DOMAINS && CPU_V7
svc_exit()	  -- emulates clrex when V6 is enabled
percpu.h          -- emulates TPIDRPRW when V6 is enabled
cmpxchg(<4byte)	  -- not available if V6 is enabled (Xen was hit by this)
cmpxchg_local     -- slow if V6 is enabled
Makefile	  -- build with -march=armv6k if building for v6k or v6+v7
		     rather than -march=armv6 for v6-only
barrier.h	  -- sev(), wfe(), wfi() are not defined for v6-only
tls.h		  -- v6 uses software, v6k uses reg, dtrt if both enabled
__kuser_cmpxchg64 -- as discussed below

>From this list it is pretty clear that we want V6K as the default as you
suggested, and I think we should eliminate any 'select CPU_V6K' except
for OMAP2 (unless I made a mistake in my platform list). Maybe Tony has
a better understanding of which OMAP2 systems are actually V6K or V6.

> > If we could show that all supported platforms are actually v6K anyway
> > and that nobody has any plans to add new ones, doing away with
> > v6 in favor of v6k would clean up a lot of confusing (i.e. possibly
> > wrong) Kconfig logic.
> >
> >> I assume we expect a v6 SMP kernel to run on a non-v6K v6 platform?
> >
> > Actually, as far as I can see:
> >
> > config SMP
> >         bool "Symmetric Multi-Processing"
> >         depends on CPU_V6K || CPU_V7
> >         depends on HAVE_SMP
> >
> > This prevents you from building a plain v6 SMP kernel, and we've
> > had a variation of that since CONFIG_SMP was first marked non-BROKEN.
> 
> I'm saying a v6k enabled kernel would not work on pure v6 h/w. But
> since all implementations appear to support doubleword exclusives and
> there may not be any pure v6 only h/w, then we may never have a
> problem with the code below.

Ok, I think I now understand what you mean: the __kuser_cmpxchg64
implementation on a pure ARMv6 CPU is broken when the kernel is built
to also support V6K or V7. I think you are right with this, but wrong
with it not being relevant on shipping hardware. We have had OMAP2+OMAP3
kernels that enable CONFIG_CPU_32v6K on a V6 CPU for a long time.

What I think happened though is that __kuser_cmpxchg64 is a function
that is used extremely rarely in real-life applications, and those
multiplatform kernels are probably used less in production than they
are in basic testing, so it was a coincidence that the problem has not
hurt anyone. All the other differences between v6 and v6k that I listed
above seem to be more relevant to the test cases that people run,
and seem to be implemented correctly in the sense that a v6+v6k
kernel just runs a little slower on v6k hardware than it could but
does work correctly.

Of course what you describe is a real bug and needs to get fixed,
plus we should probably add a test case into LTP for this if it
doesn't catch this already.

	Arnd
