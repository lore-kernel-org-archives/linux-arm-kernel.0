From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 13 Sep 2017 17:31:26 +0900
Subject: [PATCH v4 6/6] gpio: uniphier: add UniPhier GPIO controller driver
In-Reply-To: <7e46f2a3-114f-0c34-d3c5-49e6422b9200@caviumnetworks.com>
References: <1504784522-26841-1-git-send-email-yamada.masahiro@socionext.com>
 <1504784522-26841-7-git-send-email-yamada.masahiro@socionext.com>
 <CACRpkdZLG=ezxj62R=WkULh2vfpQwqh8P-6FhtONzU7yRbyeuA@mail.gmail.com>
 <7e46f2a3-114f-0c34-d3c5-49e6422b9200@caviumnetworks.com>
Message-ID: <CAK7LNAQpO+NYu2uOwEx+c1srabO8=uOjQ-9+sh6-Q1eDP0TOSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi.

2017-09-13 0:44 GMT+09:00 David Daney <ddaney@caviumnetworks.com>:
> On 09/12/2017 07:03 AM, Linus Walleij wrote:
>>
>> On Thu, Sep 7, 2017 at 1:42 PM, Masahiro Yamada
>> <yamada.masahiro@socionext.com> wrote:
>>
>>> This GPIO controller device is used on UniPhier SoCs.
>>>
>>> It also serves as an interrupt controller, but interrupt signals are
>>> just delivered to the parent irqchip without any latching or OR'ing.
>>> This is implemented by using hierarchy IRQ domain.
>>>
>>> Implementation note:
>>> Unfortunately, the IRQ mapping from this controller to the parent is
>>> random. (48, 49, ..., 63, 154, 155, ...)
>>> If "interrupts" property is used, IRQ resources may be statically
>>> allocated when platform devices are populated from DT.  This can be
>>> a problem for the hierarchy IRQ domain because IRQ allocation must
>>> happen from the outer-most domain up to the root domain in order to
>>> build up the stacked IRQ.  (https://lkml.org/lkml/2017/7/6/758)
>>> Solutions to work around it could be to hard-code parent hwirqs or
>>> to invent a driver-specific DT property.
>>>
>>> Here, the new API irq_domain_push_irq() was merged by v4.14-rc1.
>>> It allows to add irq_data to the existing hierarchy.  It will help
>>> to make this driver work whether the parent has already initialized
>>> the hierarchy or not.
>>>
>>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>>> ---
>>>
>>> Changes in v4:
>>>    - Add COMPILE_TEST and select IRQ_DOMAIN_HIERARCHY
>>>    - Reimplement irqchip part by using irq_domain_push_irq()
>>
>>
>> Awesome improvement. There was a build error and I also
>> would like David Daney to have a look at this so we know we
>> use things the right way,
>
>
> It looks correct to me.
>
> I haven't verified it, but I think the OF device-tree probing code for the
> platform devices will automatically xlat-and-map all those irqs, so that the
> irq_domain_push_irq() is required to get the domain hierarchy properly
> configured.  It would be similar to the PCI case where we configure all the
> MSI-X and then do the irq_domain_push_irq() in the Cavium ThunderX driver.
>
> If interrupt handling has been verified to work with this driver, I would
> say that we are probably using things "the right way".
>
> David.
>

V4 depends on 5 patches that got negative feedback in irqdomain subsystem.
One more problem for this approach is to virtual IRQs are statically
allocated during the driver probe.
This looks a step backward to me.
Recently, gpio_irqchip migrated to on-the-fly allocation in case some
controllers may have lots of
GPIO lines.


Finally, I came up with another (I think, better) solution.
I think v5 is less controversial,
and works very well in on-the-fly manner.

I am sending it shortly...


-- 
Best Regards
Masahiro Yamada
