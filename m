From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 14 Jan 2011 12:25:19 +0100
Subject: i.MX & IRQF_ONESHOT
In-Reply-To: <alpine.LFD.2.00.1101131839010.2678@localhost6.localdomain6>
References: <20110113091355.GP24920@pengutronix.de>
	<4D2EDE10.3040809@atmel.com>
	<alpine.LFD.2.00.1101131839010.2678@localhost6.localdomain6>
Message-ID: <4D30329F.5040201@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 13/01/2011 19:15, Thomas Gleixner :
> On Thu, 13 Jan 2011, Nicolas Ferre wrote:
>> Le 13/01/2011 10:13, Uwe Kleine-K?nig :
>>> On Thu, Jan 13, 2011 at 09:25:19AM +0100, Eric B?nard wrote:
>>>> while testing 2.6.37 on our i.MX27 based board - code in
>>>> arch/arm/mach-imx/eukrea_mbimx27-baseboard.c - I noticed the
>>>> touchscreen controller (ADS7846) doesn't work anymore.
>>>>
>>>> A few IRQ are generated when probing for the chipset and starting
>>>> calibration (usually first point works), then nothing more (even if
>>>> the IRQ signals is generated as seen on the scope, the irq count
>>>> doesn't increase anymore and stays <= 4 and no data is reported to
>>>> the input layer).
>>>>
>>>> drivers/input/touchscreen/ads7846.c was switched to threaded IRQ in
>>>> commit 2991a1ca6e9b13b639a82c0eec0cbc191bf1f42f where was added :
>>>> irq_flags |= IRQF_ONESHOT;
>>> AFAIK this is how threaded irq usually work.  The irq should get
>>> reenabled by irq_thread -> irq_finalize_oneshot then.
> 
> Well, yes and no. That applies only when you have a level type
> interrupt as you want to keep the irq line masked until the thread did
> it's magic with the device. Keeping the line masked for edge type
> interrupts would be fatal as you might loose interrupts. That's why we
> have the different flow handlers and the ONESHOT check is only
> implemented in handle_level_irq().
> 
> Though the driver sets the ONESHOT flag unconditionally, which should
> be not a problem in theory as we don't handle oneshot stuff in other
> flow handlers. The only problem could be irq_finalize_oneshot()
> fiddling with the irq line, but that's guarded by a IRQ_DISABLED and
> IRQ_MASKED check so this should not hurt.
> 
> Though it might hurt when the interrupt line has handle_level_irq()
> and the interrupt pin is configured for edge. The driver uses
> TRIGGER_RAISING/FALLING which is usually a sign of edge type. So I
> assume that there is some wreckage lurking in there, which just got
> covered up by the old code in some way.
> 
>>>> Commenting out this line in the ads7846 driver makes it work again.
>>>> Am I missing something obvious or is there a reason for IRQF_ONESHOT
>>>> creating trouble with gpio irq or SPI on i.MX ?
>>> I don't know.  Is the irq masked?  pending?
>>
>> Just to let you know that I have the same issue on my at91sam9g10ek:
>> atmel_spi + ads7846 (using ADS7843e actually).
>> ... solved by same workaround.
> 
> Eric, Nicolas: How are the interrupt handlers set for the relevant
> interrupt lines and how are the interrupt pins configured?

Thomas,

For AT91:
- the platform does not provides irq_flags so default to
IRQF_TRIGGER_FALLING | IRQF_ONESHOT as stated in the driver.
- on at91sam9g10ek the touchscreen is wired to an full featured IRQ
entry (configured with pullup in arch/arm/mach-at91/board-sam9261ek.c).
- the irq description of plain interrupts is in arch/arm/mach-at91/irq.c
and at91_aic_set_type() has an IRQ_TYPE_EDGE_FALLING entry.

So it should be configured on falling edge...

But: is seems that looking at at91_aic_set_type() initialization
function, AIC is configured with:
set_irq_handler(i, handle_level_irq);

I do not know if it is the same as i.MX but it sound to be covered by
explanation that you gave...

Thanks, best regards,
-- 
Nicolas Ferre
