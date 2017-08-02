From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 02 Aug 2017 16:14:34 +0300
Subject: [PATCH v2 3/4] drm/bridge: dw-hdmi: add cec driver
In-Reply-To: <56537209-32df-8b4e-13cd-19548ad8d1da@xs4all.nl>
References: <20170731142906.GX31807@n2100.armlinux.org.uk>
 <1884159.hmXKyeR78T@avalon> <56537209-32df-8b4e-13cd-19548ad8d1da@xs4all.nl>
Message-ID: <4399618.oOUScL5uAk@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

On Wednesday 02 Aug 2017 08:47:23 Hans Verkuil wrote:
> On 08/02/2017 12:32 AM, Laurent Pinchart wrote:
> >> +
> >> +	cec_register_cec_notifier(cec->adap, cec->notify);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static int dw_hdmi_cec_remove(struct platform_device *pdev)
> >> +{
> >> +	struct dw_hdmi_cec *cec = platform_get_drvdata(pdev);
> >> +
> >> +	cec_unregister_adapter(cec->adap);
> >> +	cec_notifier_put(cec->notify);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static struct platform_driver dw_hdmi_cec_driver = {
> >> +	.probe	= dw_hdmi_cec_probe,
> >> +	.remove	= dw_hdmi_cec_remove,
> >> +	.driver = {
> >> +		.name = "dw-hdmi-cec",
> >> +	},
> >> +};
> >> +module_platform_driver(dw_hdmi_cec_driver);
> > 
> > Is there a particular reason why this has to be a separate module instead
> > of simply calling the CEC init/cleanup functions directly from the main
> > dw-hdmi driver ?
> 
> Not all SoCs that use dw-hdmi also use the dw-hdmi CEC implementation. Some
> use their own implementation (amlogic).

Lovely. Of course we need to reinvent the wheel every time, where would the 
fun be otherwise ?

> So by implementing the cec-notifier in the dw-hdmi driver and keeping dw-
> hdmi CEC separate you can easily choose whether or not you want to use this
> CEC driver or another SoC CEC driver.

I'm certainly fine with such a split, but I don't think it requires a separate 
platform_driver. We could use a similar approach as with the HDMI PHY that can 
also differ between SoCs. The PHY is identified at runtime when possible, and 
the SoC-specific glue code can override that with a few data fields and 
function pointers.

> >> +MODULE_AUTHOR("Russell King <rmk+kernel@armlinux.org.uk>");
> >> +MODULE_DESCRIPTION("Synopsys Designware HDMI CEC driver for i.MX");
> >> +MODULE_LICENSE("GPL");
> >> +MODULE_ALIAS(PLATFORM_MODULE_PREFIX "dw-hdmi-cec");

-- 
Regards,

Laurent Pinchart
