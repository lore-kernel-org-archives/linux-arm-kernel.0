From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 2 Jun 2016 14:24:05 +0200
Subject: [PATCH 1/3] dt-bindings: add DT binding for the Aardvark PCIe
 controller
In-Reply-To: <1464858585-10963-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1464858585-10963-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1464858585-10963-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20160602122405.GG17343@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +In addition, the Device Tree describing an Aardvark PCIe controller
> +must include a sub-node that describes the legacy interrupt controller
> +built into the PCIe controller. This sub-node must have the following
> +properties:
> +
> + - interrupt-controller
> + - #interrupt-cells: set to <1>
> +
> +Example:
> +
> +	pcie0: pcie at d0070000 {
> +		compatible = "marvell,armada-3700-pcie";
> +		device_type = "pci";
> +		status = "disabled";
> +		reg = <0 0xd0070000 0 0x20000>;
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		bus-range = <0x00 0xff>;
> +		interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
> +		#interrupt-cells = <1>;
> +		ranges = <0x82000000 0 0xe8000000   0 0xe8000000 0 0x1000000 /* Port 0 MEM */
> +			  0x81000000 0 0xe9000000   0 0xe9000000 0 0x10000>; /* Port 0 IO*/
> +		interrupt-map-mask = <0 0 0 7>;
> +		interrupt-map = <0 0 0 1 &pcie_intc 0>,
> +				<0 0 0 2 &pcie_intc 1>,
> +				<0 0 0 3 &pcie_intc 2>,
> +				<0 0 0 4 &pcie_intc 3>;
> +		pcie_intc: interrupt-controller {
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +		};

Hi Thomas

It is possible to list PCIe devices on the bus here as child
nodes. I've done this when i needed a phandle to an intel ethernet
controller on the PCIe bus, which i know is soldered onto the board.

I think your current implementation simply uses the first child
node. It would be good to document that ordering is important. It must
be the first child node, and any pcie devices children must come
afterwards.

      Andrew
