From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 25 Nov 2015 09:41:42 +0100
Subject: [PATCH] ARM: shmobile: r8a7779: Add L2 cache-controller node
In-Reply-To: <1448416683-1411-1-git-send-email-horms+renesas@verge.net.au>
References: <1448416683-1411-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdVTdPocWCnzE8v-O_rpNJR=0mO23jeG8ejYzL0REtQb+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Wed, Nov 25, 2015 at 2:58 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Add the missing L2 cache-controller node, and link the CPU nodes to it.
>
> The L2 cache is an ARM L2C-310 (r3p2), of size 1 MB (64 KiB x 16 ways).
>
> Based on work for the r8a7740 by Geert Uytterhoeven.
>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Thanks for your patch!

> ---
>  arch/arm/boot/dts/r8a7779.dtsi | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
> index 6afa909865b5..f27fa2db16ee 100644
> --- a/arch/arm/boot/dts/r8a7779.dtsi
> +++ b/arch/arm/boot/dts/r8a7779.dtsi

> @@ -63,6 +67,17 @@
>                       <0xf0000100 0x100>;
>         };
>
> +       L2: cache-controller {
> +               compatible = "arm,pl310-cache";
> +               reg = <0xf0100000 0x1000>;
> +               interrupts = <0 122 IRQ_TYPE_LEVEL_HIGH>;

40?

Comparing to other devices, you have to subtract 32 from 0x5a, not
add 32?

> +               arm,data-latency = <3 3 3>;
> +               arm,tag-latency = <2 2 2>;

Table 9.5 says 2 resp. 1 instead of 3 resp. 2?

However:

"The TAG and data RAM latency can be set in the reg1_tag_ram_control and
 reg1_data_ram_control registers. However, since values to be set are
 hardware-dependent, the default values should not be modified."

Perhaps we should just omit these values?

> +               arm,shared-override;
> +               cache-unified;
> +               cache-level = <2>;
> +       };
> +

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
