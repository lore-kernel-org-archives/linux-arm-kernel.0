From: cavokz@gmail.com (Domenico Andreoli)
Date: Fri, 26 Jul 2013 23:59:00 +0200
Subject: [PATCH v2 1/5] ARM: Broadcom: Unconditionally build
 arch/arm/mach-bcm
In-Reply-To: <20130726152918.GL29916@titan.lakedaemon.net>
References: <20130726145639.116237136@gmail.com>
 <20130726151223.045835540@gmail.com>
 <20130726152918.GL29916@titan.lakedaemon.net>
Message-ID: <20130726215859.GA19469@glitch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 26, 2013 at 11:29:18AM -0400, Jason Cooper wrote:
> On Fri, Jul 26, 2013 at 04:56:40PM +0200, Domenico Andreoli wrote:
> > From: Domenico Andreoli <domenico.andreoli@linux.com>
> > 
> > arch/arm/mach-bcm contains a plurality of Broadcom SoCs, each configured
> > separately. As a matter of flexibility and maintenance, it needs to be
> > always included in the build.
> 
> So if I'm building mach-kirkwood, I _have_ to build Broadcom?  What is
> the *specific* problem you're encountering that this solves?

In mach-bcm we (or I, it's not very clear to me) want to have support for
multiple SoCs.

In trying the approach

machine-$(CONFIG_ARCH_BCM)		+= bcm
machine-$(CONFIG_ARCH_BCM4760)		+= bcm

I got linker complains about multiple symbol definitiion in case both the
config options are selected.

The first thought was to use a common option which purpose was only to
include the subdir but then, given my allergy to the tons of config options
with usually not straghtforward purpose, I opted for something more simple.

> 
> Notice:
> 
> $ git grep '^machine-y'
> $
> 
> thx,
> 
> Jason.
> 
> > Cc: Christian Daudt <csd@broadcom.com>
> > Cc: linux-arm-kernel at lists.infradead.org
> > Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>
> > ---
> >  arch/arm/Makefile |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > Index: b/arch/arm/Makefile
> > ===================================================================
> > --- a/arch/arm/Makefile
> > +++ b/arch/arm/Makefile
> > @@ -145,7 +145,7 @@ textofs-$(CONFIG_ARCH_MSM8960) := 0x0020
> >  # Machine directory name.  This list is sorted alphanumerically
> >  # by CONFIG_* macro name.
> >  machine-$(CONFIG_ARCH_AT91)		+= at91
> > -machine-$(CONFIG_ARCH_BCM)		+= bcm
> > +machine-y				+= bcm
> >  machine-$(CONFIG_ARCH_BCM2835)		+= bcm2835
> >  machine-$(CONFIG_ARCH_CLPS711X)		+= clps711x
> >  machine-$(CONFIG_ARCH_CNS3XXX)		+= cns3xxx
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
