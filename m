From: robh@kernel.org (Rob Herring)
Date: Tue, 3 Jul 2018 10:51:48 -0600
Subject: [PATCH linux-next v6 04/13] dt-bindings: Add a document of PECI
 adapter driver for ASPEED AST24xx/25xx SoCs
In-Reply-To: <20180621194024.20771-1-jae.hyun.yoo@linux.intel.com>
References: <20180621193721.20588-1-jae.hyun.yoo@linux.intel.com>
 <20180621194024.20771-1-jae.hyun.yoo@linux.intel.com>
Message-ID: <20180703165148.GA11628@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 21, 2018 at 12:40:24PM -0700, Jae Hyun Yoo wrote:
> This commit adds a dt-bindings document of PECI adapter driver for ASPEED
> AST24xx/25xx SoCs.
> 
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> Reviewed-by: Haiyue Wang <haiyue.wang@linux.intel.com>
> Reviewed-by: James Feist <james.feist@linux.intel.com>
> Reviewed-by: Vernon Mauery <vernon.mauery@linux.intel.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Greg KH <gregkh@linuxfoundation.org>
> Cc: Jason M Biils <jason.m.bills@linux.intel.com>
> Cc: Milton Miller II <miltonm@us.ibm.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>  .../devicetree/bindings/peci/peci-aspeed.txt  | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/peci/peci-aspeed.txt
> 
> diff --git a/Documentation/devicetree/bindings/peci/peci-aspeed.txt b/Documentation/devicetree/bindings/peci/peci-aspeed.txt
> new file mode 100644
> index 000000000000..8c35f905589d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/peci/peci-aspeed.txt
> @@ -0,0 +1,57 @@
> +Device tree configuration for PECI buses on the AST24XX and AST25XX SoCs.
> +
> +Required properties:
> +- compatible        : Should be "aspeed,ast2400-peci" or "aspeed,ast2500-peci"
> +		      - aspeed,ast2400-peci: ASPEED AST2400 family PECI
> +					     controller
> +		      - aspeed,ast2500-peci: ASPEED AST2500 family PECI
> +					     controller

Just this is sufficient:

Should be one of: 
	"aspeed,ast2400-peci"
	"aspeed,ast2500-peci"

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +- reg               : Should contain PECI controller registers location and
> +		      length.
> +- #address-cells    : Should be <1> required to define a client address.
> +- #size-cells       : Should be <0> required to define a client address.
> +- interrupts        : Should contain PECI controller interrupt.
> +- clocks            : Should contain clock source for PECI controller. Should
> +		      reference the external oscillator clock in the second
> +		      cell.
> +- resets            : Should contain phandle to reset controller with the reset
> +		      number in the second cell.
> +- clock-frequency   : Should contain the operation frequency of PECI controller
> +		      in units of Hz.
> +		      187500 ~ 24000000
> +
> +Optional properties:
> +- msg-timing        : Message timing negotiation period. This value will
> +		      determine the period of message timing negotiation to be
> +		      issued by PECI controller. The unit of the programmed
> +		      value is four times of PECI clock period.
> +		      0 ~ 255 (default: 1)
> +- addr-timing       : Address timing negotiation period. This value will
> +		      determine the period of address timing negotiation to be
> +		      issued by PECI controller. The unit of the programmed
> +		      value is four times of PECI clock period.
> +		      0 ~ 255 (default: 1)
> +- rd-sampling-point : Read sampling point selection. The whole period of a bit
> +		      time will be divided into 16 time frames. This value will
> +		      determine the time frame in which the controller will
> +		      sample PECI signal for data read back. Usually in the
> +		      middle of a bit time is the best.
> +		      0 ~ 15 (default: 8)
> +- cmd-timeout-ms    : Command timeout in units of ms.
> +		      1 ~ 60000 (default: 1000)
> +
> +Example:
> +	peci0: peci-bus at 0 {
> +		compatible = "aspeed,ast2500-peci";
> +		reg = <0x0 0x60>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		interrupts = <15>;
> +		clocks = <&syscon ASPEED_CLK_GATE_REFCLK>;
> +		resets = <&syscon ASPEED_RESET_PECI>;
> +		clock-frequency = <24000000>;
> +		msg-timing = <1>;
> +		addr-timing = <1>;
> +		rd-sampling-point = <8>;
> +		cmd-timeout-ms = <1000>;
> +	};
> -- 
> 2.17.1
> 
