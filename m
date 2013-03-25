From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Mon, 25 Mar 2013 11:04:48 -0600
Subject: [PATCH 6/6] ARM: dts: Add pcie controller node for Samsung
 EXYNOS5440 SoC
In-Reply-To: <00c501ce277c$30e49dc0$92add940$%han@samsung.com>
References: <00c001ce277b$92b26ab0$b8174010$%han@samsung.com>
 <00c501ce277c$30e49dc0$92add940$%han@samsung.com>
Message-ID: <20130325170448.GB16690@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 23, 2013 at 01:09:18PM +0900, Jingoo Han wrote:

> +	pcie0 at 40000000 {
> +		compatible = "samsung,exynos5440-pcie";
> +		reg = <0x40000000 0x4000
> +			0x290000 0x1000
> +			0x270000 0x1000
> +			0x271000 0x40>;
> +		interrupts = <0 20 0>, <0 21 0>, <0 22 0>;
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		device_type = "pci";
> +		bus-range = <0x0 0xf>;
> +		ranges = <0x00000800 0 0x40000000 0x40000000 0 0x00200000   /* configuration space */
> +			  0x81000000 0 0	  0x40200000 0 0x00004000   /* downstream I/O */
> +			  0x82000000 0 0	  0x40204000 0 0x10000000>; /* non-prefetchable memory */
> +	};

Can you send the lspci output so these bindings can be properly
reviewed? What PCI devices are internal to the SOC?

What is behind 'exynos_pcie_wr_own_conf' ? Is this a root port bridge
config space? What line is it in the lspci output? Can you include a
lspci -vv for it as well?

Your DT has overlapping bus-ranges, and two top level nodes. This is
going to require separate PCI domains in Linux.

However, based on your driver this HW looks similar to tegra, did you
review how tegra is setup? Merging all the ports into a single domain
is certainly preferred.

> +	pcie1 at 60000000 {
> +		compatible = "samsung,exynos5440-pcie";
> +		reg = <0x60000000 0x4000
> +			0x2a0000 0x1000
> +			0x272000 0x1000
> +			0x271040 0x40>;
> +		interrupts = <0 23 0>, <0 24 0>, <0 25 0>;
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		device_type = "pci";
> +		bus-range = <0x0 0xf>;
> +		ranges = <0x00000800 0 0x60000000 0x60000000 0 0x00200000   /* configuration space */

Do not include configuration space in ranges

> +			  0x81000000 0 0	  0x60200000 0 0x00004000   /* downstream I/O */

Please confirm that an MMIO to 0x60200000 produces a PCI-E IO TLP to
address 0

> +			  0x82000000 0 0	  0x60204000 0 0x10000000>; /* non-prefetchable memory */

Please check this, generally it should be:

			  0x82000000 0 0x60204000 0x60204000 0 0x10000000>; /* non-prefetchable memory */

Reflecting an identity mapping for MMIO - eg MMIO access to 0x60204000
producse a PCI Memory TLP to address 0x60204000 - unless your hardware
is actually doing address translation (then there are other things to
confirm..)

It is usual to have an interrupt-map - have you tested that interrupts
resolve properly?

It looks like the INTx's should be routed by an interrupt-map to the
pulse pin. Consider an interrupt controller to decode the INT ABCD.

Regards,
Jason
