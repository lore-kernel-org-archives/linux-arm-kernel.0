From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 22 Aug 2017 22:31:57 +0200
Subject: [PATCH 1/3] ARM: dts: sun7i: Fix A20-OLinuXino-MICRO dts for use
 with LAN8710
In-Reply-To: <20170822114313.9038-2-stefan@olimex.com>
References: <20170822114313.9038-1-stefan@olimex.com>
 <20170822114313.9038-2-stefan@olimex.com>
Message-ID: <20170822203157.mvnx224l546vamah@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 22, 2017 at 02:43:11PM +0300, Stefan Mavrodiev wrote:
> From revision J the board uses new phy chip LAN8710. Compared
> with RTL8201, RA17 pin is TXERR. It has pullup which causes phy
> not to work. To fix this, PA17 must be configured output-low.
> 
> This patch is compatible with earlier board revisions, since this
> pin wasn't connected to phy.
> 
> Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
>
> ---
>  arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
> index 0b7403e4d687..578c761b551a 100644
> --- a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
> @@ -102,7 +102,7 @@
>  
>  &gmac {
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&gmac_pins_mii_a>;
> +	pinctrl-0 = <&gmac_pins_mii_a>,<&gmac_txerr_pin>;
>  	phy = <&phy1>;
>  	phy-mode = "mii";
>  	status = "okay";
> @@ -229,6 +229,11 @@
>  };
>  
>  &pio {
> +	gmac_txerr_pin: gmac_txerr_pin at 0 {
> +		pins = "PA17";
> +		function = "gpio_out"
> +	};
> +

You're not enforcing any level doing this. If you're using that pin as
TXERR, why not mux it to the gmac function and let the GMAC control it?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170822/25631a07/attachment.sig>
