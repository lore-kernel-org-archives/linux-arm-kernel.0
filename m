From: rogerq@ti.com (Roger Quadros)
Date: Thu, 11 Jul 2013 10:30:35 +0300
Subject: [PATCH 5/6] USB: Support wakeup IRQ for suspended controllers
In-Reply-To: <Pine.LNX.4.44L0.1307101504220.1215-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1307101504220.1215-100000@iolanthe.rowland.org>
Message-ID: <51DE5F1B.8080201@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/10/2013 10:08 PM, Alan Stern wrote:
> On Wed, 10 Jul 2013, Roger Quadros wrote:
> 
>> Some platforms e.g. ehci-omap can generate an interrupt
>> (i.e. remote wakeup) even when the controller is suspended i.e.
>> HW_ACCESSIBLE is cleared.
>>
>> Introduce a flag "has_wakeup_irq" in struct usb_hcd to indicate
>> such cases.
>>
>> We tackle this case by disabling the IRQ, scheduling a
>> hub resume and enabling back the IRQ after the controller has
>> resumed. This ensures that the IRQ handler runs only after the
>> controller is accessible.
> 
> Oh yes, one more thing...
> 
>> @@ -132,6 +134,7 @@ struct usb_hcd {
>>  	unsigned		wireless:1;	/* Wireless USB HCD */
>>  	unsigned		authorized_default:1;
>>  	unsigned		has_tt:1;	/* Integrated TT in root hub */
>> +	unsigned		has_wakeup_irq:1; /* Can IRQ when suspended */
> 
> Please add a highly visible comment here, warning that has_wakeup_irq
> should never be set on systems with shared IRQs.  Having both would ...
> well, it would indicate a really bad system design.
> 
OK, will do.

cheers,
-roger
