From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Thu, 16 Jun 2016 12:23:40 +0300
Subject: [PATCH] Revert "gpio: bail out silently on NULL descriptors"
In-Reply-To: <3a03fc91-b339-3e43-4e95-e1488197a8df@redhat.com>
References: <1466014954-17956-1-git-send-email-hdegoede@redhat.com>
 <20160615184628.GA5144@lukather>
 <3a03fc91-b339-3e43-4e95-e1488197a8df@redhat.com>
Message-ID: <5762701C.4060409@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/15/2016 10:08 PM, Hans de Goede wrote:
> Hi,
> 
> On 15-06-16 20:46, Maxime Ripard wrote:
>> Hi,
>>
>> On Wed, Jun 15, 2016 at 08:22:34PM +0200, Hans de Goede wrote:
>>> This reverts commit 54d77198fdfb("gpio: bail out silently on NULL
>>> descriptors").
>>>
>>> This commit causes the following code to fail:
>>>
>>> gpio_desc = devm_gpiod_get_optional(dev, ...);

May be I missed smth., but in this example gpio_desc may contain err code.

>>> gpio_irq  = gpiod_to_irq(gpio_desc);
which, most probably will cause gpiod_to_irq() to crash
	if (!desc) \
		return 0; \
	if (!desc->gdev) { \
^^^^^^^^^^^^^ here

>>> if (gpio_irq >= 0) {
>>>     ret = devm_request_irq(dev, gpio_irq, ...);
>>>
>>> And now ret is an error causing the probe function in question to bail.
>>>
>>> The problem here is that gpiod_to_irq now returns 0 for a NULL
>>> gpio_desc while 0 is a valid irq-nr. Also see:
>>> commit 4c37ce8608a8("gpio: make gpiod_to_irq() return negative for 
>>> NO_IRQ")
>>> which specifically avoids returning 0.
>>
>> 0 is not a valid interrupt number.
> 
> Ok, so lets decouple the discussion a bit from whether or not 0
> is a valid interrupt number.
> 
>> irq_find_mapping returns 0 in case of an error:
>> http://lxr.free-electrons.com/source/kernel/irq/irqdomain.c#L657
> 
> Yes and in that case gpiod_to_irq() will explicitly return -ENXIO
> so as to not confuse callers.
> 
> Which is the right thing to do, since almost all kernel functions
> have the semantic ret < 0 means error >= 0 means success.
> 
> The patch I'm suggestion to revert however now has gpiod_to_irq()
> return 0 when it gets passed a NULL gpio_desc pointer, so this
> really has nothing to do with irq_find_mapping() at all (that never
> gets called in this case) and has everything to do with the
> patch I suggest we revert changing the behavior for
> gpiod_to_irq(NULL).
> 
> Also not that that patch has a Cc: stable, so fix the driver is
> really not a good answer, stable patches should not change
> (internal) api behavior and break other code.
> 


-- 
regards,
-grygorii
