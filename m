From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sun, 4 Feb 2018 10:39:33 +0000
Subject: [PATCH v4 0/6] 32bit ARM branch predictor hardening
In-Reply-To: <47d908e3-dc59-cc83-bf29-b97301fe0fb0@gmail.com>
References: <20180201110738.5421-1-marc.zyngier@arm.com>
 <47d908e3-dc59-cc83-bf29-b97301fe0fb0@gmail.com>
Message-ID: <20180204103933.2f29383b@why.wild-wind.fr.eu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 3 Feb 2018 18:51:49 -0800
Florian Fainelli <f.fainelli@gmail.com> wrote:

Hi Florian,

> Hi Marc,
> 
> On 02/01/2018 03:07 AM, Marc Zyngier wrote:
> > This small series implements some basic BP hardening by invalidating
> > the BTB on 32bit ARM CPUs that are known to be susceptible to aliasing
> > attacks (Spectre variant 2). It doesn't help non-ARM 32bit CPUs, nor
> > 32bit kernels that run on 64bit capable CPUs. This series doesn't
> > mitigate Spectre variant 1 either.
> > 
> > These patches are closely modelled against what we do on arm64,
> > although simpler as we can rely on an architected instruction to
> > perform the invalidation. The notable exception is Cortex-A15, where
> > BTB invalidation behaves like a NOP, and the only way to shoot the
> > predictor down is to invalidate the icache *and* to have ACTLR[0] set
> > to 1 (which is a secure-only operation).
> > 
> > The first patch reuses the Cortex-A8 BTB invalidation in switch_mm and
> > generalises it to be used on all affected CPUs. The second perform the
> > same invalidation on prefetch abort outside of the userspace
> > range. The third one nukes it on guest exit, and results in some major
> > surgery as we cannot take a branch from the vectors (that, and Thumb2
> > being a massive pain).
> > 
> > Patches 4 to 6 are doing a similar thing for Cortex-A15, with the
> > aforementioned ICIALLU.  
> 
> I have not had a chance to integrate those patches into the different
> downstream branches that we maintain, including upstream, but that's the
> plan for next week, because there is nothing else besides spectre &
> meltdown anyway right now :)
> 
> I would still like to pursue the RFC patch posted to your v3 where the
> kernel, if running in secure PL1 tries to set ACTLR[0], except maybe, I
> won't try to be too smart and detect the 3 states (firmware set, kernel
> set, not set) and just check whether it is set, and if not *and*
> HARDEN_BRANCH_PREDICTOR is enabled, then issue a warning?

Sure. That's pretty much orthogonal to this series, so feel free to go
ahead. Please also consider Cortex-A8 when it comes to checking the
ACTLR configuration.

Thanks,

	M.
-- 
Without deviation from the norm, progress is not possible.
