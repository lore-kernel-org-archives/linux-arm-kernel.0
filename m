From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Tue, 10 Oct 2017 14:57:35 +0300
Subject: [PATCH] ARM: imx: Enable cpuidle for i.MX6DL starting at 1.1
In-Reply-To: <1507635857.2745.12.camel@pengutronix.de>
References: <bbd72503f0e79cc6df4ba12db41b980d50415caf.1507634288.git.leonard.crestez@nxp.com>
 <1507635857.2745.12.camel@pengutronix.de>
Message-ID: <1507636655.20816.8.camel@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-10-10 at 13:44 +0200, Lucas Stach wrote:
> Am Dienstag, den 10.10.2017, 14:20 +0300 schrieb Leonard Crestez:

> > Enable cpuidle support on i.MX6DL starting from
> > IMX_CHIP_REVISION_1_1.

> Did you mean 1.0 here and in the subject? This would make sense AFAICS,
> ?and is also in line with what the code change does.

No, I do mean "1.1" for 6dl. It's a bit confusing because the code uses
> instead of >= for comparison.

This patch results in imx6q_cpuidle_init getting called if
(cpu_is_imx6dl() &&?imx_get_soc_revision() == IMX_CHIP_REVISION_1_1);
without this patch it was skipped.

> > --- a/arch/arm/mach-imx/mach-imx6q.c
> > +++ b/arch/arm/mach-imx/mach-imx6q.c
> > @@ -374,7 +374,8 @@ static void __init imx6q_init_late(void)
> > > 
> > > ?	?* WAIT mode is broken on TO 1.0 and 1.1, so there is no point
> > > ?	?* to run cpuidle on them.
> > > ?	?*/
> > > -	if (imx_get_soc_revision() > IMX_CHIP_REVISION_1_1)
> > > +	if ((cpu_is_imx6q() && imx_get_soc_revision() > IMX_CHIP_REVISION_1_1) ||
> > > +	????(cpu_is_imx6dl() && imx_get_soc_revision() > IMX_CHIP_REVISION_1_0))
> > > ?		imx6q_cpuidle_init();
