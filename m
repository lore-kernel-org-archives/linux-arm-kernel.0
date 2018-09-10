From: ran.wang_1@nxp.com (Ran Wang)
Date: Mon, 10 Sep 2018 09:09:59 +0000
Subject: [PATCH 3/3] soc: fsl: add RCPM driver
In-Reply-To: <86101ce0f4201d05510e57d74cafe8c665b8e5d4.camel@buserror.net>
References: <20180831035219.31619-1-ran.wang_1@nxp.com>
 <20180831035219.31619-3-ran.wang_1@nxp.com>
 <86101ce0f4201d05510e57d74cafe8c665b8e5d4.camel@buserror.net>
Message-ID: <AM5PR0402MB28652A2D74A891BC35B1B680F1050@AM5PR0402MB2865.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Scott,

On 2018/9/8 18:16, Scott Wood wrote:
> 
> On Fri, 2018-08-31 at 11:52 +0800, Ran Wang wrote:
> > The NXP's QorIQ Processors based on ARM Core have RCPM module (Run
> > Control and Power Management), which performs all device-level tasks
> > associated with power management such as wakeup source control.
> >
> > This driver depends on FSL platform PM driver framework which help to
> > isolate user and PM service provider (such as RCPM driver).
> >
> > Signed-off-by: Chenhui Zhao <chenhui.zhao@nxp.com>
> > Signed-off-by: Ying Zhang <ying.zhang22455@nxp.com>
> > Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> > ---
> >  drivers/soc/fsl/Kconfig   |    6 ++
> >  drivers/soc/fsl/Makefile  |    1 +
> >  drivers/soc/fsl/ls-rcpm.c |  153
> > +++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 160 insertions(+), 0 deletions(-)  create mode
> > 100644 drivers/soc/fsl/ls-rcpm.c
> 
> Is there a reason why this is LS-specific, or could it be used with PPC RCPM
> blocks?

They have different SW arch design on low power operation: PPC RCPM
driver has taken care of most things of suspend enter & exit. And LS RCPM driver
will only handle wakeup source configure and left rest work to system firmware
to do. So you might be aware that LS RCPM will only get call whenever plat_pm
driver API is called rather than system suspend begin where.

> 
> > diff --git a/drivers/soc/fsl/Kconfig b/drivers/soc/fsl/Kconfig index
> > 6517412..882330d 100644
> > --- a/drivers/soc/fsl/Kconfig
> > +++ b/drivers/soc/fsl/Kconfig
> > @@ -30,3 +30,9 @@ config FSL_PLAT_PM
> >  	  have to know the implement details of wakeup function it require.
> >  	  Besides, it is also easy for service side to upgrade its logic
> > when
> >  	  design changed and remain user side unchanged.
> > +
> > +config LS_RCPM
> > +	bool "Freescale RCPM support"
> > +	depends on (FSL_PLAT_PM)
> 
> Why is this parenthesized?

Because we'd like to decouple RCPM driver and its user.
Benefit is that will allow user doesn't have to know who will serve it for some PM
features (such as wake up source control), and provide some kind of flexibility when
either RCMP or user driver evolve in the future. So I add a plat_pm driver to prevent
wake up IP knowing any information of RCPM.

Regards,
Ran

> 
> -Scott
