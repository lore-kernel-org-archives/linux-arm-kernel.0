From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 29 Nov 2013 20:37:15 +0100
Subject: [PATCH RFC 08/10] net: stmmac:sti: Add STi SOC glue driver.
In-Reply-To: <1384264383-7653-1-git-send-email-srinivas.kandagatla@st.com>
References: <1384264311-7308-1-git-send-email-srinivas.kandagatla@st.com>
 <1384264383-7653-1-git-send-email-srinivas.kandagatla@st.com>
Message-ID: <20131129193715.GA3441@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Srinivas,

On Tue, Nov 12, 2013 at 01:53:03PM +0000, srinivas.kandagatla at st.com wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@st.com>
> 
> STi series SOCs have a glue layer on top of the synopsis gmac IP, this
> glue layer needs to be configured before the gmac driver starts using
> the IP.
> 
> This patch adds a platform driver for the glue layer which configures
> the IP before stmmac driver takes over.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
> ---
>  .../devicetree/bindings/net/sti-dwmac.txt          |   45 +++
>  drivers/net/ethernet/stmicro/stmmac/Makefile       |    1 +
>  drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c    |  294 ++++++++++++++++++++
>  3 files changed, 340 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/sti-dwmac.txt
>  create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c
> 
> diff --git a/Documentation/devicetree/bindings/net/sti-dwmac.txt b/Documentation/devicetree/bindings/net/sti-dwmac.txt
> new file mode 100644
> index 0000000..5431d9d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/sti-dwmac.txt
> @@ -0,0 +1,45 @@
> +STMicroelectronics SoC DWMAC controller
> +
> +The device node has following properties.
> +
> +Required properties:
> + - compatible	: Can be "st,stih415-dwmac", "st,stih416-dwmac" or
> +   "st,stid127-dwmac".
> + - reg		: Offset of the glue configuration register map in system
> +   configuration regmap pointed by st,syscon property and size.
> + - st,syscon	: Should be phandle to system configuration node which
> +   encompases this glue registers.
> + - st,tx-retime-src: This specifies which clk is wired up to the mac for
> +   retimeing tx lines. This is totally board dependent and can take one of the
> +   posssible values from "txclk", "clk_125", "phyclk" or "clkgen".
> +
> +Optional properties:
> + - resets	: phandle pointing to the system reset controller with correct
> +   reset line index for ethernet reset.
> +
> +Sub-nodes:
> +The dwmac core should be added as subnode to STMicroelectronics dwmac glue.
> +- dwmac :	The binding details of dwmac can be found in
> +  Documentation/devicetree/bindings/net/stmmac.txt
> +
> +Example:
> +
> +ethernet0: ethernet0{
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	compatible		= "st,stih415-dwmac";
> +	reg			= <0x148 0x4>;
> +	resets			= <&softreset STIH415_ETH0_SOFTRESET>;
> +	st,syscon		= <&syscfg_rear>;
> +	st,tx-retime-src	= "clk_125";
> +	ranges;
> +
> +	dwmac0:dwmac at fe810000 {
> +		device_type 	= "network";
> +		compatible	= "snps,dwmac", "snps,dwmac-3.610";
> +		reg 		= <0xfe810000 0x8000>;
> +		interrupts 	= <0 147 0>;
> +		interrupt-names = "macirq";
> +		...
> +	};
> +};

Sorry for stepping up so late, but I dont' think this is the right way
to do it.

DT is to describe how the hardware is laid out in a system agnostic
way, hence, it should not be impacted by the implementation details.

The fact that you use a glue to the dwmac driver *is* an
implementation detail.

I think you'd rather have something like:

dwmac0: ethernet at fe810000 {
	compatible		= "st,stih415-dwmac";
	reg 			= <0xfe810000 0x8000 0x148 0x4>;
	resets			= <&softreset STIH415_ETH0_SOFTRESET>;
	st,syscon		= <&syscfg_rear>;
	st,tx-retime-src	= "clk_125";
	interrupts 		= <0 147 0>;
	interrupt-names 	= "macirq";
	...
};

Then, the driver can have its init functions associated to the
compatible you're using, through the .data field of the of_device_id
structure, and you just call it in the generic driver at probe's time.


I don't really know what this syscon thing is either, but I think the
reg <0x148 0x4> is related to that.

Why don't you pass it directly in the st,syscon property, to have
something like <&syscfg_rear 0x148>?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131129/d5c007b0/attachment.sig>
