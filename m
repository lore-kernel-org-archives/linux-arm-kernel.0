From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 22 Jun 2018 10:23:05 +0100
Subject: [PATCH] [RFC] arm: Replace "multiple platforms" by "common
 platform"
In-Reply-To: <20180621155906.12821-1-geert+renesas@glider.be>
References: <20180621155906.12821-1-geert+renesas@glider.be>
Message-ID: <20180622092305.GS17671@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 21, 2018 at 05:59:06PM +0200, Geert Uytterhoeven wrote:
> "ARM multiplatform" has actually two meanings:
> ? 1. It groups platforms that follow the "ARM multiplatform" software
>      framework,
> ? 2. It allows to build a single kernel that can be booted on multiple
> ? ? ?platforms.
> 
> Currently support for XIP and/or NOMMU cannot be enabled on platforms
> that follow the "ARM multiplatform" framework, without duplicating their
> machine selection logic under a new Kconfig symbol.  As (in theory) all
> platforms can be used with XIP and/or NOMMU, this is not sustainable.

The reason for that has nothing to do with the way this option is named,
and even after reading your commit message, I can't come up with any
reason for this change other than "personally don't like the existing
wording" which IMHO is not a good enough reason to randomly go around
rewording stuff in the kernel.

The reason that XIP and NOMMU can't be enabled with a multi-platform
kernel is that there are often issues with different layouts of the
physical memory space which can not be taken into account.

Multi-platform works around that by (a) using the MMU to abstract
away the differences on RAM, and (b) modifying the kernel text to
adjust the virtual to physical translations.  The latter is not
possible with XIP, and the former should not be used with NOMMU.
That means the kernel must be built to accomodate the physical
layout on the target platform, and so building a kernel supporting
multiple platforms with differing memory layouts makes no sense.

This is exactly why I really don't like the idea of ARCH_MULTIPLATFORM
being hijacked for NOMMU/XIP support.

We've worked around the issues with "multi-platform" XIP/NOMMU by
using things such as "ARM_SINGLE_V7M" to cover all V7M platforms
(which must, by definition) have compatible physical layouts.
Exactly the same approach should be adopted for other XIP/NOMMU
platforms, and _not_ reusing ARCH_MULTIPLATFORM, which will lead
to lots of non-bootable kernels.

Another problems for NOMMU is that the kernel has to be linked for
a specific _physical_ address.  When you have ARCH_MULTIPLATFORM
enabled, there is no facility to select that address.

Sorry, but reusing ARCH_MULTIPLATFORM is really a non-starter and
is confusing.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
