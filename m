From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 8 Nov 2018 14:34:44 +0100
Subject: [PATCH 35/36] dt-bindings: arm: Convert Xilinx board/soc bindings
 to json-schema
In-Reply-To: <20181005165848.3474-36-robh@kernel.org>
References: <20181005165848.3474-1-robh@kernel.org>
 <20181005165848.3474-36-robh@kernel.org>
Message-ID: <0120c2a6-b7a6-cbf8-0604-855b0e01f050@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05. 10. 18 18:58, Rob Herring wrote:
> Convert Xilinx SoC bindings to DT schema format using json-schema.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: devicetree at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/arm/xilinx.txt        | 83 -------------------
>  .../devicetree/bindings/arm/xilinx.yaml       | 81 ++++++++++++++++++
>  2 files changed, 81 insertions(+), 83 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/xilinx.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/xilinx.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/xilinx.txt b/Documentation/devicetree/bindings/arm/xilinx.txt
> deleted file mode 100644
> index 26fe5ecc4332..000000000000
> --- a/Documentation/devicetree/bindings/arm/xilinx.txt
> +++ /dev/null
> @@ -1,83 +0,0 @@
> -Xilinx Zynq Platforms Device Tree Bindings
> -
> -Boards with Zynq-7000 SOC based on an ARM Cortex A9 processor
> -shall have the following properties.
> -
> -Required root node properties:
> -    - compatible = "xlnx,zynq-7000";
> -
> -Additional compatible strings:
> -
> -- Adapteva Parallella board
> -  "adapteva,parallella"
> -
> -- Avnet MicroZed board
> -  "avnet,zynq-microzed"
> -  "xlnx,zynq-microzed"
> -
> -- Avnet ZedBoard board
> -  "avnet,zynq-zed"
> -  "xlnx,zynq-zed"
> -
> -- Digilent Zybo board
> -  "digilent,zynq-zybo"
> -
> -- Digilent Zybo Z7 board
> -  "digilent,zynq-zybo-z7"
> -
> -- Xilinx CC108 internal board
> -  "xlnx,zynq-cc108"
> -
> -- Xilinx ZC702 internal board
> -  "xlnx,zynq-zc702"
> -
> -- Xilinx ZC706 internal board
> -  "xlnx,zynq-zc706"
> -
> -- Xilinx ZC770 internal board, with different FMC cards
> -  "xlnx,zynq-zc770-xm010"
> -  "xlnx,zynq-zc770-xm011"
> -  "xlnx,zynq-zc770-xm012"
> -  "xlnx,zynq-zc770-xm013"
> -
> ----------------------------------------------------------------
> -
> -Xilinx Zynq UltraScale+ MPSoC Platforms Device Tree Bindings
> -
> -Boards with ZynqMP SOC based on an ARM Cortex A53 processor
> -shall have the following properties.
> -
> -Required root node properties:
> -    - compatible = "xlnx,zynqmp";
> -
> -
> -Additional compatible strings:
> -
> -- Xilinx internal board zc1232
> -  "xlnx,zynqmp-zc1232-revA", "xlnx,zynqmp-zc1232"
> -
> -- Xilinx internal board zc1254
> -  "xlnx,zynqmp-zc1254-revA", "xlnx,zynqmp-zc1254"
> -
> -- Xilinx internal board zc1275
> -  "xlnx,zynqmp-zc1275-revA", "xlnx,zynqmp-zc1275"
> -
> -- Xilinx internal board zc1751
> -  "xlnx,zynqmp-zc1751"
> -
> -- Xilinx 96boards compatible board zcu100
> -  "xlnx,zynqmp-zcu100-revC", "xlnx,zynqmp-zcu100"
> -
> -- Xilinx evaluation board zcu102
> -  "xlnx,zynqmp-zcu102-revA", "xlnx,zynqmp-zcu102"
> -  "xlnx,zynqmp-zcu102-revB", "xlnx,zynqmp-zcu102"
> -  "xlnx,zynqmp-zcu102-rev1.0", "xlnx,zynqmp-zcu102"
> -
> -- Xilinx evaluation board zcu104
> -  "xlnx,zynqmp-zcu104-revA", "xlnx,zynqmp-zcu104"
> -
> -- Xilinx evaluation board zcu106
> -  "xlnx,zynqmp-zcu106-revA", "xlnx,zynqmp-zcu106"
> -
> -- Xilinx evaluation board zcu111
> -  "xlnx,zynqmp-zcu111-revA", "xlnx,zynqmp-zcu111"
> diff --git a/Documentation/devicetree/bindings/arm/xilinx.yaml b/Documentation/devicetree/bindings/arm/xilinx.yaml
> new file mode 100644
> index 000000000000..dd227bccf015
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/xilinx.yaml
> @@ -0,0 +1,81 @@
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/arm/xilinx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xilinx Zynq Platforms Device Tree Bindings
> +
> +maintainers:
> +  - Michal Simek <michal.simek@xilinx.com>
> +
> +description: |
> +  Xilinx boards with Zynq-7000 SOC or Zynq UltraScale+ MPSoC
> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - adapteva,parallella
> +              - digilent,zynq-zybo
> +              - digilent,zynq-zybo-z7
> +              - xlnx,zynq-cc108
> +              - xlnx,zynq-zc702
> +              - xlnx,zynq-zc706
> +              - xlnx,zynq-zc770-xm010
> +              - xlnx,zynq-zc770-xm011
> +              - xlnx,zynq-zc770-xm012
> +              - xlnx,zynq-zc770-xm013
> +          - const: xlnx,zynq-7000
> +
> +      - items:
> +          - const: avnet,zynq-microzed
> +          - const: xlnx,zynq-microzed
> +          - const: xlnx,zynq-7000
> +
> +      - items:
> +          - const: avnet,zynq-zed
> +          - const: xlnx,zynq-zed
> +          - const: xlnx,zynq-7000
> +
> +      - items:
> +          - enum:
> +              - xlnx,zynqmp-zc1751
> +          - const: xlnx,zynqmp
> +
> +      - description: Xilinx internal board zc1232
> +        items:
> +          - const: xlnx,zynqmp-zc1232-revA
> +          - const: xlnx,zynqmp-zc1232
> +          - const: xlnx,zynqmp
> +
> +      - description: Xilinx internal board zc1254
> +        items:
> +          - const: xlnx,zynqmp-zc1254-revA
> +          - const: xlnx,zynqmp-zc1254
> +          - const: xlnx,zynqmp
> +
> +      - description: Xilinx internal board zc1275
> +        items:
> +          - const: xlnx,zynqmp-zc1275-revA
> +          - const: xlnx,zynqmp-zc1275
> +          - const: xlnx,zynqmp
> +
> +      - description: Xilinx 96boards compatible board zcu100
> +        items:
> +          - const: xlnx,zynqmp-zcu100-revC
> +          - const: xlnx,zynqmp-zcu100
> +          - const: xlnx,zynqmp
> +
> +      - description: Xilinx evaluation board zcu102
> +        items:
> +          - enum:
> +              - xlnx,zynqmp-zcu102-revA
> +              - xlnx,zynqmp-zcu102-revB
> +              - xlnx,zynqmp-zcu102-rev1.0
> +          - const: xlnx,zynqmp-zcu102
> +          - const: xlnx,zynqmp
> +
> +...
> 

Conversion looks good. I have also found that we are missing some boards
when I was playing with your branch. But this can be added on the top of
this patch.
I have sent you separate patch for that.

Also I have found that we are missing one property which can go to the
tree directly and I am going to send a patch for it too.

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
