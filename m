From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Tue, 14 Aug 2012 22:12:15 +0200
Subject: [PATCH v3 10/10] ARM: tegra: pcie: Add device tree support
In-Reply-To: <1343332512-28762-11-git-send-email-thierry.reding@avionic-design.de>
References: <1343332512-28762-1-git-send-email-thierry.reding@avionic-design.de>
 <1343332512-28762-11-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <20120814201215.GA10542@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2012 at 09:55:12PM +0200, Thierry Reding wrote:
> diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
> index a094c97..c886dff 100644
> --- a/arch/arm/boot/dts/tegra20.dtsi
> +++ b/arch/arm/boot/dts/tegra20.dtsi
> @@ -199,6 +199,68 @@
>  		#size-cells = <0>;
>  	};
>  
> +	pcie-controller {
> +		compatible = "nvidia,tegra20-pcie";
> +		reg = <0x80003000 0x00000800   /* PADS registers */
> +		       0x80003800 0x00000200   /* AFI registers */
> +		       0x81000000 0x01000000   /* configuration space */
> +		       0x90000000 0x10000000>; /* extended configuration space */
> +		interrupts = <0 98 0x04   /* controller interrupt */
> +		              0 99 0x04>; /* MSI interrupt */
> +		status = "disabled";
> +
> +		ranges = <0 0 0  0x80000000 0x00001000   /* root port 0 */
> +			  0 1 0  0x81000000 0x00800000   /* port 0 config space */
> +			  0 2 0  0x90000000 0x08000000   /* port 0 ext config space */
> +			  0 3 0  0x82000000 0x00010000   /* port 0 downstream I/O */
> +			  0 4 0  0xa0000000 0x08000000   /* port 0 non-prefetchable memory */
> +			  0 5 0  0xb0000000 0x08000000   /* port 0 prefetchable memory */
> +
> +			  1 0 0  0x80001000 0x00001000   /* root port 1 */
> +			  1 1 0  0x81800000 0x00800000   /* port 1 config space */
> +			  1 2 0  0x98000000 0x08000000   /* port 1 ext config space */
> +			  1 3 0  0x82010000 0x00010000   /* port 1 downstream I/O */
> +			  1 4 0  0xa8000000 0x08000000   /* port 1 non-prefetchable memory */
> +			  1 5 0  0xb8000000 0x08000000>; /* port 1 prefetchable memory */

I've been thinking about this some more. The translations for both the
regular and extended configuration spaces are configured in the top-
level PCIe controller. It is therefore wrong how they are passed to the
PCI host bridges via the ranges property.

I remember Mitch saying that it should be passed down to the children
because it is partitioned among them, but since the layout is compatible
with ECAM, the partitioning isn't as simple as what's in the tree. In
fact the partitions will be dependent on the number of devices attached
to the host bridges.

> +
> +		#address-cells = <3>;
> +		#size-cells = <1>;
> +
> +		pci at 0 {
> +			device_type = "pciex";
> +			reg = <0 0 0 0x1000>;
> +			status = "disabled";
> +
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +
> +			ranges = <0x80000000 0 0  0 1 0  0 0x00800000   /* config space */
> +				  0x90000000 0 0  0 2 0  0 0x08000000   /* ext config space */
> +				  0x81000000 0 0  0 3 0  0 0x00010000   /* I/O */
> +				  0x82000000 0 0  0 4 0  0 0x08000000   /* non-prefetchable memory */
> +				  0xc2000000 0 0  0 5 0  0 0x08000000>; /* prefetchable memory */
> +
> +			nvidia,num-lanes = <2>;
> +		};
> +
> +		pci at 1 {
> +			device_type = "pciex";
> +			reg = <1 0 0 0x1000>;
> +			status = "disabled";
> +
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +
> +			ranges = <0x80000000 0 0  1 1 0  0 0x00800000   /* config space */
> +				  0x90000000 0 0  1 2 0  0 0x08000000   /* ext config space */
> +				  0x81000000 0 0  1 3 0  0 0x00010000   /* I/O */
> +				  0x82000000 0 0  1 4 0  0 0x08000000   /* non-prefetchable memory */
> +				  0xc2000000 0 0  1 5 0  0 0x08000000>; /* prefetchable memory */
> +
> +			nvidia,num-lanes = <2>;
> +		};
> +	};

The same is true for the ranges properties of the PCI host bridge nodes.
Which part of the configuration spaces maps to the children of the
respective host bridge depends on the actual device hierarchy.

Would it be possible to alternatively pass the complete range to the
children without further partitioning?

The driver doesn't actually care about the ranges property and only uses
the values specified in the reg property of the pcie-controller node.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120814/fc1966f8/attachment-0001.sig>
