From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 15 Jun 2017 11:35:08 +0100
Subject: [PATCH 2/2] acpi, gicv3-its, numa: Adding numa node mapping for
 gic-its units
In-Reply-To: <CAFpQJXVFGnfMeHRGfsvxZAR_CQBLU6tgLsCuTrW8giQekgndvw@mail.gmail.com>
References: <1496753787-27735-1-git-send-email-ganapatrao.kulkarni@cavium.com>
 <1496753787-27735-3-git-send-email-ganapatrao.kulkarni@cavium.com>
 <20170612105335.GA30594@red-moon>
 <CAFpQJXVFGnfMeHRGfsvxZAR_CQBLU6tgLsCuTrW8giQekgndvw@mail.gmail.com>
Message-ID: <20170615103508.GA15815@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 14, 2017 at 03:23:17PM +0530, Ganapatrao Kulkarni wrote:

[...]

> >> +static int __init
> >> +acpi_parse_its_affinity(struct acpi_subtable_header *header,
> >> +                      const unsigned long end)
> >> +{
> >> +     struct acpi_srat_its_affinity *its_affinity;
> >> +
> >> +     its_affinity = (struct acpi_srat_its_affinity *)header;
> >> +     if (!its_affinity)
> >> +             return -EINVAL;
> >> +
> >> +     acpi_table_print_srat_entry(header);

You can leave this info printing but see below.

> >> +
> >> +     /* let architecture-dependent part to do it */
> >> +     acpi_numa_its_affinity_init(its_affinity);
> >> +
> >> +     return 0;
> >> +}
> >> +
> >>  static int __initdata parsed_numa_memblks;
> >>
> >>  static int __init
> >> @@ -445,7 +473,7 @@ int __init acpi_numa_init(void)
> >>
> >>       /* SRAT: Static Resource Affinity Table */
> >>       if (!acpi_table_parse(ACPI_SIG_SRAT, acpi_parse_srat)) {
> >> -             struct acpi_subtable_proc srat_proc[3];
> >> +             struct acpi_subtable_proc srat_proc[4];
> >>
> >>               memset(srat_proc, 0, sizeof(srat_proc));
> >>               srat_proc[0].id = ACPI_SRAT_TYPE_CPU_AFFINITY;
> >> @@ -454,6 +482,8 @@ int __init acpi_numa_init(void)
> >>               srat_proc[1].handler = acpi_parse_x2apic_affinity;
> >>               srat_proc[2].id = ACPI_SRAT_TYPE_GICC_AFFINITY;
> >>               srat_proc[2].handler = acpi_parse_gicc_affinity;
> >> +             srat_proc[3].id = ACPI_SRAT_TYPE_GIC_ITS_AFFINITY;
> >> +             srat_proc[3].handler = acpi_parse_its_affinity;
> >>
> >>               acpi_table_parse_entries_array(ACPI_SIG_SRAT,
> >>                                       sizeof(struct acpi_table_srat),
> >> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> >> index 45ea1933..84936da 100644
> >> --- a/drivers/irqchip/irq-gic-v3-its.c
> >> +++ b/drivers/irqchip/irq-gic-v3-its.c
> >> @@ -1861,7 +1861,8 @@ static int __init gic_acpi_parse_madt_its(struct acpi_subtable_header *header,
> >>               goto dom_err;
> >>       }
> >>
> >> -     err = its_probe_one(&res, dom_handle, NUMA_NO_NODE);
> >> +     err = its_probe_one(&res, dom_handle,
> >> +                     acpi_numa_get_its_nid(its_entry->translation_id));
> >
> > If that's the only usage I wonder whether we really need all arm64
> > arch code/data, instead of parsing the SRAT in ITS code driver straight
> > away at probe, retrieve its node and be done with this.
> >
> > I understand you replicated what x86/GICC does with APIC code, I would
> > like to understand though if we see a reason why (or better, why we keep
> > the relevant stashed data in arch/arm64 instead of the ITS driver).
> 
> it is been thought to do ITS sub table parse along with other SRAT
> tables.  and use the mapping later when ITS devices are
> initialised/probed.  IMO, it is more appropriate to keep all SRAT sub
> table parsing to same function/place rather than moving to driver.

I do not follow. If it is just used in ITS driver code to set the ITS
affinity node what's the point of stashing data and adding callbacks
when you can simply parse the SRAT and be done with it ?

Or you have something on top of these patches that require ITS node
information and the calls you added ? If so post the code please.

Regardless, it's ITS specific information, ITS is managed through an
irqchip driver on ARM64 so even if you decided to stash the SRAT ITS
information it does not belong in arch/arm64 IMO, you can implement
acpi_numa_its_affinity_init() in the ITS driver but AFAICS for the time
being it would be just useless that's the point I am making.

Thanks,
Lorenzo
