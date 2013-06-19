From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 19 Jun 2013 16:14:39 -0400
Subject: [PATCH v4 03/12] bus: mvebu-mbus: Add static window allocation
 to the DT binding
In-Reply-To: <1371672446-21583-4-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1371672446-21583-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1371672446-21583-4-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130619201439.GI31667@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 19, 2013 at 05:07:17PM -0300, Ezequiel Garcia wrote:
> This patch adds static window allocation to the device tree binding.
> Each first-child of the mbus-compatible node, with a suitable 'ranges'
> property, declaring an address translation, will trigger an address
> decoding window allocation.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  .../devicetree/bindings/bus/mvebu-mbus.txt         | 203 +++++++++++++++++++++
>  drivers/bus/mvebu-mbus.c                           | 121 +++++++++++-
>  2 files changed, 323 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/bus/mvebu-mbus.txt
> 
> diff --git a/Documentation/devicetree/bindings/bus/mvebu-mbus.txt b/Documentation/devicetree/bindings/bus/mvebu-mbus.txt
> new file mode 100644
> index 0000000..3d31fcf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/bus/mvebu-mbus.txt
> @@ -0,0 +1,203 @@
> +
> +* Marvell MBus controller
> +
> +Required properties:
> +
> +- compatible:	 Should be set to one of the following:
> +		 marvell,armada370-mbus
> +		 marvell,armadaxp-mbus
> +
> +- reg:		 Device's register space.
> +		 Two entries are expected, see the examples below.
> +		 The first one controls the devices decoding window and
> +		 the second one controls the SDRAM decoding window.
> +
> +- address-cells: Must be '2'. The first cell for the MBus ID encoding,
> +                 the second cell for the address offset within the window.
> +
> +- size-cells:    Must be '1'.
> +
> +- ranges:        Must be set up to provide a proper translation for each child.
> +	         See the examples below.
> +
> +Example:
> +
> +	soc {
> +		compatible = "marvell,armada370-mbus", "simple-bus";
> +		reg = <0xd0020000 0x100>, <0xd0020180 0x20>;
> +		#address-cells = <2>;
> +		#size-cells = <1>;
> +	};
> +
> +** MBus address decoding window specification
> +
> +The MBus children address space is comprised of two cells: the first one for
> +the window ID and the second one for the offset within the window.
> +In order to allow to describe valid and non-valid window entries, the
> +following encoding is used:
> +
> +  0xSIAA0000 0x00oooooo
> + 
> +Where:
> +
> +  S = 0x0 for a MBus valid window
> +  S = 0xf for a non-valid window (see below)
> +
> +If S = 0x0, then:
> +
> +   I = 4-bit window target ID
> +  AA = windpw attribute 
> +
> +If S = 0xf, then:
> +
> +   I = don't care
> +   AA = 1 for internal register
> +   AA = 2 for PCI-E
> +
> +Following the above encoding, for each ranges entry for a MBus valid window
> +(S = 0x0), an address decoding window is allocated. On the other side,
> +entries for translation that do not correspond to valid windows (S = 0xf)
> +are skipped.
> +
> +	soc {
> +		compatible = "marvell,armada370-mbus", "simple-bus";
> +		reg = <0xd0020000 0x100>, <0xd0020180 0x20>;
> +		#address-cells = <2>;
> +		#size-cells = <1>;
> +
> +		ranges = <0xf0010000 0 0 0xd0000000 0x100000
> +			  0x011d0000 0 0 0xfff00000 0x100000>;
> +
> +		bootrom {
> +			compatible = "marvell,bootrom";
> +			reg = <0 0x100000>;
> +		};
> +
> +		/* other children */
> +		...
> +	};
> +
> +In the shown example, the translation entry in the 'ranges' property is what
> +makes the MBus driver create a static decoding window for the corresponding 
> +given child device. Note that the binding does not require child nodes to be
> +present. Of course, child nodes are needed to probe the devices.
> +
> +Since each window is identified by its target ID and attribute ID there's
> +a special macro that can be use to simplify the translation entries:
> +
> +#define MBUS_ID(target,attributes) (((target) << 24) | ((attributes) << 16))
> +
> +Using this macro, the above example would be:
> +
> +	soc {
> +		compatible = "marvell,armada370-mbus", "simple-bus";
> +		reg = <0xd0020000 0x100>, <0xd0020180 0x20>;
> +		#address-cells = <2>;
> +		#size-cells = <1>;
> +
> +		ranges = < MBUS_ID(0xf0, 0x01) 0 0 0xd0000000 0x100000
> +			   MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000>;
> +
> +		bootrom {
> +			compatible = "marvell,bootrom";
> +			reg = <MBUS_ID(0x01, 0x1d) 0 0x100000>;
> +		};
> +
> +		/* other children */
> +		...
> +	};
> +
> +
> +** About the window base address
> +
> +Remember the MBus controller allows a great deal of flexibility for choosing
> +the decoding window base address. When planning the device tree layout it's
> +possible to choose any address as the base address, provided of course there's
> +a region large enough available, and with the required alignment.
> +
> +Yet in other words: there's nothing preventing us from setting a base address
> +of 0xf0000000, or 0xd0000000 for the NOR device shown above, if such region is
> +unused.
> +
> +** Window allocation policy
> +
> +The mbus-node ranges property defines a set of mbus windows that are expected
> +to be set by the operating system and that are guaranteed to be free of overlaps
> +with one another or with the system memory ranges.
> +
> +Each entry in the property refers to exactly one window. If the operating system
> +choses to use a different set of mbus windows, it must ensure that any address
> +translations performed from downstream devices are adapted accordingly.
> +
> +The operating system may insert additional mbus windows that do not conflict
> +with the ones listed in the ranges, e.g. for mapping PCIe devices.
> +As a special case, the internal register window must be set up by the boot
> +loader at the address listed in the ranges property, since acess to that region

