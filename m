From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 14 May 2014 17:02:23 +0100
Subject: [PATCH v3 02/19] arm64: initial support for GICv3
In-Reply-To: <87r43zhr8v.fsf@approximate.cambridge.arm.com>
References: <1397655591-2761-1-git-send-email-marc.zyngier@arm.com>
 <1397655591-2761-3-git-send-email-marc.zyngier@arm.com>
 <20140509140522.GC3362@lvm>
 <87r43zhr8v.fsf@approximate.cambridge.arm.com>
Message-ID: <CAMJs5B9ErgxivhSiGUZKAODYh-C6KnYOy_tSVcyCmkugi8UuEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 May 2014 17:54, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On Fri, May 09 2014 at  3:05:22 pm BST, Christoffer Dall <christoffer.dall@linaro.org> wrote:
>> On Wed, Apr 16, 2014 at 02:39:34PM +0100, Marc Zyngier wrote:

[...]

>>> +
>>> +static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
>>> +                         bool force)
>>> +{
>>> +     unsigned int cpu = cpumask_any_and(mask_val, cpu_online_mask);
>>> +     void __iomem *reg;
>>> +     int enabled;
>>> +     u64 val;
>>> +
>>> +     if (gic_irq_in_rdist(d))
>>> +             return -EINVAL;
>>> +
>>> +     /* If interrupt was enabled, disable it first */
>>> +     enabled = gic_peek_irq(d, GICD_ISENABLER);
>>> +     if (enabled)
>>> +             gic_mask_irq(d);
>>> +
>>> +     reg = gic_dist_base(d) + GICD_IROUTER + (gic_irq(d) * 8);
>>> +     val = gic_mpidr_to_affinity(cpu_logical_map(cpu));
>>> +
>>> +     writeq_relaxed(val, reg);
>>> +
>>> +     /*
>>> +      * If the interrupt was enabled, enabled it again. Otherwise,
>>> +      * just wait for the distributor to have digested our changes.
>>> +      */
>>> +     if (enabled)
>>> +             gic_unmask_irq(d);
>>> +     else
>>> +             gic_dist_wait_for_rwp();
>>
>> If we don't need to wait for RWP when enabling the interrupt, why do we
>> need to wait if we're not going to enable it (presumably nothing ever
>> takes effect until someone later enables the interrupt, in which case
>> the effect would be the same? no?)?
>
> We do wait on the unmask path too (see gic_poke_irq).
>

got it, thanks.

[...]

>>
>> I noticed that you removed all the dist_lock locks here.  I assume there
>> was some rationale behind this, and given you can share that explanation
>> with me and address the other tiny issues:
>
> The purpose of the lock was to avoid races between mask/unmask and
> set_type (both of which use the enable registers). But given that these
> registers can operate on a single bit (set/clear operations), and that
> the kernel won't try to do both at the same time, it is safe to get rid
> of the whole locking.
>
ok, thanks.
