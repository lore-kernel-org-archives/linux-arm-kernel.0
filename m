From: galak@codeaurora.org (Kumar Gala)
Date: Fri, 30 Jan 2015 10:32:58 -0600
Subject: [Patch v2 1/6] soc: qcom: gsbi: Add support for ADM CRCI muxing
In-Reply-To: <1422599135-5588-2-git-send-email-agross@codeaurora.org>
References: <1422599135-5588-1-git-send-email-agross@codeaurora.org>
 <1422599135-5588-2-git-send-email-agross@codeaurora.org>
Message-ID: <B36DEAB1-2D89-4B6B-991E-C2EDBEB684D9@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Jan 30, 2015, at 12:25 AM, Andy Gross <agross@codeaurora.org> wrote:

> This patch adds automatic configuration for the ADM CRCI muxing required to
> support DMA operations for GSBI clients.  The GSBI mode and instance determine
> the correct TCSR ADM CRCI MUX value that must be programmed so that the DMA
> works properly.
> 
> Signed-off-by: Andy Gross <agross@codeaurora.org>
> ---
> .../devicetree/bindings/soc/qcom/qcom,gsbi.txt     |   18 ++-
> drivers/soc/qcom/Kconfig                           |    1 +
> drivers/soc/qcom/qcom_gsbi.c                       |  153 ++++++++++++++++++++
> 3 files changed, 171 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,gsbi.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,gsbi.txt
> index 4ce24d4..8fe7b37 100644
> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,gsbi.txt
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,gsbi.txt
> @@ -6,7 +6,7 @@ configuration settings.  The mode setting will govern the input/output mode of
> the 4 GSBI IOs.
> 
> Required properties:
> -- compatible: must contain "qcom,gsbi-v1.0.0" for APQ8064/IPQ8064
> +- compatible:	Should contain "qcom,gsbi-v1.0.0"
> - reg: Address range for GSBI registers
> - clocks: required clock
> - clock-names: must contain "iface" entry
> @@ -16,12 +16,16 @@ Required properties:
> Optional properties:
> - qcom,crci : indicates CRCI MUX value for QUP CRCI ports.  Please reference
>   dt-bindings/soc/qcom,gsbi.h for valid CRCI mux values.
> +- syscon-tcsr: indicates phandle of TCSR syscon node.  Required if child uses
> +  dma.
> 
> Required properties if child node exists:
> - #address-cells: Must be 1
> - #size-cells: Must be 1
> - ranges: Must be present
> 
> +Note: Each GSBI should have an alias correctly numbered in "aliases" node.
> +
> Properties for children:
> 
> A GSBI controller node can contain 0 or more child nodes representing serial
> @@ -37,6 +41,10 @@ Example for APQ8064:
> 
> #include <dt-bindings/soc/qcom,gsbi.h>
> 
> +	aliases {
> +		gsbi4 = <&gsbi4>;
> +	};

You appear to be using the alias name to determine a index number for the gsbi, if that is the case, than you should probably just add a cell-index node to the gsbi?s for this purpose.

> +
> 	gsbi4 at 16300000 {
> 		compatible = "qcom,gsbi-v1.0.0";
> 		reg = <0x16300000 0x100>;
> @@ -48,6 +56,8 @@ Example for APQ8064:
> 		qcom,mode = <GSBI_PROT_I2C_UART>;
> 		qcom,crci = <GSBI_CRCI_QUP>;
> 
> +		syscon-tcsr = <&tcsr>;
> +
> 		/* child nodes go under here */
> 
> 		i2c_qup4: i2c at 16380000 {
> @@ -76,3 +86,9 @@ Example for APQ8064:
> 		};
> 	};
> 
> +	tcsr: syscon at 1a400000 {
> +		compatible = "qcom,apq8064-tcsr", "syscon";
> +		reg = <0x1a400000 0x100>;
> +	};
> +
> +

- k

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
