From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 22 May 2018 11:55:03 +0100
Subject: [PATCH 07/14] ARM: spectre-v2: add Cortex A8 and A15 validation
 of the IBE bit
In-Reply-To: <CAMuHMdWdfjmdnQVmX7PJsXV8PcHhCCwAeHgxXRSV3CjX4C_amg@mail.gmail.com>
References: <20180516105949.GJ16141@n2100.armlinux.org.uk>
 <E1fIuBF-0003q0-3d@rmk-PC.armlinux.org.uk>
 <CAMuHMdWdfjmdnQVmX7PJsXV8PcHhCCwAeHgxXRSV3CjX4C_amg@mail.gmail.com>
Message-ID: <20180522105503.GR17671@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 22, 2018 at 12:38:05PM +0200, Geert Uytterhoeven wrote:
> Hi Russell,
> 
> On Wed, May 16, 2018 at 1:01 PM, Russell King
> <rmk+kernel@armlinux.org.uk> wrote:
> > When the branch predictor hardening is enabled, firmware must have set
> > the IBE bit in the auxiliary control register.  If this bit has not
> > been set, the Spectre workarounds will not be functional.
> >
> > Add validation that this bit is set, and print a warning at alert level
> > if this is not the case.
> >
> > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> 
> Thanks for your patch!
> 
> > --- /dev/null
> > +++ b/arch/arm/mm/proc-v7-bugs.c
> > @@ -0,0 +1,29 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include <linux/kernel.h>
> > +#include <linux/smp.h>
> > +
> > +static __maybe_unused void cpu_v7_check_auxcr_set(u32 mask, const char *msg)
> > +{
> > +       u32 aux_cr;
> > +
> > +       asm("mrc p15, 0, %0, c1, c0, 1" : "=r" (aux_cr));
> > +
> > +       if ((aux_cr & mask) != mask)
> > +               pr_err("CPU%u: %s", smp_processor_id(), msg);
> 
> pr_alert(), to match the patch description.

It was alert, but I've lowered it because I don't think it warrants
alert status.  Maybe critical would be better?  Shrug, this stuff is
rather subjective.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
