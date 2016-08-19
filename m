From: monstr@monstr.eu (Michal Simek)
Date: Fri, 19 Aug 2016 12:30:49 +0200
Subject: [PATCH v3 2/2] ARM64: zynqmp: Add PCIe node
In-Reply-To: <5930f26f4b5dd129dce09f0a707817d5cf82fde9.1470750018.git.michal.simek@xilinx.com>
References: <c26e914e5a65f22c2dc19dc2f90b4eb59d51828b.1470750018.git.michal.simek@xilinx.com>
 <5930f26f4b5dd129dce09f0a707817d5cf82fde9.1470750018.git.michal.simek@xilinx.com>
Message-ID: <a0012b9a-4c4f-f292-bb94-982fc53525bd@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9.8.2016 15:40, Michal Simek wrote:
> Add PCIe node with prefetchable memory which goes beyond 4GB.
> 
> Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> Changes in v3:
> - New patch to show usage of 2/2 on main amba bus
> 
> Changes in v2: None
> 
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 39 ++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> index d24014765111..fbdd6ab98988 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -193,6 +193,45 @@
>  			#size-cells = <0>;
>  		};
>  
> +		pcie: pcie at fd0e0000 {
> +			compatible = "xlnx,nwl-pcie-2.11";
> +			status = "disabled";
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			#interrupt-cells = <1>;
> +			msi-controller;
> +			device_type = "pci";
> +			interrupt-parent = <&gic>;
> +			interrupts = <0 118 4>,
> +				    <0 117 4>,
> +				    <0 116 4>,
> +				    <0 115 4>,	/* MSI_1 [63...32] */
> +				    <0 114 4>;	/* MSI_0 [31...0] */
> +			interrupt-names = "misc", "dummy", "intx",
> +					  "msi1", "msi0";
> +			msi-parent = <&pcie>;
> +			reg = <0x0 0xfd0e0000 0x0 0x1000>,
> +			      <0x0 0xfd480000 0x0 0x1000>,
> +			      <0x80 0x00000000 0x0 0x1000000>;
> +			reg-names = "breg", "pcireg", "cfg";
> +			ranges = <0x02000000 0x00000000 0xe0000000 0x00000000
> +				  0xe0000000 0x00000000 0x10000000
> +				  /* non-prefetchable memory */
> +				  0x43000000 0x00000006 0x00000000 0x00000006
> +				  0x00000000 0x00000002 0x00000000>;
> +				  /* prefetchable memory */
> +			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
> +			interrupt-map = <0x0 0x0 0x0 0x1 &pcie_intc 0x1>,
> +					<0x0 0x0 0x0 0x2 &pcie_intc 0x2>,
> +					<0x0 0x0 0x0 0x3 &pcie_intc 0x3>,
> +					<0x0 0x0 0x0 0x4 &pcie_intc 0x4>;
> +			pcie_intc: legacy-interrupt-controller {
> +				interrupt-controller;
> +				#address-cells = <0>;
> +				#interrupt-cells = <1>;
> +			};
> +		};
> +
>  		sata: ahci at fd0c0000 {
>  			compatible = "ceva,ahci-1v84";
>  			status = "disabled";
> 

Applied both.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160819/c8c779a0/attachment-0001.sig>
