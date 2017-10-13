From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 13 Oct 2017 11:00:43 +0100
Subject: [PATCH v3 2/2] drivers/irqchip: gicv3: add workaround for
 Synquacer pre-ITS
In-Reply-To: <CAKv+Gu8MUF5ng-xOqavciuzADkssJ-K_BMkNDzYbgj6aeKw3eA@mail.gmail.com>
References: <20171012183247.23679-1-ard.biesheuvel@linaro.org>
 <20171012183247.23679-3-ard.biesheuvel@linaro.org>
 <CAKv+Gu8MUF5ng-xOqavciuzADkssJ-K_BMkNDzYbgj6aeKw3eA@mail.gmail.com>
Message-ID: <02014bc8-6704-475d-47bf-4406af56fc64@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/10/17 20:11, Ard Biesheuvel wrote:
> On 12 October 2017 at 19:32, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
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
>>  arch/arm64/Kconfig                                                    |  8 +++
>>  drivers/irqchip/irq-gic-v3-its.c                                      | 63 +++++++++++++++++++-
>>  3 files changed, 72 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
>> index 4c29cdab0ea5..0798a61bbf99 100644
>> --- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
>> +++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
>> @@ -75,6 +75,10 @@ These nodes must have the following properties:
>>  - reg: Specifies the base physical address and size of the ITS
>>    registers.
>>
>> +Optional:
>> +- socionext,synquacer-pre-its: (u32, u32) tuple describing the host address
>> +  and size of the pre-ITS window, as implemented on the Socionext Synquacer SoC
>> +
>>  The main GIC node must contain the appropriate #address-cells,
>>  #size-cells and ranges properties for the reg property of all ITS
>>  nodes.
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 0df64a6a56d4..c4361dff2b74 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -539,6 +539,14 @@ config QCOM_QDF2400_ERRATUM_0065
>>
>>           If unsure, say Y.
>>
>> +config SOCIONEXT_SYNQUACER_PREITS
>> +       bool "Socionext Synquacer: Workaround for GICv3 pre-ITS"
>> +       default y
>> +       help
>> +         Socionext Synquacer SoCs implement a separate h/w block to generate
>> +         MSI doorbell writes with non-zero values for the device ID.
>> +
>> +         If unsure, say Y.
>>  endmenu
>>
>>
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>> index 891de07fd4cc..2fc4fba0cc4c 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -97,12 +97,18 @@ struct its_node {
>>         struct its_cmd_block    *cmd_write;
>>         struct its_baser        tables[GITS_BASER_NR_REGS];
>>         struct its_collection   *collections;
>> +       struct fwnode_handle    *fwnode_handle;
>>         struct list_head        its_device_list;
>>         u64                     flags;
>>         u32                     ite_size;
>>         u32                     device_ids;
>>         int                     numa_node;
>> +       unsigned int            msi_domain_flag_mask;
>>         bool                    is_v4;
>> +
>> +       /* for Socionext Synquacer pre-ITS */
>> +       u32                     pre_its_base;
>> +       u32                     pre_its_size;
>>  };
>>
>>  #define ITS_ITT_ALIGN          SZ_256
>> @@ -1095,14 +1101,29 @@ static int its_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
>>         return IRQ_SET_MASK_OK_DONE;
>>  }
>>
>> +static u64 its_irq_get_msi_base(struct its_device *its_dev)
>> +{
>> +       struct its_node *its = its_dev->its;
>> +
>> +       if (unlikely(its->pre_its_size > 0))
>> +               /*
>> +                * The Socionext Synquacer SoC has a so-called 'pre-ITS',
>> +                * which maps 32-bit writes targeted at a separate window of
>> +                * size '4 << device_id_bits' onto writes to GITS_TRANSLATER
>> +                * with device ID taken from bits [device_id_bits + 1:2] of
>> +                * the window offset.
>> +                */
>> +               return its->pre_its_base + (its_dev->device_id << 2);
>> +
>> +       return its->phys_base + GITS_TRANSLATER;
>> +}
>> +
>>  static void its_irq_compose_msi_msg(struct irq_data *d, struct msi_msg *msg)
>>  {
>>         struct its_device *its_dev = irq_data_get_irq_chip_data(d);
>> -       struct its_node *its;
>>         u64 addr;
>>
>> -       its = its_dev->its;
>> -       addr = its->phys_base + GITS_TRANSLATER;
>> +       addr = its_irq_get_msi_base(its_dev);
>>
>>         msg->address_lo         = lower_32_bits(addr);
>>         msg->address_hi         = upper_32_bits(addr);
>> @@ -2752,6 +2773,27 @@ static void __maybe_unused its_enable_quirk_qdf2400_e0065(void *data)
>>         its->ite_size = 16;
>>  }
>>
>> +static void __maybe_unused its_enable_quirk_socionext_synquacer(void *data)
>> +{
>> +       struct its_node *its = data;
>> +       u32 pre_its_window[2];
>> +       u32 ids;
>> +
>> +       if (!fwnode_property_read_u32_array(its->fwnode_handle,
>> +                                           "socionext,synquacer-pre-its",
>> +                                           pre_its_window,
>> +                                           ARRAY_SIZE(pre_its_window))) {
>> +               its->pre_its_base = pre_its_window[0];
>> +               its->pre_its_size = pre_its_window[1];
>> +
>> +               ids = ilog2(its->pre_its_size) - 2;
>> +               if (its->device_ids > ids)
>> +                       its->device_ids = ids;
>> +
>> +               its->msi_domain_flag_mask = ~IRQ_DOMAIN_FLAG_MSI_REMAP;
>> +       }
>> +}
>> +
>>  static const struct gic_quirk its_quirks[] = {
>>  #ifdef CONFIG_CAVIUM_ERRATUM_22375
>>         {
>> @@ -2777,6 +2819,19 @@ static const struct gic_quirk its_quirks[] = {
>>                 .init   = its_enable_quirk_qdf2400_e0065,
>>         },
>>  #endif
>> +#ifdef CONFIG_SOCIONEXT_SYNQUACER_PREITS
>> +       {
>> +               /*
>> +                * The Socionext Synquacer SoC incorporates ARM's own GIC-500
>> +                * implementation, but with a 'pre-ITS' added that requires
>> +                * special handling in software.
>> +                */
>> +               .desc   = "ITS: Socionext Synquacer pre-ITS",
>> +               .iidr   = 0x0001143b,
>> +               .mask   = 0xffffffff,
>> +               .init   = its_enable_quirk_socionext_synquacer,
>> +       },
>> +#endif
>>         {
>>         }
>>  };
>> @@ -2806,6 +2861,7 @@ static int its_init_domain(struct fwnode_handle *handle, struct its_node *its)
>>         inner_domain->parent = its_parent;
>>         irq_domain_update_bus_token(inner_domain, DOMAIN_BUS_NEXUS);
>>         inner_domain->flags |= IRQ_DOMAIN_FLAG_MSI_REMAP;
>> +       inner_domain->flags &= its->msi_domain_flag_mask;
> 
> Oops. its->msi_domain_flag_mask defaults to 0, so this breaks other platforms.
> 
> Unless there are better suggestions, I will move the ~ from the
> assignment to here.
> 
> 
> 
>>         info->ops = &its_msi_domain_ops;
>>         info->data = its;
>>         inner_domain->host_data = info;
>> @@ -2959,6 +3015,7 @@ static int __init its_probe_one(struct resource *res,
>>                 goto out_free_its;
>>         }
>>         its->cmd_write = its->cmd_base;
>> +       its->fwnode_handle = handle;

Or initialize msi_domain_flags with its default value here, and clear it
in the quirk handler.

Other than that (and the spurious message you reported in the v2
thread), this looks pretty good to me. Let's try to converge on the DT
side so that I can queue that for 4.15.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
