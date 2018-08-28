From: leoyang.li@nxp.com (Li Yang)
Date: Tue, 28 Aug 2018 17:49:25 -0500
Subject: [PATCH 1/2] soc: fsl: qbman: qman_portal: defer probing when qman
 is not available
In-Reply-To: <DB6PR0402MB27276B417034E7356B0CFA5886360@DB6PR0402MB2727.eurprd04.prod.outlook.com>
References: <20180823213600.23426-1-alexandre.belloni@bootlin.com>
 <DB6PR0402MB27276B417034E7356B0CFA5886360@DB6PR0402MB2727.eurprd04.prod.outlook.com>
Message-ID: <CADRPPNRJFii=ybTVm=NMGMT8U02JKsjYsgA6PR52owK=Bc3cgA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 24, 2018 at 9:54 AM Roy Pledge <roy.pledge@nxp.com> wrote:
>
> On 8/23/2018 5:36 PM, Alexandre Belloni wrote:
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

Series applied to the fix branch of soc/fsl.

> > ---
> >  drivers/soc/fsl/qbman/qman_portal.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/soc/fsl/qbman/qman_portal.c b/drivers/soc/fsl/qbman/qman_portal.c
> > index a120002b630e..4fc80d2c8feb 100644
> > --- a/drivers/soc/fsl/qbman/qman_portal.c
> > +++ b/drivers/soc/fsl/qbman/qman_portal.c
> > @@ -277,6 +277,8 @@ static int qman_portal_probe(struct platform_device *pdev)
> >       }
> >
> >       pcfg->pools = qm_get_pools_sdqcr();
> > +     if (pcfg->pools == 0)
> > +             return -EPROBE_DEFER;
> >
> >       spin_lock(&qman_lock);
> >       cpu = cpumask_next_zero(-1, &portal_cpus);
>
> Reviewed-by: Roy Pledge <roy.pledge@nxp.com>
>
>
