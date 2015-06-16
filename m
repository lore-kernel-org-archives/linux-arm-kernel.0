From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 16 Jun 2015 13:37:33 +0200
Subject: [PATCH] ARM: dts: rockchip: Add dmac_bus rx and tx for uart2
In-Reply-To: <1434390468-27296-1-git-send-email-romain.perier@gmail.com>
References: <1434390468-27296-1-git-send-email-romain.perier@gmail.com>
Message-ID: <34159914.9nlETdacuk@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am Montag, 15. Juni 2015, 17:47:48 schrieb Romain Perier:
> This removes warning "ttyS2 - Failed to request dma" from kernel logs
> 
> Signed-off-by: Romain Perier <romain.perier@gmail.com>
> ---
>  arch/arm/boot/dts/rk3288.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
> index 22316d0..816f40a 100644
> --- a/arch/arm/boot/dts/rk3288.dtsi
> +++ b/arch/arm/boot/dts/rk3288.dtsi
> @@ -385,6 +385,8 @@
>  		clock-names = "baudclk", "apb_pclk";
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&uart2_xfer>;
> +		dmas = <&dmac_bus_s 4>, <&dmac_bus_s 5>;
> +		dma-names = "tx", "rx";
>  		status = "disabled";
>  	};

The dma channels are a property of the hardware, so we probably should add 
them for all uarts in one go, instead of everytime something complains :-)

in dmac_peri
uart0: tx 1, rx 2
uart1: tx 3, rx 4
uart3: tx 7, rx 8
uart4: tx 9, rx 10


Just for the record and if anybody is interested to work in this, we have an 
issue with the dma implementation [0] that is not yet solved upstream. From 
what I've remember, that mostly got triggered on higher speeds, like higher 
spi-speeds or i2s audio stuff (poping).


Heiko

[0] 
https://chromium.googlesource.com/chromiumos/third_party/kernel/+/93c3b192dca7e8c773c4d28873114c325382b63e%5E%21/#F0
