From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 18 Jul 2016 13:28:59 +0200
Subject: [RESEND PATCH v2] thermal: tango: add resume support
In-Reply-To: <2701749.GrMaU3rvHr@wuerfel>
References: <57726196.5060909@free.fr> <7689133.3ycKRvbtrh@wuerfel>
 <20160718101338.GB422@ulmo.ba.sec> <2701749.GrMaU3rvHr@wuerfel>
Message-ID: <20160718112859.GB18547@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 18, 2016 at 01:10:07PM +0200, Arnd Bergmann wrote:
> On Monday, July 18, 2016 12:13:38 PM CEST Thierry Reding wrote:
> > On Mon, Jul 18, 2016 at 12:09:39PM +0200, Arnd Bergmann wrote:
> > > On Monday, July 18, 2016 11:33:28 AM CEST Thierry Reding wrote:
> > > 
> > > > > +
> > > > > +     return 0;
> > > > > +}
> > > > > +
> > > > > +static SIMPLE_DEV_PM_OPS(tango_thermal_pm, NULL, tango_thermal_resume);
> > > > > +
> > > > > +#define DEV_PM_OPS   &tango_thermal_pm
> > > > > +#else
> > > > > +#define DEV_PM_OPS   NULL
> > > > > +#endif
> > > > 
> > > > In my experience it's often not useful to #ifdef the struct pm_ops.
> > > > These days you almost certainly want PM enabled, and the conditional
> > > > doesn't save you all that much in the first place, because it's not
> > > > unlikely for this to fit into some of the space that would be padded
> > > > out anyway.
> > > 
> > > This will also generate a warning when CONFIG_PM_SLEEP is not set.
> > > Better write this as
> > > 
> > > #define DEV_PM_OPS (IS_ENABLED(CONFIG_PM_SLEEP) ? &tango_thermal_pm : NULL)
> > > 
> > > so the compiler can drop the variable definition when it's not
> > > needed.
> > 
> > My suggestion was to define tango_thermal_pm unconditionally to avoid
> > any of these tricks. For any real use-case in which the 92 bytes for the
> > struct dev_pm_ops would matter you most likely want PM_SLEEP anyway, so
> > I don't really see why we would even want to make it optional.
> 
> Sure, leaving it unconditional works too. 
> 
> > > > As a side-note, I've noticed that this driver has the following
> > > > dependencies:
> > > > 
> > > >         depends on ARCH_TANGO || COMPILE_TEST
> > > > 
> > > > which, last I checked, is probably going to fail on some architectures
> > > > because you need at least another one on HAS_IOMEM (for readl() and
> > > > writel()). That's a pre-existing problem, of course, so should be fixed
> > > > in a separate patch.
> > > 
> > > No need, we just merged a patch to no longer allow COMPILE_TEST on
> > > arch/um/, so we can safely rely on MMIO to be available for COMPILE_TEST.
> > 
> > I thought at least S390 didn't have readl() and writel() either, at
> > least when PCI wasn't enabled, or some such.
> 
> Yes, but they've never complained about COMPILE_TEST breakage because
> of that. Tile is in the same boat too in some configurations.

Ah, okay. I remember running into this occasionally when doing
randconfig builds on S390. That was many moons ago, so perhaps it's not
an issue anymore, and maybe I've become overly cautious about the
COMPILE_TEST dependency.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160718/a8f6b2c4/attachment.sig>
