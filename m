From: yixun.lan@amlogic.com (Yixun Lan)
Date: Thu, 26 Jul 2018 22:41:51 +0800
Subject: [PATCH] arm64: dts: meson: Switch simple-mfd and syscon order
In-Reply-To: <1532614438-7207-1-git-send-email-narmstrong@baylibre.com>
References: <1532614438-7207-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <494ff778-1888-7743-3a91-62364431d82e@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI Neil

On 07/26/2018 10:13 PM, Neil Armstrong wrote:
> The order between "syscon" and "simple-mfd" is important because in these
> particular cases, the node needs to be first a "simple-mfd" to expose
> it's sub-nodes, and later on a "syscon" to permit other nodes to access
> this register space through the "syscon" mechanism.
> 

could you explain a bit which specific case that it need compatible
"simple-mfd" come first? is this a problem in kernel side? because I see
you have a comment below about problem in U-Boot..


also while Rob review the mmc-clkc patch, he raise a suggestion to  drop
"syscon" in drivers/mfd/syscon.c, see [1], will that solve or affect
your problem?

[1]
https://lkml.kernel.org/r/CAL_Jsq+r+7BaJAPBn3L26sdxATVyDiuC=V3xE+yz0-27q0RJhA at mail.gmail.com

> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
> This also has a consequence for U-Boot since the U-Boot DM is much simpler
> and can only associate a single device to a node, thus here we want these
> nodes to be an mfd bus to be able to probe the sub-nodes.
> 
>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 4 ++--
>  arch/arm64/boot/dts/amlogic/meson-gx.dtsi  | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> index 6adc8d3..3f0de9d 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> @@ -342,7 +342,7 @@
>  			ranges = <0x0 0x0 0x0 0xff63c000 0x0 0x1c00>;
>  
>  			sysctrl: system-controller at 0 {
> -				compatible = "amlogic,meson-axg-hhi-sysctrl", "syscon", "simple-mfd";
> +				compatible = "amlogic,meson-axg-hhi-sysctrl", "simple-mfd", "syscon";
>  				reg = <0 0 0 0x400>;
>  
>  				clkc: clock-controller {
> @@ -1180,7 +1180,7 @@
>  			ranges = <0x0 0x0 0x0 0xff800000 0x0 0x100000>;
>  
>  			sysctrl_AO: sys-ctrl at 0 {
> -				compatible = "amlogic,meson-axg-ao-sysctrl", "syscon", "simple-mfd";
> +				compatible = "amlogic,meson-axg-ao-sysctrl", "simple-mfd", "syscon";
>  				reg =  <0x0 0x0 0x0 0x100>;
>  
>  				clkc_AO: clock-controller {
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> index b8dc4db..d88699f 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> @@ -344,7 +344,7 @@
>  			ranges = <0x0 0x0 0x0 0xc8100000 0x0 0x100000>;
>  
>  			sysctrl_AO: sys-ctrl at 0 {
> -				compatible = "amlogic,meson-gx-ao-sysctrl", "syscon", "simple-mfd";
> +				compatible = "amlogic,meson-gx-ao-sysctrl", "simple-mfd", "syscon";
>  				reg =  <0x0 0x0 0x0 0x100>;
>  
>  				pwrc_vpu: power-controller-vpu {
> @@ -431,7 +431,7 @@
>  			ranges = <0x0 0x0 0x0 0xc883c000 0x0 0x2000>;
>  
>  			sysctrl: system-controller at 0 {
> -				compatible = "amlogic,meson-gx-hhi-sysctrl", "syscon", "simple-mfd";
> +				compatible = "amlogic,meson-gx-hhi-sysctrl", "simple-mfd", "syscon";
>  				reg = <0 0 0 0x400>;
>  			};
>  
> 
