From: ddaney@caviumnetworks.com (David Daney)
Date: Thu, 23 Jul 2015 11:26:11 -0700
Subject: [PATCH 1/3] Docs: dt: add generic MSI bindings
In-Reply-To: <1437670365-20704-2-git-send-email-mark.rutland@arm.com>
References: <1437670365-20704-1-git-send-email-mark.rutland@arm.com>
 <1437670365-20704-2-git-send-email-mark.rutland@arm.com>
Message-ID: <55B131C3.8050009@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/23/2015 09:52 AM, Mark Rutland wrote:
[...]
> +MSI clients
> +===========
> +
> +MSI clients are devices which generate MSIs. For each MSI they wish to
> +generate, the doorbell and payload may be configured, though sideband
> +information may not be configurable.
> +
> +Required properties:
> +--------------------
> +
> +- msi-parent: A list of phandle + msi-specifier pairs, one for each MSI
> +  controller which the device is capable of using.
> +

We say here that "msi-parent" consists of pairs ...

> +  This property is unordered, and MSIs may be allocated from any combination of
> +  MSI controllers listed in the msi-parent property.
> +
> +  If a device has restrictions on the allocation of MSIs, these restrictions
> +  must be described with additional properties.
> +
> +  When #msi-cells is non-zero, busses with an msi-parent will require
> +  additional properties to describe the relationship between devices on the bus
> +  and the set of MSIs they can potentially generate.
> +
> +
> +Example
> +=======
> +
> +/ {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	msi_a: msi-controller at a {
> +		reg = <0xa 0xf00>;
> +		compatible = "vendor-a,some-controller";
> +		msi-controller;
> +		/* No sideband data, so #msi-cells omitted */
> +	};
> +
> +	msi_b: msi-controller at b {
> +		reg = <0xb 0xf00>;
> +		compatible = "vendor-b,another-controller";
> +		msi-controller;
> +		/* Each device has some unique ID */
> +		#msi-cells = <1>;
> +	};
> +
> +	msi_c: msi-controller at c {
> +		reg = <0xb 0xf00>;
> +		compatible = "vendor-b,another-controller";
> +		msi-controller;
> +		/* Each device has some unique ID */
> +		#msi-cells = <1>;
> +	};
> +
> +	dev at 0 {
> +		reg = <0x0 0xf00>;
> +		compatible = "vendor-c,some-device";
> +
> +		/* Can only generate MSIs to msi_a */
> +		msi-parent = <&msi_a>;


My device-tree syntax foo is a little rusty, but doesn't "msi-parent" 
need a pair of elements?  This has only the phandle.

> +	};
> +
> +	dev at 1 {
> +		reg = <0x1 0xf00>;
> +		compatible = "vendor-c,some-device";
> +
> +		/*
> +		 * Can generate MSIs to either A or B.
> +		 */
> +		msi-parent = <&msi_a>, <&msi_b 0x17>;


... same here, ...

> +	};
> +
> +	dev at 2 {
> +		reg = <0x2 0xf00>;
> +		compatible = "vendor-c,some-device";
> +		/*
> +		 * Has different IDs at each MSI controller.
> +		 * Can generate MSIs to all of the MSI controllers.
> +		 */
> +		msi-parent = <&msi_a>, <&msi_b 0x17>, <&msi_c 0x53>;

... and here

> +	};
> +};
>
