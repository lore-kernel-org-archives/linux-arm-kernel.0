From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 02 Aug 2017 17:22:54 +0300
Subject: [PATCH v2 3/4] drm/bridge: dw-hdmi: add cec driver
In-Reply-To: <f9cddb0a-ed24-d5a4-c85e-ee803cebcfdd@xs4all.nl>
References: <20170731142906.GX31807@n2100.armlinux.org.uk>
 <20170802132730.GZ31807@n2100.armlinux.org.uk>
 <f9cddb0a-ed24-d5a4-c85e-ee803cebcfdd@xs4all.nl>
Message-ID: <2270313.kliK1kl0Jl@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

On Wednesday 02 Aug 2017 15:34:33 Hans Verkuil wrote:
> On 08/02/17 15:27, Russell King - ARM Linux wrote:
> > On Wed, Aug 02, 2017 at 04:14:34PM +0300, Laurent Pinchart wrote:
> >> On Wednesday 02 Aug 2017 08:47:23 Hans Verkuil wrote:
> >>> On 08/02/2017 12:32 AM, Laurent Pinchart wrote:
> >>>>> +
> >>>>> +	cec_register_cec_notifier(cec->adap, cec->notify);
> >>>>> +
> >>>>> +	return 0;
> >>>>> +}
> >>>>> +
> >>>>> +static int dw_hdmi_cec_remove(struct platform_device *pdev)
> >>>>> +{
> >>>>> +	struct dw_hdmi_cec *cec = platform_get_drvdata(pdev);
> >>>>> +
> >>>>> +	cec_unregister_adapter(cec->adap);
> >>>>> +	cec_notifier_put(cec->notify);
> >>>>> +
> >>>>> +	return 0;
> >>>>> +}
> >>>>> +
> >>>>> +static struct platform_driver dw_hdmi_cec_driver = {
> >>>>> +	.probe	= dw_hdmi_cec_probe,
> >>>>> +	.remove	= dw_hdmi_cec_remove,
> >>>>> +	.driver = {
> >>>>> +		.name = "dw-hdmi-cec",
> >>>>> +	},
> >>>>> +};
> >>>>> +module_platform_driver(dw_hdmi_cec_driver);
> >>>> 
> >>>> Is there a particular reason why this has to be a separate module
> >>>> instead of simply calling the CEC init/cleanup functions directly from
> >>>> the main dw-hdmi driver ?
> >>> 
> >>> Not all SoCs that use dw-hdmi also use the dw-hdmi CEC implementation.
> >>> Some use their own implementation (amlogic).
> >> 
> >> Lovely. Of course we need to reinvent the wheel every time, where would
> >> the fun be otherwise ?
> >> 
> >>> So by implementing the cec-notifier in the dw-hdmi driver and keeping
> >>> dw-hdmi CEC separate you can easily choose whether or not you want to
> >>> use this CEC driver or another SoC CEC driver.
> >> 
> >> I'm certainly fine with such a split, but I don't think it requires a
> >> separate platform_driver. We could use a similar approach as with the
> >> HDMI PHY that can also differ between SoCs. The PHY is identified at
> >> runtime when possible, and the SoC-specific glue code can override that
> >> with a few data fields and function pointers.
> > 
> > Excuse me if I completely lose interest in reworking the driver at this
> > point, as it's enough of an effort to follow the churn in CEC from one
> > kernel version to another.  I'm not about to rewrite the driver and
> > restart the review cycle from scratch and then have several iterations
> > of having to update it as CEC continues to evolve.
> > 
> > Let's get this driver in mainline, and then if we want further changes
> > we can do that later.
> 
> +1
> 
> I also don't think the phy idea applies here. CEC implementations range from
> tightly coupled to the HDMI implementation to a completely independent i2c
> device that is unrelated to any HDMI receiver/transmitter. And various
> shades in between those extremes.

Then it should be even simpler. Instead of creating a separate platform device 
for the DW HDMI CEC, we can just call the DW HDMI CEC driver init/cleanup 
functions directly when the IP core implements CEC. When it doesn't, a 
separate device will be described in DT (at least to my understanding, 
otherwise where would it come from ?) and a separate driver would handle it.

> The only thing that is needed is that the CEC device needs to be informed
> when an EDID is read and when the hotplug disappears. The CEC notifier does
> just that and it is already in use, so it is nothing new. No need to rework
> this.

The notifier implementation in patch 1/4 looks good to me (except for the 
missing cec_notifier_put() call that I mentioned in my review).

-- 
Regards,

Laurent Pinchart
