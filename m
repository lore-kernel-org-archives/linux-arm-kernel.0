From: robherring2@gmail.com (Rob Herring)
Date: Thu, 12 Jun 2014 15:12:37 -0500
Subject: [PATCHv5 1/3] ARM: mm: add support for HW coherent systems in
 PL310 cache
In-Reply-To: <1402585772-10405-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1402585772-10405-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1402585772-10405-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <CAL_JsqKtKgT9UzL6XdMF0PfYnWS+GHT7rAwocYZ0j_KV_oKitQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 12, 2014 at 10:09 AM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> When a PL310 cache is used on a system that provides hardware
> coherency, the outer cache sync operation is useless, and can be
> skipped. Moreover, on some systems, it is harmful as it causes
> deadlocks between the Marvell coherency mechanism, the Marvell PCIe
> controller and the Cortex-A9.
>
> To avoid this, this commit introduces a new Device Tree property
> 'arm,io-coherent' for the L2 cache controller node, valid only for the
> PL310 cache. It identifies the usage of the PL310 cache in an I/O
> coherent configuration. Internally, it makes the driver disable the
> outer cache sync operation.
>
> Note that technically speaking, a fully coherent system wouldn't
> require any of the other .outer_cache operations. However, in
> practice, when booting secondary CPUs, these are not yet coherent, and
> therefore a set of cache maintenance operations are necessary at this
> point. This explains why we keep the other .outer_cache operations and
> only ->sync is disabled.
>
> While in theory any write to a PL310 register could cause the
> deadlock, in practice, disabling ->sync is sufficient to workaround
> the deadlock, since the other cache maintenance operations are only
> used in very specific situations.
>
> Contrary to previous versions of this patch, this new version does not
> simply NULL-ify the ->sync member, because the l2c_init_data
> structures are now 'const' and therefore cannot be modified, which is
> a good thing. Therefore, this patch introduces a separate
> l2c_init_data instance, called of_l2c310_coherent_data.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Acked-by: Rob Herring <robh@kernel.org>

> ---
> This patch is based on the latest mainline, as it depends on the L2CC
> cleanup from Russell King.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/arm/l2cc.txt |  3 +++
>  arch/arm/mm/cache-l2x0.c                       | 31 ++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/l2cc.txt b/Documentation/devicetree/bindings/arm/l2cc.txt
> index b513cb8..af527ee 100644
> --- a/Documentation/devicetree/bindings/arm/l2cc.txt
> +++ b/Documentation/devicetree/bindings/arm/l2cc.txt
> @@ -40,6 +40,9 @@ Optional properties:
>  - arm,filter-ranges : <start length> Starting address and length of window to
>    filter. Addresses in the filter window are directed to the M1 port. Other
>    addresses will go to the M0 port.
> +- arm,io-coherent : indicates that the system is operating in an hardware
> +  I/O coherent mode. Valid only when the arm,pl310-cache compatible
> +  string is used.
>  - interrupts : 1 combined interrupt.
>  - cache-id-part: cache id part number to be used if it is not present
>    on hardware
> diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
> index efc5cab..076172b 100644
> --- a/arch/arm/mm/cache-l2x0.c
> +++ b/arch/arm/mm/cache-l2x0.c
> @@ -1069,6 +1069,33 @@ static const struct l2c_init_data of_l2c310_data __initconst = {
>  };
>
>  /*
> + * This is a variant of the of_l2c310_data with .sync set to
> + * NULL. Outer sync operations are not needed when the system is I/O
> + * coherent, and potentially harmful in certain situations (PCIe/PL310
> + * deadlock on Armada 375/38x due to hardware I/O coherency). The
> + * other operations are kept because they are infrequent (therefore do
> + * not cause the deadlock in practice) and needed for secondary CPU
> + * boot and other power management activities.
> + */
> +static const struct l2c_init_data of_l2c310_coherent_data __initconst = {
> +       .type = "L2C-310 Coherent",
> +       .way_size_0 = SZ_8K,
> +       .num_lock = 8,
> +       .of_parse = l2c310_of_parse,
> +       .enable = l2c310_enable,
> +       .fixup = l2c310_fixup,
> +       .save  = l2c310_save,
> +       .outer_cache = {
> +               .inv_range   = l2c210_inv_range,
> +               .clean_range = l2c210_clean_range,
> +               .flush_range = l2c210_flush_range,
> +               .flush_all   = l2c210_flush_all,
> +               .disable     = l2c310_disable,
> +               .resume      = l2c310_resume,
> +       },
> +};
> +
> +/*
>   * Note that the end addresses passed to Linux primitives are
>   * noninclusive, while the hardware cache range operations use
>   * inclusive start and end addresses.
> @@ -1487,6 +1514,10 @@ int __init l2x0_of_init(u32 aux_val, u32 aux_mask)
>
>         data = of_match_node(l2x0_ids, np)->data;
>
> +       if (of_device_is_compatible(np, "arm,pl310-cache") &&
> +           of_property_read_bool(np, "arm,io-coherent"))
> +               data = &of_l2c310_coherent_data;
> +
>         old_aux = readl_relaxed(l2x0_base + L2X0_AUX_CTRL);
>         if (old_aux != ((old_aux & aux_mask) | aux_val)) {
>                 pr_warn("L2C: platform modifies aux control register: 0x%08x -> 0x%08x\n",
> --
> 2.0.0
>
