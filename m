From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 11 May 2018 17:03:22 +0200
Subject: [PATCH v2 03/12] arm: dts: mt7623: fix invalid memory node being
 generated
In-Reply-To: <d887b72e1839c7e476179e384cfc712216096f20.1523434758.git.sean.wang@mediatek.com>
References: <cover.1523434757.git.sean.wang@mediatek.com>
 <d887b72e1839c7e476179e384cfc712216096f20.1523434758.git.sean.wang@mediatek.com>
Message-ID: <4dcb0435-1f98-0753-0feb-d17ad02077ae@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/11/2018 10:53 AM, sean.wang at mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Below two wrong nodes in existing DTS files would cause a fail boot since
> in fact the address 0 is not the correct place the memory device locates
> at.
> 
> memory {
>         device_type = "memory";
>         reg = <0x0 0x0 0x0 0x0>;
> };
> 
> memory at 80000000 {
>         reg = <0x0 0x80000000 0x0 0x40000000>;
> };
> 
> In order to avoid having a memory node starting at address 0, we can't
> include file skeleton64.dtsi and instead need to explicitly manually
> define a few of properties the DTS relies on such as #address-cells
> and #size-cells in root node and device_type in the node memory at 80000000.
> 
> Cc: stable at vger.kernel.org
> Fixes: 31ac0d69a1d4 ("ARM: dts: mediatek: add MT7623 basic support")
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> ---
>  arch/arm/boot/dts/mt7623.dtsi                 | 3 ++-
>  arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts | 1 +
>  arch/arm/boot/dts/mt7623n-rfb.dtsi            | 1 +
>  3 files changed, 4 insertions(+), 1 deletion(-)
> 

merged. We would need this at least for mt2701 as well, correct?
Would you mind to provide a patch.

Regards,
Matthias

> diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
> index fec4715..406a9f3 100644
> --- a/arch/arm/boot/dts/mt7623.dtsi
> +++ b/arch/arm/boot/dts/mt7623.dtsi
> @@ -15,11 +15,12 @@
>  #include <dt-bindings/phy/phy.h>
>  #include <dt-bindings/reset/mt2701-resets.h>
>  #include <dt-bindings/thermal/thermal.h>
> -#include "skeleton64.dtsi"
>  
>  / {
>  	compatible = "mediatek,mt7623";
>  	interrupt-parent = <&sysirq>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
>  
>  	cpu_opp_table: opp-table {
>  		compatible = "operating-points-v2";
> diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> index bbf56f8..5938e4c 100644
> --- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> +++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> @@ -109,6 +109,7 @@
>  	};
>  
>  	memory at 80000000 {
> +		device_type = "memory";
>  		reg = <0 0x80000000 0 0x40000000>;
>  	};
>  };
> diff --git a/arch/arm/boot/dts/mt7623n-rfb.dtsi b/arch/arm/boot/dts/mt7623n-rfb.dtsi
> index a199ae7..343e8ef 100644
> --- a/arch/arm/boot/dts/mt7623n-rfb.dtsi
> +++ b/arch/arm/boot/dts/mt7623n-rfb.dtsi
> @@ -40,6 +40,7 @@
>  	};
>  
>  	memory at 80000000 {
> +		device_type = "memory";
>  		reg = <0 0x80000000 0 0x40000000>;
>  	};
>  
> 
