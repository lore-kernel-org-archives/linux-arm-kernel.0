From: carlo@caione.org (Carlo Caione)
Date: Tue, 2 Jun 2015 11:33:44 +0200
Subject: [PATCH 1/2] pinctrl: meson: Enable GPIO IRQs
In-Reply-To: <CACRpkdYCxnf3nUz+jTSu4qw1_nXKkc+_TioZTxW7LpP_dX-MRg@mail.gmail.com>
References: <1432551641-3256-1-git-send-email-carlo@caione.org>
 <1432551641-3256-2-git-send-email-carlo@caione.org>
 <CACRpkdYCxnf3nUz+jTSu4qw1_nXKkc+_TioZTxW7LpP_dX-MRg@mail.gmail.com>
Message-ID: <CAOQ7t2bnAewvjE9D4+Cdw5QGUapi5LnYhG-eN+phi1=tVVVUYQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 1, 2015 at 4:30 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, May 25, 2015 at 1:00 PM, Carlo Caione <carlo@caione.org> wrote:
>
>> From: Beniamino Galvani <b.galvani@gmail.com>
>>
>> On Meson8 and Meson8b SoCs there are 8 independent filtered GPIO
>> interrupt modules that can be programmed to use any of the GPIOs in the
>> chip as an interrupt source.
>>
>> For each GPIO IRQ we have:
>>
>> GPIOs --> [mux]--> [polarity]--> [filter]--> [edge select]--> GIC
>>
>> The eight GPIO interrupts respond to mask/unmask/clear/etc.. just like
>> any other interrupt in the chip. The difference for the GPIO interrupts
>> is that they can be filtered and conditioned.
>>
>> This patch adds support for the external GPIOs interrupts and enables
>> them for Meson8 and Meson8b SoCs.
>>
>> Signed-off-by: Carlo Caione <carlo@endlessm.com>
>> Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
>
> Sigh this is gonna be one of these drivers that cannot use
> GPIOLIB_IRQCHIP because it has the custom awkward
> interrupt generator thing. I guess it is a bit faster to have
> a limited number of direct IRQ lines to the CPU though so
> it does come with some advantages...

Yeah. Also this is probably the first pinctrl driver using the
hierarchy IRQ domain so there is still some piece missing with a lot
of trial and error.

>> +static int meson_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
>> +{
>> +       struct meson_domain *domain = to_meson_domain(chip);
>> +       struct meson_pinctrl *pc = domain->pinctrl;
>> +       struct meson_bank *bank;
>> +       struct of_phandle_args irq_data;
>> +       unsigned int pin, virq;
>
> Don't call it "virq" these are Linux irqs they are not any more
> virtual than any other IRQs. Call the hardware irq (pin?) hwirq
> instead.

Ok.

>> +       int ret;
>> +
>> +       pin = domain->data->pin_base + offset;
>
> This is not looking good. Nominally you should use the irqdomain to
> translate hwirq to Linux IRQ.
>
> Normally this is just
>
> line = irq_find_mapping(domain, hwirq);

The problem I see with using irq_find_mapping() here is that at this
point we do not have yet the mapping hwirq->(v)irq. Other drivers (not
using the hierarchical IRQ domain) use irq_create_mapping() to create
the mapping in the .to_irq() hook and IIUC for hierarchical domains we
cannot use irq_create_mapping().

The point here seems to be that to allocate the IRQs on the GIC we
need to call the .alloc() of the struct irq_domain_ops. This is not
usually called by irq_create_mapping() but we need to use
irq_domain_alloc_irqs(). In irq_create_of_mapping() for example we
deal with hierarchical domains and IRQs defined in the DTS using
directly irq_domain_alloc_irqs() as I did in the following lines of
code.

So when the GPIO IRQ is defined in the DTS everything works fine since
irq_create_of_mapping() takes care of everything. The problem is when
the GPIO IRQ is requested directly from the code or from another
subsystem (i.e. MMC) since this request goes through .to_irq().

>> +       ret = meson_get_bank(domain, pin, &bank);
>> +       if (ret)
>> +               return -ENXIO;
>> +
>> +       irq_data.args_count = 2;
>> +       irq_data.args[0] = pin;
>> +       virq = irq_domain_alloc_irqs(pc->irq_domain, 1, NUMA_NO_NODE, &irq_data);
>
> This is wrong. You have to alloc the irqs either
>
> (A) when the driver is probed, looping over all IRQs.
>   Then pair with free():in the IRQs in the remove()
>   call.
>
> or
>
> (B) in one of the irqchip functions like .irq_request_resources()
>   then pair with freeing the IRQs in .irq_release_resources().

Correct me if I'm wrong but in my experiments the
.irq_request_resources() seems to be called after the .to_irq() hook.

> Reason: the irqchip API can be used orthogonally from
> the gpiolib API, and there is no gurantee *at all* that consumers
> will call .to_irq() before using an IRQ. Especially not in the
> device tree case.

This is exactly my understanding: a GPIO IRQs can be requested to this
driver in two different ways: (1) device tree or (2) gpiolib API (for
example in my case a GPIO IRQ is requested by the MMC subsystem for
card detection).
In case (1) irq_create_of_mapping() manages the hierarchical domain
just fine. The problem is for case (2) where the .to_irq() hook is
used since as said before here apparently I cannot use
irq_create_mapping().

> All set-up/tear-down needs to happen without relying
> on .to_irq() to have been called first.

Agree.

>> +       return virq ? virq : -ENXIO;
>> +}
>> +
> (...)
>

