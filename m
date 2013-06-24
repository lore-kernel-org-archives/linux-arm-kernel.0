From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 24 Jun 2013 20:57:25 +0100
Subject: [PATCH v3 1/3] clk: Add APM X-Gene SoC clock driver for
 reference, PLL, and device clocks.
In-Reply-To: <1372100487-9367-2-git-send-email-lho@apm.com>
References: <1372100487-9367-1-git-send-email-lho@apm.com>
 <1372100487-9367-2-git-send-email-lho@apm.com>
Message-ID: <20130624195725.GA11289@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 24, 2013 at 08:01:25PM +0100, Loc Ho wrote:
> clk: Add APM X-Gene SoC clock driver for reference, PLL, and device clocks.
> 
> Signed-off-by: Loc Ho <lho@apm.com>
> Signed-off-by: Kumar Sankaran <ksankaran@apm.com>
> Signed-off-by: Vinayak Kale <vkale@apm.com>
> Signed-off-by: Feng Kan <fkan@apm.com>
> ---
>  drivers/clk/Kconfig     |    7 +
>  drivers/clk/Makefile    |    1 +
>  drivers/clk/clk-xgene.c |  538 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 546 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/clk/clk-xgene.c
 

[...]

> +static void __init xgene_devclk_init(struct device_node *np)
> +{
> +       const char *clk_name = np->full_name;
> +       struct clk *clk;
> +       struct resource res;
> +       int rc;
> +       struct xgene_dev_parameters parameters;
> +
> +       rc = of_address_to_resource(np, 0, &res);
> +       if (rc != 0) {
> +               pr_err("no DTS CSR register for %s\n", np->full_name);
> +               return;
> +       }
> +       if (resource_size(&res)) {
> +               parameters.csr_reg = of_iomap(np, 0);
> +               if (parameters.csr_reg == NULL) {
> +                       pr_err("Unable to map CSR register for %s\n",
> +                               np->full_name);
> +                       return;
> +               }

In my earlier post, I'd failed to understand what you were doing here --
testing that a reg represents a window of non-zero size.  I don't think
you need to describe the registers that aren't present at all, and I
believe you can use the more standard reg-names property to describe
this case. e.g. When you only have the "div" register bank, and not the
"csr" bank, you could describe this as:

some-clock {
	compatible = "apm,xgene-device-clock";
	reg = <0 0x12340000 0 0x1000>;
	reg-names = "div-reg";

	...
}

... and when you had both, you could describe this as:

some-clock {
	compatible = "apm,xgene-device-clock";
	reg = <0 0x12340000 0 0x1000>,
	      <0 0x23450000 0 0x1000>;
	reg-names = "div", "csr";

	...
}

This way, you don't describe registers that aren't actually present,
and it's clearer which register's which.

It looks like of_address_to_resource reads the reg-names property, so
you could test against the resource's name to figure out which reg you
have (if you only have one). My earlier comment to use of_iomap was
misplaced, as there doesn't seem to be anything like of_iomap_by_name,
and you have to use the resource anyway to get the name.

> +       } else {
> +               parameters.csr_reg = NULL;
> +       }
> +
> +       rc = of_address_to_resource(np, 1, &res);
> +       if (rc != 0) {
> +               pr_err("no DTS DIV register for %s\n", np->full_name);
> +               return;
> +       }
> +       if (resource_size(&res)) {
> +               parameters.divider_reg = of_iomap(np, 1);
> +               if (parameters.divider_reg == NULL) {
> +                       pr_err("Unable to map DIV register for %s\n",
> +                               np->full_name);
> +                       if (parameters.csr_reg)
> +                               iounmap(parameters.csr_reg);
> +                       return;
> +               }
> +       } else {
> +               parameters.divider_reg = NULL;
> +       }
> +       if (of_property_read_u32(np, "flags", &parameters.flags))
> +               parameters.flags = 0;

As mentioned previously, I believe you could use the standard status
property instead of flags.

Thanks,
Mark.
