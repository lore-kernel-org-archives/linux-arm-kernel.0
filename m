From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 6 Nov 2014 10:52:47 +0000
Subject: [GIT PULL] Integrator multiplatform migration for v3.19
In-Reply-To: <20141104063235.GG13562@quad.lixom.net>
References: <CACRpkdafst1j2tp4-=BZMn_P688uUSjeAZEGt26WuD_d521sHQ@mail.gmail.com>
 <20141104063235.GG13562@quad.lixom.net>
Message-ID: <20141106105246.GO4042@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 03, 2014 at 10:32:35PM -0800, Olof Johansson wrote:
> On Wed, Oct 22, 2014 at 02:13:04PM +0200, Linus Walleij wrote:
> > Hi ARM SoC folks,
> > 
> > this is the initial set of two patches to migrate the Integrator
> > platforms to multiplatform.
> > 
> > Tested on the Integrator/AP with ARM926EJ-S and Integrator/CP
> > with ARM920T.
> > 
> > Please pull it in for v3.19!
> > 
> > Yours,
> > Linus Walleij
> > 
> > The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:
> > 
> >   Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
> > tags/integrator-multiplatform-for-arm-soc
> > 
> > for you to fetch changes up to 9713497b6c64c67c8763f8f07fad325b193764b6:
> > 
> >   ARM: integrator: set V4T and V5 as default multitargets (2014-10-22
> > 09:49:26 +0200)
> > 
> > ----------------------------------------------------------------
> > Multiplatform migration of the Integrator.
> 
> Merged. The patches had better commit texts than the tag though, so please
> feel free to carry forward and/or elaborate just a bit more in the future.

Unfortunately, this totally screws multiplatform support - with this
merged, we now can enable all CPUs from ARM720T upwards into a single
kernel - and that is illegal.

The problem is that Integrator can be ARM720T all the way up to ARMv6.
So, when ARCH_INTEGRATOR is enabled, you are presented with the
individual CPUs which the platform supports as options to select.
This results in randconfig seeing all the CPU options, which it can
then enable, resulting in:

CONFIG_CPU_ARM720T=y
CONFIG_CPU_ARM920T=y
CONFIG_CPU_ARM922T=y
CONFIG_CPU_ARM926T=y
CONFIG_CPU_ARM1020=y
CONFIG_CPU_ARM1022=y
CONFIG_CPU_ARM1026=y
CONFIG_CPU_V6=y
CONFIG_CPU_V6K=y
CONFIG_CPU_V7=y

which then causes:

arch/arm/include/asm/cmpxchg.h:114:2: error: #error "SMP is not supported on this platform"
arch/arm/include/asm/atomic.h:137:2: error: #error SMP not supported on pre-ARMv6 CPUs

Integrator doesn't fit into the "is it a pre-ARMv6 or not" platform
structure chosen in the early days of multiplatform support, because
it straddles that boundary.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
