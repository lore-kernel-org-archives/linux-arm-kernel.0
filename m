From: david@lechnology.com (David Lechner)
Date: Mon, 24 Oct 2016 20:39:23 -0500
Subject: [PATCH/RFT v2 12/17] USB: ochi-da8xx: Use a regulator for
 vbus/overcurrent
In-Reply-To: <20161024164634.4330-13-ahaslam@baylibre.com>
References: <20161024164634.4330-1-ahaslam@baylibre.com>
 <20161024164634.4330-13-ahaslam@baylibre.com>
Message-ID: <672c1f1a-58b7-6947-7fb2-acd38fab8597@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/24/2016 11:46 AM, ahaslam at baylibre.com wrote:
> From: Axel Haslam <ahaslam@baylibre.com>
>
> Currently, the da8xx ohci driver uses a set of gpios and callbacks in
> board files to handle vbus and overcurrent irqs form the power supply.
> However, this does not play nice when moving to a DT based boot were
> we wont have board files.
>
> Instead of requesting and handling the gpio, use the regulator framework
> to take care of enabling and disabling vbus power.
> This has the benefit
> that we dont need to pass any more platform data to the driver:
>
> These will be handled by the regulator framework:
> set_power   ->  regulator_enable/regulator_disable
> get_power   ->  regulator_is_enabled
> get_oci     ->  regulator_get_mode
> ocic_notify ->  regulator notification
>
> We can keep the default potpgt and use the regulator start delay instead:
> potpgt      -> regulator startup delay time
>
> The hawk board does not have a GPIO/OVERCURRENT gpio to control vbus,
> (they should not have been decleared/reserved) so, just remove those
> definitions from the hwk board file.
>
> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
> ---


How do you recover after an overcurrent event?

I have configured a fixed-regulator using device-tree, but similar to 
the configuration in the board files here. However, when I shorted out 
the VBUS and caused an overcurrent event, I see nothing in the kernel 
log saying that there was an overcurrent event and after I remove the 
short, the regulator is never turned back on.



> @@ -163,7 +198,6 @@ static int ohci_da8xx_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
>  				  u16 wIndex, char *buf, u16 wLength)
>  {
>  	struct device *dev		= hcd->self.controller;
> -	struct da8xx_ohci_root_hub *hub	= dev_get_platdata(dev);

nit: unnecessary whitespace change

>  	int temp;
>
>  	switch (typeReq) {
