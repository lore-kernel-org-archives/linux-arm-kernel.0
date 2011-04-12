From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 12 Apr 2011 23:20:50 +0200
Subject: [PATCH 4/6] ARM: mxc: don't allow to compile together i.MX51
	and i.MX53
In-Reply-To: <20110412205344.GE7806@n2100.arm.linux.org.uk>
References: <1302464943-20721-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1302464943-20721-4-git-send-email-u.kleine-koenig@pengutronix.de>
	<alpine.LFD.2.00.1104102157440.28032@xanadu.home>
	<20110411074041.GF18601@pengutronix.de>
	<alpine.LFD.2.00.1104110944290.28032@xanadu.home>
	<20110412095446.GB18850@pengutronix.de>
	<20110412202734.GB7806@n2100.arm.linux.org.uk>
	<20110412203730.GE18850@pengutronix.de>
	<20110412205344.GE7806@n2100.arm.linux.org.uk>
Message-ID: <20110412212050.GF18850@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Tue, Apr 12, 2011 at 09:53:44PM +0100, Russell King - ARM Linux wrote:
> On Tue, Apr 12, 2011 at 10:37:30PM +0200, Uwe Kleine-K?nig wrote:
> > > #if !defined(CONFIG_ARM_PATCH_PHYS_VIRT)
> > > #if CONFIG_ARCH_MX1 + CONFIG_MACH_MX21 + ... > 1
> > > #error Invalid configuration - unable to handle different phys base addresses
> > > #endif
> > Same problem (and I guess it yields some cpp warnings about
> > CONFIG_ARCH_MX1 not being defined for an i.MX21-only build, but I didn't
> > test).
> 
> Well then,
> 
> #if (CONFIG_ARCH_MX1 | CONFIG_MACH_MX21) + (...) + ... > 1
> 
> where each group of | cover those which share the same phys base.
Well, the idea was to auto-catch a mismatch somehow. If I have to know
the exact groups I can better put the needed logic into mxc's Kconfig
file.
 
> No idea what those are because each MX SoC hides its phys base behind
> some SoC private definition.  This is definitely a case where more
Apart from defining PLAT_PHYS_OFFSET these symbols are used in the
machine files to define .boot_params. This is better than repeating the
bare numbers, isn't it?

> preprocessor junk reduces the code readability and makes it harder to
> understand.  Removal of preprocessor indirection sounds like a candidate
> for the consolidation effort to me.
I didn't intend to continue to try catching this error. The current
arch/arm/plat-mxc/include/mach/memory.h looks ok for me. I assume you
concur?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
