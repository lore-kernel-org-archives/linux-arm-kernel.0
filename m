From: hzpeterchen@gmail.com (Peter Chen)
Date: Tue, 29 Dec 2015 09:42:04 +0800
Subject: usb: wrong compatible string for MX23?
In-Reply-To: <671962377.218806.94ae5d1c-a34e-4695-a401-70265736fafb.open-xchange@email.1und1.de>
References: <671962377.218806.94ae5d1c-a34e-4695-a401-70265736fafb.open-xchange@email.1und1.de>
Message-ID: <20151229014203.GB20712@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 29, 2015 at 12:45:51AM +0100, Stefan Wahren wrote:
> Hi Peter,
> 
> i was inspired by the discussion about the USB runtime suspend issue on MX28. I
> think i've found another issue.
> In the dtsi for the MX23 the usb node has the following compatible:
> 
> usb0: usb at 80080000 {
>         compatible = "fsl,imx23-usb", "fsl,imx27-usb";
> ...
> 
> But in ci_hdrc_imx.c there is only "fsl,imx27-usb" and "fsl,imx28-usb" defined.
> 
> So in case of a MX23 board it would fallback to "fsl,imx27-usb", which is IMHO
> not correct.

No, it is correct. All i.mx SoC series use the same controller core, and
the first user is imx27, the reason why we have a compatible string for
imx28 is that imx28 needs special handling when write register.

> 
> Which way to fix this issue would you suggest:
> 
> a) extend ci_hdrc_imx.c and the binding by copying the imx28 platform and name
> it imx23
> 
> b) rename the compatible string from "fsl,imx23-usb" to "fsl-imx28-usb"
> 

But one thing we can improve that is imx23 needs the flag
CI_HDRC_TURN_VBUS_EARLY_ON, the platform flag would like below:

static const struct ci_hdrc_imx_platform_flag imx23_usb_data = {
	.flags = CI_HDRC_TURN_VBUS_EARLY_ON |
		CI_HDRC_DISABLE_STREAMING,

I prefer the way a), thanks.

-- 

Best Regards,
Peter Chen
