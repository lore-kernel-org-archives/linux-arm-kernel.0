From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 10 Nov 2015 09:37:43 +0100
Subject: [PATCH 3/3] ARM: shmobile: gose: Add QSPI device to DT
In-Reply-To: <1447139641-11480-4-git-send-email-horms+renesas@verge.net.au>
References: <1447139641-11480-1-git-send-email-horms+renesas@verge.net.au>
 <1447139641-11480-4-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdWUgzJR1c9EAnjV5J0J8W1Mfga9Lx7SuUw02QjLuyQPGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Tue, Nov 10, 2015 at 8:14 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Enable the QSPI controller in the gose device tree.
>
> Based similar work for the silk board by by Vladimir Barinov and
> Sergei Shtylyov.
>
> Cc: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>
> ---
> Tested: Read /dev/mtd0 with 512K blocks at 1.7MB/s
> ---
>  arch/arm/boot/dts/r8a7793-gose.dts | 40 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>
> diff --git a/arch/arm/boot/dts/r8a7793-gose.dts b/arch/arm/boot/dts/r8a7793-gose.dts
> index 1575ef759047..3bc4230aa2b5 100644
> --- a/arch/arm/boot/dts/r8a7793-gose.dts
> +++ b/arch/arm/boot/dts/r8a7793-gose.dts

> @@ -92,3 +97,38 @@
>
>         status = "okay";
>  };
> +
> +&qspi {
> +       pinctrl-0 = <&qspi_pins>;
> +       pinctrl-names = "default";
> +
> +       status = "okay";
> +
> +       flash at 0 {
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               compatible = "spansion,s25fl512s", "jedec,spi-nor";
> +               reg = <0>;
> +               spi-max-frequency = <30000000>;
> +               spi-tx-bus-width = <4>;
> +               spi-rx-bus-width = <4>;
> +               spi-cpol;
> +               spi-cpha;
> +               m25p,fast-read;
> +
> +               partition at 0 {
> +                       label = "loader";
> +                       reg = <0x00000000 0x00040000>;
> +                       read-only;
> +               };
> +               partition at 40000 {
> +                       label = "user";
> +                       reg = <0x00040000 0x00400000>;
> +                       read-only;
> +               };
> +               partition at 440000 {
> +                       label = "flash";
> +                       reg = <0x00440000 0x03bc0000>;
> +               };
> +       };

Please move the partitions inside a "partitions" subnode, cfr. the patch
I've just sent for Koelsch ("[PATCH] ARM: shmobile: koelsch: Move SPI FLASH
partitions to subnode"). I haven't updated the other DTSes yet.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
