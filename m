From: peter.chen@freescale.com (Peter Chen)
Date: Fri, 8 Mar 2013 14:27:58 +0800
Subject: [PATCH v11 6/9] usb: chipidea: add vbus regulator control
In-Reply-To: <20130307095248.GL9171@arwen.pp.htv.fi>
References: <1362563800-16673-1-git-send-email-peter.chen@freescale.com>
 <1362563800-16673-7-git-send-email-peter.chen@freescale.com>
 <20130306112916.GT28587@arwen.pp.htv.fi>
 <20130307024102.GD20470@nchen-desktop>
 <20130307095248.GL9171@arwen.pp.htv.fi>
Message-ID: <20130308062757.GB16076@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 07, 2013 at 11:52:48AM +0200, Felipe Balbi wrote:
> On Thu, Mar 07, 2013 at 10:41:03AM +0800, Peter Chen wrote:
> > On Wed, Mar 06, 2013 at 01:29:16PM +0200, Felipe Balbi wrote:
> > > Hi,
> > > 
> > > On Wed, Mar 06, 2013 at 05:56:37PM +0800, Peter Chen wrote:
> > > > For boards which have board level vbus control (eg, gpio), we
> > > > need to operation vbus according to below rules:
> > > > - For host, the vbus should always be on.
> > > > - For otg, the vbus needs to be turned on/off when usb role switches.
> > > > 
> > > > We put vbus operation to host as host is the only vbus user,
> > > > When we are at host mode, the vbus is on, when we are not at
> > > > host mode, vbus should be off.
> > > > 
> > > > Signed-off-by: Peter Chen <peter.chen@freescale.com>
> > > > ---
> > > >  
> > > > @@ -603,6 +594,7 @@ static int ci_hdrc_probe(struct platform_device *pdev)
> > > >  
> > > >  	ci->dev = dev;
> > > >  	ci->platdata = dev->platform_data;
> > > > +	ci->reg_vbus = ci->platdata->reg_vbus;
> > > 
> > > nak, teach ci_hdrc_probe() how to get its own regulator.
> > > 
> > > >  	if (ci->platdata->phy)
> > > >  		ci->transceiver = ci->platdata->phy;
> > > 
> > > this should happen for PHYs as well btw.
> > 
> > Like I said at previous email, core code has NO DTS entry.
> 
> that's your problem :-)
> 
> You can just as well create both nodes in DTS file:
> 
> ci13xx_fsl at foo {
> 	compatible = "fsl,chipidea";
> 	reg = <foo size>;
> 	blablabla
> 	ranges;
> 
> 	chipidea_core at bar {
> 		compatible = "chipidea";
> 		reg <bar size>;
> 		blablabla
> 	};
> };
> 
> then assign the regulator to chipidea itself, not to the glue.

No, that will make things more complicated at current chipidea driver.

Differ with dwc3, chipidea created its platform data at glue layer,
and chipidea core owing this data when platform device is created.

If we also want get things from DT node, we need to get node from
glue layer as this node is NOT belonged to chipidea core's pdev.
(We can't get it through compatible string as compatible string
 is the same from every chipidea device)

Convert platform data to DT for chipidea core is a big job,
it is out of scope of this patch. If Alex also thinks we
are deserved to do it, I can do it later.

> 
> -- 
> balbi



-- 

Best Regards,
Peter Chen
