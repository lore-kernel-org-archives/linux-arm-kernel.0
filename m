From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 02 Apr 2012 12:21:17 +0200
Subject: [PATCH 06/12] USB: ohci-at91: change maximum number of ports
In-Reply-To: <Pine.LNX.4.44L0.1203291100400.1417-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1203291100400.1417-100000@iolanthe.rowland.org>
Message-ID: <4F797D9D.5030600@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/29/2012 05:04 PM, Alan Stern :
> On Thu, 29 Mar 2012, Nicolas Ferre wrote:
> 
>> Change number of ports to 3 for newer SoCs. Modify pdata structure
>> and ohci-at91 code that was dealing with ports information and check
>> of port indexes.
>>
>> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>> Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
>> ---
>>  arch/arm/mach-at91/include/mach/board.h |   13 +++++++------
>>  drivers/usb/host/ohci-at91.c            |   22 +++++++++++++---------
>>  2 files changed, 20 insertions(+), 15 deletions(-)
>>
>> diff --git a/arch/arm/mach-at91/include/mach/board.h b/arch/arm/mach-at91/include/mach/board.h
>> index 544a5d5..49a8211 100644
>> --- a/arch/arm/mach-at91/include/mach/board.h
>> +++ b/arch/arm/mach-at91/include/mach/board.h
>> @@ -86,14 +86,15 @@ extern void __init at91_add_device_mci(short mmc_id, struct mci_platform_data *d
>>  extern void __init at91_add_device_eth(struct macb_platform_data *data);
>>  
>>   /* USB Host */
>> +#define AT91_MAX_USBH_PORTS	3
>>  struct at91_usbh_data {
>> -	u8		ports;		/* number of ports on root hub */
>> -	int		vbus_pin[2];	/* port power-control pin */
>> -	u8              vbus_pin_active_low[2];
>> +	int		vbus_pin[AT91_MAX_USBH_PORTS];	/* port power-control pin */
>> +	int             overcurrent_pin[AT91_MAX_USBH_PORTS];
>> +	u8		ports;				/* number of ports on root hub */
>>  	u8              overcurrent_supported;
>> -	int             overcurrent_pin[2];
>> -	u8              overcurrent_status[2];
>> -	u8              overcurrent_changed[2];
>> +	u8              vbus_pin_active_low[AT91_MAX_USBH_PORTS];
>> +	u8              overcurrent_status[AT91_MAX_USBH_PORTS];
>> +	u8              overcurrent_changed[AT91_MAX_USBH_PORTS];
>>  };
>>  extern void __init at91_add_device_usbh(struct at91_usbh_data *data);
>>  extern void __init at91_add_device_usbh_ohci(struct at91_usbh_data *data);
>> diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
>> index 1262532..cf9707d 100644
>> --- a/drivers/usb/host/ohci-at91.c
>> +++ b/drivers/usb/host/ohci-at91.c
>> @@ -240,7 +240,7 @@ ohci_at91_start (struct usb_hcd *hcd)
>>  
>>  static void ohci_at91_usb_set_power(struct at91_usbh_data *pdata, int port, int enable)
>>  {
>> -	if (port < 0 || port >= 2)
>> +	if (port < 0 || port >= ARRAY_SIZE(pdata->vbus_pin))
> 
> Here and below, it will be a lot clearer to write AT91_MAX_USBH_PORTS 
> instead of ARRAY_SIZE(padata->...).
> 
>> @@ -301,7 +301,11 @@ static int ohci_at91_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
>>  	case SetPortFeature:
>>  		if (wValue == USB_PORT_FEAT_POWER) {
>>  			dev_dbg(hcd->self.controller, "SetPortFeat: POWER\n");
>> -			ohci_at91_usb_set_power(pdata, wIndex - 1, 1);
>> +			if (wIndex && wIndex <= ARRAY_SIZE(pdata->vbus_pin)) {
>> +				ohci_at91_usb_set_power(pdata, wIndex - 1, 1);
> 
> Here and throughout the hub_control routine, things will be a lot 
> simpler if you decrement wIndex at the start of the SetPortFeature 
> case.  Same for ClearPortFeature and maybe also GetPortStatus.

Ok, I will modify it according to your sugestions in a v2 patch series.

Best regards,
-- 
Nicolas Ferre
