From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 24 Nov 2015 11:50:54 +0000
Subject: [PATCH 1/4] bus: uniphier-system-bus: add UniPhier System Bus
 Controller driver
In-Reply-To: <1448357962-12259-2-git-send-email-yamada.masahiro@socionext.com>
References: <1448357962-12259-1-git-send-email-yamada.masahiro@socionext.com>
 <1448357962-12259-2-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20151124115053.GB4108@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 24, 2015 at 06:39:19PM +0900, Masahiro Yamada wrote:
> The UniPhier System Bus is an external bus where on-board devices are
> connected to the UniPhier SoC.  This driver parses the "ranges"
> property of the System Bus and set up the registers of the System Bus
> Controller for the correct bus routing.

Could you elaborate on why you need to do that?

What needs to be configured specifically?

[...]

> +The UniPhier System Bus is an external bus where on-board devices are connected
> +to the UniPhier SoC.  It it a simple parallel bus with address, data, and some
> +control signals.  It supports up to 8 banks (chip selects).
> +
> +Required properties for System Bus:
> +- compatible: should be "socionext,uniphier-system-bus", "simple-bus".

If the kernel has to perform setup of the bus, then it is not a
"simple-bus".

Configure the bus, then probe children. Don't use simple-bus jsut to get
probing.

> +- #address-cells: should be equal to or grater than 2.  The first cell is the

s/grater/greater/

> +  bank number (chip select).  The rest is the base address within the bank that
> +  should be mapped onto the parent bus (usually AMBA).
> +
> +Optional properties for System Bus:
> +- #size-cells: should be the same as that of the parent bus, if exists.  The
> +  value of the parent bus is assumed, if not specified.

This should be just as required as #address-cells, for consistency.

> +
> +
> +UniPhier System Bus Controller
> +------------------------------
> +
> +The UniPhier System Bus Controller is a hardware block with registers that
> +controls the System Bus accessing; how each bank is mapped onto the parent bus,
> +various timing parameters of the bus access, etc.
> +
> +Required properties for System Bus Controller:
> +- compatible: should be "socionext,uniphier-system-bus-controller".
> +- reg: offsets and lengths of the register sets for the device.  It should
> +  contain 2 regions: base & control register, misc register, in this order.

The example also has a system-bus phandle.

Is the "misc register" part of the bus controller, or is it a shared
system controller?

> +Example
> +-------
> +	system_bus: system-bus {
> +		compatible = "socionext,uniphier-system-bus", "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <1>;
> +		ranges = <1 0x00000000 0x42000000 0x02000000
> +			  5 0x00000000 0x48000000 0x01000000>;
> +
> +		eth: ethernet at 1,01f00000 {
> +			compatible = "smsc,lan9115";
> +			reg = <1 0x01f00000 0x1000>;
> +			phy-mode = "mii";
> +			reg-io-width = <4>;
> +		};
> +
> +		serial: uart at 5,00200000 {
> +			compatible = "ns16550a";
> +			reg = <5 0x00200000 0x20>;
> +			clock-frequency = <12288000>;
> +			reg-shift = <1>;
> +		};
> +	};
> +
> +	system-bus-controller at 58c00000 {
> +		compatible = "socionext,uniphier-system-bus-controller";
> +		reg = <0x58c00000 0x400>, <0x59800000 0x2000>;
> +		system-bus = <&system_bus>;
> +	};

Assuming that the controller and bus are 1-1 related, make this a single
node. e.g.

system-bus {
	compatible = "socionext,uniphier-system-bus";
	reg = <0x58c00000 0x400>, <0x59800000 0x2000>;
	#address-cells = <2>;
	#size-cells = <1>;
	ranges = <1 0x00000000 0x42000000 0x02000000>,
		 <5 0x00000000 0x48000000 0x01000000>;

	...
	child nodes here
	...

};

[...]

> +static int uniphier_sbc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct uniphier_sbc_priv *priv;
> +	struct resource *regs;
> +	struct device_node *bus_np;
> +	int child_addrc, addrc, sizec, bank;
> +	u64 child_addr, addr, size;
> +	const __be32 *ranges;
> +	int rlen, rone, ret;
> +
> +	bus_np = of_find_compatible_node(NULL, NULL,
> +					 "socionext,uniphier-system-bus");

This is broken if you ever have multiple instances.

Either use a single node, or if there is a more complex relationship
between busses and their controllers, describe that explicitly with
phandles.

Thanks,
Mark.
