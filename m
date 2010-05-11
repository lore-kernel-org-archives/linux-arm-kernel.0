From: s.hauer@pengutronix.de (s.hauer at pengutronix.de)
Date: Tue, 11 May 2010 17:44:47 +0200
Subject: [PATCH 1/3] mx31moboard: Fix usb PHY reset
In-Reply-To: <4BE91ABB.40000@epfl.ch>
References: <1273513795-28247-1-git-send-email-philippe.retornaz@epfl.ch>
	<1273513795-28247-2-git-send-email-philippe.retornaz@epfl.ch>
	<4BE91ABB.40000@epfl.ch>
Message-ID: <20100511154447.GA31199@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 11, 2010 at 10:52:11AM +0200, Valentin Longchamp wrote:
> On 05/10/2010 07:49 PM, Philippe R?tornaz wrote:
>> Setup the pad with correct pull-up/down before doing the reset.
>> Assert the PHY enable signal so the reset is really done.
>
> For Sascha and other people involved in mx31 support: as I am ending my  
> thesis and I will leave the lab afterwards, Philippe is replacing me for  
> the Linux support of the mx31moboard. We still discuss the patches  
> together, but he now is the one that writes and pushes them.

Ok, I won't wait for your ack then.

Sascha

>
> Acked-by: Valentin Longchamp<valentin.longchamp@epfl.ch>
>
>>
>> Signed-off-by: Philippe R?tornaz<philippe.retornaz@epfl.ch>
>> ---
>>   arch/arm/mach-mx3/mach-mx31moboard.c |   98 +++++++++++++---------------------
>>   1 files changed, 37 insertions(+), 61 deletions(-)
>>
>> diff --git a/arch/arm/mach-mx3/mach-mx31moboard.c b/arch/arm/mach-mx3/mach-mx31moboard.c
>> index fccb920..5c44489 100644
>> --- a/arch/arm/mach-mx3/mach-mx31moboard.c
>> +++ b/arch/arm/mach-mx3/mach-mx31moboard.c
>> @@ -306,37 +306,51 @@ static struct imxmmc_platform_data sdhc1_pdata = {
>>    * this pin is dedicated for all mx31moboard systems, so we do it here
>>    */
>>   #define USB_RESET_B	IOMUX_TO_GPIO(MX31_PIN_GPIO1_0)
>> -
>> -static void usb_xcvr_reset(void)
>> -{
>> -	gpio_request(USB_RESET_B, "usb-reset");
>> -	gpio_direction_output(USB_RESET_B, 0);
>> -	mdelay(1);
>> -	gpio_set_value(USB_RESET_B, 1);
>> -}
>> -
>>   #define USB_PAD_CFG (PAD_CTL_DRV_MAX | PAD_CTL_SRE_FAST | PAD_CTL_HYS_CMOS | \
>> -			PAD_CTL_ODE_CMOS | PAD_CTL_100K_PU)
>> +		      PAD_CTL_ODE_CMOS)
>>
>>   #define OTG_EN_B IOMUX_TO_GPIO(MX31_PIN_USB_OC)
>> +#define USBH2_EN_B IOMUX_TO_GPIO(MX31_PIN_SCK6)
>>
>> -static void moboard_usbotg_init(void)
>> +static void usb_xcvr_reset(void)
>>   {
>> -	mxc_iomux_set_pad(MX31_PIN_USBOTG_DATA0, USB_PAD_CFG);
>> -	mxc_iomux_set_pad(MX31_PIN_USBOTG_DATA1, USB_PAD_CFG);
>> -	mxc_iomux_set_pad(MX31_PIN_USBOTG_DATA2, USB_PAD_CFG);
>> -	mxc_iomux_set_pad(MX31_PIN_USBOTG_DATA3, USB_PAD_CFG);
>> -	mxc_iomux_set_pad(MX31_PIN_USBOTG_DATA4, USB_PAD_CFG);
>> -	mxc_iomux_set_pad(MX31_PIN_USBOTG_DATA5, USB_PAD_CFG);
>> -	mxc_iomux_set_pad(MX31_PIN_USBOTG_DATA6, USB_PAD_CFG);
>> -	mxc_iomux_set_pad(MX31_PIN_USBOTG_DATA7, USB_PAD_CFG);
>> -	mxc_iomux_set_pad(MX31_PIN_USBOTG_CLK, USB_PAD_CFG);
>> -	mxc_iomux_set_pad(MX31_PIN_USBOTG_DIR, USB_PAD_CFG);
>> -	mxc_iomux_set_pad(MX31_PIN_USBOTG_NXT, USB_PAD_CFG);
>> -	mxc_iomux_set_pad(MX31_PIN_USBOTG_STP, USB_PAD_CFG);
>> +	mxc_iomux_set_pad(MX31_PIN_USBOTG_DATA0, USB_PAD_CFG | PAD_CTL_100K_PD);
>> +	mxc_iomux_set_pad(MX31_PIN_USBOTG_DATA1, USB_PAD_CFG | PAD_CTL_100K_PD);
>> +	mxc_iomux_set_pad(MX31_PIN_USBOTG_DATA2, USB_PAD_CFG | PAD_CTL_100K_PD);
>> +	mxc_iomux_set_pad(MX31_PIN_USBOTG_DATA3, USB_PAD_CFG | PAD_CTL_100K_PD);
>> +	mxc_iomux_set_pad(MX31_PIN_USBOTG_DATA4, USB_PAD_CFG | PAD_CTL_100K_PD);
>> +	mxc_iomux_set_pad(MX31_PIN_USBOTG_DATA5, USB_PAD_CFG | PAD_CTL_100K_PD);
>> +	mxc_iomux_set_pad(MX31_PIN_USBOTG_DATA6, USB_PAD_CFG | PAD_CTL_100K_PD);
>> +	mxc_iomux_set_pad(MX31_PIN_USBOTG_DATA7, USB_PAD_CFG | PAD_CTL_100K_PD);
>> +	mxc_iomux_set_pad(MX31_PIN_USBOTG_CLK, USB_PAD_CFG | PAD_CTL_100K_PU);
>> +	mxc_iomux_set_pad(MX31_PIN_USBOTG_DIR, USB_PAD_CFG | PAD_CTL_100K_PU);
>> +	mxc_iomux_set_pad(MX31_PIN_USBOTG_NXT, USB_PAD_CFG | PAD_CTL_100K_PU);
>> +	mxc_iomux_set_pad(MX31_PIN_USBOTG_STP, USB_PAD_CFG | PAD_CTL_100K_PU);
>> +
>> +	mxc_iomux_set_gpr(MUX_PGP_UH2, true);
>> +	mxc_iomux_set_pad(MX31_PIN_USBH2_CLK, USB_PAD_CFG | PAD_CTL_100K_PU);
>> +	mxc_iomux_set_pad(MX31_PIN_USBH2_DIR, USB_PAD_CFG | PAD_CTL_100K_PU);
>> +	mxc_iomux_set_pad(MX31_PIN_USBH2_NXT, USB_PAD_CFG | PAD_CTL_100K_PU);
>> +	mxc_iomux_set_pad(MX31_PIN_USBH2_STP, USB_PAD_CFG | PAD_CTL_100K_PU);
>> +	mxc_iomux_set_pad(MX31_PIN_USBH2_DATA0, USB_PAD_CFG | PAD_CTL_100K_PD);
>> +	mxc_iomux_set_pad(MX31_PIN_USBH2_DATA1, USB_PAD_CFG | PAD_CTL_100K_PD);
>> +	mxc_iomux_set_pad(MX31_PIN_SRXD6, USB_PAD_CFG | PAD_CTL_100K_PD);
>> +	mxc_iomux_set_pad(MX31_PIN_STXD6, USB_PAD_CFG | PAD_CTL_100K_PD);
>> +	mxc_iomux_set_pad(MX31_PIN_SFS3, USB_PAD_CFG | PAD_CTL_100K_PD);
>> +	mxc_iomux_set_pad(MX31_PIN_SCK3, USB_PAD_CFG | PAD_CTL_100K_PD);
>> +	mxc_iomux_set_pad(MX31_PIN_SRXD3, USB_PAD_CFG | PAD_CTL_100K_PD);
>> +	mxc_iomux_set_pad(MX31_PIN_STXD3, USB_PAD_CFG | PAD_CTL_100K_PD);
>>
>>   	gpio_request(OTG_EN_B, "usb-udc-en");
>>   	gpio_direction_output(OTG_EN_B, 0);
>> +	gpio_request(USBH2_EN_B, "usbh2-en");
>> +	gpio_direction_output(USBH2_EN_B, 0);
>> +
>> +	gpio_request(USB_RESET_B, "usb-reset");
>> +	gpio_direction_output(USB_RESET_B, 0);
>> +	mdelay(1);
>> +	gpio_set_value(USB_RESET_B, 1);
>> +	mdelay(1);
>>   }
>>
>>   static struct fsl_usb2_platform_data usb_pdata = {
>> @@ -346,44 +360,7 @@ static struct fsl_usb2_platform_data usb_pdata = {
>>
>>   #if defined(CONFIG_USB_ULPI)
>>
>> -#define USBH2_EN_B IOMUX_TO_GPIO(MX31_PIN_SCK6)
>> -
>> -static int moboard_usbh2_hw_init(struct platform_device *pdev)
>> -{
>> -	int ret;
>> -
>> -	mxc_iomux_set_gpr(MUX_PGP_UH2, true);
>> -
>> -	mxc_iomux_set_pad(MX31_PIN_USBH2_CLK, USB_PAD_CFG);
>> -	mxc_iomux_set_pad(MX31_PIN_USBH2_DIR, USB_PAD_CFG);
>> -	mxc_iomux_set_pad(MX31_PIN_USBH2_NXT, USB_PAD_CFG);
>> -	mxc_iomux_set_pad(MX31_PIN_USBH2_STP, USB_PAD_CFG);
>> -	mxc_iomux_set_pad(MX31_PIN_USBH2_DATA0, USB_PAD_CFG);
>> -	mxc_iomux_set_pad(MX31_PIN_USBH2_DATA1, USB_PAD_CFG);
>> -	mxc_iomux_set_pad(MX31_PIN_SRXD6, USB_PAD_CFG);
>> -	mxc_iomux_set_pad(MX31_PIN_STXD6, USB_PAD_CFG);
>> -	mxc_iomux_set_pad(MX31_PIN_SFS3, USB_PAD_CFG);
>> -	mxc_iomux_set_pad(MX31_PIN_SCK3, USB_PAD_CFG);
>> -	mxc_iomux_set_pad(MX31_PIN_SRXD3, USB_PAD_CFG);
>> -	mxc_iomux_set_pad(MX31_PIN_STXD3, USB_PAD_CFG);
>> -
>> -	ret = gpio_request(USBH2_EN_B, "usbh2-en");
>> -	if (ret)
>> -		return ret;
>> -	gpio_direction_output(USBH2_EN_B, 0);
>> -
>> -	return 0;
>> -}
>> -
>> -static int moboard_usbh2_hw_exit(struct platform_device *pdev)
>> -{
>> -	gpio_free(USBH2_EN_B);
>> -	return 0;
>> -}
>> -
>>   static struct mxc_usbh_platform_data usbh2_pdata = {
>> -	.init	= moboard_usbh2_hw_init,
>> -	.exit	= moboard_usbh2_hw_exit,
>>   	.portsc	= MXC_EHCI_MODE_ULPI | MXC_EHCI_UTMI_8BIT,
>>   	.flags	= MXC_EHCI_POWER_PINS_ENABLED,
>>   };
>> @@ -508,7 +485,6 @@ static void __init mxc_board_init(void)
>>
>>   	usb_xcvr_reset();
>>
>> -	moboard_usbotg_init();
>>   	mxc_register_device(&mxc_otg_udc_device,&usb_pdata);
>>   	moboard_usbh2_init();
>>
>
>
> -- 
> Valentin Longchamp, PhD Student, EPFL-STI-LSRO1
> valentin.longchamp at epfl.ch, Phone: +41216937827
> http://people.epfl.ch/valentin.longchamp
> MEB3494, Station 9, CH-1015 Lausanne
>

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
