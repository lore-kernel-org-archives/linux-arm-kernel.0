From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 30 Aug 2017 16:37:28 +0200
Subject: [PATCH v2 1/2] ARM: dts: sun7i: Fix A20-OLinuXino-MICRO dts for
 LAN8710
In-Reply-To: <1503901963-9457-2-git-send-email-stefan@olimex.com>
References: <1503901963-9457-1-git-send-email-stefan@olimex.com>
 <1503901963-9457-2-git-send-email-stefan@olimex.com>
Message-ID: <20170830143728.friajjequvioqjpu@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Aug 28, 2017 at 09:32:42AM +0300, Stefan Mavrodiev wrote:
> From revision J the board uses new phy chip LAN8710. Compared
> with RTL8201, RA17 pin is TXERR. It has pullup which causes phy
> not to work. To fix this PA17 is muxed with GMAC function. This
> makes the pin output-low.
> 
> This patch is compatible with earlier board revisions, since this
> pin wasn't connected to phy.
> 
> Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
> ---
>  arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
> index 0b7403e..cb1b081 100644
> --- a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
> @@ -102,7 +102,7 @@
>  
>  &gmac {
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&gmac_pins_mii_a>;
> +	pinctrl-0 = <&gmac_pins_mii_a>,<&gmac_txerr>;
>  	phy = <&phy1>;
>  	phy-mode = "mii";
>  	status = "okay";
> @@ -229,6 +229,11 @@
>  };
>  
>  &pio {
> +	gmac_txerr: gmac_txerr at 0 {
> +		pins = "PA17";
> +		function = "gmac";
> +	};
> +

The patch looks fine, I still have one question though.

Can a PHY operate without this signal? My real question is, would it
make sense to mux that pin for all the users, or is it an optional
signal that each board designer can choose to use or not?

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170830/5c95924a/attachment.sig>
