From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 21 Aug 2017 09:30:24 +0100
Subject: [PATCH v3 6/8] irqchip/gic-v3-its: Initialize its nodes later
In-Reply-To: <20170808122259.6299-7-rrichter@cavium.com>
References: <20170808122259.6299-1-rrichter@cavium.com>
 <20170808122259.6299-7-rrichter@cavium.com>
Message-ID: <02849da3-f4a9-562d-ee2c-e08a563c3908@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+Lorenzo

On 08/08/17 13:22, Robert Richter wrote:
> Use an initcall to initialize its. This allows us to use the device
> framework during initialization that is up at this point. We use
> subsys_initcall() here since we need the arch to be initialized
> first. It is before pci and platform device probe where devices are
> bound to msi interrupts.
> 
> Signed-off-by: Robert Richter <rrichter@cavium.com>
> ---
>  drivers/irqchip/irq-gic-v3-its.c   | 3 ++-
>  drivers/irqchip/irq-gic-v3.c       | 5 -----
>  include/linux/irqchip/arm-gic-v3.h | 1 -
>  3 files changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 5e2d4f2876d8..488f811d5978 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -1994,7 +1994,7 @@ int __init its_probe(struct fwnode_handle *handle, struct rdists *rdists,
>  	return 0;
>  }
>  
> -int __init its_init(void)
> +static int __init its_init(void)
>  {
>  	struct its_node *its, *tmp;
>  	int err = 0, err2;
> @@ -2036,3 +2036,4 @@ int __init its_init(void)
>  
>  	return 0;
>  }
> +subsys_initcall(its_init);

*ding*!

I'm sorry, but that's a total NAK. We're trading hard to maintain
hardcoded dependencies for even more difficult to deal with, link-order
driven dependencies.  That's exactly what Lorenzo and I have been
fighting against in the XGene ACPI case, and I'm not going to introduce
more of this.

We need to break the dependency between the HW and the associated MSI
domains, not making it tighter. Let the HW be probed at some time, and
the MSI domains lazily created as needed once the end-points are probed.

I'm also pretty worried that (as mentioned in my reply to patch #2) that
this "make it happen later" games with the initcalls are breaking stuff
(see how platform devices are instantiated on the back of an
arch_initcall_sync). As far as I can tell, non-PCI MSI is dead after
patch #2.

I think there is a number of things to fix in the core code before we
can start playing that kind of tricks. The major issue I see is that MSI
domains are expected to be available way too early, at device discovery
time rather than at driver probe time. This has a cascading effect which
we should solve first.

I'll try to prototype something...

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
