From: lars@metafoo.de (Lars-Peter Clausen)
Date: Mon, 12 Feb 2018 19:24:22 +0100
Subject: [PATCH v2 3/5] [RFT] ARM: dts: wheat: Fix ADV7513 address usage
In-Reply-To: <1518459117-16733-4-git-send-email-kbingham@kernel.org>
References: <1518459117-16733-1-git-send-email-kbingham@kernel.org>
 <1518459117-16733-4-git-send-email-kbingham@kernel.org>
Message-ID: <bc0dfd28-652a-80e7-a08b-6909b0e34883@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/12/2018 07:11 PM, Kieran Bingham wrote:
[...]
> +	/*
> +	 * The adv75xx resets its addresses to defaults during low power power
> +	 * mode. Because we have two ADV7513 devices on the same bus, we must
> +	 * change both of them away from the defaults so that they do not
> +	 * conflict.
> +	 */
>  	hdmi at 3d {
>  		compatible = "adi,adv7513";
> -		reg = <0x3d>;
> +		reg = <0x3d 0x2d 0x4d, 0x5d>;

To have the correct semantics this should be:
		reg = <0x3d>, <0x2d>, <0x4d>, <0x5d>;

It is a set of 4 single cell addresses. The other thing is a single 4 cell
address. It will get compiled to the same bytes, but the DT tools should
complain about it, because it doesn't match #address-cells.

> +		reg-names = "main", "cec", "edid", "packet";
>  
>  		adi,input-depth = <8>;
>  		adi,input-colorspace = "rgb";
> @@ -272,7 +279,8 @@
>  
>  	hdmi at 39 {
>  		compatible = "adi,adv7513";
> -		reg = <0x39>;
> +		reg = <0x39 0x29 0x49, 0x59>;

Same here.

> +		reg-names = "main", "cec", "edid", "packet";
>  
>  		adi,input-depth = <8>;
>  		adi,input-colorspace = "rgb";
> 
