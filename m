From: Hong-Xing.Zhu@freescale.com (Hong-Xing.Zhu at freescale.com)
Date: Mon, 20 Jan 2014 03:28:24 +0000
Subject: imx6 eSATA
In-Reply-To: <20140119041534.GF16158@S2101-09.ap.freescale.net>
References: <20140118184427.GJ15937@n2100.arm.linux.org.uk>
 <20140119041534.GF16158@S2101-09.ap.freescale.net>
Message-ID: <ca42a80b62fd4accbdaa418e226be782@BLUPR03MB136.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi:

> -----Original Message-----
> From: Shawn Guo [mailto:shawn.guo at linaro.org]
> Sent: Sunday, January 19, 2014 12:16 PM
> To: Russell King - ARM Linux
> Cc: Sascha Hauer; Zhu Richard-R65037; linux-arm-kernel at lists.infradead.org
> Subject: Re: imx6 eSATA
> 
> Copy Richard who might be better to clarify.
> 
> Shawn
> 
> On Sat, Jan 18, 2014 at 06:44:27PM +0000, Russell King - ARM Linux wrote:
> > So, I see we have AHCI support for SATA on the iMX6.  Great... but it
> > doesn't work on the cubox-i, because the phy settings are wrong.
> >
> > The Cubox-i requires GPR13 set to 0x0593A044 - I haven't decoded what
> > this means yet, but it's different from the 0x0593E4A4 which is

 [Richard] About the configurations of GPR13, first of all, this parameters are used to configure
imx6q ahci sata phy and to co-operated with board properly.
The differences between, 0x0593A044 and 0x0593E4A4 are listed below:

0x0593E4A4 enable the SATA PHY - Spread Spectrum Enable[bit 14]
0x0593A044 doesn't enable the SATA PHY - Spread Spectrum Enable[bit 14]

0x0593E4A4: SATA PHY Tx -Transmit Boost Control[bit10-7] 3.33 dB
0x0593A044: SATA PHY Tx -Transmit Boost Control[bit10-7] 0 dB

0x0593E4A4: SATA PHY - Transmit level settings[bit6-2] 1.025V
0x0593A044: SATA PHY - Transmit level settings[bit6-2] 1.104V

> > currently hard-coded into the driver (and I've independently tested
> > that this is indeed required.)
> >
> > So, there's presently no DT properties for this - given that these
> > parameters would be board specific, it surprises me that this has not
> > been thought about, and properties already generated, because now it
> > means that we need to _add_ new properties to this driver.
> >
> > Also, this PDDQ mode thing, which can't be recovered except by reset.
> > This is another illustration why Linux is unfriendly - the thing can
> > silently go into this power down mode which is irrecoverable without
> > any messages being generated nor any hints how to avoid it - maybe
> > this should also be a DT property, not just a command line option.
> >
> > More importantly, maybe we should print a message when we discover
> > that there's nothing connected and we're going to enter this mode -
> > maybe something like this:
> >
> > diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c index
> > 3e23e9941dad..0a1ae7213992 100644
> > --- a/drivers/ata/ahci_imx.c
> > +++ b/drivers/ata/ahci_imx.c
> > @@ -77,6 +77,10 @@ static void ahci_imx_error_handler(struct ata_port *ap)
> >  			!IMX6Q_GPR13_SATA_MPLL_CLK_EN);
> >  	clk_disable_unprepare(imxpriv->sata_ref_clk);
> >  	imxpriv->no_device = true;
> > +
> > +	dev_info(ap->dev, "no device, link disabled until next reset.\n");
> > +	dev_info(ap->dev, "pass " MODULE_PARAM_PREFIX
> > +		 ".hotplug=1 to enable link hotplug support\n");
> >  }
> >
> >  static struct ata_port_operations ahci_imx_ops = {
> >
> >
> > --
> > FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
> > in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
> > Estimate before purchase was "up to 13.2Mbit".

Best Regards
Richard Zhu
