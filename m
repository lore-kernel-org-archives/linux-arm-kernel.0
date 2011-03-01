From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 1 Mar 2011 16:10:23 +0100
Subject: [PATCH V6 02/17] ST SPEAr13xx: Added PCIe host controller base
	driver support.
In-Reply-To: <30b834e959889fb20404f45e7e66de78155874c2.1298977728.git.viresh.kumar@st.com>
References: <cover.1298977727.git.viresh.kumar@st.com>
	<30b834e959889fb20404f45e7e66de78155874c2.1298977728.git.viresh.kumar@st.com>
Message-ID: <201103011610.24283.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 01 March 2011, Viresh Kumar wrote:
> From: Pratyush Anand <pratyush.anand@st.com>

Hi Viresh and Pratyush,

The code looks really nice, I have just a few comments, mostly
about pointer type conversion.
 
> SPEAr13xx family contains Synopsys designware PCIe version 3.30a. This
> patch adds support for this PCIe module for spear platform.

If this is a standard PCIe controller, why add it to the platform
code instead of a common place like arch/arch/common or arch/arm/kernel ?

> diff --git a/arch/arm/mach-spear13xx/include/mach/hardware.h b/arch/arm/mach-spear13xx/include/mach/hardware.h
> index fd8c2dc..c3fb454 100644
> --- a/arch/arm/mach-spear13xx/include/mach/hardware.h
> +++ b/arch/arm/mach-spear13xx/include/mach/hardware.h
> @@ -28,4 +28,11 @@
>  /* typesafe io address */
>  #define __io_address(n)		__io(IO_ADDRESS(n))

I could not find the definition for __io() here, but I suspect this is
wrong. If __io_address() is what you use for accessing the direct-mapped
MMIO registers, it cannot also be what you use to access the PCIe PIO
ports, so most likely one of the two is broken. Can you explain?

> +#if defined(CONFIG_PCI)
> +#define PCIBIOS_MIN_IO		0
> +#define PCIBIOS_MIN_MEM		0
> +#define pcibios_assign_all_busses()	0
> +#endif
> +

No need for the #ifdef here, if you have no PCI, there won't be a conflict.

Better make PCIBIOS_MIN_IO 0x1000, in order to avoid stepping over
ISA port ranges.

> +static u32 spr_pcie_base[NUM_PCIE_PORTS] = {
> +	SPEAR13XX_PCIE0_BASE,
> +	SPEAR13XX_PCIE1_BASE,
> +	SPEAR13XX_PCIE2_BASE,
> +};
> +static u32 spr_pcie_app_base[NUM_PCIE_PORTS] = {
> +	SPEAR13XX_PCIE0_APP_BASE,
> +	SPEAR13XX_PCIE1_APP_BASE,
> +	SPEAR13XX_PCIE2_APP_BASE,
> +};

I think these should be __iomem pointers, not u32 tokens, since you
are listing virtual addresses. If you unroll the loop in
spear13xx_pcie_init() that uses these, you can actually get rid
of the two arrays, and simplify the code used there at the
same time.

> +#ifdef CONFIG_PCI_MSI
> +static DECLARE_BITMAP(msi_irq_in_use[NUM_PCIE_PORTS], SPEAR_NUM_MSI_IRQS);
> +static unsigned int spear_msi_data[NUM_PCIE_PORTS];
> +
> +static void spear13xx_msi_init(struct pcie_port *pp);
> +#endif
> +
> +static void spear_pcie_int_handler(unsigned int irq, struct irq_desc *desc);

It would be nice if you could avoid the forward declarations by reordering
the functions if possible.

> +static int __init spear13xx_pcie_setup(int nr, struct pci_sys_data *sys)
> +{
> +	struct pcie_port *pp;
> +	u32 val = 0;
> +
> +	if (nr >= NUM_PCIE_PORTS)
> +		return 0;
> +
> +	if ((*pcie_port_is_host)(nr) != 1)
> +		return 0;
> +
> +	pp = &pcie_port[nr];
> +	if (!spear13xx_pcie_link_up((void __iomem *)pp->va_app_base))
> +		return 0;

No need for the cast, va_app_base is already (void __iomem *).

> +static void __init add_pcie_port(int port, u32 base, u32 app_base)
> +{
> +	struct pcie_port *pp = &pcie_port[port];
> +	struct pcie_app_reg *app_reg;
> +
> +	pp->port = port;
> +	pp->root_bus_nr = -1;
> +	pp->base = (void __iomem *)base;
> +	pp->app_base = (void __iomem *)app_base;
> +	pp->va_app_base = (void __iomem *) ioremap(app_base, 0x200);
> +	if (!pp->va_app_base) {
> +		pr_err("error with ioremap in function %s\n", __func__);
> +		return;
> +	}
> +	pp->va_dbi_base = (void __iomem *) ioremap(base, 0x2000);
> +	if (!pp->va_dbi_base) {
> +		pr_err("error with ioremap in function %s\n", __func__);
> +		return;
> +	}

Please remove all these casts. Some are unneeded, some can go away
after the things I mention above.

> +	spin_lock_init(&pp->conf_lock);
> +	memset(pp->res, 0, sizeof(pp->res));
> +	pr_info("spear13xx PCIe port %d\n", port);
> +	if (spear13xx_pcie_link_up((void __iomem *)pp->va_app_base)) {
> +		pr_info("link up in bios\n");
> +	} else {
> +		pr_info("link down in bios\n");
> +		spear13xx_pcie_host_init(pp);
> +		spear13xx_int_init(pp);
> +		app_reg = (struct pcie_app_reg *)pp->va_app_base;

This cast looks invalid, you cast from __iomem to a regular pointer,

> +		pp->va_cfg0_base = (void __iomem *)
> +			ioremap(app_reg->in_cfg0_addr_start, IN_CFG0_SIZE);

which breaks here when you pass the value to ioremap without doing a readl.

> +#ifdef CONFIG_PCI_MSI
> +/* MSI int handler
> + */
> +static void handle_msi(struct pcie_port *pp)
> +{
> +	unsigned long val;
> +	int i, pos;
> +
> +	for (i = 0; i < 8; i++) {
> +		spear_dbi_read_reg(pp, PCIE_MSI_INTR0_STATUS + i * 12, 4,
> +				(u32 *)&val);
> +		if (val) {
> +			pos = 0;
> +			while ((pos = find_next_bit(&val, 32, pos)) != 32) {
> +				generic_handle_irq(SPEAR_MSI0_INT_BASE
> +					+ pp->port * SPEAR_NUM_MSI_IRQS
> +					+ (i * 32) + pos);
> +				pos++;
> +			}
> +		}
> +		spear_dbi_write_reg(pp, PCIE_MSI_INTR0_STATUS + i * 12, 4, val);
> +	}
> +}
> +#else
> +static void handle_msi(struct pcie_port *pp)
> +{
> +}
> +#endif

The MSI code is not big, but I'd still recommend moving it to a separate
file, which gets compiled only when CONFIG_PCI_MSI is set. You can have
the #ifdef and inline NOP alternative in a header for this.

	Arnd
