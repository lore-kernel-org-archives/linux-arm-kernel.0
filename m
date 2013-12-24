From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 24 Dec 2013 10:05:52 +0800
Subject: [PATCH v7 06/14] usb: phy-mxs: Add anatop regmap
In-Reply-To: <20131224012010.GA13518@shlinux1.ap.freescale.net>
References: <1387525930-27313-1-git-send-email-peter.chen@freescale.com>
 <1387525930-27313-7-git-send-email-peter.chen@freescale.com>
 <20131224001457.GA1128@S2101-09.ap.freescale.net>
 <20131224012010.GA13518@shlinux1.ap.freescale.net>
Message-ID: <20131224020550.GB1128@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 24, 2013 at 09:20:11AM +0800, Peter Chen wrote:
> > > @@ -226,6 +235,16 @@ static int mxs_phy_probe(struct platform_device *pdev)
> > >  
> > >  	platform_set_drvdata(pdev, mxs_phy);
> > >  
> > > +	if (mxs_phy->data->flags & MXS_PHY_HAS_ANATOP) {
> > > +		mxs_phy->regmap_anatop = syscon_regmap_lookup_by_phandle
> > > +			(np, "fsl,anatop");
> > > +		if (IS_ERR(mxs_phy->regmap_anatop)) {
> > > +			dev_dbg(&pdev->dev,
> > > +				"failed to find regmap for anatop\n");
> > > +			return PTR_ERR(mxs_phy->regmap_anatop);
> > 
> > I'm looking at the merge dependency that Felipe mentions, and just think
> > of the DTB compatibility thing.  Does the above code mean that USB will
> > be broken if someone runs the new kernel with an old DTB on his board?
> > 
> > We're entering the stage where we need to maintain the DTB compatibility
> > in kernel.  That said, if users choose to upgrade their kernel only
> > (running with an old DTB), it's okay we do not give them new
> > features, but we shouldn't cause any regression/breakage for them.
> > 
> 
> Then, this patch needs to change for old imx6 DTB. I will use of_find_property 
> like my previous version patch, do you think so?
> 
> http://marc.info/?l=linux-usb&m=138361742123380&w=2

Yes.  Basically, we need to add the new property as optional one and
keep the driver work in the existing way if the property is absent.

Shawn
