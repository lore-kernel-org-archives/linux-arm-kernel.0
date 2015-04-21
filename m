From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 21 Apr 2015 12:41:45 +0100
Subject: Standard/common method for booting secondary cores
In-Reply-To: <553580F7.7040903@free.fr>
References: <553580F7.7040903@free.fr>
Message-ID: <20150421113914.GA3638@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 21, 2015 at 12:43:03AM +0200, Mason wrote:
> Hello,
> 
> With the current push for CONFIG_ARCH_MULTIPLATFORM,
> I'm wondering if things like starting secondary cores
> have been "standardized"/factorized to the point where
> I can just use some default implementation?
> 
> I think the implementation I'm using as a starting
> point uses SMC calls. I think we are using "TrustZone"
> where Linux runs in NS (non secure) mode, and a tiny
> proprietary OS runs in secure mode.

_If_ you're implementing something new and have a say in what gets
implemented in the firmware, please consider PSCI.

Without this, little standardisation exists.  Low level CPU
power management must typically involve SMCs, but there's
no standardisation of their exact semantics, which implies that
some platform-specific glue will likely be needed.  The best you can
do is look for one or more backends in the kernel that are
close to what you need (if any), and if so propose some refactoring
to extend support to your platform.

> IIUC (which is probably NOT the case), when Linux runs
> in NS mode, some operations that are typically carried
> out at boot/init are not allowed, such as
> 
> - starting secondary cores
> - configuring the L2 cache controller
> 
> and this must be done by the secure OS via SMC?

Generally, yes.

> I'd be happy to be given pointers to internet references
> and do my own reading. I've bookmarked a few on related
> subjects:
> 
> http://events.linuxfoundation.org/sites/events/files/slides/clement-smp-bring-up-on-arm-soc.pdf
> http://www.linux-arm.org/pub/LinuxPlatform/RealViewLink/Booting_ARM_Linux_SMP_on_MPCore.doc
> http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0388g/Beihjjgb.html
> http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.prd29-genc-009492c/index.html

For PSCI, you can look at http://infocenter.arm.com/help/topic/com.arm.doc.den0022c/index.html.

> 
> Are the arch/arm/common/mcpm_* files relevant?

MCPM is infrastructure for handling _cluster_ powerup/powerdown, in
kernels where Linux runs in Secure (or otherwise has a high level of
access to power controls).

If unsure, say N.

[...]

Cheers
---Dave
