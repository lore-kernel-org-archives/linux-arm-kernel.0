From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 12 Apr 2011 21:27:34 +0100
Subject: [PATCH 4/6] ARM: mxc: don't allow to compile together i.MX51
	and i.MX53
In-Reply-To: <20110412095446.GB18850@pengutronix.de>
References: <1302464943-20721-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1302464943-20721-4-git-send-email-u.kleine-koenig@pengutronix.de>
	<alpine.LFD.2.00.1104102157440.28032@xanadu.home>
	<20110411074041.GF18601@pengutronix.de>
	<alpine.LFD.2.00.1104110944290.28032@xanadu.home>
	<20110412095446.GB18850@pengutronix.de>
Message-ID: <20110412202734.GB7806@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 12, 2011 at 11:54:46AM +0200, Uwe Kleine-K?nig wrote:
> #if !defined(CONFIG_ARM_PATCH_PHYS_VIRT)
> # if defined CONFIG_ARCH_MX1
> #  define PLAT_PHYS_OFFSET              MX1_PHYS_OFFSET
> # endif
> # if defined CONFIG_MACH_MX21 && (!defined(PLAT_PHYS_OFFSET) || PLAT_PHYS_OFFSET != MX21_PHYS_OFFSET)
> #  define PLAT_PHYS_OFFSET              MX21_PHYS_OFFSET
> # endif
> # if defined CONFIG_ARCH_MX25 && (!defined(PLAT_PHYS_OFFSET) || PLAT_PHYS_OFFSET != MX25_PHYS_OFFSET)
> #  define PLAT_PHYS_OFFSET              MX25_PHYS_OFFSET
> # endif

And what's wrong with:

#if !defined(CONFIG_ARM_PATCH_PHYS_VIRT)
#ifdef CONFIG_ARCH_MX1
#ifdef PLAT_PHYS_OFFSET
#error Invalid configuration - PLAT_PHYS_OFFSET already defined
#endif
#define PLAT_PHYS_OFFSET MX1_PHYS_OFFSET
#endif

#ifdef CONFIG_MACH_MX21
#ifdef PLAT_PHYS_OFFSET
#error Invalid configuration - PLAT_PHYS_OFFSET already defined
#endif
#define PLAT_PHYS_OFFSET MX21_PHYS_OFFSET
#endif
...
#endif

?

Or this _may_ work:

#if !defined(CONFIG_ARM_PATCH_PHYS_VIRT)
#if CONFIG_ARCH_MX1 + CONFIG_MACH_MX21 + ... > 1
#error Invalid configuration - unable to handle different phys base addresses
#endif
...
#endif
