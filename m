From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 11 May 2015 17:29:45 +0100
Subject: [PATCH 2/2] ARM64: kernel: unify ACPI and DT cpus initialization
In-Reply-To: <1431020084-5875-2-git-send-email-lorenzo.pieralisi@arm.com>
References: <1431020084-5875-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1431020084-5875-2-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <20150511162945.GD4595@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo,

> +               enable_method = acpi_get_enable_method(cpu);
> +               if (!enable_method)
> +                       pr_err("Undefined ACPI enable-method\n");

I was going to complain that "enable-method" is a DT term that doesn't
strictly apply to ACPI, but ACPI doesn't seem to have its own
terminology for this, so I guess this is ok.

However, I'd recommend replacing "Undefined" with "Unknown/Unsupported"
in the log message.

[...]

> +static u64 __init of_get_cpu_mpidr(struct device_node *dn)
> +{
> +       const u32 *cell;
> +       u64 hwid;
> +
> +       /*
> +        * A cpu node with missing "reg" property is
> +        * considered invalid to build a cpu_logical_map
> +        * entry.
> +        */
> +       cell = of_get_property(dn, "reg", NULL);
> +       if (!cell) {
> +               pr_err("%s: missing reg property\n", dn->full_name);
> +               return INVALID_HWID;
> +       }
> +
> +       hwid = of_read_number(cell, of_n_addr_cells(dn));

Existing bug, but cell should be a __be32 pointer rather than a u32
pointer (as that's what of_read_number expects).

Other than that, this looks fine to me:

Acked-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com> [DT]

Thanks,
Mark.
