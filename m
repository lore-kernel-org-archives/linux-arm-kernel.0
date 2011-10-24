From: robherring2@gmail.com (Rob Herring)
Date: Mon, 24 Oct 2011 17:48:05 -0500
Subject: [PATCH] gpio: pl061: add DT binding support
In-Reply-To: <20111024222618.GI4394@ponder.secretlab.ca>
References: <1312397661-3328-1-git-send-email-robherring2@gmail.com>
	<CACxGe6u1g_XZCvWB=7Z=0hGhZKfcQaiRm1WaQfJMrkkHTTqn8Q@mail.gmail.com>
	<4E39D755.2030700@gmail.com>
	<20111024222618.GI4394@ponder.secretlab.ca>
Message-ID: <4EA5EB25.8080003@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/24/2011 05:26 PM, Grant Likely wrote:
> On Wed, Aug 03, 2011 at 06:18:45PM -0500, Rob Herring wrote:
>> Grant,
>>
>> On 08/03/2011 05:22 PM, Grant Likely wrote:
>>> On Wed, Aug 3, 2011 at 7:54 PM, Rob Herring <robherring2@gmail.com> wrote:
>>>> From: Rob Herring <rob.herring@calxeda.com>
>>>>
>>>> This adds devicetree binding support to the ARM pl061 driver removing the
>>>> platform_data dependency. When DT binding is used, the gpio numbering is
>>>> assigned dynamically. The interrupt assignment is converted to use the
>>>> irq_domain infrastructure.
>>>>
>>>> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
>>>> Cc: Grant Likely <grant.likely@secretlab.ca>
>>>> ---
>>>>  drivers/gpio/gpio-pl061.c |   32 +++++++++++++++++++++++---------
>>>>  1 files changed, 23 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/drivers/gpio/gpio-pl061.c b/drivers/gpio/gpio-pl061.c
>>>> index 2c5a18f..7ea74ff 100644
>>>> --- a/drivers/gpio/gpio-pl061.c
>>>> +++ b/drivers/gpio/gpio-pl061.c
>>>> @@ -23,6 +23,7 @@
>>>>  #include <linux/amba/bus.h>
>>>>  #include <linux/amba/pl061.h>
>>>>  #include <linux/slab.h>
>>>> +#include <linux/of_irq.h>
>>>>
>>>>  #define GPIODIR 0x400
>>>>  #define GPIOIS  0x404
>>>> @@ -246,6 +247,20 @@ static int pl061_probe(struct amba_device *dev, const struct amba_id *id)
>>>>        if (chip == NULL)
>>>>                return -ENOMEM;
>>>>
>>>> +       pdata = dev->dev.platform_data;
>>>> +       if (pdata) {
>>>> +               chip->gc.base = pdata->gpio_base;
>>>> +               chip->irq_base = pdata->irq_base;
>>>> +       } else if (dev->dev.of_node) {
>>>> +               u32 intspec = 0;
>>>> +               chip->gc.base = -1;
>>>> +               chip->irq_base = irq_create_of_mapping(dev->dev.of_node,
>>>> +                                                      &intspec, 1);
>>>
>>> This looks wrong.  intspec is always 0 here, when I would assume you
>>> would want the value of the interrupts property from this device's
>>> node.  Is this the cascade irq number?  Or is it supposed to be the
>>> starting interrupt number for the gpios?  If it is starting interrupt
>>> number, then it should actually be dynamically assigned.  If it is the
>>> cascade, then platform_get_irq() should work.
>>>
>> It's the latter case that I need to retrieve. I have this platform code
>> assigning the linux irq numbers:
>>
>>         struct device_node *node;
>>         int n = 0;
>>
>>         node = of_find_compatible_node(NULL, NULL, "arm,cortex-a9-gic");
>>         if (!node)
>>                 panic("missing gic devicetree node\n");
>>         irq_domain_add_simple(node, 0);
>>
>>         for_each_compatible_node(node, NULL, "arm,pl061") {
>>                 irq_domain_add_simple(node, 160 + (8 * n));
>>                 n++;
>>         }
>>
>> In this case with simple translation, intspec is really a don't care.
>> irq_create_of_mapping just finds the domain that matches the gpio
>> ctrlr's node and returns the domain's irq_base (+ 0) as the translate
>> function will just return the intspec value for the hw_irq.
>>
>> Have I missed something? There is not yet any dynamic assignment of
>> linux irq numbers?
> 
> Yes, the kernel does support dynamic irq number assignment, but the
> interrupt controller still needs to manage it.  I've not yet decided
> what the best way to integrate it into irq_domain is.
> 

I had since figured that out with the GIC series. We should discuss at
Connect. My plan here is to make generic-irq-chip use domains and
irq_alloc_descs, then convert pl061 to use generic-irq-chip.

Rob
