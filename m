From: balbi@ti.com (Felipe Balbi)
Date: Fri, 18 Jan 2013 14:00:22 +0200
Subject: [PATCH 2/4] ARM: OMAP: devices: create device for usb part of
 control module
In-Reply-To: <1358502045-27008-3-git-send-email-kishon@ti.com>
References: <1358502045-27008-1-git-send-email-kishon@ti.com>
 <1358502045-27008-3-git-send-email-kishon@ti.com>
Message-ID: <20130118120022.GB4672@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 18, 2013 at 03:10:43PM +0530, Kishon Vijay Abraham I wrote:
> A seperate driver has been added to handle the usb part of control
> module. A device for the above driver is created here, using the register
> address information to be used by the driver for powering on the PHY and
> for writing to the mailbox.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  arch/arm/mach-omap2/devices.c |   48 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> index 5e304d0..a58b0ce 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -20,6 +20,7 @@
>  #include <linux/pinctrl/machine.h>
>  #include <linux/platform_data/omap4-keypad.h>
>  #include <linux/platform_data/omap_ocp2scp.h>
> +#include <linux/usb/omap_control_usb.h>
>  
>  #include <asm/mach-types.h>
>  #include <asm/mach/map.h>
> @@ -254,6 +255,52 @@ static inline void omap_init_camera(void)
>  #endif
>  }
>  
> +#if IS_ENABLED(CONFIG_OMAP_CONTROL_USB)
> +static struct omap_control_usb_platform_data omap4_control_usb_pdata = {
> +	.has_mailbox = true,
> +};
> +
> +struct resource omap4_control_usb_res[] = {
> +	{
> +		.name	= "control_dev_conf",
> +		.start	= 0x4a002300,
> +		.end	= 0x4a002303,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +	{
> +		.name	= "otghs_control",
> +		.start	= 0x4a00233c,
> +		.end	= 0x4a00233f,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +};
> +
> +static struct platform_device omap4_control_usb = {
> +	.name		= "omap-control-usb",
> +	.id		= -1,
> +	.dev = {
> +		.platform_data = &omap4_control_usb_pdata,
> +	},
> +	.num_resources = 2,
> +	.resource = omap4_control_usb_res,
> +};
> +
> +static inline void __init omap_init_control_usb(void)
> +{
> +	int ret = 0;
> +
> +	if (cpu_is_omap44xx()) {
> +		ret = platform_device_register(&omap4_control_usb);
> +		if (ret)
> +			pr_err("Error registering omap_control_usb device:%d\n",
> +			    ret);
> +	}

you can decrease indentation if you invert the check:

if (!cpu_is_omap44xx())
	return;

if (platform_device_register(.....)
-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130118/5be607ef/attachment.sig>
