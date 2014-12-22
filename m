From: panand@redhat.com (Pratyush Anand)
Date: Mon, 22 Dec 2014 10:42:29 +0530
Subject: [PATCH 3/5] PCI: st: Provide support for the sti PCIe controller
In-Reply-To: <1418812486-12394-4-git-send-email-gabriel.fernandez@linaro.org>
References: <1418812486-12394-1-git-send-email-gabriel.fernandez@linaro.org>
 <1418812486-12394-4-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <5497A83D.5060108@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Wednesday 17 December 2014 04:04 PM, Gabriel FERNANDEZ wrote:
> sti pcie is built around a Synopsis Designware PCIe IP.
>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
> ---
>   drivers/pci/host/Kconfig  |   5 +
>   drivers/pci/host/Makefile |   1 +
>   drivers/pci/host/pci-st.c | 713 ++++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 719 insertions(+)
>   create mode 100644 drivers/pci/host/pci-st.c
>

[...]

> +static int st_pcie_abort_handler(unsigned long addr, unsigned int fsr,
> +				 struct pt_regs *regs)
> +{
> +	return 0;
> +}
> +

You should have modification here to populate registers having cfg read 
values by 0xFFFFFFFF.

I would suggest to have a look here:
drivers/pci/host/pci-keystone.c:keystone_pcie_fault

> +/*
> + * The PCI express core IP expects the following arrangement on it's address
> + * bus (slv_haddr) when driving config cycles.
> + * bus_number		[31:24]
> + * dev_number		[23:19]
> + * func_number		[18:16]
> + * unused		[15:12]
> + * ext_reg_number	[11:8]
> + * reg_number		[7:2]
> + *
> + * Bits [15:12] are unused.
> + *
> + * In the glue logic there is a 64K region of address space that can be
> + * written/read to generate config cycles. The base address of this is
> + * controlled by CFG_BASE_ADDRESS. There are 8 16 bit registers called
> + * FUNC0_BDF_NUM to FUNC8_BDF_NUM. These split the bottom half of the 64K
> + * window into 8 regions at 4K boundaries. These control the bus,device and
> + * function number you are trying to talk to.
> + *
> + * The decision on whether to generate a type 0 or type 1 access is controlled
> + * by bits 15:12 of the address you write to.  If they are zero, then a type 0
> + * is generated, if anything else it will be a type 1. Thus the bottom 4K
> + * region controlled by FUNC0_BDF_NUM can only generate type 0, all the others
> + * can only generate type 1.
> + *
> + * We only use FUNC0_BDF_NUM and FUNC1_BDF_NUM. Which one you use is selected
> + * by bit 12 of the address you write to. The selected register is then used
> + * for the top 16 bits of the slv_haddr to form the bus/dev/func, bit 15:12 are
> + * wired to zero, and bits 11:2 form the address of the register you want to
> + * read in config space.
> + *
> + * We always write FUNC0_BDF_NUM as a 32 bit write. So if we want type 1
> + * accesses we have to shift by 16 so in effect we are writing to FUNC1_BDF_NUM
> + */
> +static inline u32 bdf_num(int bus, int devfn, int is_root_bus)
> +{
> +	return ((bus << 8) | devfn) << (is_root_bus ? 0 : 16);
> +}
> +
> +static inline unsigned config_addr(int where, int is_root_bus)
> +{
> +	return (where & ~3) | (!is_root_bus << 12);
> +}
> +
> +static int st_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
> +				 unsigned int devfn, int where, int size,
> +				 u32 *val)
> +{
> +	u32 data;
> +	u32 bdf;
> +	struct st_pcie *pcie = to_st_pcie(pp);
> +	int is_root_bus = pci_is_root_bus(bus);
> +	int retry_count = 0;
> +	int ret;
> +	void __iomem *addr;
> +
> +	/*
> +	 * Prerequisite
> +	 * PCI express devices will respond to all config type 0 cycles, since
> +	 * they are point to point links. Thus to avoid probing for multiple
> +	 * devices on the root, dw-pcie already check for us if it is on the
> +	 * root bus / other slots. Also, dw-pcie checks for the link being up
> +	 * as we will hang if we issue a config request and the link is down.
> +	 * A switch will reject requests for slots it knows do not exist.
> +	 */
> +	bdf = bdf_num(bus->number, devfn, is_root_bus);
> +	addr = pcie->config_area + config_addr(where,
> +			bus->parent->number == pp->root_bus_nr);
> +retry:
> +	/* Set the config packet devfn */
> +	writel_relaxed(bdf, pp->dbi_base + FUNC0_BDF_NUM);
> +	readl_relaxed(pp->dbi_base + FUNC0_BDF_NUM);
> +
> +	ret = dw_pcie_cfg_read(addr, where, size, &data);
> +
> +	/*
> +	 * This is intended to help with when we are probing the bus. The
> +	 * problem is that the wrapper logic doesn't have any way to
> +	 * interrogate if the configuration request failed or not.
> +	 * On the ARM we actually get a real bus error.
> +	 *
> +	 * Unfortunately this means it is impossible to tell the difference
> +	 * between when a device doesn't exist (the switch will return a UR
> +	 * completion) or the device does exist but isn't yet ready to accept
> +	 * configuration requests (the device will return a CRS completion)
> +	 *
> +	 * The result of this is that we will miss devices when probing.
> +	 *
> +	 * So if we are trying to read the dev/vendor id on devfn 0 and we
> +	 * appear to get zero back, then we retry the request.  We know that
> +	 * zero can never be a valid device/vendor id. The specification says
> +	 * we must retry for up to a second before we decide the device is

Not sure if retry has to be part of software. This might already be done 
by hardware.

> +	 * dead. If we are still dead then we assume there is nothing there and
> +	 * return ~0
> +	 *
> +	 * The downside of this is that we incur a delay of 1s for every pci
> +	 * express link that doesn't have a device connected.
> +	 */
> +	if (((where & ~3) == 0) && devfn == 0 && (data == 0 || data == ~0)) {
> +		if (retry_count++ < 1000) {
> +			mdelay(1);
> +			goto retry;
> +		} else {
> +			*val = ~0;
> +			return PCIBIOS_DEVICE_NOT_FOUND;
> +		}
> +	}

Have you found a situation with any of the card when your retry_count > 
0 and  < 1000@this point. If not then, I think modifying abort 
handler will solve your issue.

> +
> +	*val = data;
> +	return ret;
> +}
> +

~Pratyush
