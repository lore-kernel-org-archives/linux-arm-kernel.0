From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 15 Sep 2011 09:32:48 +0100
Subject: [PATCH v2 1/2] ARM: cache-l2x0: remove __init annotation from
	initialization functions
In-Reply-To: <20110915013937.GE1488@S2100-06.ap.freescale.net>
References: <1315288107-14689-1-git-send-email-shawn.guo@linaro.org>
	<1315288107-14689-2-git-send-email-shawn.guo@linaro.org>
	<20110914084237.GC6267@n2100.arm.linux.org.uk>
	<20110915013937.GE1488@S2100-06.ap.freescale.net>
Message-ID: <20110915083248.GG6267@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 15, 2011 at 09:39:39AM +0800, Shawn Guo wrote:
> On Wed, Sep 14, 2011 at 09:42:38AM +0100, Russell King - ARM Linux wrote:
> > I'm unconvinced about the wise-ness of this.  We read-modify-write the
> > auxillary control register, which means some bits are preserved from
> > the initial boot.  If the boot loader sets the L2 cache up for normal
> > boot and not for resume, we'll end up with different L2 cache settings.
> > 
> > We've historically seen this kind of thing with boot loaders over the
> > years, to the point where systems boot at one CPU clock rate but resume
> > at some other CPU clock rate.
> > 
> I would think this is a problem in the kernel.  Kernel initialization
> code should put all these stuff into a known state to ensure boot and
> resume of the kernel do not result in a different state, shouldn't it?

grep the kernel for l2x0_init() and look at the mask and value registers.
Note that any bit set in the mask is preserved from boot time.
