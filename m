From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 4 Jun 2015 08:42:59 +0200
Subject: [PATCH 08/11] MTD: m25p80: Add option to limit SPI transfer size.
In-Reply-To: <8fc4b9f5291a509c4c35782a1337bf536f1019af.1433364398.git.hramrach@gmail.com>
References: <cover.1433364398.git.hramrach@gmail.com>
 <8fc4b9f5291a509c4c35782a1337bf536f1019af.1433364398.git.hramrach@gmail.com>
Message-ID: <CAMuHMdVT2M7pPHDDHmoNF_zVXhz1PUm5PiYxDKcAjSAcfSDiZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 3, 2015 at 11:26 PM, Michal Suchanek <hramrach@gmail.com> wrote:
> On sunxi the SPI controller currently does not have DMA support and fails
> any transfer larger than 63 bytes.

This is a driver limitation, not a hardware limitation.

> On Exynos the pl330 DMA controller fails any transfer larger than 64kb
> when using slower speed like 40MHz and any transfer larger than 128bytes
> when running at 133MHz.

This may be a driver bug.

> The best thing is that in both cases the controller can just lock up and
> never finish potentially leaving the hardware in unusable state.
>
> So it is required that the m25p80 driver actively prevents doing
> transfers that are too large for the current driver state on a
> particular piece of hardware.

OK.

> Signed-off-by: Michal Suchanek <hramrach@gmail.com>
>
> --
>
> Update commit message and documentation text.
> ---
>  .../devicetree/bindings/mtd/jedec,spi-nor.txt      |  6 ++++++
>  drivers/mtd/devices/m25p80.c                       | 24 ++++++++++++++++++++--
>  2 files changed, 28 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt
> index 2bee681..4e63ae8 100644
> --- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt
> +++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt
> @@ -19,6 +19,12 @@ Optional properties:
>                     all chips and support for it can not be detected at runtime.
>                     Refer to your chips' datasheet to check if this is supported
>                     by your chip.
> +- linux,max_tx_len : With some SPI controller drivers possible transfer size is
> +                     limited. This may be hardware or driver bug.
> +                     Transfer data in chunks no larger than this value.
> +                     Using this option may severely degrade performance and
> +                     possibly flash memory life when max_tx_len is smaller than
> +                     flash page size (typically 256 bytes)

DT describes the hardware, not buggy drivers.

So IMHO this doesn't belong in DT, but it can be a field in struct spi_master.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
