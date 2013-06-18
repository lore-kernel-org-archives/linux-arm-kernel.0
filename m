From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 18 Jun 2013 18:14:33 +0200
Subject: [PATCH v3 03/12] bus: mvebu-mbus: Add static window allocation to
 the DT binding
In-Reply-To: <1371554737-25319-4-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1371554737-25319-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1371554737-25319-4-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <201306181814.33941.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 June 2013, Ezequiel Garcia wrote:
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

You should explain here what the policy is regarding windows set up by the
boot loader. Are the ranges in here required to be the ones that the boot
loader has preconfigured, or are they the ones that the mbus driver is supposed
to set up?

> +Each child device needs at least a 'ranges' property. If the child is avaiable
> +(i.e. status not 'disabled'), then the MBus driver creates a decoding window
> +for it. For instance, in the example below the BootROM child is specified:
> +
> +	soc {
> +		compatible = "marvell,armada370-mbus", "simple-bus";
> +		reg = <0xd0020000 0x100>, <0xd0020180 0x20>;
> +		#address-cells = <2>;
> +		#size-cells = <1>;
> +
> +		ranges = < ... /* other entries */
> +			   0x011d0000 0 0 0xfff00000 0x100000>;
> +
> +		bootrom {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0 0x011d0000 0 0x100000>;
> +		};
> +
> +		/* other children */
> +		...
> +	};

Do you really want to require the child to provide a "ranges" property?
I think this makes it more complicated to specify devices that belong
into the "internal-regs" category.

Is this mainly for convenience when settup up the windows?

> +
> +			ranges =
> +			       <0x82000000 0 0x40000 0xffff0001 0x40000 0 0x00002000   /* Port 0.0 registers */
> +				0x82000000 0 0x42000 0xffff0001 0x42000 0 0x00002000   /* Port 2.0 registers */
> +				0x82000000 0 0x44000 0xffff0001 0x44000 0 0x00002000   /* Port 0.1 registers */
> +				0x82000000 0 0x48000 0xffff0001 0x48000 0 0x00002000   /* Port 0.2 registers */
> +				0x82000000 0 0x4c000 0xffff0001 0x4c000 0 0x00002000   /* Port 0.3 registers */
> +				0x82000000 0 0x80000 0xffff0001 0x80000 0 0x00002000   /* Port 1.0 registers */
> +				0x82000000 0 0x82000 0xffff0001 0x82000 0 0x00002000   /* Port 3.0 registers */
> +				0x82000000 0 0xe0000000 0xffff0002 0 0 0x08000000   /* non-prefetchable memory */
> +				0x81000000 0 0 0xffff0002 0x8000000 0 0x00100000>; /* downstream I/O */

Using 0xffff0002 as a placeholder for the pcie translation is definitely
better than 0xffff0000 as you had before, but let me ask again in case
you missed it the last time (and sorry if I missed the answer):

Why not just put the actual translation here the way it happens for each
of the PCIe ports? With the definition here, the PCIe driver actually has no
way to figure out what settings the windows need to use!

On a side note, is there a reason why you use 0xffff0001 for the internal-regs
rather than just 0x1? This one isn't important as they both work as well, it's
just more to write your way.

	Arnd
