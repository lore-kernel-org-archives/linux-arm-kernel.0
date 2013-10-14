From: peter.chen@freescale.com (Peter Chen)
Date: Mon, 14 Oct 2013 09:41:23 +0800
Subject: [PATCH 07/12] usb: phy-mxs: Add implementation of set_wakeup
In-Reply-To: <201310121144.59501.marex@denx.de>
References: <1381568986-19802-1-git-send-email-peter.chen@freescale.com>
 <1381568986-19802-8-git-send-email-peter.chen@freescale.com>
 <201310121144.59501.marex@denx.de>
Message-ID: <20131014014122.GE3879@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 12, 2013 at 11:44:59AM +0200, Marek Vasut wrote:
> 
> > +static int mxs_phy_set_wakeup(struct usb_phy *x, bool enabled)
> > +{
> > +	struct mxs_phy *mxs_phy = to_mxs_phy(x);
> > +	u32 value = BM_USBPHY_CTRL_ENVBUSCHG_WKUP |
> > +			BM_USBPHY_CTRL_ENDPDMCHG_WKUP |
> > +				BM_USBPHY_CTRL_ENIDCHG_WKUP;
> 
> Does this stuff pass checkpatch at all? I mean, this alignment seems a bit 
> strange.

Yes, it passed.

	u32 value = BM_USBPHY_CTRL_ENVBUSCHG_WKUP |
			BM_USBPHY_CTRL_ENDPDMCHG_WKUP | /* two tabs for last line */
				BM_USBPHY_CTRL_ENIDCHG_WKUP; /* one tab for last line */

Any better suggestions?

> 
> > +	if (enabled) {
> > +		mxs_phy_disconnect_line(mxs_phy, true);
> > +		writel_relaxed(value, x->io_priv + HW_USBPHY_CTRL_SET);
> > +	} else {
> > +		writel_relaxed(value, x->io_priv + HW_USBPHY_CTRL_CLR);
> > +		mxs_phy_disconnect_line(mxs_phy, false);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static int mxs_phy_on_connect(struct usb_phy *phy,
> >  		enum usb_device_speed speed)
> >  {
> > @@ -315,6 +390,10 @@ static int mxs_phy_probe(struct platform_device *pdev)
> >  		}
> >  	}
> > 
> > +	if (of_find_property(np, "disconnect_line_without_vbus", NULL) &&
> > +			mxs_phy->regmap_anatop)
> 
> You might want to introduce a variable here to make the condition shorter:
> 
> var = of_find....
> if (var && mxs_phy->...)

I will change.


-- 

Best Regards,
Peter Chen
