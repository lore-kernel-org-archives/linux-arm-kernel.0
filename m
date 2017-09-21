From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 21 Sep 2017 15:08:40 +0200
Subject: [PATCH v2 8/8] arm64: dts: renesas: eagle: add EtherAVB support
In-Reply-To: <20170915194449.538504992@cogentembedded.com>
References: <20170915194449.538504992@cogentembedded.com>
Message-ID: <CAMuHMdXQXFuVzwW7G-U7XWZUEj8qFRjtfDQF1+TgyzO0Xb+eYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Fri, Sep 15, 2017 at 9:43 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Define the Eagle board  dependent part of the EtherAVB device node.
> Enable DHCP  and NFS root for the kernel booting.
>
> Based  on the original (and large) patch by Vladimir Barinov.
>
> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

> --- renesas.orig/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
> +++ renesas/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
> @@ -18,10 +18,11 @@
>
>         aliases {
>                 serial0 = &scif0;
> +               ethernet0 = &avb;
>         };
>
>         chosen {
> -               bootargs = "ignore_loglevel";
> +               bootargs = "ignore_loglevel rw root=/dev/nfs ip=dhcp";
>                 stdout-path = "serial0:115200n8";
>         };
>
> @@ -43,3 +44,14 @@
>  &scif0 {
>         status = "okay";
>  };
> +
> +&avb {
> +       renesas,no-ether-link;
> +       phy-handle = <&phy0>;
> +       status = "okay";
> +
> +       phy0: ethernet-phy at 0 {
> +               rxc-skew-ps = <1500>;
> +               reg = <0>;

Any specific reason why you don't want to wire up the interrupt?

                interrupt-parent = <&gpio2>;
                interrupts = <11 IRQ_TYPE_LEVEL_LOW>;

> +       };
> +};

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
