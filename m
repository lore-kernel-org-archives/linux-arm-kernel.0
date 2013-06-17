From: rogerq@ti.com (Roger Quadros)
Date: Mon, 17 Jun 2013 11:17:21 +0300
Subject: [PATCh V10 04/12] usb: ehci: ehci-mv: use PHY driver for ehci
In-Reply-To: <Pine.LNX.4.44L0.1306141553030.3152-100000@netrider.rowland.org>
References: <Pine.LNX.4.44L0.1306141553030.3152-100000@netrider.rowland.org>
Message-ID: <51BEC611.5090304@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/14/2013 11:01 PM, Alan Stern wrote:
> On Fri, 14 Jun 2013, Roger Quadros wrote:
> 
>>>> hi
>>>> The following is my understanding.
>>>> I think for PHY initialization and shutdown part, it is generic for
>>>> other parts.
>>>> PHY initialization need to be called before hc_driver->reset is called.
>>>> I think it can be added at usb_add_hcd.
>>>> For PHY shutdown, it can be added at usb_remove_hcd.
>>>
>>> Yes, that should work.
>>
>> I don't think this will work with OMAP USB host controller when used in
>> Transceiver-less mode (e.g. HSIC). In this mode we need to release the HSIC
>> reset (mapped to PHY init), after the EHCI controller is up and running.
>>
>> On the other hand, in the PHY mode, the PHY needs to be initialized (brought out
>> of reset) before the EHCI controller starts.
> 
> In other words, transceiver-less mode effectively works without using a 
> software-controlled PHY?
> 
Right.

>> This behavior might be different on other controllers. Generalization is good
>> as long as there is an override available for the controllers to handle the
>> PHY init/shutdown themselves.
> 
> To avoid PHY init/shutdown, the platform driver should simply leave the 
> generic PHY pointer (which has not yet been added to struct hcd) set to 
> NULL.
> 
>>>> For suspend/resume, i do not know how to add it. For our EHCI driver,
>>>> when system goes to deep idle states, we just directly shutdown the
>>>> hcd and initialize it again when the system goes back.
>>>
>>> You shut down the host controller?  Then how does it detect wakeup 
>>> events?  And how does it know if a device was disconnected while the 
>>> power was off?
>>>
>>
>> On OMAP as well we are aiming to cut clocks to the host controller (state saved)
>> during bus/system suspend. PHY is in low power mode capable of detecting wakeup events.
>> The SoC is configured to wake up on any I/O activity on the PHY pins. Upon
>> detection of PHY related I/O event, SoC wakes up, we restore the host controller state
>> and proceed as normal.
> 
> Maybe it's just me, but turning off USB Vbus power during suspend seems
> like a bad idea.  Except for the case where all the root-hub ports are 
> disabled (such as when no devices are plugged in) -- in that case it's 
> fine.

We don't turn off Vbus power at all. Just the USB controller IPs clocks (internal to
our SoC) are cut off.

cheers,
-roger
