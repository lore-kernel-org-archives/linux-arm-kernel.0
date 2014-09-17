From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 17 Sep 2014 09:33:49 +0200
Subject: [PATCH v2 1/5] ARM: shmobile: kzm9d: Remove spurious regulator
 base addresses
In-Reply-To: <1410914896-14395-2-git-send-email-horms+renesas@verge.net.au>
References: <1410914896-14395-1-git-send-email-horms+renesas@verge.net.au>
 <1410914896-14395-2-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdWo+gNM=GMJ4LiotDQ6LJ5Pa6F1bqyJwW5xqdunw9-AyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Wed, Sep 17, 2014 at 2:48 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> As there is no reg property the regulator nodes should
> not include @...

You missed an important part of my comment:

"However, in the absence of a unit-address, the node name must be unique."

> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>
> ---
> v2
> * First post
> ---
>  arch/arm/boot/dts/emev2-kzm9d.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/emev2-kzm9d.dts b/arch/arm/boot/dts/emev2-kzm9d.dts
> index 50ccd15..f27fcf0 100644
> --- a/arch/arm/boot/dts/emev2-kzm9d.dts
> +++ b/arch/arm/boot/dts/emev2-kzm9d.dts
> @@ -27,7 +27,7 @@
>                 bootargs = "console=ttyS1,115200n81 ignore_loglevel root=/dev/nfs ip=dhcp";
>         };
>
> -       reg_1p8v: regulator at 0 {
> +       reg_1p8v: regulator {
>                 compatible = "regulator-fixed";
>                 regulator-name = "fixed-1.8V";
>                 regulator-min-microvolt = <1800000>;
> @@ -36,7 +36,7 @@
>                 regulator-boot-on;
>         };
>
> -       reg_3p3v: regulator at 1 {
> +       reg_3p3v: regulator {
>                 compatible = "regulator-fixed";
>                 regulator-name = "fixed-3.3V";
>                 regulator-min-microvolt = <3300000>;

Now there are two "regulator" nodes.

Dtc will not complain, but will assume the second contains overrides for
first. "vddvario-supply" and "vdd33a-supply" of node "lan9220 at 20000000"
will both the point to the same node, and the network may not work.

You can see this yourself running

    dtc -I dtb -O dts arch/arm/boot/dts/emev2-kzm9d.dtb

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
