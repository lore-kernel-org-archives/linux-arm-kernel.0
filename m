From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 5 Oct 2017 13:30:45 +0100
Subject: [PATCH] drivers/irqchip: gicv3: add workaround for Synquacer
 pre-ITS
In-Reply-To: <78b7d2cb-9c72-f8b2-fb3d-0b9331c7c968@arm.com>
References: <20171005114344.21029-1-ard.biesheuvel@linaro.org>
 <78b7d2cb-9c72-f8b2-fb3d-0b9331c7c968@arm.com>
Message-ID: <CAKv+Gu9KrpLhbUzHtsdMCXWr4ZeRmdCp-=NKyugMqCH6iVh0Fw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 October 2017 at 13:19, Robin Murphy <robin.murphy@arm.com> wrote:
> On 05/10/17 12:43, Ard Biesheuvel wrote:
>> The Socionext Synquacer SoC's implementation of GICv3 has a so-called
>> 'pre-ITS', which maps 32-bit writes targeted at a separate window of
>> size '4 << device_id_bits' onto writes to GITS_TRANSLATER with device
>> ID taken from bits [device_id_bits + 1:2] of the window offset.
>> Writes that target GITS_TRANSLATER directly are reported as originating
>> from device ID #0.
>>
>> So add a workaround for this. Given that this breaks isolation, clear
>> the IRQ_DOMAIN_FLAG_MSI_REMAP flag as well.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>  Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt |  4 ++
>>  arch/arm64/Kconfig                                                    |  8 ++++
>>  drivers/irqchip/irq-gic-v3-its.c                                      | 50 ++++++++++++++++++--
>>  3 files changed, 58 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
>> index 4c29cdab0ea5..112ebb286728 100644
>> --- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
>> +++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
>> @@ -75,6 +75,10 @@ These nodes must have the following properties:
>>  - reg: Specifies the base physical address and size of the ITS
>>    registers.
>>
>> +Optional:
>> +- socionext,synquacer-pre-its: (u64, u64) tuple describing the PCI address
>> +  and size of the pre-ITS window.
>> +
>>  The main GIC node must contain the appropriate #address-cells,
>>  #size-cells and ranges properties for the reg property of all ITS
>>  nodes.
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index dfd908630631..081722240936 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -538,6 +538,14 @@ config QCOM_QDF2400_ERRATUM_0065
>>
>>         If unsure, say Y.
>>
>> +config SOCIONEXT_SYNQUACER_PREITS
>> +     bool "Socionext Synquacer: Workaround for GICv3 pre-ITS"
>> +     default y
>> +     help
>> +       Socionext Synquacer SoCs implement a separate h/w block to generate
>> +       MSI doorbell writes with non-zero values for the device ID.
>> +
>> +       If unsure, say Y.
>>  endmenu
>>
>>
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>> index 284738add89b..fb86b15fa10d 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -45,6 +45,7 @@
>>  #define ITS_FLAGS_CMDQ_NEEDS_FLUSHING                (1ULL << 0)
>>  #define ITS_FLAGS_WORKAROUND_CAVIUM_22375    (1ULL << 1)
>>  #define ITS_FLAGS_WORKAROUND_CAVIUM_23144    (1ULL << 2)
>> +#define ITS_FLAGS_WORKAROUND_SOCIONEXT_PREITS        (1ULL << 3)
>>
>>  #define RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING  (1 << 0)
>>
>> @@ -85,6 +86,10 @@ struct its_node {
>>       struct its_collection   *collections;
>>       struct list_head        its_device_list;
>>       u64                     flags;
>> +#ifdef CONFIG_SOCIONEXT_SYNQUACER_PREITS
>> +     u64                     pre_its_base;
>> +     u64                     pre_its_size;
>> +#endif
>>       u32                     ite_size;
>>       u32                     device_ids;
>>       int                     numa_node;
>> @@ -654,6 +659,23 @@ static int its_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
>>       return IRQ_SET_MASK_OK_DONE;
>>  }
>>
>> +static u64 its_irq_get_msi_base(struct its_node *its)
>> +{
>> +#ifdef CONFIG_SOCIONEXT_SYNQUACER_PREITS
>> +     if (its->flags & ITS_FLAGS_WORKAROUND_SOCIONEXT_PREITS)
>> +
>> +             /*
>> +              * The Socionext Synquacer SoC has a so-called 'pre-ITS',
>> +              * which maps 32-bit writes targeted at a separate window of
>> +              * size '4 << device_id_bits' onto writes to GITS_TRANSLATER
>> +              * with device ID taken from bits [device_id_bits + 1:2] of
>> +              * the window offset.
>> +              */
>> +             return its->pre_its_base + (its_dev->device_id << 2);
>> +#endif
>> +     return its->phys_base + GITS_TRANSLATER;
>> +}
>> +
>>  static void its_irq_compose_msi_msg(struct irq_data *d, struct msi_msg *msg)
>>  {
>>       struct its_device *its_dev = irq_data_get_irq_chip_data(d);
>> @@ -661,12 +683,15 @@ static void its_irq_compose_msi_msg(struct irq_data *d, struct msi_msg *msg)
>>       u64 addr;
>>
>>       its = its_dev->its;
>> -     addr = its->phys_base + GITS_TRANSLATER;
>> +     addr = its_irq_get_msi_base(its);
>>
>>       msg->address_lo         = lower_32_bits(addr);
>>       msg->address_hi         = upper_32_bits(addr);
>>       msg->data               = its_get_event_id(d);
>>
>> +     if (its->flags & ITS_FLAGS_WORKAROUND_SOCIONEXT_PREITS)
>> +             return;
>
> Oh, goody. If the pre-ITS is in front of SMMU translation as well then
> we're really going to need that generic IOMMU reserved region binding.
> Does this thing plan to support ACPI booting as well?
>

Yes. And bring world peace.

There are various SMMUs on this board, but they are currently owned by
the firmware, and it is unclear whether we can expose any of them the
OS at any point.

Ideally, I would like to specify the host address, and let the SMMU
take care of the translation (if needed). Also, it would be nice if
the pre-ITS was accessible to legacy endpoints that only support
32-bit MSIs, and so it would be much better if the pre-ITS were simple
mapped 1:1, and then we can just translate it like any other MSI if we
do end up exposing the SMMU to the OS.
