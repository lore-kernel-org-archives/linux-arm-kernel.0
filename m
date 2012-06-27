From: zhangfei.gao@gmail.com (zhangfei gao)
Date: Wed, 27 Jun 2012 17:14:45 +0800
Subject: Could resource_size can be used for IORESOURCE_IRQ in device tree?
In-Reply-To: <201206270832.16418.arnd@arndb.de>
References: <CAMj5BkhkybgAAXbpLqUQvs0qhgLyKxdT0cMz8=5kaDdMwoL46Q@mail.gmail.com>
 <201206270832.16418.arnd@arndb.de>
Message-ID: <CAMj5Bkg_6eBXxxN0frcjFFV+Kpq4O+bq+sYb3oSbd-UzKGT=dg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 27, 2012 at 4:32 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 27 June 2012, zhangfei gao wrote:
>>
>> Excuse me,
>> I have one question when using device tree to get resource_size for
>> IORESOURCE_IRQ
>>
>> Without dt,
>> static struct resource
>> {
>> ? ? ? ? ? ? ? ? .start ?= 18,
>> ? ? ? ? ? ? ? ? .end ? ?= 19,
>> ? ? ? ? ? ? ? ? .flags ?= IORESOURCE_IRQ,
>> },
>> iores = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>> resource_size(iores) = 2 can be used to get how many irq.
>> iores->start = 18; iores->end = 19;
>
> IMHO we should just discourage this from being done.
> While the API allows you to put multiple interrupts
> into a single resource, it does not generally work,
> e.g. when the same device is used in another SoC that
> puts connects the interrupt lines to non-contiguous
> irqs.
>
> It also breaks down with sparse IRQs when you move
> away from legacy irqdomains and the linux-internal numbers
> that you put in the resource are not related to the hw
> numbers any more.
>
>> Is there any API directly get resource number in dt, like resource_size(iores).
>> The reason is interrupts is not constant, and we want to parse
>> directly from resource.
>> If only one irq, then driver parse irqs internally.
>> Only if irq number same as channel number, then every channel have own irq.
>> It seems inconvenient get irq number one by one and check whether they
>> equals channel number or not.
>
> Which driver is it?
>
> I guess in any case the solution would be to split the platform IRQ resource
> and change the driver to just read the IRQs individually like most other
> drivers do.
>
> ? ? ? ?Arnd

Thanks Arnd for kind explanation.
Will change to read the IRQs individually.
The only requirement is parse IORESOURCE_IRQ number first.
Looks no existing API, so just use platform_get_irq one by one.

Thanks a lot for the advice.
