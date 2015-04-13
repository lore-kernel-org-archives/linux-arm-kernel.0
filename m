From: eric.nelson@boundarydevices.com (Eric Nelson)
Date: Mon, 13 Apr 2015 12:48:44 -0700
Subject: [PATCH 1/2] ARM: dts: imx6qdl-sabrelite: add supported LVDS
 displays
In-Reply-To: <1428920545.3192.41.camel@pengutronix.de>
References: <5521E08F.3060407@boundarydevices.com>
 <1428920545.3192.41.camel@pengutronix.de>
Message-ID: <552C1D9C.4090303@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Philipp,

On 04/13/2015 03:22 AM, Philipp Zabel wrote:
> Hi Eric,
> 
> Am Sonntag, den 05.04.2015, 18:25 -0700 schrieb Eric Nelson:
>> Hi Philipp,
>>
>> Sorry for the delayed response. I missed your reply and Shawn pointed
>> it out.
> [...]
>> The use of simple panel seems to add and remove functionality:
>> 	- adds backlight, regulators and enable GPIOs!
>> 	- loses the ability to express timings in DT
> 
> For the simple panel driver Thierry preferred to have a panel database
> in the driver and uniquely identify the panel by its compatible value.
> This will also allow to infer the data mapping and width from
> the panel, and the panel timings are available for the next hardware to
> reuse the same panel (however likely that is).
> 
> The old method with display-timings will stay available, but for
> mainline I think it is better to add the panel to the driver.
> 

I predict that panel-simple.c will get really big, really fast.

Scanning it for panels that match our Okaya 1024x600 panel shows
that there already four with that resolution which seem to differ
only in margin timings.

I think the addition of an optional display-timings node and/or
a VESA GTF mode string would prevent a lot of churn, but this is
a separate topic.

>>> After:
>>> 	ldb {
>>> 		...
>>>
>>> 		lvds-channel at 0 {
>>> 			...
>>>
>>
>> Using port here to point at the panel seems to conflict
>> with the use of ports to point at the IPU.
> 
> I'm sorry, I don't understand what you mean exactly. There are some
> input ports (two on i.MX5, four on i.MX6) that are connected to the IPU,
> and one output port that is connected to the panel, in that order by
> convention. The port id 4 (reg = <4>) uniquely identifies the output
> port on i.MX6.
> 

The full DT for an LVDS channel looks like this:

...	
lvds-channel at 0 {
	#address-cells = <0x00000001>;
	#size-cells = <0x00000000>;
	...
	port at 0 {
		reg = <0x00000000>;
		endpoint {
			remote-endpoint = <0x00000013>;
			linux,phandle = <0x00000039>;
			phandle = <0x00000039>;
		};
	};
	port at 1 {
...	};
	port at 2 {
...	};
	port at 3 {
...	};
	port at 4 {
		reg = <0x00000004>;
		endpoint {
			remote-endpoint = <0x00000017>;
			linux,phandle = <0x00000053>;
			phandle = <0x00000053>;
		};
	};
};

ports 0-3 refer to the LVDS mux and which IPU and display
interface is connected up to the LVDS channel (i.e. the
input to the LVDS display bridge) and port at 4 refer to the
panel.

>>> [snip]
>>>
>>> 	panel {
>>> 		compatible = "edt,etm0700g0dh6", "simple-panel";
>>> 		...
>>>
>>
>> And why would the panel need to point back to the LVDS
>> channel?
> 
> This is the way the bindings are defined right now in
> Documentation/devicetree/bindings/graph.txt, section "Links between
> endpoints". The panel driver itself doesn't use the backlink, but the
> endpoint needs to exist anyway.
> 

Thanks for the reference.

I'm not following the rationale  since in this case, the communication
needs seem to be uni-directional, but okay.

>> [snip]
>>
>> Do you have a working example of how this should be used?
>>
>> My attempts to follow the notes above results in a failure
>> to find a crtc for the LVDS channel.
>>
>> Please advise,
> 
> I have used this patch to connect a HannStar HSD070PWW1 LVDS panel to a
> Nitrogen6X board:
> 

Thanks again. This patch works for me with your prior patch applied:

	https://patchwork.kernel.org/patch/5854771/

> -----8<-----
> diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
> index 0821812..9e52adf 100644
> --- a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
> @@ -122,7 +122,7 @@
>  		status = "okay";
>  	};
>  
> -	backlight_lvds {
> +	backlight_lvds: backlight_lvds {
>  		compatible = "pwm-backlight";
>  		pwms = <&pwm4 0 5000000>;
>  		brightness-levels = <0 4 8 16 32 64 128 255>;
> @@ -130,6 +130,17 @@
>  		power-supply = <&reg_3p3v>;
>  		status = "okay";
>  	};
> +
> +	panel {
> +		compatible = "hannstar,hsd070pww1";
> +		backlight = <&backlight_lvds>;
> +
> +		port {
> +			panel_in: endpoint {
> +				remote-endpoint = <&lvds0_out>;
> +			};
> +		};
> +	};
>  };
>  

This does give me a path to get the equivalent functionality
as my original patches:

	- (if needed) add displays to panel-simple.c
	- update DT in boot loader to fix up displays based on panel
	detection by setting the panel.compatible string value.

I am still left with a quandary, which relates to my comment about
the port selection.

With our current device tree, both the HDMI and LVDS devices
are being mapped to IPU1/DI0 and the same DRM "card":

	~# ls  /sys/class/graphics/fb0/device/drm/card0/card*
	card0-HDMI-A-1	card0-LVDS-1

Since the default i.MX6 graph appears to have links for all four LVDS
mux options, and the path to binding to one of the IPU/DI -> LVDS
channel mappings isn't clear to me.

I have the same question for HDMI and LCD interfaces though, and
this is a separate topic.

Regards,


Eric
