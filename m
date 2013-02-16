From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 16 Feb 2013 17:56:13 +0000
Subject: mx28evk does not boot with linux-next 20130207
In-Reply-To: <CAOMZO5DxcrSRgvjzHUHgHTfqeUL772KrUWk4vgcMrAoje=g-7A@mail.gmail.com>
References: <CAOMZO5Ar1T3Lg2KRvSLK-gjNAaAFAf39f6KqaYeF03w5bNj6EQ@mail.gmail.com>
 <20130207125801.GA19091@S2101-09.ap.freescale.net>
 <CAOMZO5D5ipAF0JOUOFezGz4Zr66M4bRm819ZurAfwPOrduBo5w@mail.gmail.com>
 <20130208161811.GW17833@n2100.arm.linux.org.uk>
 <20130208164858.GA32318@mudshark.cambridge.arm.com>
 <CAOMZO5CbJfpVwqHM1RSYdEQH4n1EL67Kt2_tC9TNPxZGMsPevQ@mail.gmail.com>
 <CAOMZO5DxcrSRgvjzHUHgHTfqeUL772KrUWk4vgcMrAoje=g-7A@mail.gmail.com>
Message-ID: <20130216175613.GP17833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 16, 2013 at 03:41:53PM -0200, Fabio Estevam wrote:
> Hi Will,
> 
> On Fri, Feb 8, 2013 at 3:14 PM, Fabio Estevam <festevam@gmail.com> wrote:
> > On Fri, Feb 8, 2013 at 2:48 PM, Will Deacon <will.deacon@arm.com> wrote:
> >
> >> From dc381a5dff9663901a61fe0dd86c986add382281 Mon Sep 17 00:00:00 2001
> >> From: Will Deacon <will.deacon@arm.com>
> >> Date: Fri, 8 Feb 2013 16:41:19 +0000
> >> Subject: [PATCH] ARM: tlb: fix branch predictor maintenance for ARMv6
> >>
> >> The BPIALL operation is not available on all CPUs, so ensure that we
> >> only execute it on processors implementing the instruction.
> >>
> >> Reported-by: Fabio Estevam <festevam@gmail.com>
> >> Signed-off-by: Will Deacon <will.deacon@arm.com>
> >
> > Thanks, Will.
> >
> > This makes the kernel to boot again on my mx28evk, so:
> >
> > Tested-by: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Do you plan to submit this patch to Russell's patch system?

No, I've suggested to Will that we deal with the branch predictor a
different way, because we actually rarely need to flush it.  Plus,
these patches are architecturally wrong (you're not allowed to branch
between the BP maintanence instruction and the following isb/dsb
instructions because the branches become "unpredictable".

Plus, we _used_ to flush the BP here, and I did an amount of work to
remove the flushing because it just wasn't necessary - all the paths
at that time just didn't require it.

What we have ended up with today is a couple of paths which do, both
of which are arch-specific code, and we should deal with that in an
arch specific way.  Will has been working on a patch to do that...

In the mean time, I'm dropping 5d9e3f9d7fcd7d09feb5d23974768a60bcea4094
which added the BP maintanence (I actually said to Will that I'd already
done this but it appears not.)
