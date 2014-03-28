From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 28 Mar 2014 11:11:46 +0100
Subject: [PATCH v3 08/10] ARM: sun7i/sun4i: dt: Add AXP209 support to
 various boards
In-Reply-To: <1395955764-18103-9-git-send-email-carlo@caione.org>
References: <1395955764-18103-1-git-send-email-carlo@caione.org>
 <1395955764-18103-9-git-send-email-carlo@caione.org>
Message-ID: <20140328101146.GP6120@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 27, 2014 at 10:29:22PM +0100, Carlo Caione wrote:
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Carlo Caione <carlo@caione.org>
> ---
>  arch/arm/boot/dts/sun4i-a10-a1000.dts           | 13 +++++++++++++
>  arch/arm/boot/dts/sun4i-a10-cubieboard.dts      | 13 +++++++++++++
>  arch/arm/boot/dts/sun4i-a10-hackberry.dts       | 19 +++++++++++++++++++
>  arch/arm/boot/dts/sun4i-a10-inet97fv2.dts       | 13 +++++++++++++
>  arch/arm/boot/dts/sun4i-a10-mini-xplus.dts      | 19 +++++++++++++++++++
>  arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts  | 19 +++++++++++++++++++
>  arch/arm/boot/dts/sun4i-a10-pcduino.dts         | 13 +++++++++++++
>  arch/arm/boot/dts/sun7i-a20-cubieboard2.dts     | 14 ++++++++++++++
>  arch/arm/boot/dts/sun7i-a20-cubietruck.dts      | 15 +++++++++++++++
>  arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts | 14 ++++++++++++++
>  10 files changed, 152 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun4i-a10-a1000.dts b/arch/arm/boot/dts/sun4i-a10-a1000.dts
> index fa746aea..cf18c4d 100644
> --- a/arch/arm/boot/dts/sun4i-a10-a1000.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-a1000.dts
> @@ -88,6 +88,19 @@
>  			pinctrl-names = "default";
>  			pinctrl-0 = <&i2c0_pins_a>;
>  			status = "okay";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			axp: axp20x at 34 {
> +				reg = <0x34>;
> +				interrupts = <0>;
> +
> +				compatible = "x-powers,axp209";
> +				interrupt-controller;
> +				#interrupt-cells = <1>;
> +
> +				/include/ "x-powers-axp209.dtsi"
> +			};
>  		};
>  	};

Actually, you can make the whole thing much more robust by using the
&label syntax.

Here, you would just include the dtsi at the top of the file, and in
the DTSI, you would have something like:

&axp209 {
   regulators {
      ...
   }
}

(Given that the node in your DTS is axp209: pmic at something like
Chen-Yu suggested)

You don't rely any more on the position of the include, and you use a
standard DT syntax.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140328/a64d1732/attachment.sig>
