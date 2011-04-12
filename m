From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 12 Apr 2011 21:53:44 +0100
Subject: [PATCH 4/6] ARM: mxc: don't allow to compile together i.MX51
	and i.MX53
In-Reply-To: <20110412203730.GE18850@pengutronix.de>
References: <1302464943-20721-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1302464943-20721-4-git-send-email-u.kleine-koenig@pengutronix.de>
	<alpine.LFD.2.00.1104102157440.28032@xanadu.home>
	<20110411074041.GF18601@pengutronix.de>
	<alpine.LFD.2.00.1104110944290.28032@xanadu.home>
	<20110412095446.GB18850@pengutronix.de>
	<20110412202734.GB7806@n2100.arm.linux.org.uk>
	<20110412203730.GE18850@pengutronix.de>
Message-ID: <20110412205344.GE7806@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 12, 2011 at 10:37:30PM +0200, Uwe Kleine-K?nig wrote:
> > #if !defined(CONFIG_ARM_PATCH_PHYS_VIRT)
> > #if CONFIG_ARCH_MX1 + CONFIG_MACH_MX21 + ... > 1
> > #error Invalid configuration - unable to handle different phys base addresses
> > #endif
> Same problem (and I guess it yields some cpp warnings about
> CONFIG_ARCH_MX1 not being defined for an i.MX21-only build, but I didn't
> test).

Well then,

#if (CONFIG_ARCH_MX1 | CONFIG_MACH_MX21) + (...) + ... > 1

where each group of | cover those which share the same phys base.

No idea what those are because each MX SoC hides its phys base behind
some SoC private definition.  This is definitely a case where more
preprocessor junk reduces the code readability and makes it harder to
understand.  Removal of preprocessor indirection sounds like a candidate
for the consolidation effort to me.

I think we're at the point where "no" to that is not acceptable.  Make
it happen please.  We must reduce the size of arch/arm by all means
possible.
