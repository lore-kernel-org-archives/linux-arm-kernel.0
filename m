From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 22 Jun 2018 10:26:19 +0100
Subject: [PATCHv4 4/4] ARM: versatile: support configuring versatile
 machine for no-MMU
In-Reply-To: <CAMuHMdUyCEq0U_CJindwcSEF+0dR-SJc1v8zGT-CcUqVkdOeVw@mail.gmail.com>
References: <20180618141905.7789-1-gerg@linux-m68k.org>
 <20180618141905.7789-5-gerg@linux-m68k.org>
 <CAMuHMdUyCEq0U_CJindwcSEF+0dR-SJc1v8zGT-CcUqVkdOeVw@mail.gmail.com>
Message-ID: <20180622092619.GT17671@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 21, 2018 at 05:59:54PM +0200, Geert Uytterhoeven wrote:
> Hi Greg,
> 
> CC Chris, Arnd, Nicolas
> 
> On Mon, Jun 18, 2018 at 4:21 PM Greg Ungerer <gerg@linux-m68k.org> wrote:
> > Allow the arm versatile machine to be configured for no-MMU operation.
> >
> > Older kernels had the ability to build the versatile machine with the MMU
> > disabled (!CONFIG_MMU). Recent changes to convert the versatile machine
> > to device tree lost this ability. (Although older kernels could be built
> > they did not run due to a bug in the IO_ADDRESS() mapping on this machine).
> >
> > The motivation for this is that the versatile machine is well supported
> > in qemu. And this provides an excellent platform for development and
> > testing no-MMU support on ARM in general.
> >
> > This patch adds a versatile platform selection in the upper level arm
> > system type menu - where it appeared in older kernel versions - when
> > configuring for the no-MMU case. There is no visible change to the way
> > versatile is selected for the MMU enabled case.
> >
> > Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
> 
> Thanks for your patch! I'm happy to see nommu spreading ;-)
> 
> 
> > ---
> >  arch/arm/Kconfig                | 11 +++++++++++
> >  arch/arm/Kconfig.debug          |  3 ++-
> >  arch/arm/mach-versatile/Kconfig |  5 +++--
> >  3 files changed, 16 insertions(+), 3 deletions(-)
> >
> > v2: don't use a multiplatform setup, move versatile choice to top level menu
> > v3: rebase on top of linux-4.10
> > v3: rebase on top of linux-4.17
> >
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index 54eeb8d00bc6..0608a6a32fac 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -356,6 +356,17 @@ config ARM_SINGLE_ARMV7M
> >         select SPARSE_IRQ
> >         select USE_OF
> >
> > +config ARM_SINGLE_ARCH_VERSATILE
> > +       bool "ARM Ltd. Versatile family"
> > +       depends on !MMU
> > +       select AUTO_ZRELADDR
> > +       select CLKSRC_OF
> > +       select COMMON_CLK
> > +       select GENERIC_CLOCKEVENTS
> > +       select GPIOLIB
> > +       select SPARSE_IRQ
> > +       select USE_OF
> > +
> 
> I'm afraid adding (duplicating) machine entries for nommu support is not a
> sustainable solutions. Any machine can run a nommu kernel, in theory.

Sorry, I strongly disagree.  You may be right "in theory" but theory
is useless when in practice you _can't_ because of the radically
different physical memory layouts.

I don't care about "but in theory" crap - we have to deal with
reality, and the reality is that ARM platforms are diverse in their
physical memory layouts.

So, violent NAK on reusing MULTIPLATFORM for XIP/NOMMU.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
