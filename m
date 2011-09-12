From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 12 Sep 2011 13:41:41 +0800
Subject: [PATCH v2 0/2] make reinitialization of ARM core components
	possible
In-Reply-To: <4E65B71E.6060307@ti.com>
References: <1315288107-14689-1-git-send-email-shawn.guo@linaro.org>
	<4E65B71E.6060307@ti.com>
Message-ID: <20110912054140.GE1258@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 06, 2011 at 11:31:02AM +0530, Santosh wrote:
> On Tuesday 06 September 2011 11:18 AM, Shawn Guo wrote:
> >When ARM core resumes from low-power mode where losing power, for my
> >example: CA-9 MPCore resumes from Dormant/Shutdown, we have to
> >reinitialize components like L2 Cache, GIC and SCU to bring system
> >back to work.
> >
> I think you mean to drop GIC from above as well.
> 
> >The patch set basically removes __init annotation from a bunch of
> >initialization functions, so that platform resume procedure can call
> >into them again to set those components up.
> >
> >Changes since v1:
> >  * Drop the GIC patch, as it's been handled by [1] nicely.
> >  * Drop the change of adding empty l2x0_of_init(), as it's been
> >    handled by [2].
> >
> >Shawn Guo (2):
> >       ARM: cache-l2x0: remove __init annotation from initialization functions
> Do you really need to do a re-init function for L2.
> Look at the OMAP code, You just need to restore the configuration
> registers and that's it. And the save can be done only once because
> these are configuration register which won't change in the live system.
> 
OMAP and IMX6Q retains L2 cache, we have to go save/restore approach
to work with generic cpu_suspend/resume routines.  But for platforms
that will power off L2 during suspend, I think re-init is the easiest
way for them get L2 back to work.

> >       ARM: smp_scu: remove __init annotation from scu_enable()
> >
> This init is really small one so should be ok but I still feel a
> simple register restore is better.
> 
Obviously, some people would disagree that.  We can see that function
exynos4_scu_enable() found in arch/arm/mach-exynos4/pm.c is a direct
copy of scu_enable().  We can save code duplication in platforms by
simply remove the __init annotation from scu_enable().

-- 
Regards,
Shawn
