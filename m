From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 10 May 2012 09:38:52 +0200
Subject: [PATCH] USB: ohci-at91: add a reset function to fix race condition
In-Reply-To: <4FAAA7CC.7050208@mvista.com>
References: <1336553334-31058-1-git-send-email-nicolas.ferre@atmel.com>
 <4FAAA7CC.7050208@mvista.com>
Message-ID: <4FAB708C.9020600@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/09/2012 07:22 PM, Sergei Shtylyov :
> Hello.
> 
> On 09-05-2012 12:48, Nicolas Ferre wrote:
> 
>> A possible race condition appears because we are not initializing
>> the ohci->regs before calling usb_hcd_request_irqs().
>> We move the call to ohci_init() in hcd->driver->reset() instead of
>> hcd->driver->start() to fix this.
>> This was experienced when we share the same IRQ line between OHCI and
>> EHCI
>> controllers.
> 
>> Signed-off-by: Nicolas Ferre<nicolas.ferre@atmel.com>
>> Tested-by: Christian Eggers<christian.eggers@kathrein.de>
>> Cc: stable<stable@vger.kernel.org>
>> ---
>>   drivers/usb/host/ohci-at91.c |   11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
>> diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
>> index 13ebeca..55d3d64 100644
>> --- a/drivers/usb/host/ohci-at91.c
>> +++ b/drivers/usb/host/ohci-at91.c
>> @@ -223,7 +223,7 @@ static void __devexit usb_hcd_at91_remove(struct
>> usb_hcd *hcd,
>>  
>> /*-------------------------------------------------------------------------*/
>>
>>
>>   static int __devinit
>> -ohci_at91_start (struct usb_hcd *hcd)
>> +ohci_at91_reset (struct usb_hcd *hcd)
> 
>    Have you run the patch thru scripts/checkpatch.pl? There should be no
> space between function name and '('.
>
>>   {
>>       struct at91_usbh_data    *board =
>> hcd->self.controller->platform_data;
>>       struct ohci_hcd        *ohci = hcd_to_ohci (hcd);
>> @@ -233,6 +233,14 @@ ohci_at91_start (struct usb_hcd *hcd)
>>           return ret;
>>
>>       ohci->num_ports = board->ports;
>> +    return 0;
>> +}
>> +
>> +static int __devinit
>> +ohci_at91_start (struct usb_hcd *hcd)
> 
>    Same here.
> 
>> +{
>> +    struct ohci_hcd        *ohci = hcd_to_ohci (hcd);
> 
>    And here.

Yes, I have run checkpatch.pl. But I also know that I have to conform to
existing code and the history of the file that I am touching.
This file is using this convention as well as
drivers/usb/host/ohci-hcd.c and several others dealing with USB. So I
kept this style in my patch.

Best regards,
-- 
Nicolas Ferre
