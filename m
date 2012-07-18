From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 18 Jul 2012 12:59:21 +0000
Subject: [PATCHv2 1/1] ARM:vt8500: Convert to use .restart and remove
 arch_reset()
In-Reply-To: <1342615030.5079.YahooMailNeo@web140804.mail.bf1.yahoo.com>
References: <1342615030.5079.YahooMailNeo@web140804.mail.bf1.yahoo.com>
Message-ID: <201207181259.21669.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 July 2012, Tony Prisk wrote:
> Changed the existing board files to use .restart in there machine
> descriptions.
> Removed system.h as it only contained an inline for arch_reset()
> 
> Added device tree support for the restart controller.
> Device tree support for vt8500 is still a work-in-progress.
> 
> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>

Looks ok from the point of view that it's technically correct.
Let me make some comments about the style though:

> +/* PM Software Reset request register */
> +#define LEGACY_PMSR_REG        0xD8130060
> +#define WMT_PRIZM_PMSR_REG    0x60
> +
> +static void __iomem *wmt_restart_reg;

I think it's better to point this to the pmc_base virtual address,
which is what we commonly do for similar scenarios. This also means
changing the phys address constant here to 0xD8130000, i.e. the
same as the one in the device tree.

> +    /*
> +     * Check if Power Mgmt Controller node is present in device tree. If no
> +     * device tree node, use the legacy PMSR value (valid for all current
> +     * SoCs).
> +     */
> +    np = of_find_compatible_node(NULL, NULL, "wmt,prizm-pmc");
> +    if (np) {
> +        pmc_base = of_iomap(np, 0);
> +
> +        if (!pmc_base)
> +            pr_err("%s:of_iomap(pmc) failed\n", __func__);
> +
> +        of_node_put(np);
> +
> +        wmt_restart_reg = (void *)((u32)(pmc_base) + WMT_PRIZM_PMSR_REG);

The type cast is ugly, wrong and uncessary ;-)

It's ugly because you are casting the same address twice, which you should
never need to do.
It's wrong because you use the wrong target type (should be void __iomem *)
and the intermediate type (u32) relies on the code being compiled for 32
bit. This is probably a safe assumption, but if you have to cast between
a pointer and an integer in the kernel, the idiom is to use 'unsigned long'
as the integer type.

It's also unnecessary because 

	wmt_restart_reg = pmc_base + WMT_PRIZM_PMSR_REG;

has the exact same effect without any of the above disadvantages.

As mentioned, I would not do the calculation here at all but instead
do it below in wmt_restart(), as 

	if (pmc_base)
		writel(1, pmc_base + WMT_PRIZM_PMSR_REG);

	Arnd
