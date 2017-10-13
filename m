From: robh@kernel.org (Rob Herring)
Date: Fri, 13 Oct 2017 08:49:02 -0500
Subject: [PATCH v2 1/3] dt-bindings: nvmem: add description for UniPhier
 eFuse
In-Reply-To: <1507266180-11840-2-git-send-email-hayashibara.keiji@socionext.com>
References: <1507266180-11840-1-git-send-email-hayashibara.keiji@socionext.com>
 <1507266180-11840-2-git-send-email-hayashibara.keiji@socionext.com>
Message-ID: <20171013134902.7gvmkvxvwnjlmstp@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 06, 2017 at 02:02:58PM +0900, Keiji Hayashibara wrote:
> Add uniphier-efuse dt-bindings documentation.
> 
> Signed-off-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>
> ---
>  .../devicetree/bindings/nvmem/uniphier-efuse.txt   | 49 ++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/uniphier-efuse.txt
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/uniphier-efuse.txt b/Documentation/devicetree/bindings/nvmem/uniphier-efuse.txt
> new file mode 100644
> index 0000000..1a394e5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/uniphier-efuse.txt
> @@ -0,0 +1,49 @@
> += UniPhier eFuse device tree bindings =
> +
> +This UniPhier eFuse must be under soc-glue.
> +
> +Required properties:
> +- compatible: should be "socionext,uniphier-efuse"
> +- reg: should contain the register location and length
> +
> += Data cells =
> +Are child nodes of efuse, bindings of which as described in
> +bindings/nvmem/nvmem.txt
> +
> +Example:
> +
> +	soc-glue at 5f900000 {
> +		compatible = "socionext,uniphier-ld20-soc-glue-debug",
> +			     "simple-mfd";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0x0 0x5f900000 0x2000>;
> +
> +		efuse at 100 {
> +			compatible = "socionext,uniphier-efuse";
> +			reg = <0x100 0x28>;
> +		};
> +
> +		efuse at 200 {
> +			compatible = "socionext,uniphier-efuse";
> +			reg = <0x200 0x68>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			/* Data cells */
> +			usb_mon: usb_mon {

Don't use '_' and needs a unit-address. Build your dtb with W=2 option 
and you'll get these warnings.

> +				reg = <0x54 0xc>;

Without ranges above, this is address 5f900054. I think you want 
5f900254. You need:

ranges = <0x0 0x200 0x68>; 

> +			};
> +		};
> +	};
> +
> += Data consumers =
> +Are device nodes which consume nvmem data cells.
> +
> +Example:
> +
> +	usb {
> +		...
> +		nvmem-cells = <&usb_mon>;
> +		nvmem-cell-names = "usb_mon";
> +	}
> -- 
> 2.7.4
> 
