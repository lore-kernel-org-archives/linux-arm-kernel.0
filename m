From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 30 Oct 2014 11:23:39 +0100
Subject: [PATCH] ARM: shmobile: koelsch: Fix flash partition label and
 size in device tree
In-Reply-To: <1414648469-29947-1-git-send-email-horms+renesas@verge.net.au>
References: <1414648469-29947-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdUAYJfLtMwzwOvsqaoDtXPW=q2yQLUH9+jQDB+A2JHX9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 30, 2014 at 6:54 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> From: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
>
> The size and the name of flash partition are consistent
> across use the R-Car Gen2 series.
>
> This patch makes the koelsch board consistent with the lager board.

Does this match the actual data in the FLASH?

On my board, the SPI boot loader is at 0x00000000.
There's also a small unidentified chunk at 0x00040000:

    00040000  00 40 30 e6 5c 3a 03 00  ff ff ff ff ff ff ff ff
|. at 0.\:..........|

u-Boot seems to be at 0x00080000.
u-Boot environment variables are saved at 0x000c0000.
This does match the old "bootenv" partition.

After that it's all-zeroes until 0x00100000, where I did my SPI tests,
based on the old layout.

Do I have a non-standard Koelsch FLASH layout on my board?

> --- a/arch/arm/boot/dts/r8a7791-koelsch.dts
> +++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
> @@ -390,17 +390,17 @@
>
>                 partition at 0 {
>                         label = "loader";
> -                       reg = <0x00000000 0x00080000>;
> +                       reg = <0x00000000 0x00040000>;
>                         read-only;
>                 };
> -               partition at 80000 {
> -                       label = "bootenv";
> -                       reg = <0x00080000 0x00080000>;
> +               partition at 40000 {
> +                       label = "user";
> +                       reg = <0x00040000 0x00400000>;
>                         read-only;
>                 };
> -               partition at 100000 {
> -                       label = "data";
> -                       reg = <0x00100000 0x03f00000>;
> +               partition at 440000 {
> +                       label = "flash";
> +                       reg = <0x00440000 0x03bc0000>;
>                 };
>         };
>  };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
