From: leoyang.li@nxp.com (Leo Li)
Date: Thu, 8 Nov 2018 21:29:04 +0000
Subject: [PATCH 21/23] dt-bindings: pci: Add NXP LX SoCs PCIe controller
In-Reply-To: <20181106131807.29951-22-Zhiqiang.Hou@nxp.com>
References: <20181106131807.29951-1-Zhiqiang.Hou@nxp.com>
 <20181106131807.29951-22-Zhiqiang.Hou@nxp.com>
Message-ID: <AM6PR04MB58639AF03E732FCF491113728FC50@AM6PR04MB5863.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Z.q. Hou
> Sent: Tuesday, November 6, 2018 7:21 AM
> To: linux-pci at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> devicetree at vger.kernel.org; linux-kernel at vger.kernel.org;
> bhelgaas at google.com; robh+dt at kernel.org; mark.rutland at arm.com;
> l.subrahmanya at mobiveil.co.in; shawnguo at kernel.org; Leo Li
> <leoyang.li@nxp.com>; lorenzo.pieralisi at arm.com
> Cc: Mingkai Hu <mingkai.hu@nxp.com>; M.h. Lian
> <minghuan.lian@nxp.com>; Xiaowei Bao <xiaowei.bao@nxp.com>; Z.q. Hou
> <zhiqiang.hou@nxp.com>
> Subject: [PATCH 21/23] dt-bindings: pci: Add NXP LX SoCs PCIe controller
> 
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> Add PCIe controller DT bindings of NXP LX series SoCs.

I'm not sure if this is a good idea to name this controller LX PCIe controller.  Right now, it could be true that it is only used on LX series SoCs.  But I'm not sure if the LS series will not use this controller or LX series will only use this controller in the future.

Since the LX series is still using the layerscape branding, so probably we should keep using the layerscape-pci.txt and define the PCIe Gen4 variant?

Same comment for other places using the LX naming in this driver.

> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
>  .../devicetree/bindings/pci/lx-pci.txt        | 52 +++++++++++++++++++
>  MAINTAINERS                                   |  8 +++
>  2 files changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/lx-pci.txt
> 
> diff --git a/Documentation/devicetree/bindings/pci/lx-pci.txt
> b/Documentation/devicetree/bindings/pci/lx-pci.txt
> new file mode 100644
> index 000000000000..dc602fef93b0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/lx-pci.txt
> @@ -0,0 +1,52 @@
> +NXP LX PCIe controller
> +
> +This PCIe controller is based on the Mobiveil PCIe IP and thus inherits
> +all the common properties defined in mobiveil-pcie.txt.
> +
> +Required properties:
> +- compatible: should contain the platform identifier such as:
> +  "fsl,lx2160a-pcie"
> +- reg: base addresses and lengths of the PCIe controller register blocks.
> +  "config_axi_slave": PCIe controller registers
> +  "csr_axi_slave": Bridge config registers
> +- interrupts: A list of interrupt outputs of the controller. Must
> +contain an
> +  entry for each entry in the interrupt-names property.
> +- interrupt-names: It could include the following entries:
> +  "intr": The interrupt that is asserted for controller interrupts
> +  "aer": Asserted for aer interrupt when chip support the aer interrupt with
> +		 none MSI/MSI-X/INTx mode,but there is interrupt line for
> aer.
> +  "pme": Asserted for pme interrupt when chip support the pme interrupt
> with
> +		 none MSI/MSI-X/INTx mode,but there is interrupt line for
> pme.
> +- dma-coherent: Indicates that the hardware IP block can ensure the
> +coherency
> +  of the data transferred from/to the IP block. This can avoid the
> +software
> +  cache flush/invalid actions, and improve the performance significantly.
> +- msi-parent : See the generic MSI binding described in
> +  Documentation/devicetree/bindings/interrupt-controller/msi.txt.
> +
> +Example:
> +
> +	pcie at 3400000 {
> +		compatible = "fsl,lx2160a-pcie";
> +		reg = <0x00 0x03400000 0x0 0x00100000   /* controller
> registers */
> +		       0x80 0x00000000 0x0 0x00001000>; /* configuration
> space */
> +		reg-names = "csr_axi_slave", "config_axi_slave";
> +		interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>, /* AER
> interrupt */
> +			     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>, /* PME
> interrupt */
> +			     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>; /*
> controller interrupt */
> +		interrupt-names = "aer", "pme", "intr";
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		device_type = "pci";
> +		apio-wins = <8>;
> +		ppio-wins = <8>;
> +		dma-coherent;
> +		bus-range = <0x0 0xff>;
> +		msi-parent = <&its>;
> +		ranges = <0x82000000 0x0 0x40000000 0x80 0x40000000 0x0
> 0x40000000>;
> +		#interrupt-cells = <1>;
> +		interrupt-map-mask = <0 0 0 7>;
> +		interrupt-map = <0000 0 0 1 &gic GIC_SPI 109
> IRQ_TYPE_LEVEL_HIGH>,
> +				<0000 0 0 2 &gic GIC_SPI 110
> IRQ_TYPE_LEVEL_HIGH>,
> +				<0000 0 0 3 &gic GIC_SPI 111
> IRQ_TYPE_LEVEL_HIGH>,
> +				<0000 0 0 4 &gic GIC_SPI 112
> IRQ_TYPE_LEVEL_HIGH>;
> +	};
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0c57ccff3188..7da555c8e2f5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11252,6 +11252,14 @@ L:	linux-arm-kernel at lists.infradead.org
>  S:	Maintained
>  F:	drivers/pci/controller/dwc/*layerscape*
> 
> +PCI DRIVER FOR NXP LX
> +M:	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> +L:	linux-pci at vger.kernel.org
> +L:	linux-arm-kernel at lists.infradead.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/pci/lx-pci.txt
> +F:	drivers/pci/controller/mobibeil/pci-lx.c
> +
>  PCI DRIVER FOR GENERIC OF HOSTS
>  M:	Will Deacon <will.deacon@arm.com>
>  L:	linux-pci at vger.kernel.org
> --
> 2.17.1
