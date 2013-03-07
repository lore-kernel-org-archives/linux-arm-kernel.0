From: balbi@ti.com (Felipe Balbi)
Date: Thu, 7 Mar 2013 11:52:48 +0200
Subject: [PATCH v11 6/9] usb: chipidea: add vbus regulator control
In-Reply-To: <20130307024102.GD20470@nchen-desktop>
References: <1362563800-16673-1-git-send-email-peter.chen@freescale.com>
 <1362563800-16673-7-git-send-email-peter.chen@freescale.com>
 <20130306112916.GT28587@arwen.pp.htv.fi>
 <20130307024102.GD20470@nchen-desktop>
Message-ID: <20130307095248.GL9171@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 07, 2013 at 10:41:03AM +0800, Peter Chen wrote:
> On Wed, Mar 06, 2013 at 01:29:16PM +0200, Felipe Balbi wrote:
> > Hi,
> > 
> > On Wed, Mar 06, 2013 at 05:56:37PM +0800, Peter Chen wrote:
> > > For boards which have board level vbus control (eg, gpio), we
> > > need to operation vbus according to below rules:
> > > - For host, the vbus should always be on.
> > > - For otg, the vbus needs to be turned on/off when usb role switches.
> > > 
> > > We put vbus operation to host as host is the only vbus user,
> > > When we are at host mode, the vbus is on, when we are not at
> > > host mode, vbus should be off.
> > > 
> > > Signed-off-by: Peter Chen <peter.chen@freescale.com>
> > > ---
> > >  
> > > @@ -603,6 +594,7 @@ static int ci_hdrc_probe(struct platform_device *pdev)
> > >  
> > >  	ci->dev = dev;
> > >  	ci->platdata = dev->platform_data;
> > > +	ci->reg_vbus = ci->platdata->reg_vbus;
> > 
> > nak, teach ci_hdrc_probe() how to get its own regulator.
> > 
> > >  	if (ci->platdata->phy)
> > >  		ci->transceiver = ci->platdata->phy;
> > 
> > this should happen for PHYs as well btw.
> 
> Like I said at previous email, core code has NO DTS entry.

that's your problem :-)

You can just as well create both nodes in DTS file:

ci13xx_fsl at foo {
	compatible = "fsl,chipidea";
	reg = <foo size>;
	blablabla
	ranges;

	chipidea_core at bar {
		compatible = "chipidea";
		reg <bar size>;
		blablabla
	};
};

then assign the regulator to chipidea itself, not to the glue.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130307/e43cfb62/attachment.sig>
