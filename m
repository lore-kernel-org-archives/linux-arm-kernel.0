From: balbi@ti.com (Felipe Balbi)
Date: Fri, 14 Jun 2013 04:27:42 +0300
Subject: [PATCH 2/3] USB: OMAP: add omap-otg
In-Reply-To: <20130613223711.GD18360@blackmetal.musicnaut.iki.fi>
References: <1370817606-1008-1-git-send-email-aaro.koskinen@iki.fi>
 <1370817606-1008-3-git-send-email-aaro.koskinen@iki.fi>
 <20130612151326.GE15056@arwen.pp.htv.fi>
 <20130613223711.GD18360@blackmetal.musicnaut.iki.fi>
Message-ID: <20130614012742.GA20258@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jun 14, 2013 at 01:37:11AM +0300, Aaro Koskinen wrote:
> Hi,
> 
> On Wed, Jun 12, 2013 at 06:13:26PM +0300, Felipe Balbi wrote:
> > On Mon, Jun 10, 2013 at 01:40:05AM +0300, Aaro Koskinen wrote:
> > > +void omap_otg_set_mode(enum omap_otg_mode mode)
> > > +{
> > > +	if (!otg_dev) {
> > > +		WARN(1, "%s: controller not present\n", __func__);
> > > +		return;
> > > +	}
> > > +	mutex_lock(&otg_dev->serialize);
> > > +	switch (mode) {
> > > +	case OMAP_OTG_MODE_DEVICE:
> > > +		/*
> > > +		 * Set B-session valid.
> > > +		 */
> > > +		omap_otg_ctrl(OMAP_OTG_ID | OMAP_OTG_BSESSVLD);
> > > +		break;
> > > +	case OMAP_OTG_MODE_HOST:
> > > +		/*
> > > +		 * Set A-session valid.
> > > +		 */
> > > +		omap_otg_ctrl(OMAP_OTG_ASESSVLD);
> > > +		break;
> > > +	case OMAP_OTG_MODE_DISCONNECT:
> > > +		/*
> > > +		 * Set B-session end to indicate no VBUS.
> > > +		 */
> > > +		omap_otg_ctrl(OMAP_OTG_ID | OMAP_OTG_BSESSEND);
> > > +		break;
> > > +	default:
> > > +		WARN(1, "%s: unknown mode: %d\n", __func__, mode);
> > > +	}
> > > +	mutex_unlock(&otg_dev->serialize);
> > > +}
> > > +EXPORT_SYMBOL_GPL(omap_otg_set_mode);
> > 
> > looks like this should provide a extcon interface for its users.
> 
> Is there any examples available? Anyway, I'll look into this.

In extcon tree there are some patches from Kishon adding that to
dwc3-omap.c :-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130614/46d8465b/attachment.sig>