(...)

>> +{
>> +       struct meson_pinctrl *pc = domain->host_data;
>> +       struct of_phandle_args *irq_data = arg;
>> +       struct of_phandle_args gic_data;
>> +       irq_hw_number_t hwirq;
>> +       int index, ret, i;
>> +
>> +       if (irq_data->args_count != 2)
>> +               return -EINVAL;
>> +
>> +       hwirq = irq_data->args[0];
>> +       dev_dbg(pc->dev, "%s virq %d, nr %d, hwirq %lu\n",
>> +               __func__, virq, nr_irqs, hwirq);
>> +
>> +       for (i = 0; i < nr_irqs; i++) {
>> +               index = meson_map_gic_irq(domain, hwirq + i);
>> +               if (index < 0)
>> +                       return index;
>> +
>> +               irq_domain_set_hwirq_and_chip(domain, virq + i,
>> +                                             hwirq + i,
>> +                                             &meson_irq_chip,
>> +                                             pc);
>> +
>> +               gic_data = pc->gic_irqs[index];
>> +               ret = irq_domain_alloc_irqs_parent(domain, virq + i, nr_irqs,
>> +                                                  &gic_data);
>> +       }
>
> OK... hm quite complex.

Fortunately also quite standard for hierarchical IRQ domains.

>> +static void meson_irq_domain_free(struct irq_domain *domain, unsigned int virq,
>> +                                 unsigned int nr_irqs)
>
> virq -> irq

Ok

>> +{
>> +       struct meson_pinctrl *pc = domain->host_data;
>> +       struct irq_data *irq_data;
>> +       int index, i;
>> +
>> +       spin_lock(&pc->lock);
>> +       for (i = 0; i < nr_irqs; i++) {
>> +               irq_data = irq_domain_get_irq_data(domain, virq + i);
>> +               index = meson_get_gic_irq(pc, irq_data->hwirq);
>> +               if (index < 0)
>> +                       continue;
>> +               pc->irq_map[index] = IRQ_FREE;
>
> Don't you need to call irq_dispose_mapping() for all
> IRQs here? Or is the irq_domain_free_irqs_paren()
> taking care of this?

Yes. irq_domain_free_irqs_parent() takes care of everything.

> Sorry if I don't fully understand this. It is a quite complex
> interrupt generator logic :(

Totally agree. It took a while to me to grasp some of the concepts
here and still I'm missing the big picture.

Thanks for the review,

-- 
Carlo Caione
