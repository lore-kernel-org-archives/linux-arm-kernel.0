From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 22 Mar 2017 12:06:49 +0800
Subject: [PATCH] ARM: dts: sun7i: lamobo-r1: Fix CPU port RGMII settings
In-Reply-To: <20170319045039.6163-1-f.fainelli@gmail.com>
References: <20170319045039.6163-1-f.fainelli@gmail.com>
Message-ID: <CAGb2v65KvoC9MUoErkGeHvmbm8Ocq-vhFBhxXvZu--=xT4zAeg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,

On Sun, Mar 19, 2017 at 12:50 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> The CPU port of the BCM53125 is configured with RGMII (no delays) but
> this should actually be RGMII with transmit delay (rgmii-txid) because
> STMMAC takes care of inserting the transmitter delay. This fixes
> occasional packet loss encountered.
>
> Fixes: d7b9eaff5f0c ("ARM: dts: sun7i: Add BCM53125 switch nodes to the lamobo-r1 board")
> Reported-by: Hartmut Knaack <knaack.h@gmx.de>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts b/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts
> index 72ec0d5ae052..bbf1c8cbaac6 100644
> --- a/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts
> @@ -167,7 +167,7 @@
>                                         reg = <8>;
>                                         label = "cpu";
>                                         ethernet = <&gmac>;
> -                                       phy-mode = "rgmii";
> +                                       phy-mode = "rgmii-txid";

Just to clarify, the DT binding says:

  * "rgmii-txid" (RGMII with internal TX delay provided by the PHY, the MAC
     should not add an TX delay in this case)

I'm assuming this applies from the device node's point of view?
In this case the "PHY" is STMMAC, and the "MAC" is the switch chip?
Is that right?


Thanks
ChenYu

>                                         fixed-link {
>                                                 speed = <1000>;
>                                                 full-duplex;
> --
> 2.9.3
>
