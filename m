From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 7 Jun 2013 21:01:44 +0200
Subject: [PATCH 04/14] bus: mvebu-mbus: Add static window allocation to
 the DT binding
In-Reply-To: <1370623671-7748-5-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1370623671-7748-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1370623671-7748-5-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <201306072101.44694.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 June 2013, Ezequiel Garcia wrote:
> This patch adds static window allocation to the device tree binding.
> Each first-child of the mbus-compatible node, with a suitable 'ranges'
> property, declaring an address translation, will trigger an address
> decoding window allocation.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

I think this is very good in general, but in some cases should be reworded
for clarity, and in a few others we should remove the special cases from
the binding and try to treat them more like the common case.

>  .../devicetree/bindings/bus/mvebu-mbus.txt         | 152 +++++++++++++++++++++
>  drivers/bus/mvebu-mbus.c                           | 110 ++++++++++++++-
>  2 files changed, 261 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/bus/mvebu-mbus.txt
> 
> diff --git a/Documentation/devicetree/bindings/bus/mvebu-mbus.txt b/Documentation/devicetree/bindings/bus/mvebu-mbus.txt
> new file mode 100644
> index 0000000..2b0303e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/bus/mvebu-mbus.txt
> @@ -0,0 +1,152 @@
> +
> +* Marvell MBus controller
> +
> +Required properties:
> +
> +- compatible:	Should be set to one of the following:
> +		marvell,armada370-mbus
> +		marvell,armadaxp-mbus

I thought they are compatible with all older ones at the register level,
as long as we describe all the differences in the ranges property
and other properties.

> +- reg:		Device's register space.
> +		Two entries are expected, see the examples below.
> +		The first one controls the devices decoding window and
> +		the second one controls the SDRAM decoding window.

I think you should also list #address-cells=<2> and #size-cells=<1>
as required here, as long as an optional "ranges" property.

I think it makes sense to describe the "ranges" format here,
even if we expect the property to be empty at boot time and
only filled at run-time.

> +Example:
> +
> +	soc {
> +		compatible = "marvell,armada370-mbus", "simple-bus";
> +		reg = <0xd0020000 0x100>, <0xd0020180 0x20>;
> +	};
> +
> +** How does it work?
> +
> +The MBus driver controls the allocation and release of the addresses
> +decoding windows needed to access devices.
> +
> +Each window, is identified by its target ID and attribute ID. In order
> +to represent this, each of mbus-node first-level child has to declare
> +a suitable 'ranges' translation entry for the MBus to allocate a window
> +for it. This entry will encode the target and attribute in a 'windowid'
> +ad-hoc cell, like this:
> +
> +	soc {
> +		bootrom {
> +			ranges = <0 0x01e00000 0xfff00000 0x100000>;
> +		};
> +	};

I think I'm a bit lost here. Is the "soc" node in this example the node
that is described as compatible="marvell,armada370-mbus"? Maybe expand
the example a little here to clarify this.

> +
> +In this case, the MBus driver will allocate a window with target ID = 0x01,
> +attribute ID = 0xe0, base address 0xfff00000, and size 0x100000.
> +The windowid cell encodes the target and attribute in the upper bytes.

If you use the new preprocessor feature we have in DT now, you can
actually list a macro that is used to assembly the cell from target
and attribute ID.

> +Note that, the above 'ranges' property is creating a fictitious 2-cell address
> +space with the windowid and the base address. We need to get rid of this
> +2-cell address space, translating it into a real address space consisting of
> +just the base address.

I would not describe it as "fictious" here, rather an as "defined". This
binding is what turns the fiction into a reality ;-)

> +The obvious way is to add a translation at the mbus-node level, like this:
> +
> +	soc {
> +		ranges = <0x01e00000 0xfff00000 0xfff00000 0x100000>;
> +		bootrom {
> +			ranges = <0 0x01e00000 0xfff00000 0x100000>;
> +		};
> +	};
> +
> +This would lead to a lot of 'ranges' properties duplication because
> +when you need to declare a new translation for a given device, you have
> +to do it at the per-board DTS file. But since 'ranges' entries are not
> +inherited from included dtsi files, you would have to go through each of the
> +included dtsi files, making sure you duplicate each of the previous entries.

