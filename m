From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 2 Aug 2017 14:27:30 +0100
Subject: [PATCH v2 3/4] drm/bridge: dw-hdmi: add cec driver
In-Reply-To: <4399618.oOUScL5uAk@avalon>
References: <20170731142906.GX31807@n2100.armlinux.org.uk>
 <1884159.hmXKyeR78T@avalon>
 <56537209-32df-8b4e-13cd-19548ad8d1da@xs4all.nl>
 <4399618.oOUScL5uAk@avalon>
Message-ID: <20170802132730.GZ31807@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 02, 2017 at 04:14:34PM +0300, Laurent Pinchart wrote:
> Hi Hans,
> 
> On Wednesday 02 Aug 2017 08:47:23 Hans Verkuil wrote:
> > On 08/02/2017 12:32 AM, Laurent Pinchart wrote:
> > >> +
> > >> +	cec_register_cec_notifier(cec->adap, cec->notify);
> > >> +
> > >> +	return 0;
> > >> +}
> > >> +
> > >> +static int dw_hdmi_cec_remove(struct platform_device *pdev)
> > >> +{
> > >> +	struct dw_hdmi_cec *cec = platform_get_drvdata(pdev);
> > >> +
> > >> +	cec_unregister_adapter(cec->adap);
> > >> +	cec_notifier_put(cec->notify);
> > >> +
> > >> +	return 0;
> > >> +}
> > >> +
> > >> +static struct platform_driver dw_hdmi_cec_driver = {
> > >> +	.probe	= dw_hdmi_cec_probe,
> > >> +	.remove	= dw_hdmi_cec_remove,
> > >> +	.driver = {
> > >> +		.name = "dw-hdmi-cec",
> > >> +	},
> > >> +};
> > >> +module_platform_driver(dw_hdmi_cec_driver);
> > > 
> > > Is there a particular reason why this has to be a separate module instead
> > > of simply calling the CEC init/cleanup functions directly from the main
> > > dw-hdmi driver ?
> > 
> > Not all SoCs that use dw-hdmi also use the dw-hdmi CEC implementation. Some
> > use their own implementation (amlogic).
> 
> Lovely. Of course we need to reinvent the wheel every time, where would the 
> fun be otherwise ?
> 
> > So by implementing the cec-notifier in the dw-hdmi driver and keeping dw-
> > hdmi CEC separate you can easily choose whether or not you want to use this
> > CEC driver or another SoC CEC driver.
> 
> I'm certainly fine with such a split, but I don't think it requires a separate 
> platform_driver. We could use a similar approach as with the HDMI PHY that can 
> also differ between SoCs. The PHY is identified at runtime when possible, and 
> the SoC-specific glue code can override that with a few data fields and 
> function pointers.

Excuse me if I completely lose interest in reworking the driver at this
point, as it's enough of an effort to follow the churn in CEC from one
kernel version to another.  I'm not about to rewrite the driver and
restart the review cycle from scratch and then have several iterations
of having to update it as CEC continues to evolve.

Let's get this driver in mainline, and then if we want further changes
we can do that later.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
