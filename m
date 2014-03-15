From: mohun106@gmail.com (Radha Mohan)
Date: Sat, 15 Mar 2014 20:52:34 +0530
Subject: [PATCH 01/18] arm64: initial support for GICv3
In-Reply-To: <20140227120730.GE30003@mudshark.cambridge.arm.com>
References: <1391607050-540-1-git-send-email-marc.zyngier@arm.com>
 <1391607050-540-2-git-send-email-marc.zyngier@arm.com>
 <20140225180619.GG23136@mudshark.cambridge.arm.com>
 <530DE3CE.1010002@arm.com>
 <20140227120730.GE30003@mudshark.cambridge.arm.com>
Message-ID: <CAC8NTUWoqAg_L01GMoWG_H2QeN1-Y5iuOGSrnmCttCy6DXd1DQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,
I am from Cavium and we have tried your GICv3 driver on our internal
emulation platform. We have booted systems with >8 cores and tested
basic SGIs, PPIs and SPIs.
However we haven't exercised LPIs and ITS yet. We plan to do this soon.

If you have a new version of the patches coming out soon, we can
exercise that as well on our platform.

regards,
Radha Mohan

On Thu, Feb 27, 2014 at 5:37 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Wed, Feb 26, 2014 at 12:53:34PM +0000, Marc Zyngier wrote:
>> On 25/02/14 18:06, Will Deacon wrote:
>> > Not sure if you care, but readq is a show-stopper if you want to build this
>> > with arch/arm/.
>>
>> I realized that recently. Any reason why we don't have writeq/readq on
>> LPAE-capable stuff (other than the obvious runtime detection madness)?
>
> I'm not sure that you'd be guaranteed single-copy atomicity for such an
> access, which is probably assumed by readq/writeq.
>
>> >> +                       if ((typer >> 32) == aff) {
>> >> +                               gic_data_rdist_rd_base() = ptr;
>> >> +                               pr_info("CPU%d: found redistributor %llx @%p\n",
>> >> +                                       smp_processor_id(),
>> >> +                                       (unsigned long long) mpidr, ptr);
>> >> +                               return 0;
>> >> +                       }
>> >> +
>> >> +                       if (gic_data.redist_stride) {
>> >> +                               ptr += gic_data.redist_stride;
>> >> +                       } else {
>> >> +                               ptr += SZ_64K * 2; /* Skip RD_base + SGI_base */
>> >> +                               if (typer & GICR_TYPER_VLPIS)
>> >> +                                       ptr += SZ_64K * 2; /* Skip VLPI_base + reserved page */
>> >> +                       }
>> >
>> > VLPIS is RES0 in GICv3.
>>
>> Indeed. But we still want this driver to run on GICv4 HW, even if we
>> don't use VLPIs just yet.
>
> Ok, just mention that in the commit then.
>
>> >> +static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
>> >> +                           bool force)
>> >> +{
>> >> +       unsigned int cpu = cpumask_any_and(mask_val, cpu_online_mask);
>> >> +       void __iomem *reg;
>> >> +       u64 val;
>> >> +
>> >> +       if (gic_irq(d) < 32)
>> >> +               return -EINVAL;
>> >> +
>> >> +       reg = gic_dist_base(d) + GICD_IROUTER + (gic_irq(d) * 8);
>> >> +       val = gic_mpidr_to_affinity(cpu_logical_map(cpu));
>> >> +
>> >> +       writeq_relaxed(val, reg);
>> >
>> > How do you ensure that the interrupt has actually moved?
>>
>> There is no way to ensure it actually did (other than reading back from
>> the same register, if that's what you're aiming for?).
>
> I guess it depends how angry Linux will get if the interrupt fires on the
> wrong CPU. If the interrupt is pending when the moving takes place, will it
> be asserted on the new target?
>
> Will
> _______________________________________________
> kvmarm mailing list
> kvmarm at lists.cs.columbia.edu
> https://lists.cs.columbia.edu/cucslists/listinfo/kvmarm
