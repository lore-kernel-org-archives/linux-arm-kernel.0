From: robherring2@gmail.com (Rob Herring)
Date: Fri, 14 Aug 2015 16:08:10 -0500
Subject: [PATCH v2 1/4] of/pci: Add of_pci_check_probe_only to parse
 "linux, pci-probe-only"
In-Reply-To: <1439569159-10051-2-git-send-email-marc.zyngier@arm.com>
References: <1439569159-10051-1-git-send-email-marc.zyngier@arm.com>
 <1439569159-10051-2-git-send-email-marc.zyngier@arm.com>
Message-ID: <CAL_JsqL7VPB6nc-zRYm_73ZSgYVq_+a6sW_XZZ_LRaUXf4jTng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 14, 2015 at 11:19 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> Both pci-host-generic and Pseries parse the "linux,pci-probe-only"
> to engage the PCI_PROBE_ONLY mode, and both have a subtle bug that
> can be triggered if the property has no parameter.

Humm, I bet we could break a lot of machines if we fixed the core code
to properly make pp->value NULL when there is no value.

> Provide a generic implementation that can be used by both.
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  drivers/of/of_pci.c    | 30 ++++++++++++++++++++++++++++++
>  include/linux/of_pci.h |  3 +++
>  2 files changed, 33 insertions(+)
>
> diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
> index 5751dc5..a4e29ff 100644
> --- a/drivers/of/of_pci.c
> +++ b/drivers/of/of_pci.c
> @@ -118,6 +118,36 @@ int of_get_pci_domain_nr(struct device_node *node)
>  EXPORT_SYMBOL_GPL(of_get_pci_domain_nr);
>
>  /**
> + * of_pci_check_probe_only - Setup probe only mode if linux,pci-probe-only
> + *                           is present and valid
> + *
> + * @node: device tree node that may contain the property (usually "chosen")
> + *
> + */
> +void of_pci_check_probe_only(struct device_node *node)
> +{
> +       const int *prop;
> +       int len;
> +
> +       if (!node)
> +               return;
> +
> +       prop = of_get_property(node, "linux,pci-probe-only", &len);

It is preferred to use of_property_read_u32 to avoid just these types
of problems.

Rob
