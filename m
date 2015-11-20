From: agross@codeaurora.org (Andy Gross)
Date: Fri, 20 Nov 2015 09:54:12 -0600
Subject: [PATCH 2/4] usb: dwc3: qcom: Configure TCSR phy mux register
In-Reply-To: <87a8q8emme.fsf@saruman.tx.rr.com>
References: <1448008509-8913-1-git-send-email-agross@codeaurora.org>
 <1448008509-8913-3-git-send-email-agross@codeaurora.org>
 <87a8q8emme.fsf@saruman.tx.rr.com>
Message-ID: <20151120155411.GB8722@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 20, 2015 at 09:06:33AM -0600, Felipe Balbi wrote:
> 
> Hi,
> 
> Andy Gross <agross@codeaurora.org> writes:
> > This patch adds automatic configuration of the TCSR phy mux register based on
> > the syscon-tcsr devicetree entry.  This configuration is optional, as some
> > platforms may not require the mux selection.
> >
> > Signed-off-by: Andy Gross <agross@codeaurora.org>
> 
> just when I find a way to make a generic dwc3-of-simple.c glue layer :-p
> 
> I can, certainly drop my patches but I need more details on the syscon
> usage below.
> 
> > ---
> >  drivers/usb/dwc3/dwc3-qcom.c | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >
> > diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> > index 0880260..fcf264c 100644
> > --- a/drivers/usb/dwc3/dwc3-qcom.c
> > +++ b/drivers/usb/dwc3/dwc3-qcom.c
> > @@ -17,6 +17,8 @@
> >  #include <linux/of.h>
> >  #include <linux/of_platform.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/mfd/syscon.h>
> > +#include <linux/regmap.h>
> >  
> >  struct dwc3_qcom {
> >  	struct device		*dev;
> > @@ -30,6 +32,9 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
> >  {
> >  	struct device_node *node = pdev->dev.of_node;
> >  	struct dwc3_qcom *qdwc;
> > +	struct regmap *regmap;
> > +	u32 mux_offset;
> > +	u32 mux_bit;
> >  	int ret;
> >  
> >  	qdwc = devm_kzalloc(&pdev->dev, sizeof(*qdwc), GFP_KERNEL);
> > @@ -58,6 +63,26 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
> >  		qdwc->sleep_clk = NULL;
> >  	}
> >  
> > +	/* look for tcsr and if present, provision it */
> > +	regmap = syscon_regmap_lookup_by_phandle(node, "syscon-tcsr");
> > +	if (!IS_ERR(regmap)) {
> > +		if (of_property_read_u32_index(node, "syscon-tcsr", 1,
> > +					       &mux_offset)) {
> > +			dev_err(qdwc->dev, "missing USB TCSR mux offset\n");
> > +			return -EINVAL;
> > +		}
> > +		if (of_property_read_u32_index(node, "syscon-tcsr", 2,
> > +					       &mux_bit)) {
> > +			dev_err(qdwc->dev, "missing USB TCSR mux bit\n");
> > +			return -EINVAL;
> > +		}
> > +
> > +		regmap_update_bits(regmap, mux_offset, BIT(mux_bit),
> > +				   BIT(mux_bit));
> 
> what is tcsr and what does it ? It also seems to be optional, why's that ?
> 
> -- 
> balbi

The syscon is to set the mux selection for the phys.  Our hardware has a
steering mux between hsic and dwc3 and setting this to 1 steers the phys to the
right controller.

It is optional because not all platforms appear to have this stupidity.


-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
