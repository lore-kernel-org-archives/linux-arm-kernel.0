From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 2 Jul 2014 15:26:21 +0100
Subject: [PATCH v2] ARM: save/restore diagnostic register on Cortex-A9
 suspend/resume
In-Reply-To: <20140702140134.GA21091@e102568-lin.cambridge.arm.com>
References: <1403432119-1409-1-git-send-email-shawn.guo@freescale.com>
 <53A9A746.6080200@samsung.com> <20140624163320.GM9121@arm.com>
 <53A9B80B.7020608@samsung.com>
 <20140701144417.GV32514@n2100.arm.linux.org.uk>
 <53B2E11D.5000507@samsung.com> <20140702123444.GB24879@arm.com>
 <20140702140134.GA21091@e102568-lin.cambridge.arm.com>
Message-ID: <20140702142620.GJ32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 02, 2014 at 03:01:34PM +0100, Lorenzo Pieralisi wrote:
> On Wed, Jul 02, 2014 at 01:34:44PM +0100, Will Deacon wrote:
> > Does anybody have any ideas? We could try `handling' the undef, but it's
> > ugly and fragile.
> 
> You could try to treat it the same way as ACTLR (see cpu_v7_do_resume,
> where the ACTLR is first read, if it is already set, ie equal to the
> saved value, skip the write); ACTLR suffers from the same issue and IIRC
> that's why Russell added the "teq" then "write" test at the time
> cpu_suspend was consolidated.

We can't do that now for these, because if they were already correct,
then by definition we wouldn't need to restore them except on secure
parts.

>From the comments that have been made on the subject of these registers,
it is already the case that non-secure platforms don't restore this
register, instead relying on the platform to jump through hoops to
update it _after_ the MMU has been enabled.

Will Deacon raised a point when I discussed this that once the MMU is
enabled, the hardware doesn't expect the diagnostic register to be
changed.  So, having platform code (which runs after the MMU has been
enabled) sounds dodgy to me.

Of course, prior to DT and single zImage, this wouldn't be that big
a deal, we _could_ work around it via the kernel config or similar,
insisting that we have a secure and a non-secure build mode.  We don't
have that "luxury" anymore though.

What this all means is that we can't even augment the suspend/resume
paths to deal with this register even for secure mode parts.

I, too, don't know what the answer is here.  This is really a totally
fubar'd situation where there is no solution which will work for
everyone.

I guess what this ultimately comes down to is that we _did_ accept the
work-arounds into the kernel source for secure parts - had we not done
that and set a clear message like ARM64 does that work-arounds must be
done prior to calling the kernel (irrespective of how that happens,
iow, whether boot or resume) then we wouldn't have this problem right
now.  Such a statement would have raised lots of objections though, but
with hindsight, it would have been the right thing to do to overrule
those objections and just mandate it.  It would've been a pain for some
people, but we would not be in this situation now where there is no
proper solution which works for everyone.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
