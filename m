From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 3 Jun 2015 16:19:21 +0100
Subject: [PATCHv3 11/12] ARM: migrate to common PSCI client code
In-Reply-To: <20150527171747.GB23176@leverpostej>
References: <1432648350-5454-1-git-send-email-mark.rutland@arm.com>
 <1432648350-5454-12-git-send-email-mark.rutland@arm.com>
 <CAL_JsqJG=k=z5+p55YVzmdFBjcGSX2t3ct337kYRd6c5HG5H3g@mail.gmail.com>
 <20150527171747.GB23176@leverpostej>
Message-ID: <20150603151921.GB599@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Wed, May 27, 2015 at 06:17:47PM +0100, Mark Rutland wrote:
> On Wed, May 27, 2015 at 05:46:47PM +0100, Rob Herring wrote:
> > On Tue, May 26, 2015 at 8:52 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> > > Now that the common PSCI client code has been factored out to
> > > drivers/firmware, and made safe for 32-bit use, move the 32-bit ARM code
> > > over to it. This results in a moderate reduction of duplicated lines,
> > > and will prevent further duplication as the PSCI client code is updated
> > > for PSCI 1.0 and beyond.
> > >
> > > The two legacy platform users of the PSCI invocation code are updated to
> > > account for interface changes. In both cases the power state parameter
> > > is changed to an opaque u32 token in preparation for PSCI 1.0 power
> > > state changes.

Other than the changes you requested below, are you happy with the
patch?

Are you happy to ack the patch with those changes folded in?

Mark.

> > >  static int highbank_suspend_finish(unsigned long val)
> > >  {
> > > -       const struct psci_power_state ps = {
> > > -               .type = PSCI_POWER_STATE_TYPE_POWER_DOWN,
> > > -               .affinity_level = 1,
> > > -       };
> > > -
> > > +       u32 ps = 0x01010000; /* Aff1 power down */
> > 
> > Why not just pass directly instead of sticking in a variable first.
> 
> No particular reason. I'll fold it in.
>  
> > >         return psci_ops.cpu_suspend(ps, __pa(cpu_resume));
> > >  }
> > >
> > > diff --git a/drivers/cpuidle/cpuidle-calxeda.c b/drivers/cpuidle/cpuidle-calxeda.c
> > > index 9445e6c..d010da8f 100644
> > > --- a/drivers/cpuidle/cpuidle-calxeda.c
> > > +++ b/drivers/cpuidle/cpuidle-calxeda.c
> > > @@ -25,15 +25,14 @@
> > >  #include <linux/init.h>
> > >  #include <linux/mm.h>
> > >  #include <linux/platform_device.h>
> > > +#include <linux/psci.h>
> > > +
> > >  #include <asm/cpuidle.h>
> > >  #include <asm/suspend.h>
> > > -#include <asm/psci.h>
> > >
> > >  static int calxeda_idle_finish(unsigned long val)
> > >  {
> > > -       const struct psci_power_state ps = {
> > > -               .type = PSCI_POWER_STATE_TYPE_POWER_DOWN,
> > > -       };
> > > +       u32 ps = 0x00010000; /* Aff0 power down */
> > 
> > ditto.
> 
> Likewise.
> 
> Thanks,
> Mark.
> 
> > 
> > >         return psci_ops.cpu_suspend(ps, __pa(cpu_resume));
> > >  }
> > >
> > > --
> > > 1.9.1
> > >
> > 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
