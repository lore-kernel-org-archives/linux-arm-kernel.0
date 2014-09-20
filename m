From: robherring2@gmail.com (Rob Herring)
Date: Sat, 20 Sep 2014 12:52:44 -0500
Subject: [PATCH v11 07/10] OF: Introduce helper function for getting PCI
 domain_nr
In-Reply-To: <1411003825-21521-8-git-send-email-Liviu.Dudau@arm.com>
References: <1411003825-21521-1-git-send-email-Liviu.Dudau@arm.com>
 <1411003825-21521-8-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <541DBEEC.6010305@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/17/2014 08:30 PM, Liviu Dudau wrote:
> Add of_pci_get_domain_nr() to retrieve the PCI domain number
> of a given device from DT. If the information is not present,
> the function can be requested to allocate a new domain number.
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Grant Likely <grant.likely@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> ---

[...]

> +/**
> + * This function will try to obtain the host bridge domain number by
> + * using of_alias_get_id() call with "pci-domain" as a stem. If that
> + * fails, a local allocator will be used. The local allocator can
> + * be requested to return a new domain_nr if the information is missing
> + * from the device tree.
> + *
> + * @node: device tree node with the domain information
> + * @allocate_if_missing: if DT lacks information about the domain nr,
> + * allocate a new number.
> + *
> + * Returns the associated domain number from DT, or a new domain number
> + * if DT information is missing and @allocate_if_missing is true. If
> + * @allocate_if_missing is false then the last allocated domain number
> + * will be returned.
> + */
> +int of_pci_get_domain_nr(struct device_node *node, bool allocate_if_missing)
> +{
> +	int domain;
> +
> +	domain = atomic_read(&of_domain_nr);
> +	if (domain == -1) {
> +		/* first run, get max defined domain nr in device tree */
> +		domain = of_get_max_pci_domain_nr();
> +		/* then set the start value for allocator to be max + 1 */
> +		atomic_set(&of_domain_nr, domain + 1);

atomic_read followed by atomic_set is not an atomic operation.

As I previously said, I don't like how this function is a mixture of
data retrieval and domian # allocation. I think we need 2 functions.

> +	}
> +	domain = of_alias_get_id(node, "pci-domain");

I still do not like using aliases here. Just put pci-domain or
linux,pci-domain into the PCI node.

I think we should assume all PCI root buses either have a domain
property or they don't and a mixture is an error. I'm not sure if that
simplifies the code or not though.

In the interest of merging, I think you should just do a simple
allocation and add the DT domain handling as a second step. You will
also need to document the DT part.

Rob