The part about "inheriting" is not clear. Also, this is not written more
like a blog post than a specification ;-)

> +So to avoid this duplication, the MBus driver is capable of adding the
> +required translation entry to the device tree programatically. In other
> +words, when writing the device tree you don't need to extend the mbus-node
> +translation entry list; the driver will do it dynamically.

I think the key here is not to avoid duplication but to allow flexibility.
I would write this as:

The mappings in the mbus device are expected to be dynamically created by
the operating system at boot time, or a later point. Since the ranges property
in the mbus device must match the actual mappings, it is also expected
to be filled out dynamically. A boot loader may set up mappings before
loading the operating system and describe them in the ranges property.

> +So for instance, if you want to add support for a NOR device, that sits
> +behind the Device Bus controller, you would have this device tree:
> +(Note that the windowid cell is encoding the target ID = 0x01 and attribute
> +ID = 0x2f, and the selected base address for the window is 0xe8000000).
> +
> +	soc {
> +		devbus-bootcs {
> +			status = "okay";
> +			ranges = <0 0x012f0000 0xe8000000 0x8000000>;
> +

The example should also contain an #address-cells and #size-cells
property in the devbus-bootcs, as those are required for interpreting the
ranges property.

> +** About the special target ID and attribute ID
> +
> +As stated above, for each 'ranges' translation entry in mbus-node first-level
> +children, the MBus driver will allocate a decoding window.
> +However, in some cases it's desirable to declare a translation entry but have
> +the MBus driver skip it.

I would leave out here what the driver does, or say that the mbus driver "may"
skip them. For the purpose of this specification, it does not matter whether
the driver leaves the translation in place or changes it.

> +This is currently the case for the internal-regs and the pcie-controller
> +nodes.
> +
> +In the former, a dummy translation entry is needed to map the regular device
> +nodes into the {windowid / base address} address space, using a zeroed windowid
> +(target = 0x0, attribute = 0x0). The MBus driver will skip entries with such
> +windowid.
> +
> +	soc {
> +		/* ... */
> +		internal-regs {
> +			compatible = "simple-bus";
> +			ranges = <0 0 0 0x100000>;  /* Dummy translation */
> +			serial at 12000 {
> +				reg = <0x12000 0x100>;
> +				/* ... */
> +			};
> +		};
> +	};

I don't understand the part about zeroing a windowid. Is "target = 0x0,
attribute = 0x0" the actual setting for the internal registers? If so,
don't call it a dummy translation or a special case.
If not, why not use the actual setting here?

> +In the pcie-controller case, we have two kinds of entries we need to skip.
> +The first one is identical to the internal-regs case; in fact it's declaring a
> +translation into the internal-regs address space.
> +
> +The second one is identified by a target ID = 0xff and attribute ID = 0xff.
> +We use this to create the mapping into the large region where the PCIe
> +controller will request decoding window allocations from the MBus driver.
> +
> +	soc {
> +		pcie-controller {
> +			ranges =
> +			       <0x82000000 0 0x40000    0          0x40000    0 0x00002000
> +				0x82000000 0 0x80000    0          0x80000    0 0x00002000
> +				0x82000000 0 0xe0000000 0xffff0000 0xe0000000 0 0x08000000
> +				0x81000000 0 0          0xffff0000 0xe8000000 0 0x00100000>;
> +
> +			pcie at 1,0 {
> +				/* ... */
> +			};
> +		};
> +	};

Again, I don't understand this part. For the purpose of specification, I
would not make a special case here. It is not a hardware property that makes
these special but the way we use it from Linux. Consequently I would suggest
we skip the PCI ranges in the initial boot time setup by identifying the
pcie-controller node by its "compatible" property.

	Arnd
