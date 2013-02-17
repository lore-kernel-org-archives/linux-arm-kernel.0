From: will.deacon@arm.com (Will Deacon)
Date: Sun, 17 Feb 2013 19:18:17 +0000
Subject: mx28evk does not boot with linux-next 20130207
In-Reply-To: <20130216175613.GP17833@n2100.arm.linux.org.uk>
References: <CAOMZO5Ar1T3Lg2KRvSLK-gjNAaAFAf39f6KqaYeF03w5bNj6EQ@mail.gmail.com>
 <20130207125801.GA19091@S2101-09.ap.freescale.net>
 <CAOMZO5D5ipAF0JOUOFezGz4Zr66M4bRm819ZurAfwPOrduBo5w@mail.gmail.com>
 <20130208161811.GW17833@n2100.arm.linux.org.uk>
 <20130208164858.GA32318@mudshark.cambridge.arm.com>
 <CAOMZO5CbJfpVwqHM1RSYdEQH4n1EL67Kt2_tC9TNPxZGMsPevQ@mail.gmail.com>
 <CAOMZO5DxcrSRgvjzHUHgHTfqeUL772KrUWk4vgcMrAoje=g-7A@mail.gmail.com>
 <20130216175613.GP17833@n2100.arm.linux.org.uk>
Message-ID: <20130217191817.GA18277@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 16, 2013 at 05:56:13PM +0000, Russell King - ARM Linux wrote:
> On Sat, Feb 16, 2013 at 03:41:53PM -0200, Fabio Estevam wrote:
> > Hi Will,

Hello,

> > On Fri, Feb 8, 2013 at 3:14 PM, Fabio Estevam <festevam@gmail.com> wrote:
> > Do you plan to submit this patch to Russell's patch system?
> 
> No, I've suggested to Will that we deal with the branch predictor a
> different way, because we actually rarely need to flush it.  Plus,
> these patches are architecturally wrong (you're not allowed to branch
> between the BP maintanence instruction and the following isb/dsb
> instructions because the branches become "unpredictable".

I think the branches are actually ok, because the code in question (that is,
the kernel code dispatching to and performing the flush) is mapped
identically before and after the page table switch.

> Plus, we _used_ to flush the BP here, and I did an amount of work to
> remove the flushing because it just wasn't necessary - all the paths
> at that time just didn't require it.

This is the killer argument. We don't need the maintenance except in a few,
tiny places. I've written some patches for that and I'll post them to the
list in due course, aiming for 3.10.

> What we have ended up with today is a couple of paths which do, both
> of which are arch-specific code, and we should deal with that in an
> arch specific way.  Will has been working on a patch to do that...

Yup. I've also been looking at TLB invalidation as a whole and some
optimisations we can do on ARMv7 where we don't *actually* need to use the
inner-shareable variants. Non-shareable often suffices and is a win in terms
of both performance and power (it makes the deferred flushing on ASID
rollover usable by v7 too). Again, I've been hacking in this area so I'll
post patches for review once I've got a coherent story.

> In the mean time, I'm dropping 5d9e3f9d7fcd7d09feb5d23974768a60bcea4094
> which added the BP maintanence (I actually said to Will that I'd already
> done this but it appears not.)

Thanks Russell.

Will
