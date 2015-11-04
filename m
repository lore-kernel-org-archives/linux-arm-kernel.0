From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 5 Nov 2015 00:34:47 +0100
Subject: [PATCH 1/4] ARM: dts: kirkwood: add Linksys EA4500
In-Reply-To: <00000150d49a7cf7-e97bf540-89ce-49bf-a25e-2d082acab273-000000@email.amazonses.com>
References: <00000150d49a7cf7-e97bf540-89ce-49bf-a25e-2d082acab273-000000@email.amazonses.com>
Message-ID: <20151104233447.GB8263@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 82d2ac9..264f8ba 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -124,6 +124,7 @@ lantiq	Lantiq Semiconductor
>  lenovo	Lenovo Group Ltd.
>  lg	LG Corporation
>  linux	Linux-specific binding
> +linksys	Belkin International, Inc.
>  lsi	LSI Corp. (LSI Logic)
>  lltc	Linear Technology Corporation
>  marvell	Marvell Technology Group Ltd.

Hi Luka

This part should probably be a patch of its own, sent to the DT
maintainers.

> +/ {
> +	model = "Linksys EA4500";
> +	compatible = "linksys,ea4500", "marvell,kirkwood-88f6282", "marvell,kirkwood";
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x00000000 0x8000000>;
> +	};
> +
> +	chosen {
> +		bootargs = "console=ttyS0,115200n8 earlyprintk";

Please use stdout-path = &uart0; You can also put the baud rate etc on
the end.

> +&nand {
> +	status = "okay";
> +	pinctrl-0 = <&pmx_nand>;
> +	pinctrl-names = "default";
> +
> +	partition at 0 {
> +		label = "u-boot";
> +		reg = <0x0000000 0x80000>;
> +	};
> +
> +	partition at 80000 {
> +		label = "u-boot environment";
> +		reg = <0x80000 0x20000>;
> +	};

Is there a hole here?

> +
> +	partition at 200000 {
> +		label = "kernel";
> +		reg = <0x200000 0x200000>;
> +	};
> +
> +	partition at 400000 {
> +		label = "root";
> +		reg = <0x400000 0x1c00000>;
> +	};
> +};

> +&eth0 {
> +	status = "okay";
> +	ethernet0-port at 0 {
> +		speed = <1000>;
> +		duplex = <1>;
> +	};
> +};
> +
> +&eth1 {
> +	status = "okay";
> +	ethernet1-port at 0 {
> +		speed = <1000>;
> +		duplex = <1>;
> +	};
> +};

Why fix the speed? Are they connected to a switch?

    Andrew
