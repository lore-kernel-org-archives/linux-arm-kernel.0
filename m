From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 4 Jul 2014 11:31:38 +0800
Subject: [PATCH v2] ARM: save/restore diagnostic register on Cortex-A9
 suspend/resume
In-Reply-To: <20140702142620.GJ32514@n2100.arm.linux.org.uk>
References: <1403432119-1409-1-git-send-email-shawn.guo@freescale.com>
 <53A9A746.6080200@samsung.com> <20140624163320.GM9121@arm.com>
 <53A9B80B.7020608@samsung.com>
 <20140701144417.GV32514@n2100.arm.linux.org.uk>
 <53B2E11D.5000507@samsung.com> <20140702123444.GB24879@arm.com>
 <20140702140134.GA21091@e102568-lin.cambridge.arm.com>
 <20140702142620.GJ32514@n2100.arm.linux.org.uk>
Message-ID: <20140704033137.GB1970@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 02, 2014 at 03:26:21PM +0100, Russell King - ARM Linux wrote:
> On Wed, Jul 02, 2014 at 03:01:34PM +0100, Lorenzo Pieralisi wrote:
> > On Wed, Jul 02, 2014 at 01:34:44PM +0100, Will Deacon wrote:
> > > Does anybody have any ideas? We could try `handling' the undef, but it's
> > > ugly and fragile.
> > 
> > You could try to treat it the same way as ACTLR (see cpu_v7_do_resume,
> > where the ACTLR is first read, if it is already set, ie equal to the
> > saved value, skip the write); ACTLR suffers from the same issue and IIRC
> > that's why Russell added the "teq" then "write" test at the time
> > cpu_suspend was consolidated.
> 
> We can't do that now for these, because if they were already correct,
> then by definition we wouldn't need to restore them except on secure
> parts.
> 
> From the comments that have been made on the subject of these registers,
> it is already the case that non-secure platforms don't restore this
> register, instead relying on the platform to jump through hoops to
> update it _after_ the MMU has been enabled.
> 
> Will Deacon raised a point when I discussed this that once the MMU is
> enabled, the hardware doesn't expect the diagnostic register to be
> changed.  So, having platform code (which runs after the MMU has been
> enabled) sounds dodgy to me.

Though it sounds dodgy, restoring the registers at platform level is the
only choice we have now to get the workaround effectiveness back, due to
this secure vs. non-secure pain.  Also it seems Exynos has been doing
this for years (see exynos_cpu_restore_register()).

Shawn
