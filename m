From: dinguyen@altera.com (Dinh Nguyen)
Date: Fri, 25 Jan 2013 10:24:17 -0600
Subject: [PATCHv1 for soc 4/5] arm: Add v7_invalidate_l1 to cache-v7.S
In-Reply-To: <20130125154955.GD10055@amd.pavel.ucw.cz>
References: <1359075633-13502-1-git-send-email-dinguyen@altera.com>
 <1359075633-13502-5-git-send-email-dinguyen@altera.com>
 <20130125154955.GD10055@amd.pavel.ucw.cz>
Message-ID: <1359131057.32148.9.camel@linux-builds1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pavel,
On Fri, 2013-01-25 at 16:49 +0100, Pavel Machek wrote:
> Hi!
> 
> > mach-socfpga is another platform that needs to use
> > v7_invalidate_l1 to bringup additional cores. There was a comment that
> > the ideal place for v7_invalidate_l1 should be in arm/mm/cache-v7.S
> 
> If there are three copies of code, with fourth one needed for next
> platform, moving it into common code makes sense.
> 
> But... The code was not identical before the merge. Are you sure that
> the differences do not hurt? At the very least, it should be mentioned
> in the changelog.

Indeed, the addition of 

mcr     p15, 0, r0, c7, c5, 0   @ invalidate I cache

was done by commit # 5b2acf384c8a8707d32a98106192ee7187e4446d

This adds invalidate I-Cache as well as D-Cache, which I think should be
ok for most platforms. 

Hopefully, Stephen can test and verify.

Dinh
> 
> Thanks,
> 								Pavel
> 
> > diff --git a/arch/arm/mach-imx/headsmp.S b/arch/arm/mach-imx/headsmp.S
> > index 7e49deb..921fc15 100644
> > --- a/arch/arm/mach-imx/headsmp.S
> > +++ b/arch/arm/mach-imx/headsmp.S
> > @@ -17,53 +17,6 @@
> > -ENTRY(v7_invalidate_l1)
> > -	mov	r0, #0
> > -	mcr	p15, 0, r0, c7, c5, 0	@ invalidate I cache
> > -	mcr	p15, 2, r0, c0, c0, 0
> > -	mrc	p15, 1, r0, c0, c0, 0
> ...
> > diff --git a/arch/arm/mach-tegra/headsmp.S b/arch/arm/mach-tegra/headsmp.S
> > index 4a317fa..fb082c4 100644
> > --- a/arch/arm/mach-tegra/headsmp.S
> > +++ b/arch/arm/mach-tegra/headsmp.S
> > @@ -18,49 +18,6 @@
> > -ENTRY(v7_invalidate_l1)
> > -        mov     r0, #0
> > -        mcr     p15, 2, r0, c0, c0, 0
> > -        mrc     p15, 1, r0, c0, c0, 0
> 
> [Note missing mcr p15, 0, .. line.]
> 
> 
