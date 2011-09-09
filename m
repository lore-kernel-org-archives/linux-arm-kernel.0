From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 9 Sep 2011 19:47:08 +0100
Subject: [PATCH 6/6] arm/imx6q: add suspend/resume support
In-Reply-To: <20110909101509.GG31581@S2100-06.ap.freescale.net>
References: <1315303120-24203-1-git-send-email-shawn.guo@linaro.org>
	<1315303120-24203-7-git-send-email-shawn.guo@linaro.org>
	<CAGsJ_4x6cUWey=jCxY-LaazxB=WCRAH0tFsKdpJHgy=iMFkjuw@mail.gmail.com>
	<20110908062301.GK8148@S2100-06.ap.freescale.net>
	<20110908074718.GA14953@n2100.arm.linux.org.uk>
	<20110908152222.GA31581@S2100-06.ap.freescale.net>
	<20110908162452.GA20292@n2100.arm.linux.org.uk>
	<20110909073247.GD31581@S2100-06.ap.freescale.net>
	<20110909081520.GE14953@n2100.arm.linux.org.uk>
	<20110909101509.GG31581@S2100-06.ap.freescale.net>
Message-ID: <20110909184708.GA14403@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 09, 2011 at 06:15:10PM +0800, Shawn Guo wrote:
> On Fri, Sep 09, 2011 at 09:15:20AM +0100, Russell King - ARM Linux wrote:
> > On Fri, Sep 09, 2011 at 03:32:48PM +0800, Shawn Guo wrote:
> > > > Now to the physical act of enabling the L2 cache.  The L2 cache control
> > > > registers are subject to security restrictions when running in non-secure
> > > > mode, needing platform specific SMC calls to reprogram the cache.  Generic
> > > > code is unable to do this.
> > >
> > > I could be very possibly wrong here.  But isn't the core in secure mode
> > > upon reset?  Do we really have to reprogram L2 through SMC calls there?
> > 
> > It probably will be, but the core won't be running the resume function
> > directly on reset.  (No ARM CPU does this - not even the pre-security
> > ones.  They've traditionally run the boot loader first.)
> 
> Some naive boot ROM may simply jump to the resume entry address saved
> in persistent register.

That would mean that the platform code needs to deal with this too - and
it's likely that it too is platform specific.

> Then the question is that for given bad boot ROM, whether kernel resume
> routine should stand up to fill the hole up.

That can only be done with knowledge of the platform (eg, where the
secure mode vectors should be pointed) and so can't be dealt with by
generic code.

I would also imagine that it's also far easier to sort out before we
enable the MMU, rather than dealing with the aftermath of having pulled
secure mode entries from the non-secure world into the caches.
