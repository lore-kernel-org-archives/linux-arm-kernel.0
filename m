From: robherring2@gmail.com (Rob Herring)
Date: Tue, 04 Sep 2012 07:58:20 -0500
Subject: [PATCH 10/11] ARM: vexpress: Add config bus components and clocks
 to DTs
In-Reply-To: <1346689531-7212-11-git-send-email-pawel.moll@arm.com>
References: <1346689531-7212-1-git-send-email-pawel.moll@arm.com>
 <1346689531-7212-11-git-send-email-pawel.moll@arm.com>
Message-ID: <5045FAEC.6030906@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/03/2012 11:25 AM, Pawel Moll wrote:
> Add description of all functions provided by Versatile Express
> motherboard and daughterboards configuration controllers and
> clock dependencies between devices.
> 
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> ---
>  arch/arm/boot/dts/vexpress-v2m-rs1.dtsi     |  136 ++++++++++++++++++++-
>  arch/arm/boot/dts/vexpress-v2m.dtsi         |  136 ++++++++++++++++++++-
>  arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts |  103 ++++++++++++++++
>  arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts  |  169 +++++++++++++++++++++++++++
>  arch/arm/boot/dts/vexpress-v2p-ca5s.dts     |   71 +++++++++++
>  arch/arm/boot/dts/vexpress-v2p-ca9.dts      |  121 +++++++++++++++++++
>  6 files changed, 732 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi b/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
> index d8a827b..9cc2a56 100644
> --- a/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
> +++ b/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
> @@ -72,14 +72,20 @@
>  			#size-cells = <1>;
>  			ranges = <0 3 0 0x200000>;
>  
> -			sysreg at 010000 {
> +			v2m_sysreg: sysreg at 010000 {
>  				compatible = "arm,vexpress-sysreg";
>  				reg = <0x010000 0x1000>;
> +				gpio-controller;
> +				#gpio-cells = <2>;
>  			};
>  
> -			sysctl at 020000 {
> +			v2m_sysctl: sysctl at 020000 {
>  				compatible = "arm,sp810", "arm,primecell";
>  				reg = <0x020000 0x1000>;
> +				clocks = <&v2m_refclk32khz>, <&v2m_refclk1mhz>, <&v2m_osc_clk0>;
> +				clock-names = "refclk", "timclk", "apb_pclk";

See Documentation/devicetree/bindings/arm/primecell.txt

apb_pclk should be first in the list.

Rob
