From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 18 Jun 2013 13:33:37 +0200
Subject: [PATCH v3 00/12] MBus device tree binding
In-Reply-To: <1371554737-25319-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1371554737-25319-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <51C04591.3010206@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/18/13 13:25, Ezequiel Garcia wrote:
> In the example below there's an extract of a device tree showing how
> the internal-regs and pcie nodes can be represented:
>
> 	#define MBUS_ID(target,attributes) (((target) << 24) | ((attributes) << 16))
>
> 	soc {
> 		compatible = "marvell,armadaxp-mbus";
> 		reg = <0 0xd0020000 0 0x100>, <0 0xd0020180 0 0x20>;
>
> 		ranges = <0xffff0001 0 0 0xd0000000 0x100000   /* internal-regs */
> 			  0xffff0000 0 0 0xe0000000 0x8100000  /* pcie */
> 			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
> 			  MBUS_ID(0x01, 0x2f) 0 0 0xf0000000 0x8000000>;

Ezequiel,

you should update PCIE above (and possibly anywhere else) too.

> 		pcie-controller {
> 			compatible = "marvell,armada-xp-pcie";
> 			status = "okay";
> 			device_type = "pci";
>
> 			#address-cells = <3>;
> 			#size-cells = <2>;
>
> 			ranges =
> 			       <0x82000000 0 0x40000 0xffff0001 0x40000 0 0x00002000   /* Port 0.0 registers */
> 				0x82000000 0 0x42000 0xffff0001 0x42000 0 0x00002000   /* Port 2.0 registers */
> 				0x82000000 0 0x44000 0xffff0001 0x44000 0 0x00002000   /* Port 0.1 registers */
> 				0x82000000 0 0x48000 0xffff0001 0x48000 0 0x00002000   /* Port 0.2 registers */
> 				0x82000000 0 0x4c000 0xffff0001 0x4c000 0 0x00002000   /* Port 0.3 registers */
> 				0x82000000 0 0x80000 0xffff0001 0x80000 0 0x00002000   /* Port 1.0 registers */
> 				0x82000000 0 0x82000 0xffff0001 0x82000 0 0x00002000   /* Port 3.0 registers */
> 				0x82000000 0 0xe0000000 0xffff0000 0 0 0x08000000   /* non-prefetchable memory */
> 				0x81000000 0 0 0xffff0000 0x8000000 0 0x00100000>; /* downstream I/O */

Here for example.

> Changes from v2:
>   * Replaced the PCIe mapping with 0xffff0002, to avoid using a representation
>     that might correspond to a possible window id.

Out of curiosity, how will these fake mappings play with LPAE? If you
extend possible address space to >32b the lower bits may belong to valid
addresses.
Maybe you can (already do?) ignore that because of the 32b address
restriction for internal registers IIRC Thomas mentioned?

Sebastian
