From: rogerq@ti.com (Roger Quadros)
Date: Thu, 20 Jun 2013 15:39:35 +0300
Subject: [RFC PATCH 0/6] Suspend USB Host controller on bus suspend
In-Reply-To: <Pine.LNX.4.44L0.1306191121280.2026-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1306191121280.2026-100000@iolanthe.rowland.org>
Message-ID: <51C2F807.1000301@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/19/2013 06:23 PM, Alan Stern wrote:
> On Wed, 19 Jun 2013, Roger Quadros wrote:
> 
>> Hi,
>>
>> This series attempts to suspend the OMAP EHCI host controller on USB
>> Bus suspend.
> 
> Why do you want to suspend the host controller during bus suspend?  
> They are two different operations and should be carried out at two 
> different times.  The controller should be suspended during controller 
> suspend, not during bus suspend.
> 

Good point. I didn't think it that way. I think it should work.

>> As the omap-ehci controller driver needs to do some additional work to put
>> itself into suspend/resume and make sure it is resumed to process an interrupt,
>> we need to be able to override irq, bus_suspend, and bus_resume handlers. This
>> provision is done in patch 3.
> 
> Do you still need to override these things if you do the controller
> suspend at the right time?
> 

At least not for bus_suspend and bus_resume. We will still need to override the irq
handler though. But, if we can take care of this generically in the ehci_irq handler (i.e. make
sure controller is not suspended while accessing it) then we don't need such override
for irq.

cheers,
-roger
