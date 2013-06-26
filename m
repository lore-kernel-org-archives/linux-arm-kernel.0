From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 26 Jun 2013 11:37:24 +0100
Subject: [PATCH v4 1/3] clk: Add APM X-Gene SoC clock driver
In-Reply-To: <1372113263-18082-2-git-send-email-lho@apm.com>
References: <1372113263-18082-1-git-send-email-lho@apm.com>
 <1372113263-18082-2-git-send-email-lho@apm.com>
Message-ID: <20130626103724.GC10833@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jun 24, 2013 at 11:34:21PM +0100, Loc Ho wrote:
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

> +static void xgene_socpllclk_init(struct device_node *np)
> +{
> +        const char *clk_name = np->full_name;
> +        struct clk *clk;
> +        void *reg;
> +
> +        reg = of_iomap(np, 0);
> +        if (reg == NULL) {
> +                pr_err("Unable to map CSR register for %s\n", np->full_name);
> +                return;
> +        }
> +        of_property_read_string(np, "clock-output-names", &clk_name);
> +        clk = xgene_register_clk_pll(NULL,
> +                        clk_name, of_clk_get_parent_name(np, 0),
> +                        CLK_IS_ROOT, reg, 0, PLL_TYPE_SOC, &clk_lock);
> +        if (!IS_ERR(clk)) {
> +                of_clk_add_provider(np, of_clk_src_simple_get, clk);
> +                clk_register_clkdev(clk, clk_name, NULL);
> +                pr_debug("Add %s clock PLL\n", clk_name);
> +        }
> +}
> +
> +static void xgene_pcppllclk_init(struct device_node *np)
> +{
> +       const char *clk_name = np->full_name;
> +       struct clk *clk;
> +       void *reg;
> +
> +       reg = of_iomap(np, 0);
> +       if (reg == NULL) {
> +               pr_err("Unable to map CSR register for %s\n", np->full_name);
> +               return;
> +       }
> +       of_property_read_string(np, "clock-output-names", &clk_name);
> +       clk = xgene_register_clk_pll(NULL,
> +                       clk_name, of_clk_get_parent_name(np, 0),
> +                       CLK_IS_ROOT, reg, 0, PLL_TYPE_PCP, &clk_lock);
> +       if (!IS_ERR(clk)) {
> +               of_clk_add_provider(np, of_clk_src_simple_get, clk);
> +               clk_register_clkdev(clk, clk_name, NULL);
> +               pr_debug("Add %s clock PLL\n", clk_name);
> +       }
> +}

Unless I've missed something, these two functions look identical other
than the PLL_TYPE_{PCP,SOC} passed to xgene_register_clkdev. You could
unify most of the logic by having a helper (xgene_pllck_init?) that took
the xgene_pll_type, and then xgene_{soc,pll}clk_init would look
something like:

static void xgene_socpllclk_init(struct device_node *np)
{
	xgene_pllclk_init(np, PLL_TYPE_SOC);
}

> +
> +/* IP Clock */
> +struct xgene_dev_parameters {
> +       u32  flags;                     /* Any flags to the clock framework */

As this is always zero now, it could be removed.

> +       void __iomem *csr_reg;          /* CSR for IP clock */
> +       u32 reg_clk_offset;             /* Offset to clock enable CSR */
> +       u32 reg_clk_mask;               /* Mask bit for clock enable */
> +       u32 reg_csr_offset;             /* Offset to CSR reset */
> +       u32 reg_csr_mask;               /* Mask bit for disable CSR reset */
> +       void __iomem *divider_reg;      /* CSR for divider */
> +       u32 reg_divider_offset;         /* Offset to divider register */
> +       u32 reg_divider_shift;          /* Bit shift to divider field */
> +       u32 reg_divider_width;          /* Width of the bit to divider field */
> +};

[...]

> +static void __init xgene_devclk_init(struct device_node *np)
> +{
> +       const char *clk_name = np->full_name;
> +       struct clk *clk;
> +       struct resource res;
> +       int rc;
> +       struct xgene_dev_parameters parameters;
> +       int i;
> +
> +       /* Check if the entry is disabled */
> +        if (!of_device_is_available(np))
> +                return;
> +
> +       /* Parse the DTS register for resource */
> +       parameters.csr_reg = NULL;
> +       parameters.divider_reg = NULL;
> +       for (i = 0; i < 2; i++) {
> +               void *map_res;
> +               rc = of_address_to_resource(np, i, &res);
> +               if (rc != 0) {
> +                       if (i == 0) {
> +                               pr_err("no DTS register for %s\n",
> +                                       np->full_name);
> +                               return;
> +                       }
> +                       break;
> +               }
> +               map_res = of_iomap(np, i);
> +               if (map_res == NULL) {
> +                       pr_err("Unable to map resource %d for %s\n",
> +                               i, np->full_name);
> +                       if (parameters.csr_reg)
> +                               iounmap(parameters.csr_reg);
> +                       if (parameters.divider_reg)
> +                               iounmap(parameters.divider_reg);

You could move this freeing of the register iomaps to the end of the
function with some label (err_unmap?) and use a goto. You could then
use a goto in the IS_ERR(clk) case below, and unify the unmapping.

> +                       return;
> +               }
> +               if (strcmp(res.name, "div-reg") == 0)
> +                       parameters.divider_reg = map_res;
> +               else /* if (strcmp(res->name, "csr-reg") == 0) */
> +                       parameters.csr_reg = map_res;
> +       }
> +       parameters.flags = 0;
> +       if (of_property_read_u32(np, "csr-offset", &parameters.reg_csr_offset))
> +               parameters.reg_csr_offset = 0;
> +       if (of_property_read_u32(np, "csr-mask", &parameters.reg_csr_mask))
> +               parameters.reg_csr_mask = 0xF;
> +       if (of_property_read_u32(np, "enable-offset",
> +                               &parameters.reg_clk_offset))
> +               parameters.reg_clk_offset = 0x8;
> +       if (of_property_read_u32(np, "enable-mask", &parameters.reg_clk_mask))
> +               parameters.reg_clk_mask = 0xF;
> +       if (of_property_read_u32(np, "divider-offset",
> +                               &parameters.reg_divider_offset))
> +               parameters.reg_divider_offset = 0;
> +       if (of_property_read_u32(np, "divider-width",
> +                               &parameters.reg_divider_width))
> +               parameters.reg_divider_width = 0;
> +       if (of_property_read_u32(np, "divider-shift",
> +                               &parameters.reg_divider_shift))
> +               parameters.reg_divider_shift = 0;
> +       of_property_read_string(np, "clock-output-names", &clk_name);
> +
> +       clk = xgene_register_clk(NULL, clk_name,
> +               of_clk_get_parent_name(np, 0), &parameters, &clk_lock);
> +       if (IS_ERR(clk)) {
> +               if (parameters.csr_reg)
> +                       iounmap(parameters.csr_reg);
> +               if (parameters.divider_reg)
> +                       iounmap(parameters.divider_reg);
> +               return;
> +       }
> +       pr_debug("Add %s clock\n", clk_name);
> +       rc = of_clk_add_provider(np, of_clk_src_simple_get, clk);
> +       if (rc != 0) {
> +               pr_err("%s: could register provider clk %s\n", __func__,
> +                       np->full_name);
> +               return;
> +       }
> +}

The return is currently unnecessary as there's nothing beyond it in the
function. You could remove it, and since that leaves one statement in
the braces, you could remove the braces too.

Thanks,
Mark.
