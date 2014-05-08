From: robherring2@gmail.com (Rob Herring)
Date: Thu, 8 May 2014 12:04:08 -0500
Subject: [PATCH 3/4] irqchip: gic: Add support for per CPU bank offset
 specification in DT
In-Reply-To: <1397832181-5153-4-git-send-email-t.figa@samsung.com>
References: <1397832181-5153-1-git-send-email-t.figa@samsung.com>
 <1397832181-5153-4-git-send-email-t.figa@samsung.com>
Message-ID: <CAL_Jsq+wCDWnZ-wemMPc1tvpnK3kd=bx5fkT5GAP_QyLPjQfJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 18, 2014 at 9:43 AM, Tomasz Figa <t.figa@samsung.com> wrote:
> On most platforms GIC registers are banked, so each CPU can access its
> registers at the same address. However there is a small number of SoCs
> on which the banking is not implemented and each CPU has its GIC
> register set at different offset from GIC base address.
>
> Originally the driver used simple maths to calculate the address, i.e.
> multiplying constant percpu_offset by cpu_logical_map(cpu). However this
> assumed the namespace of cpu_logical_map() to be from 0 to num_cpus-1,
> but if CPU topology is specified via DT, this changes to full ID in
> the same format as MPIDR register and thus breaks the assumption.
>
> This patch adds support for per CPU GIC bank offset specification
> through device tree to separate SoC-internal core wiring from CPU
> multi-processor IDs.
>
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> ---
>  Documentation/devicetree/bindings/arm/cpus.txt |  7 ++
>  Documentation/devicetree/bindings/arm/gic.txt  | 34 +++++++++-
>  drivers/irqchip/irq-gic.c                      | 94 ++++++++++++++++++--------
>  3 files changed, 105 insertions(+), 30 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
> index 333f4ae..47654e6 100644
> --- a/Documentation/devicetree/bindings/arm/cpus.txt
> +++ b/Documentation/devicetree/bindings/arm/cpus.txt
> @@ -209,6 +209,13 @@ nodes to be present and contain the properties described below.
>                 Value type: <phandle>
>                 Definition: Specifies the ACC[2] node associated with this CPU.
>
> +       - gic-offset
> +               Usage: required for systems that have non-banked GIC
> +                      implementation that requires each CPU to use different
> +                      offset to access its set of GIC registers
> +               Value type: <u32>
> +               Definition: Specifies the offset of GIC registers specific to
> +                           this CPU.

What if you have 1 distributor address and a per cpu address which is
allowed in the gicv2 spec IIRC.

I think I would rather see this stay contained within the gic node and
use reg property.

Rob

