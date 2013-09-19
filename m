From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 19 Sep 2013 18:11:09 +0400
Subject: [RFC PATCH 15/15] arm: dts: dra7: add sata node
In-Reply-To: <1379597059-15405-1-git-send-email-rogerq@ti.com>
References: <1379595943-14622-1-git-send-email-rogerq@ti.com>
 <1379597059-15405-1-git-send-email-rogerq@ti.com>
Message-ID: <523B05FD.7020200@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 09/19/2013 05:24 PM, Roger Quadros wrote:

> From: Balaji T K <balajitk@ti.com>

> Add support for sata controller.

> [Roger Q] Clean up.

> CC: Benoit Cousson <bcousson@baylibre.com>
> Signed-off-by: Balaji T K <balajitk@ti.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>   arch/arm/boot/dts/dra7.dtsi |   49 +++++++++++++++++++++++++++++++++++++++++++
>   1 files changed, 49 insertions(+), 0 deletions(-)

> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> index ce9a0f0..545545d 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -426,6 +426,55 @@
>   			dma-names = "tx", "rx";
>   		};
>
> +		omap_control_sata: control-phy at 4a002374 {
> +			compatible = "ti,control-phy-pipe3";
> +			reg = <0x4a002374 0x4>;
> +			reg-names = "power";
> +			clocks = <&sys_clkin1>;
> +			clock-names = "sysclk";
> +		};
> +
> +		ocp2scp3: ocp2scp3 at 4a090000 {
> +			compatible = "ti,omap-ocp2scp";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +			ti,hwmods = "ocp2scp3";
> +			reg = <0x4a090000 0x1f>; /* ocp2scp3 */
> +			reg-names = "ocp2scp3";
> +			sata_phy: sataphy at 4A096000 {

    It's better to name the PHY nodes uniformly after already standard 
"ethernet-phy" and your "control-phy".

> +				compatible = "ti,phy-pipe3-sata";
> +				reg = <0x4A096000 0x80>, /* phy_rx */
> +				      <0x4A096400 0x64>, /* phy_tx */
> +				      <0x4A096800 0x40>; /* pll_ctrl */
> +				reg-names = "phy_rx", "phy_tx", "pll_ctrl";
> +				ctrl-module = <&omap_control_sata>;
> +				clocks = <&sata_ref_clk>,
> +					 <&sys_clkin1>;
> +				clock-names = "optclk", "sysclk";
> +				#phy-cells = <0>;
> +			};
> +		};
> +
> +		sata: sata at 4a141100 {
> +			compatible = "ti,sata";
> +			ti,hwmods = "sata";
> +			reg = <0x4a141100 0x7>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +			dwc-ahci at 4a140000 {

    Hm, ePAPR spec. [1] says that "the name of a node should be somewhat 
generic, reflecting the function of the device and not its precise programming 
model", so it looks like the name should be "sata" as well. I'm a bit at a 
loss here, not sure why you had to use the nested device nodes.

> +				  compatible = "snps,dwc-ahci";
> +				  reg = <0x4a140000 0x1100>;
> +				  interrupts = <0 54 0x4>;
> +				  phys = <&sata_phy>;

    Hm, it's the third PHY related generic property I'm encountering. First, 
there was "phy-handle", then "phy", now "phys"... Seems like a bit too much. :-)

> +				  phy-names = "sata-phy";
> +				  clocks = <&sata_ref_clk>;
> +				  clock-names = "optclk";
> +			};
> +		};

[1] http://www.power.org/resources/downloads/Power_ePAPR_APPROVED_v1.0.pdf
