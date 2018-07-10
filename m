From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Tue, 10 Jul 2018 13:18:00 +0000
Subject: [PATCH v2 1/2] soc: imx: gpc: Disable 6sl display power gating
 for ERR006287
In-Reply-To: <CAPDyKFoELWSiZ4cfOByziPQzqW7Tx3m29qKu9uCKPHO1gXO4YA@mail.gmail.com>
References: <cover.1531138446.git.leonard.crestez@nxp.com>
 <a00303c5672b332d1d363b78926903187169b8cc.1531138446.git.leonard.crestez@nxp.com>
 <CAPDyKFoELWSiZ4cfOByziPQzqW7Tx3m29qKu9uCKPHO1gXO4YA@mail.gmail.com>
Message-ID: <8aba202031bb222d9d78f8ac272757c930aff0c5.camel@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2018-07-10 at 00:33 +0200, Ulf Hansson wrote:
> On 9 July 2018 at 14:23, Leonard Crestez <leonard.crestez@nxp.com>
> wrote:
> > The imx6sl chip errata document describes ERR006287 like this:
> > 
> > """
> > Upon resuming from power gating, the modules in the display power
> > domain
> > (eLCDIF, EPDC, PXP and SPDC) might fail to perform register reads
> > correctly.
> > 
> > When the modules listed above are used, do not use power gating on
> > the
> > display power domain.
> > """
> > 
> > Link: https://emea01.safelinks.protection.outlook.com/?url=https%3A
> > %2F%2Fwww.nxp.com%2Fdocs%2Fen%2Ferrata%2FIMX6SLCE.pdf%23page%3D62&a
> > mp;data=02%7C01%7Cleonard.crestez%40nxp.com%7Cdbc5b00a97c548c470320
> > 8d5e5ebfb24%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C1%7C6366677240
> > 50833256&amp;sdata=VgYIGGTYQ0ChR%2FCEBSZJ1D1JyfJRDi96YHa%2Byt4Qr5s%
> > 3D&amp;reserved=0
> > 
> > Handle this in linux in the same way as imx6qp ERR009619: make the
> > DISP
> > domain return -EBUSY on power_off.
> > 
> > Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> > ---
> >  drivers/soc/imx/gpc.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
> > index 526f2d02dc78..6b726dada560 100644
> > --- a/drivers/soc/imx/gpc.c
> > +++ b/drivers/soc/imx/gpc.c
> > @@ -339,30 +339,35 @@ static struct imx_pm_domain imx_gpc_domains[]
> > = {
> >  };
> > 
> >  struct imx_gpc_dt_data {
> >         int num_domains;
> >         bool err009619_present;
> > +       bool err006287_present;
> >  };
> > 
> >  static const struct imx_gpc_dt_data imx6q_dt_data = {
> >         .num_domains = 2,
> >         .err009619_present = false,
> > +       .err006287_present = false,
> >  };
> > 
> >  static const struct imx_gpc_dt_data imx6qp_dt_data = {
> >         .num_domains = 2,
> >         .err009619_present = true,
> > +       .err006287_present = false,
> >  };
> > 
> >  static const struct imx_gpc_dt_data imx6sl_dt_data = {
> >         .num_domains = 3,
> >         .err009619_present = false,
> > +       .err006287_present = true,
> >  };
> > 
> >  static const struct imx_gpc_dt_data imx6sx_dt_data = {
> >         .num_domains = 4,
> >         .err009619_present = false,
> > +       .err006287_present = false,
> >  };
> > 
> >  static const struct of_device_id imx_gpc_dt_ids[] = {
> >         { .compatible = "fsl,imx6q-gpc", .data = &imx6q_dt_data },
> >         { .compatible = "fsl,imx6qp-gpc", .data = &imx6qp_dt_data
> > },
> > @@ -467,10 +472,15 @@ static int imx_gpc_probe(struct
> > platform_device *pdev)
> >         /* Disable PU power down in normal operation if ERR009619
> > is present */
> >         if (of_id_data->err009619_present)
> >                 imx_gpc_domains[GPC_PGC_DOMAIN_PU].flags |=
> >                                 PGC_DOMAIN_FLAG_NO_PD;
> > 
> > +       /* Disable DISP power down in normal operation if ERR006287
> > is present */
> > +       if (of_id_data->err006287_present)
> > +               imx_gpc_domains[GPC_PGC_DOMAIN_DISPLAY].flags |=
> > +                               PGC_DOMAIN_FLAG_NO_PD;
> > +
> 
> This looks like a use-case for an always powered on PM domain?
> 
> If that's the case, GENPD_FLAG_ALWAYS_ON does the trick, but more
> efficient as it enables genpd to take a few shortcuts when trying to
> power of a PM domain.

GENPD_FLAG_ALWAYS_ON would be a reasonable here.

I searched but I've been unable to find a good reference for scenarios
where power gating DISP on 6sl is still supported. I think it should be
safe to turn off in suspend but this is only based based on old commits
from the imx internal tree.

Right now displays on imx6sl don't work at all because nothing is
inside the DISP and it gets powered off. Fixing this in the safest and
most uncontroversial way would be worthwhile, yes?
