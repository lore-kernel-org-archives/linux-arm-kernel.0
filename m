From: robherring2@gmail.com (Rob Herring)
Date: Thu, 15 May 2014 14:08:39 -0500
Subject: [PATCHv4 2/3] ARM: mm: add support for HW coherent systems in
 PL310
In-Reply-To: <1400165974-9059-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1400165974-9059-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1400165974-9059-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <CAL_Jsq+VRZdJD6sMR=whC=bmjgODb01h8dci_KsjHx7pMLDhuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 15, 2014 at 9:59 AM, Thomas Petazzoni
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
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/arm/l2cc.txt |  3 +++
>  arch/arm/mm/cache-l2x0.c                       | 14 ++++++++++++++
>  2 files changed, 17 insertions(+)
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
> index 7abde2ce..199a745 100644
> --- a/arch/arm/mm/cache-l2x0.c
> +++ b/arch/arm/mm/cache-l2x0.c
> @@ -1005,6 +1005,20 @@ int __init l2x0_of_init(u32 aux_val, u32 aux_mask)
>
>         of_init = true;
>         memcpy(&outer_cache, &data->outer_cache, sizeof(outer_cache));
> +
> +       /*
> +        * outer sync operations are not needed when the system is I/O
> +        * coherent, and potentially harmful in certain situations
> +        * (PCIe/PL310 deadlock on Armada 375/38x due to hardware I/O
> +        * coherency). The other operations are kept because they are
> +        * infrequent (therefore do not cause the deadlock) and needed
> +        * for secondary CPU boot and other power management
> +        * activities.
> +        */
> +       if (of_device_is_compatible(np, "arm,pl310-cache") &&

Don't we have a pl310 specific init function this can be placed in
removing this check? We could probably remove this check here anyway
because we're never going to see this on an L210 or L220.

> +           of_property_read_bool(np, "arm,io-coherent"))
> +               outer_cache.sync = NULL;
> +
>         l2x0_init(l2x0_base, aux_val, aux_mask);
>
>         return 0;
> --
> 1.9.3
>
