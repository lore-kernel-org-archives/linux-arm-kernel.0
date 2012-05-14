From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Mon, 14 May 2012 17:02:59 +0100
Subject: [PATCH v4 2/2] ARM: vfp: clear fpscr length and stride bits on
 entry to sig handler
In-Reply-To: <20120514145931.GF11088@mudshark.cambridge.arm.com>
References: <1330009632-1235-1-git-send-email-will.deacon@arm.com>
 <1330009632-1235-2-git-send-email-will.deacon@arm.com>
 <1337006035.16954.21.camel@linaro1.home>
 <20120514145931.GF11088@mudshark.cambridge.arm.com>
Message-ID: <1337011379.16954.40.camel@linaro1.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-05-14 at 15:59 +0100, Will Deacon wrote:
> On Mon, May 14, 2012 at 03:33:55PM +0100, Jon Medhurst (Tixy) wrote:
> > Hi Will
> 
> Hi Jon,
> 
> > I've bisected a screen corruption problem on vexpress down to this
> > commit, I've commented at the end of the patch at to what I see the
> > problem being...
> 
> Interesting and thanks for the heads up. I've been running with this patch
> applied for ages and haven't seen any problems myself but I've also been
> running headless. What's the best way to reproduce the problem on vexpress?
> I can connect a display if required.

I'm running the Ubuntu Desktop image from Linaro's last release [1] but
with the kernel uImage replaced by one I built based on rc6 + one MMC
hack [2]. Once booted as far as the yellow wallpaper then moving the
mouse around the screen causes black streaks of pixels to be left of the
screen.

> > On Thu, 2012-02-23 at 15:07 +0000, Will Deacon wrote:
> > > @@ -574,7 +589,12 @@ int vfp_restore_user_hwstate(struct user_vfp __user *ufp,
> > >  	unsigned long fpexc;
> > >  	int err = 0;
> > >  
> > > -	vfp_flush_hwstate(thread);
> > > +	/*
> > > +	 * If VFP has been used, then disable it to avoid corrupting
> > > +	 * the new thread state.
> > > +	 */
> > > +	if (hwstate->fpexc & FPEXC_EN)
> > > +		vfp_flush_hwstate(thread);
> > >  
> > >  	/*
> > >  	 * Copy the floating point registers. There can be unused
> > 
> > If the signal handler uses VFP, will it actually cause hwstate->fpexc &
> > FPEXC_EN to be set? Won't it instead just enable the VFP in the hardware
> > registers? (It looks to me that hwstate only gets updated by
> > vfp_flush_hwstate().)
> 
> The idea is that we disable VFP in hardware (via vfp_flush_hwstate) prior to
> entering the signal handler. Then we clear hwstate->fpexc.FPEXC_EN so that
> we can detect if VFP gets used during the handler, since the exception
> handling code will set that back up if we trapon a VFP operation (see
> vfp_support_entry in vfphw.S).

I had a look at vfp_support_entry. I can see it loading the hardware
registers from the saved vfp state, but can't see where it updates the
fpexc value in the saved vfp state. (I also can't think of why it would
need to, but this is the first time I've looked Linux vfp code so there
could be lots I've missed.)

> > This certainly seems to be the case in my screen corruption situation
> > where on entry to vfp_restore_user_hwstate() "fmrx(FPEXC) & FPEXC_EN"
> > is true and "hwstate->fpexc & FPEXC_EN" is false.
> 
> That sounds wrong to me. Out of interest, can you try this patch please?:
> 
> http://git.kernel.org/?p=linux/kernel/git/will/linux.git;a=commit;h=468c963e0210bf8108b17cf75066f25f39cabb56
> 
> Of course, if you're not running with CONFIG_PREEMPT, that shouldn't make a
> difference.

I'm not, and it didn't. :-)

-- 
Tixy

[1] http://releases.linaro.org/12.04/ubuntu/vexpress/
[2] http://git.linaro.org/gitweb?p=people/tixy/kernel.git;a=shortlog;h=refs/heads/vfp-regs-bug
