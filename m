From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 11 Mar 2015 23:11:41 +0000
Subject: [PATCH v10 16/21] irqchip: Add GICv2 specific ACPI boot support
In-Reply-To: <CACxGe6uWwts6X=Yc2ioBdQizXkF1_YgoNNOsREWirk2MFBVDHg@mail.gmail.com>
References: <1426077587-1561-1-git-send-email-hanjun.guo@linaro.org>
 <1426077587-1561-17-git-send-email-hanjun.guo@linaro.org>
 <CACxGe6uWwts6X=Yc2ioBdQizXkF1_YgoNNOsREWirk2MFBVDHg@mail.gmail.com>
Message-ID: <20150311231141.GG21998@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Grant,

On Wed, Mar 11, 2015 at 06:04:50PM +0000, Grant Likely wrote:
> On 11 Mar 2015 12:42, "Hanjun Guo" <hanjun.guo@linaro.org> wrote:
> >
> > From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> >
> > ACPI kernel uses MADT table for proper GIC initialization. It needs to
> > parse GIC related subtables, collect CPU interface and distributor
> > addresses and call driver initialization function (which is hardware
> > abstraction agnostic). In a similar way, FDT initialize GICv1/2.
> >
> > NOTE: This commit allow to initialize GICv1/2 basic functionality.
> > While now simple GICv2 init call is used, any further GIC features
> > require generic infrastructure for proper ACPI irqchip initialization.
> > That mechanism and stacked irqdomains to support GICv2 MSI/virtualization
> > extension, GICv3/4 and its ITS are considered as next steps.
> >
> > CC: Jason Cooper <jason@lakedaemon.net>
> > CC: Marc Zyngier <marc.zyngier@arm.com>
> > CC: Thomas Gleixner <tglx@linutronix.de>
> 
> BTW, Thomas is taking a bit of a break, do he is unlikely to give an ack
> here in a timely manner. I've not heard from Jason. Personally, I think we
> can proceed without their ack if everything else is in order (heck, I used
> to help with the irq subsystem, use me as an ack of you want). The patch is
> low impact and only had effect for ARM ACPI builds.

I'm not talking much, but I am tracking and collecting everything for irqchip.
We do have some other changes in this driver this time around.  So it'd be nice
if I could take this.

I had reached out to Olof for his thoughts on this and he hasn't had enough
cycles to look at it.  iirc, Marc reviewed a previous version and was happy with
the changes.  My only question I had for Olof I'll put below:

> > diff --git a/drivers/irqchip/irqchip.c b/drivers/irqchip/irqchip.c
> > index 0fe2f71..afd1af3 100644
> > --- a/drivers/irqchip/irqchip.c
> > +++ b/drivers/irqchip/irqchip.c
> > @@ -8,6 +8,7 @@
> >   * warranty of any kind, whether express or implied.
> >   */
> >
> > +#include <linux/acpi_irq.h>
> >  #include <linux/init.h>
> >  #include <linux/of_irq.h>
> >  #include <linux/irqchip.h>
> > @@ -26,4 +27,6 @@ extern struct of_device_id __irqchip_of_table[];
> >  void __init irqchip_init(void)
> >  {
> >         of_irq_init(__irqchip_of_table);
> > +
> > +       acpi_irq_init();
> >  }

Is this in line with Olof's idea that providing a dtb would override ACPI?

I have no strong opinion on the matter personally.  I haven't been able to
follow the ACPI discussion as closely as I would have liked, what with the new
job and all.

Just let me know and I can pull it in with other GIC changes for this cycle.
I'll do a topic branch in case other branches need to depend on this.

thx,

Jason.
