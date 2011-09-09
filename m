From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 9 Sep 2011 18:15:10 +0800
Subject: [PATCH 6/6] arm/imx6q: add suspend/resume support
In-Reply-To: <20110909081520.GE14953@n2100.arm.linux.org.uk>
References: <1315303120-24203-1-git-send-email-shawn.guo@linaro.org>
	<1315303120-24203-7-git-send-email-shawn.guo@linaro.org>
	<CAGsJ_4x6cUWey=jCxY-LaazxB=WCRAH0tFsKdpJHgy=iMFkjuw@mail.gmail.com>
	<20110908062301.GK8148@S2100-06.ap.freescale.net>
	<20110908074718.GA14953@n2100.arm.linux.org.uk>
	<20110908152222.GA31581@S2100-06.ap.freescale.net>
	<20110908162452.GA20292@n2100.arm.linux.org.uk>
	<20110909073247.GD31581@S2100-06.ap.freescale.net>
	<20110909081520.GE14953@n2100.arm.linux.org.uk>
Message-ID: <20110909101509.GG31581@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 09, 2011 at 09:15:20AM +0100, Russell King - ARM Linux wrote:
> On Fri, Sep 09, 2011 at 03:32:48PM +0800, Shawn Guo wrote:
> > > Now to the physical act of enabling the L2 cache.  The L2 cache control
> > > registers are subject to security restrictions when running in non-secure
> > > mode, needing platform specific SMC calls to reprogram the cache.  Generic
> > > code is unable to do this.
> >
> > I could be very possibly wrong here.  But isn't the core in secure mode
> > upon reset?  Do we really have to reprogram L2 through SMC calls there?
> 
> It probably will be, but the core won't be running the resume function
> directly on reset.  (No ARM CPU does this - not even the pre-security
> ones.  They've traditionally run the boot loader first.)
> 
Some naive boot ROM may simply jump to the resume entry address saved
in persistent register.

> Take a moment to think about this in terms of security of data stored on
> the secure side (where there maybe private keys stored.)
> 
> The kernel runs in the non-secure side of the partition.  If it were to be
> entered on resume in secure mode, it could access those keys.  That would
> be a really great security hole, which would make the whole thing pointless.
> 
> What would happen is the secure monitor ROM code gets control first, just
> like it does at normal boot time on secure devices.  Eventually, the kernel
> will gain control but only after the secure monitor has switched to
> non-secure mode.
> 
Then the question is that for given bad boot ROM, whether kernel resume
routine should stand up to fill the hole up.

-- 
Regards,
Shawn
