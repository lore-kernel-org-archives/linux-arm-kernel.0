From: John.Youn@synopsys.com (John Youn)
Date: Thu, 29 Jan 2015 18:12:21 -0800
Subject: [PATCH] usb: dwc2: fix USB core dependencies
In-Reply-To: <20150129162444.GI21217@saruman.tx.rr.com>
References: <1554724.zbFzpEsGrd@wuerfel>
 <20150129162444.GI21217@saruman.tx.rr.com>
Message-ID: <54CAE885.8070603@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/29/2015 08:25 AM, Felipe Balbi wrote:
> Hi,
> 
> Adding John
> 
> On Wed, Jan 28, 2015 at 10:49:00PM +0100, Arnd Bergmann wrote:
>> It is currently possible to configure the dwc2 driver as built-in
>> when host mode or dual-role is enabled, but the USB core is
>> a loadable module. This leads to a link failure:
>>
>> drivers/built-in.o: In function `_dwc2_hcd_start':
>> :(.text+0x84538): undefined reference to `usb_hcd_resume_root_hub'
>> drivers/built-in.o: In function `_dwc2_hcd_urb_dequeue':
>> :(.text+0x84aa0): undefined reference to `usb_hcd_check_unlink_urb'
>> :(.text+0x84e4c): undefined reference to `usb_hcd_unlink_urb_from_ep'
>> :(.text+0x84e74): undefined reference to `usb_hcd_giveback_urb'
>> drivers/built-in.o: In function `dwc2_assign_and_init_hc':
>> :(.text+0x86b98): undefined reference to `usb_hcd_unmap_urb_for_dma'
>> drivers/built-in.o: In function `_dwc2_hcd_urb_enqueue':
>> :(.text+0x8717c): undefined reference to `usb_hcd_link_urb_to_ep'
>> :(.text+0x872f4): undefined reference to `usb_hcd_unlink_urb_from_ep'
>> drivers/built-in.o: In function `dwc2_host_complete':
>> :(.text+0x875d4): undefined reference to `usb_hcd_unlink_urb_from_ep'
>> :(.text+0x87600): undefined reference to `usb_hcd_giveback_urb'
>> drivers/built-in.o: In function `dwc2_hcd_init':
>> :(.text+0x87ba8): undefined reference to `usb_disabled'
>> :(.text+0x87d38): undefined reference to `usb_create_hcd'
>> :(.text+0x88094): undefined reference to `usb_add_hcd'
>> :(.text+0x880dc): undefined reference to `usb_put_hcd'
>> drivers/built-in.o: In function `dwc2_hcd_remove':
>> :(.text+0x8821c): undefined reference to `usb_remove_hcd'
>> :(.text+0x8823c): undefined reference to `usb_put_hcd'
>> drivers/built-in.o: In function `dwc2_hc_handle_tt_clear.isra.10':
>> :(.text+0x88e2c): undefined reference to `usb_hub_clear_tt_buffer'
>> drivers/built-in.o: In function `dwc2_hcd_qtd_add':
>> :(.text+0x8b554): undefined reference to `usb_calc_bus_time'
>>
>> To fix the problem, this patch changes the dependencies so that
>> dwc2 host mode can only be enabled if either the USB core is
>> built-in or both USB and dwc2 are modules.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>
>> diff --git a/drivers/usb/dwc2/Kconfig b/drivers/usb/dwc2/Kconfig
>> index b323c4c11b0a..76b9ba4dc925 100644
>> --- a/drivers/usb/dwc2/Kconfig
>> +++ b/drivers/usb/dwc2/Kconfig
>> @@ -23,7 +23,7 @@ choice
>>  
>>  config USB_DWC2_HOST
>>  	bool "Host only mode"
>> -	depends on USB
>> +	depends on USB=y || (USB_DWC2=m && USB)
>>  	help
>>  	  The Designware USB2.0 high-speed host controller
>>  	  integrated into many SoCs. Select this option if you want the
>> @@ -42,7 +42,7 @@ config USB_DWC2_PERIPHERAL
>>  
>>  config USB_DWC2_DUAL_ROLE
>>  	bool "Dual Role mode"
>> -	depends on (USB=y || USB=USB_DWC2) && (USB_GADGET=y || USB_GADGET=USB_DWC2)
>> +	depends on (USB=y && USB_GADGET=y) || (USB_DWC2=m && USB && USB_GADGET)
>>  	help
>>  	  Select this option if you want the driver to work in a dual-role
>>  	  mode. In this mode both host and gadget features are enabled, and
>>
>>

Acked-by: John Youn <johnyoun@synopsys.com>
