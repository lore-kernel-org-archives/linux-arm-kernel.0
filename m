From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Fri, 16 May 2014 20:05:12 +0530
Subject: [PATCH RFC 3/4] clk: samsung: Add driver to control CLKOUT line
 on Exynos SoCs
In-Reply-To: <5375EDFD.1020708@samsung.com>
References: <1400175151-27779-1-git-send-email-t.figa@samsung.com>
 <1400175151-27779-4-git-send-email-t.figa@samsung.com>
 <CAPdUM4P7Z1eLVKuc0N1iPaekM_7kNv7KCve2MgrEziszfnzz7A@mail.gmail.com>
 <5375EDFD.1020708@samsung.com>
Message-ID: <CAPdUM4O4RKFZFR_tcwG4pd7E6KMkneG9R_VbZPt+m4fGG_UFVg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 May 2014 16:22, Tomasz Figa <t.figa@samsung.com> wrote:
> Hi Rahul,
>
> On 16.05.2014 12:39, Rahul Sharma wrote:
>> [snip]
>>> +       gate->lock = &clkout_lock;
>>> +
>>> +       mux->reg = reg + EXYNOS_PMU_DEBUG_REG;
>>> +       mux->mask = EXYNOS_CLKOUT_MUX_MASK;
>>> +       mux->shift = EXYNOS_CLKOUT_MUX_SHIFT;
>>> +       mux->lock = &clkout_lock;
>>> +
>>> +       clk = clk_register_composite(NULL, "clkout", parent_names,
>>> +                                       parent_count, &mux->hw,
>>> +                                       &clk_mux_ops, NULL, NULL, &gate->hw,
>>> +                                       &clk_gate_ops, 0);
>>> +       if (IS_ERR(clk))
>>> +               goto err_unmap;
>>> +
>>
>> Hi Tomasz,
>>
>> Do we really need a composite clock here? How about registering
>> a mux and a gate separately?
>
> What's wrong with a composite clock? It simplifies the code as just a
> single clock needs to be registered. I don't see any drawbacks compared
> to registering two clocks separately.
>

I always took it as a thumb rule to not to use composite clocks if you
can easily represent the block using basic clocks structures.

There can be a problem when drivers using such clocks assume that such
clock continue to offer composite functionality for all futures SoCs and
write code around it. This is what we faced when fixing drivers during
CCF migration.

> Best regards,
> Tomasz
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
