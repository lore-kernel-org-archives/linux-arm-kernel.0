From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 10 Jun 2013 15:52:07 +0200
Subject: [PATCH v2 07/11] ARM:stixxxx: Add STiH416 SOC support
In-Reply-To: <1370856425-7135-1-git-send-email-srinivas.kandagatla@st.com>
References: <1370855828-5318-1-git-send-email-srinivas.kandagatla@st.com>
 <1370856425-7135-1-git-send-email-srinivas.kandagatla@st.com>
Message-ID: <3733079.FxbR14kFrs@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 10 June 2013 10:27:05 Srinivas KANDAGATLA wrote:

> +	soc {
> +		pin-controller-sbc {
> +			#address-cells	= <1>;
> +			#size-cells	= <1>;
> +			compatible	= "st,stih416-pinctrl", "simple-bus";

Why is this both its own device with a compatible string and a
"simple-bus" at the same time? Wouldn't it be simpler to just
scan the child device nodes from the "st,stih416-pinctrl"
driver instead of having a separate platform_driver for them?

> +			st,retime-in-delay	= <0 300 500 750 1000 1250 1500 1750 2000 2250 2500 2750 3000 3250>;
> +			st,retime-out-delay	= <0 300 500 750 1000 1250 1500 1750 2000 2250 2500 2750 3000 3250>;
> +			st,syscfg		= <&syscfg_sbc>;
> +			st,syscfg-offsets	= <0 40 50 60 100>;
> +			ranges;
> +			PIO0: pinctrl at fe610000 {
> +				#gpio-cells = <1>;
> +				compatible = "st,stixxxx-gpio";
> +				gpio-controller;
> +				reg = <0xfe610000 0x100>;
> +				st,bank-name  = "PIO0";
> +				st,retime-pin-mask = <0xff>;
> +			};
> +			PIO1: pinctrl at fe611000 {
> +				#gpio-cells	= <1>;
> +				compatible	= "st,stixxxx-gpio";
> +				gpio-controller;
> +				reg = <0xfe611000 0x100>;
> +				st,bank-name  = "PIO1";
> +				st,retime-pin-mask = <0xff>;
> +			};

What is in the ranges between these registers? It seems you have
256 bytes for each pinctrl node, with 4kb spacing. I wonder if
it would make sense to declare the entire range to belong to a single
pinctrl device. At least since all of the registers are in a single
range, you could add a property like

	ranges = <0 0xfe610000 0x10000>;

and use relative addresses in the sub-nodes.

Please don't use identifiers with 'xxx' in them. Instead use numbers
of actual chips, ideally using the first one that this is compatible
with.

> +		syscfg_sbc:syscfg at fe600000{
> +			compatible	= "st,stih416-syscfg";
> +			reg		= <0xfe600000 0x1000>;
> +			syscfg-range	= <0 999>;
> +			syscfg-name	= "SYSCFG_SBC";
> +		};
> +		syscfg_front:syscfg at fee10000{
> +			compatible	= "st,stih416-syscfg";
> +			reg		= <0xfee10000 0x1000>;
> +			syscfg-range	= <1000 999>;
> +			syscfg-name	= "SYSCFG_FRONT";
> +		};

Did you mean to declare ranges excluding 1000 and 2000 here?
Normally I would expect inclusive ranges like syscfg-range=<0 1000>;

What is the idea of the 'syscfg-name'? If the nodes are all different,
I would expect them to have distinct "compatible" values and not
need them.

	Arnd
