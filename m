From: b.brezillon@overkiz.com (boris brezillon)
Date: Mon, 18 Nov 2013 09:39:23 +0100
Subject: [PATCH 2/9] ARM: at91/dt: add ethernet phy to at91rm9200ek board
In-Reply-To: <1377687819-10653-1-git-send-email-b.brezillon@overkiz.com>
References: <1377687640-10529-1-git-send-email-b.brezillon@overkiz.com>
 <1377687819-10653-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <5289D23B.6090101@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/08/2013 13:03, Boris BREZILLON wrote:
> Add ethernet phy node in at91rm9200ek.dts.
> The reg register is not specified, as it may differ depending on the init
> process of the board:
> ADDR0/1 phy pins are connected to PA13/14 rm9200 pins. Which means the phy
> will take its address from these pins during the reset process.
>
> The macb driver will launch a full scan on the mdio bus to discover the phy
> address.
>
> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
> ---
>   arch/arm/boot/dts/at91rm9200ek.dts |    5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/boot/dts/at91rm9200ek.dts b/arch/arm/boot/dts/at91rm9200ek.dts
> index d2d72c3..37b0880 100644
> --- a/arch/arm/boot/dts/at91rm9200ek.dts
> +++ b/arch/arm/boot/dts/at91rm9200ek.dts
> @@ -47,6 +47,11 @@
>   			macb0: ethernet at fffbc000 {
>   				phy-mode = "rmii";
>   				status = "okay";
> +
> +				phy0: ethernet-phy {
> +					interrupt-parent = <&pioC>;
> +					interrupts = <4 IRQ_TYPE_EDGE_FALLING>;

rm9200 pio controller does not support specific edge detection.
The line above should be replaced with:
				interrupts = <4 IRQ_TYPE_EDGE_BOTH>;
or
				interrupts = <4 0>;

Nicolas, I know you were planning to push this patch for 3.14.
If you haven't done it yet (or if you changed your mind), I can send a 
new version including this fix.


> +				};
>   			};
>
>   			usb1: gadget at fffb0000 {
>
