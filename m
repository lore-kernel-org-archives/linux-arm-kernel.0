From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 27 Sep 2012 13:59:08 +0200
Subject: [PATCH] pinctrl/nomadik: allocate IRQ descriptors dynamically
In-Reply-To: <5063E06A.6000205@nvidia.com>
References: <1348679887-2135-1-git-send-email-linus.walleij@stericsson.com>
 <5063E06A.6000205@nvidia.com>
Message-ID: <CACRpkdYdU-4yszhbJ5ZkyfncVpObdy0Ah=kz7pSpZ=HGgFax7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 27, 2012 at 7:13 AM, Stephen Warren <swarren@nvidia.com> wrote:
> On 09/26/2012 11:18 AM, Linus Walleij wrote:

>> +     irq_start = NOMADIK_GPIO_TO_IRQ(pdata->first_gpio);
>
> Presumably that's a 1:1 mapping...

Yep, albeit on a legacy domain to be able to keep the start irq.

>> +     irq_base = irq_alloc_descs(irq_start, 0, NMK_GPIO_PER_CHIP,
>> +                                numa_node_id());
>> +     if (IS_ERR_VALUE(irq_base)) {
>> +             WARN(1, "Cannot allocate irq_descs @ IRQ%d, assuming pre-allocated\n",
>> +                  irq_start);
>> +             irq_base = irq_start;
>> +     }
>
> Hmmm. Is this code targetting the DT case or the non-DT case or both? I
> think typically you'd call irq_domain_add_linear without forcing a
> particular IRQ base for the DT case, and only call irq_alloc_descs() for
> the non-DT case, right?

This is indeed the non-DT case. The irqdomain stuff here doesn't seem
to be properly addressing the DT usecase. I'll cook a v2 version doing
a linear domain for DT and have Lee review it.

Thanks!
Linus Walleij
