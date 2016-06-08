From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 9 Jun 2016 00:03:14 +0200
Subject: [PATCH 7/7] ARM: dts: sun7i: Enable NAND on Wexler TAB7200
In-Reply-To: <1465208664-9366-8-git-send-email-mamlinav@gmail.com>
References: <1465208664-9366-1-git-send-email-mamlinav@gmail.com>
 <1465208664-9366-8-git-send-email-mamlinav@gmail.com>
Message-ID: <20160608220314.GL14179@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jun 06, 2016 at 01:24:24PM +0300, Aleksei Mamlin wrote:
> Enable the NFC and describe the NAND flash connected to this controller.
> 
> Signed-off-by: Aleksei Mamlin <mamlinav@gmail.com>
> ---
>  arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts | 41 ++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts b/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts
> index 2f6b21a..42aff91 100644
> --- a/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts
> @@ -159,6 +159,47 @@
>  	status = "okay";
>  };
>  
> +&nfc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&nand_pins_a>, <&nand_cs0_pins_a>, <&nand_rb0_pins_a>;
> +	status = "okay";
> +
> +	nand at 0 {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		reg = <0>;
> +		allwinner,rb = <0>;
> +
> +		nand-ecc-mode = "hw";
> +		nand-on-flash-bbt;
> +
> +		boot0 at 0 {
> +			label = "boot0";
> +			reg = /bits/ 64 <0x0 0x200000>;
> +		};
> +
> +		boot0-rescue at 200000 {
> +			label = "boot0-rescue";
> +			reg = /bits/ 64 <0x200000 0x200000>;
> +		};
> +
> +		uboot at 400000 {
> +			label = "uboot";
> +			reg = /bits/ 64 <0x400000 0x200000>;
> +		};
> +
> +		uboot-rescue at 600000 {
> +			label = "uboot-rescue";
> +			reg = /bits/ 64 <0x600000 0x200000>;
> +		};
> +
> +		main at 800000 {
> +			label = "main";
> +			reg = /bits/ 64 <0x800000 0xff800000>;
> +		};
> +	};
> +};

This feels a bit premature. The two boards you're using have an MLC
NAND which is not supported yet. Until there's proper MLC support in
the kernel, I'm not sure we want to enable that for end-users when we
know that things will get wrong.

However, after discussing this with Boris, I appreciate that we don't
have any example available because of this policy for people that want
to opt-in anyway.

What we could do is to still mark the status as disabled in the DTS,
with a big fat warning as comment just before, so that it requires
user action, and that user will have been warned.

Would that work for you?
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160609/23129dab/attachment.sig>
