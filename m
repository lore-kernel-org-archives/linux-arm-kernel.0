From: balbi@ti.com (Felipe Balbi)
Date: Fri, 8 Mar 2013 09:26:24 +0200
Subject: [PATCH v11 6/9] usb: chipidea: add vbus regulator control
In-Reply-To: <20130308062757.GB16076@nchen-desktop>
References: <1362563800-16673-1-git-send-email-peter.chen@freescale.com>
 <1362563800-16673-7-git-send-email-peter.chen@freescale.com>
 <20130306112916.GT28587@arwen.pp.htv.fi>
 <20130307024102.GD20470@nchen-desktop>
 <20130307095248.GL9171@arwen.pp.htv.fi>
 <20130308062757.GB16076@nchen-desktop>
Message-ID: <20130308072624.GF21589@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Mar 08, 2013 at 02:27:58PM +0800, Peter Chen wrote:
> > > > > For boards which have board level vbus control (eg, gpio), we
> > > > > need to operation vbus according to below rules:
> > > > > - For host, the vbus should always be on.
> > > > > - For otg, the vbus needs to be turned on/off when usb role switches.
> > > > > 
> > > > > We put vbus operation to host as host is the only vbus user,
> > > > > When we are at host mode, the vbus is on, when we are not at
> > > > > host mode, vbus should be off.
> > > > > 
> > > > > Signed-off-by: Peter Chen <peter.chen@freescale.com>
> > > > > ---
> > > > >  
> > > > > @@ -603,6 +594,7 @@ static int ci_hdrc_probe(struct platform_device *pdev)
> > > > >  
> > > > >  	ci->dev = dev;
> > > > >  	ci->platdata = dev->platform_data;
> > > > > +	ci->reg_vbus = ci->platdata->reg_vbus;
> > > > 
> > > > nak, teach ci_hdrc_probe() how to get its own regulator.
> > > > 
> > > > >  	if (ci->platdata->phy)
> > > > >  		ci->transceiver = ci->platdata->phy;
> > > > 
> > > > this should happen for PHYs as well btw.
> > > 
> > > Like I said at previous email, core code has NO DTS entry.
> > 
> > that's your problem :-)
> > 
> > You can just as well create both nodes in DTS file:
> > 
> > ci13xx_fsl at foo {
> > 	compatible = "fsl,chipidea";
> > 	reg = <foo size>;
> > 	blablabla
> > 	ranges;
> > 
> > 	chipidea_core at bar {
> > 		compatible = "chipidea";
> > 		reg <bar size>;
> > 		blablabla
> > 	};
> > };
> > 
> > then assign the regulator to chipidea itself, not to the glue.
> 
> No, that will make things more complicated at current chipidea driver.

so what ? We're not here to choose the easy approach, we're here to
choose the 'right' approach. If that means rewritting a bunch of
chipidea core code, so be it.

> Differ with dwc3, chipidea created its platform data at glue layer,
> and chipidea core owing this data when platform device is created.

yeah yeah, but that's just because chipidea core doesn't understand DT.

It should take you no more than a day to teach it about DT, though. Not
sure what you're complaining about.

> If we also want get things from DT node, we need to get node from
> glue layer as this node is NOT belonged to chipidea core's pdev.

which DT node are you talking about ? you want chipidea core to have
access to glue's DT node ? Are you insane ?

Currently your regulator only belongs to glue because chipidea core
doesn't know about DT, if you teach it about DT, then you move the
regulator to chipidea core and it will not need access to glue's DT
node.

> (We can't get it through compatible string as compatible string
>  is the same from every chipidea device)

you're not making sense.

If you wanna add DT support for chipidea core, you need to come up with
a compatible that makes sense. It won't be fsl,* because chipidea core
doesn't belong to fsl.

> Convert platform data to DT for chipidea core is a big job,

no it's not.

> it is out of scope of this patch. If Alex also thinks we

yeah, but this patch makes no sense. The right thing (TM) to do is, as I
have said multiple times before, to teach chipidea core about DT. Please
stop trying to find excuses for not doing the work you need to do; You
would've already done it if you had spent so much of everybody's time
trying to find excuses why not to do it and why Alex should accept your
broken patches.

Have you already forgotten how many issues were found in each and every
version of your patchset ? There's a reason why we're revieweing v11,
right ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130308/c4c78e1f/attachment.sig>
