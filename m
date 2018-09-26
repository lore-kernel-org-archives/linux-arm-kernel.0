From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Wed, 26 Sep 2018 11:27:06 +0200
Subject: [PATCH 1/2] soc: fsl: qbman: qman_portal: defer probing when
 qman is not available
In-Reply-To: <CAOesGMjDKKSNVccu4D579SiwL9zEU7ha7HQCHncvh2r4kpO6fQ@mail.gmail.com>
References: <20180823213600.23426-1-alexandre.belloni@bootlin.com>
 <CAOesGMjDKKSNVccu4D579SiwL9zEU7ha7HQCHncvh2r4kpO6fQ@mail.gmail.com>
Message-ID: <20180926092706.GA16644@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/09/2018 21:45:56+0200, Olof Johansson wrote:
> Hi,
> 
> 
> On Thu, Aug 23, 2018 at 11:36 PM Alexandre Belloni
> <alexandre.belloni@bootlin.com> wrote:
> >
> > If the qman driver (qman_ccsr) doesn't probe or fail to probe before
> > qman_portal, qm_ccsr_start will be either NULL or a stale pointer to an
> > unmapped page.
> >
> > This leads to a crash when probing  qman_portal as the init_pcfg function
> > calls qman_liodn_fixup that tries to read qman registers.
> >
> > Assume that qman didn't probe when the pool mask is 0.
> >
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > ---
> >  drivers/soc/fsl/qbman/qman_portal.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/soc/fsl/qbman/qman_portal.c b/drivers/soc/fsl/qbman/qman_portal.c
> > index a120002b630e..4fc80d2c8feb 100644
> > --- a/drivers/soc/fsl/qbman/qman_portal.c
> > +++ b/drivers/soc/fsl/qbman/qman_portal.c
> > @@ -277,6 +277,8 @@ static int qman_portal_probe(struct platform_device *pdev)
> >         }
> >
> >         pcfg->pools = qm_get_pools_sdqcr();
> > +       if (pcfg->pools == 0)
> > +               return -EPROBE_DEFER;
> 
> This is quite late in the probe, after a bunch of resources have been claimed.
> 
> Note that the ioremaps above this are doing unwinds, and you'll end up
> doing duplicate ioremaps if you come in and probe again.
> 
> You should probably unwind those allocations, or move them to devm_*
> or do this check earlier in the function.
> 

The actual chance of having that happen is quite small (this was coming
from a non working DT) and I mainly wanted to avoid a crash so the
platform could still boot. I would think moving to devm_ would be the
right thing to do.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
