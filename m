From: ran.wang_1@nxp.com (Ran Wang)
Date: Mon, 10 Sep 2018 09:26:58 +0000
Subject: [PATCH 1/3] soc: fsl: add Platform PM driver QorIQ platforms
In-Reply-To: <cad8c585fb415959e7ade8b500278c2c5e070873.camel@buserror.net>
References: <20180831035219.31619-1-ran.wang_1@nxp.com>
 <cad8c585fb415959e7ade8b500278c2c5e070873.camel@buserror.net>
Message-ID: <AM5PR0402MB2865520968A3656EC904ECB8F1050@AM5PR0402MB2865.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Scott,

On 2018/9/8 4:35, Scott Wood wrote:
> 
> On Fri, 2018-08-31 at 11:52 +0800, Ran Wang wrote:
> > This driver is to provide a independent framework for PM service
> > provider and consumer to configure system level wake up feature. For
> > example, RCPM driver could register a callback function on this
> > platform first, and Flex timer driver who want to enable timer wake up
> > feature, will call generic API provided by this platform driver, and
> > then it will trigger RCPM driver to do it. The benefit is to isolate
> > the user and service, such as flex timer driver will not have to know
> > the implement details of wakeup function it require. Besides, it is
> > also easy for service side to upgrade its logic when design is changed
> > and remain user side unchanged.
> >
> > Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> > ---
> >  drivers/soc/fsl/Kconfig   |   14 +++++
> >  drivers/soc/fsl/Makefile  |    1 +
> >  drivers/soc/fsl/plat_pm.c |  144
> > +++++++++++++++++++++++++++++++++++++++++++++
> >  include/soc/fsl/plat_pm.h |   22 +++++++
> >  4 files changed, 181 insertions(+), 0 deletions(-)  create mode
> > 100644 drivers/soc/fsl/plat_pm.c  create mode 100644
> > include/soc/fsl/plat_pm.h
> >
> > diff --git a/drivers/soc/fsl/Kconfig b/drivers/soc/fsl/Kconfig index
> > 7a9fb9b..6517412 100644
> > --- a/drivers/soc/fsl/Kconfig
> > +++ b/drivers/soc/fsl/Kconfig
> > @@ -16,3 +16,17 @@ config FSL_GUTS
> >  	  Initially only reading SVR and registering soc device are
> > supported.
> >  	  Other guts accesses, such as reading RCW, should eventually be
> > moved
> >  	  into this driver as well.
> +
> > +config FSL_PLAT_PM
> > +	bool "Freescale platform PM framework"
> 
> This name seems to be simultaneously too generic (for something that is
> likely intended only for use with certain Freescale/NXP chip families) and too
> specific (for something that seems to be general infrastructure with no real
> hardware dependencies).

Yes, this driver has no real HW dependencies at all. But we'd like to introduce it
to help providing more flexibility & generic on FSL PM feature configure (so far 
we have RCPM on system wakeup source control). I think it's good
for driver/IP porting among different SoC in the future. As to the name, do you
have better suggestion?

> What specific problems with Linux's generic wakeup infrastructure is this
> trying to solve, and why would those problems not be better solved there?

Actually, I am not sure if generic wakeup infrastructure have this kind of PM feature
(keep specific IP alive during system suspend, could you please show me?).
And I think it is not common requirement, so I decide to put it in FSL folder. 

> Also, you should CC linux-pm on these patches.

Yes, thanks for suggestion

Regards,
Ran

> -Scott
