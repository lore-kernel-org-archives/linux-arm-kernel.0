From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Sun, 28 Jun 2015 00:08:05 +0200
Subject: [PATCH] ARM: BCM5301X: Enable UART0 for SmartRG SR-400AC
In-Reply-To: <1435103504-28592-1-git-send-email-f.fainelli@gmail.com>
References: <1435103504-28592-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <CACna6rzJE8Gzrwvj+nCw=qCRho=6nZ+k1h_tFQLhNZvf5zWTDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 June 2015 at 01:51, Florian Fainelli <f.fainelli@gmail.com> wrote:
> Enable the use of UART0 by overriding its default status property.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts b/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
> index d6a033b97c70..64a5e8ab65e0 100644
> --- a/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
> +++ b/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
> @@ -118,3 +118,7 @@
>                 };
>         };
>  };
> +
> +&uart0 {
> +       status = "okay";
> +};

We have many more changes like this in OpenWrt, I just didn't upstream
them because of current chipcommonA state.

It was added before we got "brcm,bus-axi" and I believe Hauke wanted
move it to the "correct" place at some point. Since UART is part of
ChipCommon device and ChipCommon is part of "brcm,bus-axi",.I guess we
should add UARTs as a ChipCommon device subnodes. We already have
chipcommon: chipcommon at 0 {
        reg = <0x00000000 0x1000>;

        gpio-controller;
        #gpio-cells = <2>;
};
, is it possible to move UARTs there?

I'm not sure if this UART cleanup should block your change. I guess it
depends on the way it'll finally look like.

I'm also wondering: is there any preference between overwriting status
with something like
&uart0 { };
and
chipcommonA {
    uart0: serial at 0300 { };
};
? I don't know DT that well, just asking.

-- 
Rafa?
