From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 11 Apr 2016 12:25:19 -0700
Subject: [PATCH RFC 5/5] ARM: dts: sun8i: Enable Ethernet controller on
 the Orange PI PC
In-Reply-To: <1459786954-12649-6-git-send-email-wens@csie.org>
References: <1459786954-12649-1-git-send-email-wens@csie.org>
 <1459786954-12649-6-git-send-email-wens@csie.org>
Message-ID: <570BFA1F.2040601@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/04/16 09:22, Chen-Yu Tsai wrote:
> The Orange PI PC uses the H3's internal Ethernet PHY with the EMAC
> Ethernet controller.
> 
> Set a proper address for the PHY and enable the EMAC.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
> 
> This patch depends on "ARM: dts: sun8i-h3: Add Ethernet controller device",
> which uses an binding still in development.
> 
> Do not merge.
> 
> ---
>  arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
> index daf50b9a6657..f01e10df812a 100644
> --- a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
> +++ b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
> @@ -102,6 +102,20 @@
>  	status = "okay";
>  };
>  
> +&ephy {
> +	allwinner,ephy-addr = <0x1>;
> +};
> +
> +&emac {
> +	phy = <&phy1>;
> +	phy-mode = "mii";
> +	status = "okay";
> +
> +	phy1: ethernet-phy at 1 {
> +		reg = <1>;
> +	};
> +};

As commented in patch 1, the fact that you have to put the Ethernet PHY
address twice here is not really a good thing, because they cannot be
dissociated from eath other, I would rather have a standard Ethernet PHY
DT node represent the desired PHY address, and have your glue/SHIM
SUN8I_H3_EMAC driver scan the Device Tree to know what address to
program for the Ethernet PHY.
-- 
Florian
