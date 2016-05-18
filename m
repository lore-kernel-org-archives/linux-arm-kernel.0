From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed, 18 May 2016 16:33:20 +0100
Subject: [PATCH] usb: echi-hcd: Add register access check in shutdown
In-Reply-To: <Pine.LNX.4.44L0.1605181044460.1981-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1605181044460.1981-100000@iolanthe.rowland.org>
Message-ID: <573C8B40.1040503@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 18/05/16 15:56, Alan Stern wrote:
> On Wed, 18 May 2016, Srinivas Kandagatla wrote:
>
>> This patch adds a check in ehci_shutdown(), to make sure
>> that the register access is available before accessing registers.
>>
>> The use case is simple, for boards like DB410c where the usb host
>> or device functionality is decided based on the micro-usb cable
>> presence. If the board boots up with micro-usb connected and the
>> host driver is probed, but the ehci_setup() has not been done yet,
>> then a system shutdown would trigger below NULL pointer exception
>> without this patch.
>
> How can that happen?  While the host driver is probed, the probing
> thread holds the device lock.  But the system shutdown routine acquires
> the device lock before invoking the ->shutdown callback.  Therefore the
> two things cannot happen concurrently.

No, I did not mean them happening concurrently, I mean that the host 
driver is up, however ehci_setup() is not done yet.

Will change the comments if its misleading the reader.

>
>> Unable to handle kernel NULL pointer dereference at virtual address
>> 00000008
>
> ...
>
>> --- a/drivers/usb/host/ehci-hcd.c
>> +++ b/drivers/usb/host/ehci-hcd.c
>> @@ -368,6 +368,9 @@ static void ehci_shutdown(struct usb_hcd *hcd)
>>   {
>>   	struct ehci_hcd	*ehci = hcd_to_ehci(hcd);
>>
>> +	if (!HCD_HW_ACCESSIBLE(hcd))
>> +		return;
>> +
>>   	spin_lock_irq(&ehci->lock);
>>   	ehci->shutdown = true;
>>   	ehci->rh_state = EHCI_RH_STOPPING;
>
> This doesn't seem like the right place.  What you really should do is
> skip calling ehci_silence_controller() if the hardware isn't
> accessible.  That's where the hardware gets touched, not in
> ehci_shutdown().
Yep , that should work as well.

Will send a v2 patch.

thanks,
srini

>
> Alan Stern
>
