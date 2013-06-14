From: rogerq@ti.com (Roger Quadros)
Date: Fri, 14 Jun 2013 12:07:57 +0300
Subject: [PATCh V10 04/12] usb: ehci: ehci-mv: use PHY driver for ehci
In-Reply-To: <Pine.LNX.4.44L0.1306131106160.1561-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1306131106160.1561-100000@iolanthe.rowland.org>
Message-ID: <51BADD6D.5040600@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/13/2013 06:08 PM, Alan Stern wrote:
> On Thu, 13 Jun 2013, Chao Xie wrote:
> 
>>>> These operations sound generic enough to be done at HCD layer, no? So no need to
>>>> replicate the same stuff in ohci, ehci, xhci, etc.
>>>
>>> The HCD layer handles suspend and resume only for PCI host controllers.
>>> Not for other types.
>>>
>>> I don't know if the acquire/start and stop/release parts can be moved
>>> into the USB core.  Maybe they can.
>>>
>>> Alan Stern
>>>
>> hi
>> The following is my understanding.
>> I think for PHY initialization and shutdown part, it is generic for
>> other parts.
>> PHY initialization need to be called before hc_driver->reset is called.
>> I think it can be added at usb_add_hcd.
>> For PHY shutdown, it can be added at usb_remove_hcd.
> 
> Yes, that should work.

I don't think this will work with OMAP USB host controller when used in
Transceiver-less mode (e.g. HSIC). In this mode we need to release the HSIC
reset (mapped to PHY init), after the EHCI controller is up and running.

On the other hand, in the PHY mode, the PHY needs to be initialized (brought out
of reset) before the EHCI controller starts.

This behavior might be different on other controllers. Generalization is good
as long as there is an override available for the controllers to handle the
PHY init/shutdown themselves.

> 
>> For suspend/resume, i do not know how to add it. For our EHCI driver,
>> when system goes to deep idle states, we just directly shutdown the
>> hcd and initialize it again when the system goes back.
> 
> You shut down the host controller?  Then how does it detect wakeup 
> events?  And how does it know if a device was disconnected while the 
> power was off?
> 

On OMAP as well we are aiming to cut clocks to the host controller (state saved)
during bus/system suspend. PHY is in low power mode capable of detecting wakeup events.
The SoC is configured to wake up on any I/O activity on the PHY pins. Upon
detection of PHY related I/O event, SoC wakes up, we restore the host controller state
and proceed as normal.

cheers,
-roger
