From: robert.richter@caviumnetworks.com (Robert Richter)
Date: Mon, 7 Sep 2015 18:48:44 +0200
Subject: [PATCH v2] irqchip, gicv3-its, numa: Workaround for Cavium
 ThunderX erratum 23144
In-Reply-To: <55EDBEF9.4050007@arm.com>
References: <1440497885-24584-1-git-send-email-gkulkarni@caviumnetworks.com>
 <55EDBEF9.4050007@arm.com>
Message-ID: <20150907164844.GU1820@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07.09.15 17:44:41, Marc Zyngier wrote:
> On 25/08/15 11:18, Ganapatrao Kulkarni wrote:
> > The patch below adds a workaround for gicv3 in a numa environment. It
> > is on top of Robert's recent gicv3 errata patch submission v4 and my
> > arm64 numa patches v5.
> > 
> > This implements a workaround for gicv3-its erratum 23144 on Cavium's
> > ThunderX dual-socket platforms, where LPI cannot be routed to a
> > redistributors present on a foreign node.
> > 
> > v2:
> > updatated as per Marc Zyngier's review comments.
> > 
> > Signed-off-by: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
> > Signed-off-by: Robert Richter <rrichter@cavium.com>
> > ---
> >  drivers/irqchip/irq-gic-v3-its.c | 53 +++++++++++++++++++++++++++++++++-------
> >  1 file changed, 44 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> > index 614a367..d3fe0a4 100644
> > --- a/drivers/irqchip/irq-gic-v3-its.c
> > +++ b/drivers/irqchip/irq-gic-v3-its.c
> > @@ -40,7 +40,8 @@
> >  #include "irqchip.h"
> >  
> >  #define ITS_FLAGS_CMDQ_NEEDS_FLUSHING          (1ULL << 0)
> > -#define ITS_FLAGS_CAVIUM_THUNDERX              (1ULL << 1)
> > +#define ITS_WORKAROUND_CAVIUM_22375            (1ULL << 1)
> > +#define ITS_WORKAROUND_CAVIUM_23144            (1ULL << 2)
> 
> Please move this to Robert's series, as it doesn't make much sense to
> add a quirk flag just to modify it in the next patch. This will help
> declutter this patch.

I will merge the bits in and rebase and rework this one on top (we
will post this separately due to dependencies to other patch sets).

Thanks,

-Robert
