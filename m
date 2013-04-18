From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 18 Apr 2013 11:47:19 +0200
Subject: [GIT PULL] mvebu irqchip for v3.10
In-Reply-To: <20130418064217.GF12816@quad.lixom.net>
References: <20130415195245.GU28693@titan.lakedaemon.net>
 <20130418064217.GF12816@quad.lixom.net>
Message-ID: <20130418114719.01e9f375@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof, Jason,

On Wed, 17 Apr 2013 23:42:17 -0700, Olof Johansson wrote:

> > The following changes since commit
> > 31880c37c11e28cb81c70757e38392b42e695dc6:
> > 
> >   Linux 3.9-rc6 (2013-04-07 20:49:54 -0700)
> > 
> > are available in the git repository at:
> > 
> >   git://git.infradead.org/users/jcooper/linux.git tags/irqchip-3.10
> > 
> > for you to fetch changes up to
> > 5ec69017cc944f3ed88362d4b60818713a45e616:
> > 
> >   irqchip: armada-370-xp: slightly cleanup irq controller driver
> > (2013-04-15 19:35:17 +0000)
> > 
> > ----------------------------------------------------------------
> > mvebu driver irqchip for v3.10
> > 
> >  - move the armada irqchip driver to drivers/irqchip/
> > 
> > Note:
> >  - I asked tglx if it was ok to take this series on 10 Apr due to
> > it's complex dependencies.  5+ days have passed with no objection.
> >  - I put this driver in a separate mvebu branch in case tglx or
> > others object, it can be dropped with minimal impact to other work.
> 
> 
> Hi,
> 
> These notes are useful to include in the pull request, but not in the
> git tag -- they don't really hold much permanent value.
> 
> This branch also seems to have a few internal conflicts on mbus
> changes. Not a big deal, I fixed it up, but you might as well have
> based this on the other branch as well.
> 
> Merged as a late/cleanup branch.

I just tested arm-soc/for-next, and it seems like there was a merge
conflict that was not properly resolved. The
arch/arm/mach-mvebu/Makefile still references irq-armada-370-xp.c, even
though it has been moved to drivers/irqchip/ as per the pull request of
this e-mail. The fix is:

diff --git a/arch/arm/mach-mvebu/Makefile b/arch/arm/mach-mvebu/Makefile
index ca3b43f..90be143 100644
--- a/arch/arm/mach-mvebu/Makefile
+++ b/arch/arm/mach-mvebu/Makefile
@@ -6,6 +6,6 @@ AFLAGS_coherency_ll.o           := -Wa,-march=armv7-a
 obj-y                           += system-controller.o
 obj-$(CONFIG_MACH_ARMADA_370_XP) += armada-370-xp.o
 obj-$(CONFIG_ARCH_MVEBU)        += coherency.o coherency_ll.o
-obj-$(CONFIG_ARCH_MVEBU)        += pmsu.o irq-armada-370-xp.o
+obj-$(CONFIG_ARCH_MVEBU)        += pmsu.o
 obj-$(CONFIG_SMP)                += platsmp.o headsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)        += hotplug.o

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