>
>  Example 1 (dual-cluster big.LITTLE system 32-bit):
>
> diff --git a/Documentation/devicetree/bindings/arm/gic.txt b/Documentation/devicetree/bindings/arm/gic.txt
> index 5573c08..2bd03406 100644
> --- a/Documentation/devicetree/bindings/arm/gic.txt
> +++ b/Documentation/devicetree/bindings/arm/gic.txt
> @@ -48,7 +48,7 @@ Optional
>
>  - cpu-offset   : per-cpu offset within the distributor and cpu interface
>    regions, used when the GIC doesn't have banked registers. The offset is
> -  cpu-offset * cpu-nr.
> +  cpu-offset * cpu-nr. (DEPRECATED, see per-CPU 'gic-offset' property.)
>
>  - arm,routable-irqs : Total number of gic irq inputs which are not directly
>                   connected from the peripherals, but are routed dynamically
> @@ -67,6 +67,38 @@ Example:
>                       <0xfff10100 0x100>;
>         };
>
> +* Per-CPU register offset specification for non-banked GIC
> +
> +On most platforms GIC registers are banked, so each CPU can access its
> +registers at the same address. However there is a small number of SoCs
> +on which the banking is not implemented and each CPU has its GIC
> +register set at different offset from GIC base address. These offsets
> +need to be be provided from device tree, as described below.
> +
> +Optional properties in node of each CPU in the system:
> +
> + - gic-offset : A single u32 value that needs to be added to GIC base
> +   address to calculate address of GIC registers for that CPU.
> +
> +See [1] for more details about ARM CPU bindings.
> +
> +Example:
> +
> +       cpus {
> +               /* ... */
> +
> +               cpu at a00 {
> +                       /* ... */
> +                       gic-offset = <0x0000>;
> +               };
> +
> +               cpu at a01 {
> +                       /* ... */
> +                       gic-offset = <0x8000>;
> +               };
> +       };
> +
> +[1] Documentation/devicetree/bindings/arm/cpus.txt
>
>  * GIC virtualization extensions (VGIC)
>
> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> index 4300b66..ad6f4fe 100644
> --- a/drivers/irqchip/irq-gic.c
> +++ b/drivers/irqchip/irq-gic.c
> @@ -924,6 +924,69 @@ const struct irq_domain_ops gic_default_routable_irq_domain_ops = {
>  const struct irq_domain_ops *gic_routable_irq_domain_ops =
>                                         &gic_default_routable_irq_domain_ops;
>
> +static int gic_setup_bases(struct gic_chip_data *gic, void __iomem *dist_base,
> +                          void __iomem *cpu_base, u32 percpu_offset)
> +{
> +       bool use_cpu_nodes = true;
> +       u32 offset;
> +       unsigned int cpu;
> +
> +       for_each_possible_cpu(cpu) {
> +               struct device_node *cpu_node = of_get_cpu_node(cpu, NULL);
> +
> +               if (!cpu_node
> +                   || of_property_read_u32(cpu_node, "gic-offset", &offset)) {
> +                       use_cpu_nodes = false;
> +                       break;
> +               }
> +       }
> +
> +       if (!(percpu_offset || use_cpu_nodes)
> +           || !IS_ENABLED(CONFIG_GIC_NON_BANKED)) {
> +               /* Normal, sane GIC... (or non-banked unsupported) */
> +               WARN(percpu_offset || use_cpu_nodes,
> +                    "GIC_NON_BANKED not enabled, ignoring %08x offset!",
> +                    percpu_offset);
> +
> +               gic->dist_base.common_base = dist_base;
> +               gic->cpu_base.common_base = cpu_base;
> +               gic_set_base_accessor(gic, gic_get_common_base);
> +
> +               return 0;
> +       }
> +
> +       /* Frankein-GIC without banked registers... */
> +       gic->dist_base.percpu_base = alloc_percpu(void __iomem *);
> +       gic->cpu_base.percpu_base = alloc_percpu(void __iomem *);
> +       if (WARN_ON(!gic->dist_base.percpu_base ||
> +                       !gic->cpu_base.percpu_base)) {
> +               free_percpu(gic->dist_base.percpu_base);
> +               free_percpu(gic->cpu_base.percpu_base);
> +
> +               return -ENOMEM;
> +       }
> +
> +       for_each_possible_cpu(cpu) {
> +               if (use_cpu_nodes) {
> +                       struct device_node *cpu_node =
> +                                               of_get_cpu_node(cpu, NULL);
> +
> +                       of_property_read_u32(cpu_node, "gic-offset", &offset);
> +               } else {
> +                       offset = percpu_offset * cpu_logical_map(cpu);
> +               }
> +
> +               *per_cpu_ptr(gic->dist_base.percpu_base, cpu) =
> +                                                       dist_base + offset;
> +               *per_cpu_ptr(gic->cpu_base.percpu_base, cpu) =
> +                                                       cpu_base + offset;
> +       }
> +
> +       gic_set_base_accessor(gic, gic_get_percpu_base);
> +
> +       return 0;
> +}
> +
>  void __init gic_init_bases(unsigned int gic_nr, int irq_start,
>                            void __iomem *dist_base, void __iomem *cpu_base,
>                            u32 percpu_offset, struct device_node *node)
> @@ -936,36 +999,9 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
>         BUG_ON(gic_nr >= MAX_GIC_NR);
>
>         gic = &gic_data[gic_nr];
> -#ifdef CONFIG_GIC_NON_BANKED
> -       if (percpu_offset) { /* Frankein-GIC without banked registers... */
> -               unsigned int cpu;
> -
> -               gic->dist_base.percpu_base = alloc_percpu(void __iomem *);
> -               gic->cpu_base.percpu_base = alloc_percpu(void __iomem *);
> -               if (WARN_ON(!gic->dist_base.percpu_base ||
> -                           !gic->cpu_base.percpu_base)) {
> -                       free_percpu(gic->dist_base.percpu_base);
> -                       free_percpu(gic->cpu_base.percpu_base);
> -                       return;
> -               }
>
> -               for_each_possible_cpu(cpu) {
> -                       unsigned long offset = percpu_offset * cpu_logical_map(cpu);
> -                       *per_cpu_ptr(gic->dist_base.percpu_base, cpu) = dist_base + offset;
> -                       *per_cpu_ptr(gic->cpu_base.percpu_base, cpu) = cpu_base + offset;
> -               }
> -
> -               gic_set_base_accessor(gic, gic_get_percpu_base);
> -       } else
> -#endif
> -       {                       /* Normal, sane GIC... */
> -               WARN(percpu_offset,
> -                    "GIC_NON_BANKED not enabled, ignoring %08x offset!",
> -                    percpu_offset);
> -               gic->dist_base.common_base = dist_base;
> -               gic->cpu_base.common_base = cpu_base;
> -               gic_set_base_accessor(gic, gic_get_common_base);
> -       }
> +       if (gic_setup_bases(gic, dist_base, cpu_base, percpu_offset))
> +               return;
>
>         /*
>          * Initialize the CPU interface map to all CPUs.
> --
> 1.9.2
>
