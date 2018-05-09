From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Wed, 9 May 2018 07:06:28 +0200
Subject: [PATCH v6 2/6] ARM: imx6: register pm_power_off handler if
 "fsl,pmic-stby-poweroff" is set
In-Reply-To: <20180508124033.GL16141@n2100.armlinux.org.uk>
References: <20180305102524.5905-1-o.rempel@pengutronix.de>
 <20180305102524.5905-3-o.rempel@pengutronix.de>
 <20180508124033.GL16141@n2100.armlinux.org.uk>
Message-ID: <20180509050628.csbusplowpvmmiwa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 08, 2018 at 01:40:33PM +0100, Russell King - ARM Linux wrote:
> On Mon, Mar 05, 2018 at 11:25:19AM +0100, Oleksij Rempel wrote:
> > One of the Freescale recommended sequences for power off with external
> > PMIC is the following:
> > ...
> > 3.  SoC is programming PMIC for power off when standby is asserted.
> > 4.  In CCM STOP mode, Standby is asserted, PMIC gates SoC supplies.
> > 
> > See:
> > http://www.nxp.com/assets/documents/data/en/reference-manuals/IMX6DQRM.pdf
> > page 5083
> > 
> > This patch implements step 4. of this sequence.
> > 
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > ---
> >  arch/arm/mach-imx/pm-imx6.c | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> > 
> > diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c
> > index ecdf071653d4..24689260a2a5 100644
> > --- a/arch/arm/mach-imx/pm-imx6.c
> > +++ b/arch/arm/mach-imx/pm-imx6.c
> > @@ -604,6 +604,28 @@ static void __init imx6_pm_common_init(const struct imx6_pm_socdata
> >  				   IMX6Q_GPR1_GINT);
> >  }
> >  
> > +static void imx6_pm_stby_poweroff(void)
> > +{
> > +	imx6_set_lpm(STOP_POWER_OFF);
> > +	cpu_suspend(0, imx6q_suspend_finish);
> 
> Do you actually need to save the processor state etc here - the request
> is after all to power down the system and not to suspend.  Would calling
> imx6q_suspend_finish() directly work (and hence simplify the code) ?

yes you right. This will work as well.
I'll send changed version after Rafaels feedback for kernel/reboot.c
part.
Russell, can I expect your Signed-off-by for changed patch?

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180509/206f1672/attachment.sig>
