From: jon-hunter@ti.com (Jon Hunter)
Date: Mon, 23 Apr 2012 11:09:22 -0500
Subject: [PATCH 01/19] ARM: OMAP4: PM: save/restore all DPLL settings
 in OFF mode
In-Reply-To: <1334914432-26456-2-git-send-email-t-kristo@ti.com>
References: <1334914432-26456-1-git-send-email-t-kristo@ti.com>
 <1334914432-26456-2-git-send-email-t-kristo@ti.com>
Message-ID: <4F957EB2.9080200@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tero,

On 04/20/2012 04:33 AM, Tero Kristo wrote:

[...]

> +/**
> + * omap4_dpll_print_reg - dump out a single DPLL register value
> + * @dpll_reg: register to dump
> + * @name: name of the register
> + * @tuple: content of the register
> + *
> + * Helper dump function to print out a DPLL register value in case
> + * of restore failures.
> + */
> +static void omap4_dpll_print_reg(struct omap4_dpll_regs *dpll_reg, char *name,
> +				 struct dpll_reg *tuple)
> +{
> +	if (tuple->offset)
> +		pr_warn("%s - Address offset = 0x%08x, value=0x%08x\n", name,
> +			tuple->offset, tuple->val);

Minor nit-pick here ...

1. Offset is 16-bits and so we can just have "offset = 0x%04x"
2. Consider dropping "Address" from "Address offset"
3. Can we be consistent in our spaces for "offset = " and "value="?

> +}
> +
> +/*
> + * omap4_dpll_dump_regs - dump out DPLL registers
> + * @dpll_reg: DPLL to dump
> + *
> + * Dump out the contents of the registers for a DPLL. Called if a
> + * restore for DPLL fails to lock.
> + */
> +static void omap4_dpll_dump_regs(struct omap4_dpll_regs *dpll_reg)
> +{
> +	pr_warn("%s: Unable to lock dpll %s[part=%x inst=%x]:\n",
> +		__func__, dpll_reg->name, dpll_reg->mod_partition,
> +		dpll_reg->mod_inst);
> +	omap4_dpll_print_reg(dpll_reg, "clksel", &dpll_reg->clksel);
> +	omap4_dpll_print_reg(dpll_reg, "div_m2", &dpll_reg->div_m2);
> +	omap4_dpll_print_reg(dpll_reg, "div_m3", &dpll_reg->div_m3);
> +	omap4_dpll_print_reg(dpll_reg, "div_m4", &dpll_reg->div_m4);
> +	omap4_dpll_print_reg(dpll_reg, "div_m5", &dpll_reg->div_m5);
> +	omap4_dpll_print_reg(dpll_reg, "div_m6", &dpll_reg->div_m6);
> +	omap4_dpll_print_reg(dpll_reg, "div_m7", &dpll_reg->div_m7);
> +	omap4_dpll_print_reg(dpll_reg, "clkdcoldo", &dpll_reg->clkdcoldo);
> +	omap4_dpll_print_reg(dpll_reg, "clkmode", &dpll_reg->clkmode);
> +	omap4_dpll_print_reg(dpll_reg, "autoidle", &dpll_reg->autoidle);
> +	if (dpll_reg->idlest.offset)
> +		pr_warn("idlest - Address offset = 0x%08x, before val=0x%08x"
> +			" after = 0x%08x\n", dpll_reg->idlest.offset,
> +			dpll_reg->idlest.val,
> +			omap4_dpll_read_reg(dpll_reg, &dpll_reg->idlest));

Nit-pick ...

1. Same comments as above
2. Consider dropping "Address offset" altogether here as we print
"idlest" the offset should be implied.
3. Also can we be consistent in our naming of "before val and "after"?
For example, "val before =" and "val now = ".

Cheers
Jon
