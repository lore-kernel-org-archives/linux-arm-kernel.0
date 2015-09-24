From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 24 Sep 2015 20:30:06 +0100
Subject: [PATCH v4 1/2] Add the driver of mbigen interrupt controller
In-Reply-To: <560253C2.60609@huawei.com>
References: <1439952920-2296-1-git-send-email-majun258@huawei.com>
 <1439952920-2296-2-git-send-email-majun258@huawei.com>
 <20150921225324.5568f673@arm.com> <560253C2.60609@huawei.com>
Message-ID: <20150924203006.4bb162aa@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 23 Sep 2015 15:24:50 +0800
"majun (F)" <majun258@huawei.com> wrote:

[...]

> >> +static int mbigen_device_init(struct mbigen_chip *chip,
> >> +                       struct device_node *node)
> >> +{
> >> +       struct mbigen_device *mgn_dev;
> >> +       struct device_node *msi_np;
> >> +       struct irq_domain *msi_domain;
> >> +       struct msi_desc *desc;
> >> +       struct mbigen_irq_data *mgn_irq_data;
> >> +       u32 nvec, dev_id;
> >> +       int ret;
> >> +
> >> +       of_property_read_u32(node, "nr-interrupts", &nvec);
> >> +       if (!nvec)
> >> +               return -EINVAL;
> >> +
> >> +       ret = of_property_read_u32_index(node, "msi-parent", 1, &dev_id);
> >> +       if (ret)
> >> +               return -EINVAL;
> >> +
> >> +       msi_np = of_parse_phandle(node, "msi-parent", 0);
> >> +       if (!msi_np) {
> >> +               pr_err("%s- no msi node found: %s\n", __func__,
> >> +                       node->full_name);
> >> +               return -ENXIO;
> >> +       }
> >> +
> >> +       msi_domain = irq_find_matching_host(msi_np, DOMAIN_BUS_PLATFORM_MSI);
> >> +       if (!msi_domain) {
> >> +               pr_err("MBIGEN: no platform-msi domain for %s\n",
> >> +                       msi_np->full_name);
> >> +               return -ENXIO;
> >> +       }
> > 
> > There shouldn't be any need for all this msi-parent handling if you
> > correctly created the platform-devices for the mbigen devices. I've
> > gone though quite some effort to make sure none of that was necessary,
> 
> Do you mean I should use the of_msi_configure() function at here,
> or
> msi-parent should be handled during initial when this function be
> called in function of_platform_device_create_pdata() ?

The second option. I understand this is a bit complicated because your
node is both an interrupt controller and an MSI client.

You need a platform device to represent the MSI client and use this
to get the MSI setup to be done automatically by the core code.
of_platform_populate() should normally solve this neatly. On top of
that, you need to use the normal irqchip infrastructure to probe the
irqchip side of the node.

[...]

> >> +static int __init mbigen_init(void)
> >> +{
> >> +       struct device_node *np;
> >> +
> >> +       for (np = of_find_matching_node(NULL, mbigen_chip_id); np;
> >> +            np = of_find_matching_node(np, mbigen_chip_id)) {
> >> +               mbigen_of_init(np);
> >> +       }
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +core_initcall(mbigen_init);
> > 
> > That's the wrong thing to do. The interrupt controller should be
> > probed with IRQCHIP_DECLARE(). Yes, this creates a dependency
> > problem between the MSI layer and the irqchip layer, but that
> > should be easy (-ish) to solve.
> 
> Based on our discusstion about DTS,I will change the code likes below:
> IRQCHIP_DECLARE(hisi_mbigen, "hisilicon,mbigen-v2", mbigen_of_init);
> 
> Mbigen device is initialized as a interrupt controller.
> 
> But I still can't call platform_msi_domain_alloc_irqs()
> to apply the msi irqs.
> 
> It think this is what you said "dependency problem between
>  the MSI layer and the irqchip layer" , am i right ?
> 
> Do you have any idea about this problem?

You need to have multiple phases for initializing this beast:
- IRQCHIP_DECLARE() to create the irqchips, allocate the domains and
  the main data structures,
- platform device probing of the top-level device to do some HW probing
  and to kick of_platform_populate on the subnodes,
- Handle the the subnode probing, allocate the MSIs, and finish the
  initialization of the irqchip how that you have all the information.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
