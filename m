From: robherring2@gmail.com (Rob Herring)
Date: Tue, 21 Aug 2012 08:16:37 -0500
Subject: [PATCH 1/6] gpio/mxs: adopt irq_domain support for mxs gpio driver
In-Reply-To: <CACRpkda2hc2eZaFqRfAPEG7KfLd3mFFdWze=V45=w84nRPqijA@mail.gmail.com>
References: <1345472400-31262-1-git-send-email-shawn.guo@linaro.org>
 <1345472400-31262-2-git-send-email-shawn.guo@linaro.org>
 <CACRpkda2hc2eZaFqRfAPEG7KfLd3mFFdWze=V45=w84nRPqijA@mail.gmail.com>
Message-ID: <50338A35.9070803@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/21/2012 08:01 AM, Linus Walleij wrote:
> On Mon, Aug 20, 2012 at 4:19 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> 
>> Remove irq_domain_add_legacy call from mach-mxs.c and have the gpio
>> driver adopt irqdomain support, so that we can have the mapping
>> between gpio and irq number available without using virtual_irq_start
>> and MXS_GPIO_IRQ_START.
> 
> Seems like a good thing to do, but with Grant and Rob being better at
> irqdomain than me I'd prefer one of them to have a look at this too.
> 
>> +       irq_base = irq_alloc_descs(-1, 0, 32, numa_node_id());
>> +       if (irq_base < 0)
>> +               return irq_base;
>> +
>> +       port->domain = irq_domain_add_legacy(np, 32, irq_base, 0,
>> +                                            &irq_domain_simple_ops, NULL);
> 
> For example I want to understand if it'd be possible to use a
> linear domain here.

Unfortunately, not if you care about your irq base and need sequential
irq numbers which is the case for non-DT.

Rob

> 
> Yours,
> Linus Walleij
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
