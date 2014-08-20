From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 20 Aug 2014 16:29:44 +0100
Subject: [PATCH 06/19] ARM64 / ACPI: Parse FADT table to get PSCI flags
 for PSCI init
In-Reply-To: <20140820150029.0BB3FC41205@trevor.secretlab.ca>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org>
 <1406206825-15590-7-git-send-email-hanjun.guo@linaro.org>
 <20140820150029.0BB3FC41205@trevor.secretlab.ca>
Message-ID: <20140820152944.GR24600@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 20, 2014 at 04:00:28PM +0100, Grant Likely wrote:
> On Thu, 24 Jul 2014 21:00:12 +0800, Hanjun Guo <hanjun.guo@linaro.org> wrote:
> > @@ -345,13 +378,19 @@ int __init psci_init(void)
> >  	const struct of_device_id *matched_np;
> >  	psci_initcall_t init_fn;
> >  
> > -	np = of_find_matching_node_and_match(NULL, psci_of_match, &matched_np);
> > +	if (acpi_disabled) {
> > +		np = of_find_matching_node_and_match(NULL,
> > +				psci_of_match, &matched_np);
> >  
> > -	if (!np)
> > -		return -ENODEV;
> > +		if (!np)
> > +			return -ENODEV;
> > +
> > +		init_fn = (psci_initcall_t)matched_np->data;
> > +
> > +		return init_fn(np);
> > +	}
> >  
> > -	init_fn = (psci_initcall_t)matched_np->data;
> > -	return init_fn(np);
> > +	return psci_0_2_init_acpi();
> >  }
> 
> So, while the functionality is sound, this is kind of a stinky diff. The
> ACPI path should not push the OF code into a sub branch. Make it look
> like this instead (with the advantage that the diff will be simpler):
> 
> +	if (IS_ENABLED(CONFIG_ACPI) && !acpi_disabled)
> +		return psci_0_2_init_acpi();

Minor point: we should define acpi_disabled to 1 when !CONFIG_ACPI and
avoid additional IS_ENABLED(CONFIG_ACPI) checks (unless already don this
way).

-- 
Catalin
