From: opendmb@gmail.com (Doug Berger)
Date: Mon, 16 Oct 2017 16:04:32 -0700
Subject: [PATCH 6/7] gpio: brcmstb: consolidate interrupt domains
In-Reply-To: <61cb2c09-8078-d3ed-907b-64aff4553650@gmail.com>
References: <20170930034057.15166-1-opendmb@gmail.com>
 <20170930034057.15166-7-opendmb@gmail.com>
 <CADtm3G5v6_BHwanRYvCq1y-8Hdmn7gxX3zoVHx2c7cOFL-pj+Q@mail.gmail.com>
 <61cb2c09-8078-d3ed-907b-64aff4553650@gmail.com>
Message-ID: <d1622149-58b8-ddca-2d09-649189fd9c4e@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/04/2017 02:24 PM, Doug Berger wrote:
> On 10/03/2017 08:03 PM, Gregory Fong wrote:
>> Hi Doug,
>>
>> On Fri, Sep 29, 2017 at 8:40 PM, Doug Berger <opendmb@gmail.com> wrote:
>>> The GPIOLIB IRQ chip helpers were very appealing, but badly broke
>>> the 1:1 mapping between a GPIO controller's device_node and its
>>> interrupt domain.
>>
>> Out of curiosity, what sort of problems have you seen from this?
>>
> 
> As you know, the BRCMSTB devices conceptually distinguish between an
> always-on GPIO device and a regular GPIO device that each can have many
> more than 32 General Purpose I/Os. The driver supports these by dividing
> the GPIO across a number of banks each of which is implemented as a
> separate gpiochip as an implementation convenience. The main issue is
> that each gpiochip that uses the GPIOLIB IRQ chip helpers creates its
> own irq domain even though they are associated with the same device and
> device-tree node.
> 
> When another device-tree node references a GPIO device as its interrupt
> parent, the irq_create_of_mapping() function looks for the irq domain of
> the GPIO device and since all bank irq domains reference the same GPIO
> device node it always resolves to the irq domain of the first bank
> regardless of which bank the number of the GPIO should resolve. This
> domain can only map hwirq numbers 0-31 so interrupts on GPIO above that
> can't be mapped by the device-tree.
> 
>>>
>>> This commit consolidates the per bank irq domains to a version
>>> where we have one larger interrupt domain per GPIO controller
>>> instance spanning multiple GPIO banks.
>>
>> This works (and is reminiscent to my initially submitted
>> implementation at [1]), but I think it might make sense to keep as-is
>> (using the gpiolib irqchip helpers), and instead allocate an irqchip
>> fwnode per bank and use to_of_node() to set it as the of_node for the
>> gpiochip before calling gpiochip_irqchip_add().  OTOH, that capability
>> might go away...
>>
>> Linus, can you comment on the FIXME in gpiochip_irqchip_add_key() that
>> says "get rid of this and use gpiochip->parent->of_node everywhere"?
>> It seems like it would still be beneficial to be able to override the
>> associated node for a gpiochip, since that's what's used for the
>> irqdomain, but if that's going away, obviously we don't want to start
>> using that now.
>>
> 
> Yes, this is effectively a reversion to an earlier implementation. I
> produced an implementation based on the generic irqchip libraries, but
> that was stripped from this submission when I discovered that no support
> exists within the generic irqchip libraries for removal of domain
> generic chips and we wanted to preserve the module support of this driver.
> 
> It is conceivable that the current GPIO device-tree nodes could be
> broken down into separate devices per bank, but it is believed that this
> would only confuse things for users of the device as the concept
> diverges from the concept expressed in device documentation.
> 
>> Thanks,
>> Gregory
>>
>> [1] https://patchwork.kernel.org/patch/6347811/
>>
> 
> Thanks for the review,
>     Doug
> 

Gregory,

Do you have any additional feedback on patches 6 and 7 before I submit a
version 2?

Thanks,
    Doug
