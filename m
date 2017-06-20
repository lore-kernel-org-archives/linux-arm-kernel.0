From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Tue, 20 Jun 2017 17:32:16 +0300
Subject: [PATCH v5 2/6] ARM: imx6: register pm_power_off handler if
 "fsl,pmic-stby-poweroff" is set
In-Reply-To: <7f2db0a8-a316-5ecb-24bf-46bcb625e123@pengutronix.de>
References: <20170619050245.2632-1-o.rempel@pengutronix.de>
 <20170619050245.2632-3-o.rempel@pengutronix.de>
 <1497872133.5380.11.camel@nxp.com>
 <7f2db0a8-a316-5ecb-24bf-46bcb625e123@pengutronix.de>
Message-ID: <1497969136.3177.10.camel@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-06-20 at 06:55 +0200, Oleksij Rempel wrote:
> On 19.06.2017 13:35, Leonard Crestez wrote:
> > On Mon, 2017-06-19 at 07:02 +0200, Oleksij Rempel wrote:
> > > 
> > > One of the Freescale recommended sequences for power off with
> > > external
> > > PMIC is the following:
> > > ...
> > > 3.??SoC is programming PMIC for power off when standby is asserted.
> > > 4.??In CCM STOP mode, Standby is asserted, PMIC gates SoC supplies.
> > > 
> > > This patch implements step 4. of this sequence.
> > > 
> > > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > > ---
> > > ?arch/arm/mach-imx/pm-imx6.c | 25 +++++++++++++++++++++++++
> > > ?1 file changed, 25 insertions(+)
> > > 
> > > diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-
> > > imx6.c
> > > index e61b1d1027e1..cb76832935f0 100644
> > > --- a/arch/arm/mach-imx/pm-imx6.c
> > > +++ b/arch/arm/mach-imx/pm-imx6.c
> > > @@ -602,6 +602,28 @@ static void __init imx6_pm_common_init(const
> > > struct imx6_pm_socdata
> > > ?				???IMX6Q_GPR1_GINT);
> > > ?}
> > > 
> > > +static void imx6_pm_poweroff(void)
> > > +{
> > > +	imx6_set_lpm(STOP_POWER_OFF);
> > > +	cpu_suspend(0, imx6q_suspend_finish);
> > It's a bit strange that you're using parts of the suspend code for
> > this. Perhaps you could just write your bits to CLPCR and then execute
> > a WFI?
> Well, every thing in this patch set, yell about using standby/suspend?
> path in HW for power off. Even iMX code use STOP_POWER_OFF for?
> configuring this regs. How can it be more strange? :) Should i really?
> duplicate code to hide this?
> 
This code is used to set the power state the soc enters on WFI. These
function try to ensure that it is possible to come back up when woken
by an interrupt later. That part you don't want, right?

However I can't think of any obvious way this could misbehave so I
guess it's fine.