nit.  s/acess/access/, but only if you need to do another version for
other reasons.

thx,

Jason.

> +is needed to set up the other windows.
> +
> +** Example
> +
> +See the example below, where a more complete device tree is shown:
> +
> +	soc {
> +		compatible = "marvell,armadaxp-mbus";
> +		reg = <0 0xd0020000 0 0x100>, <0 0xd0020180 0 0x20>;
> +
> +		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xd0000000 0x100000   /* internal-regs */
> +			  MBUS_ID(0xf0, 0x02) 0xe0000000 0 0xe0000000 0x8100000  /* pcie */
> +			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
> +			  MBUS_ID(0x01, 0x2f) 0 0 0xf0000000 0x8000000>;
> +
> +		bootrom {
> +			compatible = "marvell,bootrom";
> +			reg = <MBUS_ID(0x01, 0x1d) 0 0x100000>;
> +		};
> +
> +		devbus-bootcs {
> +			status = "okay";
> +			ranges = <0 MBUS_ID(0x01, 0x2f) 0 0x8000000>;
> +
> +			/* NOR */
> +			nor {
> +				compatible = "cfi-flash";
> +				reg = <0 0x8000000>;
> +				bank-width = <2>;
> +			};
> +		};
> +
> +		pcie-controller {
> +			compatible = "marvell,armada-xp-pcie";
> +			status = "okay";
> +			device_type = "pci";
> +
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +
> +			ranges =
> +			       <0x82000000 0 0x40000 MBUS_ID(0xf0, 0x01) 0x40000 0 0x00002000   /* Port 0.0 registers */
> +				0x82000000 0 0x42000 MBUS_ID(0xf0, 0x01) 0x42000 0 0x00002000   /* Port 2.0 registers */
> +				0x82000000 0 0x44000 MBUS_ID(0xf0, 0x01) 0x44000 0 0x00002000   /* Port 0.1 registers */
> +				0x82000000 0 0x48000 MBUS_ID(0xf0, 0x01) 0x48000 0 0x00002000   /* Port 0.2 registers */
> +				0x82000000 0 0x4c000 MBUS_ID(0xf0, 0x01) 0x4c000 0 0x00002000   /* Port 0.3 registers */
> +				0x82000000 0 0x80000 MBUS_ID(0xf0, 0x01) 0x80000 0 0x00002000   /* Port 1.0 registers */
> +				0x82000000 0 0x82000 MBUS_ID(0xf0, 0x01) 0x82000 0 0x00002000   /* Port 3.0 registers */
> +				0x82000000 0 0xe0000000 MBUS_ID(0xf0, 0x02) 0xe0000000 0 0x08000000   /* non-prefetchable memory */
> +				0x81000000 0 0 MBUS_ID(0xf0, 0x02) 0xe8000000 0 0x00100000>; /* downstream I/O */
> +
> +			pcie at 1,0 {
> +				/* Port 0, Lane 0 */
> +				status = "okay";
> +			};
> +		};
> +
> +		internal-regs {
> +			compatible = "simple-bus";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0 MBUS_ID(0xf0, 0x01) 0 0x100000>;
> +
> +			interrupt-controller at 20000 {
> +			      reg = <0x20a00 0x2d0>, <0x21070 0x58>;
> +			};
> +		};
> +	};
> diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
> index 23f6ae6..c8eb6c6 100644
> --- a/drivers/bus/mvebu-mbus.c
> +++ b/drivers/bus/mvebu-mbus.c
> @@ -885,6 +885,121 @@ int __init mvebu_mbus_init(const char *soc, phys_addr_t mbuswins_phys_base,
>  }
>  
>  #ifdef CONFIG_OF
> +/*
> + * The window IDs in the ranges DT property have the following format:
> + *  - bits 28 to 31: MBus custom field
> + *  - bits 24 to 27: window target ID
> + *  - bits 16 to 23: window attribute ID
> + *  - bits  0 to 15: unused
> + */
> +#define CUSTOM(id) (((id) & 0xF0000000) >> 24)
> +#define TARGET(id) (((id) & 0x0F000000) >> 24)
> +#define ATTR(id)   (((id) & 0x00FF0000) >> 16)
> +
> +static int __init mbus_dt_setup_win(struct mvebu_mbus_state *mbus,
> +				    u32 base, u32 size,
> +				    u8 target, u8 attr)
> +{
> +	const struct mvebu_mbus_mapping *map = mbus->soc->map;
> +	const char *name;
> +	int i;
> +
> +	/* Search for a suitable window in the existing mappings */
> +	for (i = 0; map[i].name; i++)
> +		if (map[i].target == target &&
> +		    map[i].attr == (attr & map[i].attrmask))
> +			break;
> +
> +	name = map[i].name;
> +	if (!name) {
> +		pr_err("window 0x%x:0x%x is unknown, skipping\n",
> +		       target, attr);
> +		return -EINVAL;
> +	}
> +
> +	if (!mvebu_mbus_window_conflicts(mbus, base, size, target, attr)) {
> +		pr_err("cannot add window '%s', conflicts with another window\n",
> +		       name);
> +		return -EBUSY;
> +	}
> +
> +	if (mvebu_mbus_alloc_window(mbus, base, size, MVEBU_MBUS_NO_REMAP,
> +				    target, attr)) {
> +		pr_err("cannot add window '%s', too many windows\n",
> +		       name);
> +		return -ENOMEM;
> +	}
> +	return 0;
> +}
> +
> +static int __init
> +mbus_parse_ranges(struct device_node *node,
> +		  int *addr_cells, int *c_addr_cells, int *c_size_cells,
> +		  int *cell_count, const __be32 **ranges_start,
> +		  const __be32 **ranges_end)
> +{
> +	const __be32 *prop;
> +	int ranges_len, tuple_len;
> +
> +	*addr_cells = of_n_addr_cells(node);
> +
> +	prop = of_get_property(node, "#address-cells", NULL);
> +	*c_addr_cells = be32_to_cpup(prop);
> +
> +	prop = of_get_property(node, "#size-cells", NULL);
> +	*c_size_cells = be32_to_cpup(prop);
> +
> +	*cell_count = *addr_cells + *c_addr_cells + *c_size_cells;
> +	tuple_len = (*cell_count) * sizeof(__be32);
> +
> +	*ranges_start = of_get_property(node, "ranges", &ranges_len);
> +	*ranges_end = *ranges_start + ranges_len / sizeof(__be32);
> +
> +	if (*ranges_start == NULL || ranges_len % tuple_len) {
> +		pr_warn("malformed ranges entry '%s'\n", node->name);
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +static int __init mbus_dt_setup(struct mvebu_mbus_state *mbus,
> +				struct device_node *np)
> +{
> +	int addr_cells, c_addr_cells, c_size_cells;
> +	int i, ret, cell_count;
> +	const __be32 *r, *ranges_start, *ranges_end;
> +
> +	ret = mbus_parse_ranges(np, &addr_cells, &c_addr_cells,
> +				&c_size_cells, &cell_count,
> +				&ranges_start, &ranges_end);
> +	if (ret < 0)
> +		return ret;
> +
> +	for (i = 0, r = ranges_start; r < ranges_end; r += cell_count, i++) {
> +		u32 windowid, base, size;
> +		u8 target, attr;
> +
> +		/*
> +		 * An entry with a non-zero custom field do not
> +		 * correspond to a static window, so skip it.
> +		 */
> +		windowid = of_read_number(r, 1);
> +		if (CUSTOM(windowid))
> +			continue;
> +
> +		target = TARGET(windowid);
> +		attr = ATTR(windowid);
> +
> +		base = of_read_number(r + c_addr_cells, addr_cells);
> +		size = of_read_number(r + c_addr_cells + addr_cells,
> +				      c_size_cells);
> +		ret = mbus_dt_setup_win(mbus, base, size, target, attr);
> +		if (ret < 0)
> +			return ret;
> +	}
> +	return 0;
> +}
> +
>  int __init mvebu_mbus_dt_init(void)
>  {
>  	struct resource mbuswins_res, sdramwins_res;
> @@ -916,6 +1031,10 @@ int __init mvebu_mbus_dt_init(void)
>  				     resource_size(&mbuswins_res),
>  				     sdramwins_res.start,
>  				     resource_size(&sdramwins_res));
> -	return ret;
> +	if (ret)
> +		return ret;
> +
> +	/* Setup statically declared windows in the DT */
> +	return mbus_dt_setup(&mbus_state, np);
>  }
>  #endif
> -- 
> 1.8.1.5
> 
