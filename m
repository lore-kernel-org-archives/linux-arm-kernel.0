From: robh@kernel.org (Rob Herring)
Date: Fri, 16 Sep 2016 10:19:51 -0500
Subject: [PATCH v4 22/22] phy: Add support for Qualcomm's USB HS phy
In-Reply-To: <20160907213519.27340-23-stephen.boyd@linaro.org>
References: <20160907213519.27340-1-stephen.boyd@linaro.org>
 <20160907213519.27340-23-stephen.boyd@linaro.org>
Message-ID: <20160916151950.GA31804@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 07, 2016 at 02:35:19PM -0700, Stephen Boyd wrote:
> The high-speed phy on qcom SoCs is controlled via the ULPI
> viewport.
> 
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: <devicetree@vger.kernel.org>
> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
> ---
>  .../devicetree/bindings/phy/qcom,usb-hs-phy.txt    |  83 ++++++
>  drivers/phy/Kconfig                                |   8 +
>  drivers/phy/Makefile                               |   1 +
>  drivers/phy/phy-qcom-usb-hs.c                      | 289 +++++++++++++++++++++
>  4 files changed, 381 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.txt
>  create mode 100644 drivers/phy/phy-qcom-usb-hs.c
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.txt b/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.txt
> new file mode 100644
> index 000000000000..d7eacd63d06b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.txt
> @@ -0,0 +1,83 @@
> +Qualcomm's USB HS PHY
> +
> +PROPERTIES
> +
> +- compatible:
> +    Usage: required
> +    Value type: <string>
> +    Definition: Should contain "qcom,usb-hs-phy" and more specifically one of the
> +                following:
> +
> +                        "qcom,usb-hs-phy-apq8064"
> +                        "qcom,usb-hs-phy-msm8916"
> +                        "qcom,usb-hs-phy-msm8974"

This is fine, but things are usually named <soc>-<ipblock>.

> +
> +- #phy-cells:
> +    Usage: required
> +    Value type: <u32>
> +    Definition: Should contain 0
> +
> +- clocks:
> +    Usage: required
> +    Value type: <prop-encoded-array>
> +    Definition: Should contain clock specifier for the reference and sleep
> +                clocks
> +
> +- clock-names:
> +    Usage: required
> +    Value type: <stringlist>
> +    Definition: Should contain "ref" and "sleep" for the reference and sleep
> +                clocks respectively
> +
> +- resets:
> +    Usage: required
> +    Value type: <prop-encoded-array>
> +    Definition: Should contain the phy and POR resets
> +
> +- reset-names:
> +    Usage: required
> +    Value type: <stringlist>
> +    Definition: Should contain "phy" and "por" for the phy and POR resets
> +                respectively
> +
> +- v3p3-supply:
> +    Usage: required
> +    Value type: <phandle>
> +    Definition: Should contain a reference to the 3.3V supply
> +
> +- v1p8-supply:
> +    Usage: required
> +    Value type: <phandle>
> +    Definition: Should contain a reference to the 1.8V supply
> +
> +- extcon:

I don't recommend using extcon binding. It needs some work to put it 
nicely.

> +    Usage: optional
> +    Value type: <prop-encoded-array>
> +    Definition: Should contain the vbus and ID extcons in the first and second
> +                cells respectively
> +
> +- qcom,init-seq:
> +    Usage: optional
> +    Value type: <u8 array>
> +    Definition: Should contain a sequence of ULPI register and address pairs to
> +                program into the ULPI_EXT_VENDOR_SPECIFIC area. This is related
> +                to Device Mode Eye Diagram test.

We generally nak this type of property. For 1 register I don't care so 
much. For 100, that would be another story.

Is this value per unit, per board, per SoC? Can you limit it to certain 
registers?

> +
> +EXAMPLE
> +
> +otg: usb-controller {
> +	ulpi {
> +		phy {
> +			compatible = "qcom,usb-hs-phy-msm8974", "qcom,usb-hs-phy";
> +			#phy-cells = <0>;
> +			clocks = <&xo_board>, <&gcc GCC_USB2A_PHY_SLEEP_CLK>;
> +			clock-names = "ref", "sleep";
> +			resets = <&gcc GCC_USB2A_PHY_BCR>, <&otg 0>;
> +			reset-names = "phy", "por";
> +			v3p3-supply = <&pm8941_l24>;
> +			v1p8-supply = <&pm8941_l6>;
> +			extcon = <&smbb>, <&usb_id>;
> +			qcom,init-seq = /bits/ 8 <0x81 0x63>;
> +		};
> +	};
> +};
