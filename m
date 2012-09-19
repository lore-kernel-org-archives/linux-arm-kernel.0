From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed, 19 Sep 2012 16:45:01 +0200
Subject: [PATCH 4/4] usb: phy: omap-usb2: enable 960Mhz clock for omap5
In-Reply-To: <20120919115647.GI3772@arwen.pp.htv.fi>
References: <1348054229-27362-1-git-send-email-kishon@ti.com>
 <1348054229-27362-5-git-send-email-kishon@ti.com>
 <20120919115647.GI3772@arwen.pp.htv.fi>
Message-ID: <5059DA6D.4070205@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/19/2012 01:56 PM, Felipe Balbi wrote:
> On Wed, Sep 19, 2012 at 05:00:29PM +0530, Kishon Vijay Abraham I wrote:
>> "usb_otg_ss_refclk960m" is needed by usb2 phy present in omap5. For
>> omap4, the clk_get of this clock will fail since it does not have this
>> clock.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  Documentation/devicetree/bindings/usb/usb-phy.txt |    3 +++
>>  drivers/usb/phy/omap-usb2.c                       |   28 ++++++++++++++++++++-
>>  2 files changed, 30 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/usb-phy.txt b/Documentation/devicetree/bindings/usb/usb-phy.txt
>> index 7c5fd89..d5626de 100644
>> --- a/Documentation/devicetree/bindings/usb/usb-phy.txt
>> +++ b/Documentation/devicetree/bindings/usb/usb-phy.txt
>> @@ -24,6 +24,9 @@ Required properties:
>>  add the address of control module phy power register until a driver for
>>  control module is added
>>  
>> +Optional properties:
>> + - has960mhzclk: should be added if the phy needs 960mhz clock
>> +
>>  This is usually a subnode of ocp2scp to which it is connected.
>>  
>>  usb3phy at 4a084400 {
>> diff --git a/drivers/usb/phy/omap-usb2.c b/drivers/usb/phy/omap-usb2.c
>> index d36c282..d6612ba 100644
>> --- a/drivers/usb/phy/omap-usb2.c
>> +++ b/drivers/usb/phy/omap-usb2.c
>> @@ -146,6 +146,7 @@ static int __devinit omap_usb2_probe(struct platform_device *pdev)
>>  	struct omap_usb			*phy;
>>  	struct usb_otg			*otg;
>>  	struct resource			*res;
>> +	struct device_node		*np = pdev->dev.of_node;
>>  
>>  	phy = devm_kzalloc(&pdev->dev, sizeof(*phy), GFP_KERNEL);
>>  	if (!phy) {
>> @@ -190,6 +191,15 @@ static int __devinit omap_usb2_probe(struct platform_device *pdev)
>>  	}
>>  	clk_prepare(phy->wkupclk);
>>  
>> +	if (of_property_read_bool(np, "has960mhzclk")) {
>> +		phy->optclk = devm_clk_get(phy->dev, "usb_otg_ss_refclk960m");
>> +		if (IS_ERR(phy->optclk)) {
>> +			dev_err(&pdev->dev, "unable to get refclk960m\n");
>> +			return PTR_ERR(phy->optclk);
>> +		}
>> +		clk_prepare(phy->optclk);
>> +	}
> 
> instead, can't you just always try to get the clock but ignore the error
> if it fails ?

On imx we add no-op dummy clocks, so that the drivers will always find
all needed clocks. If a clk_get fails it's an error.

> If it works you can set a flag to let you know that you can use that
> optional clock.

Marc
-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 259 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120919/e145a2fb/attachment.sig>
