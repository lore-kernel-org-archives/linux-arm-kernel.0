From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 29 Jan 2015 16:56:16 +0100
Subject: [PATCH] spi/xilinx: Cast ioread32/iowrite32 function pointers
In-Reply-To: <1422543073-21895-1-git-send-email-ricardo.ribalda@gmail.com>
References: <1422543073-21895-1-git-send-email-ricardo.ribalda@gmail.com>
Message-ID: <CAMuHMdX5CMH0Q5S_BBjb-F-kJfzkTS+sP9H-FDe_K_gFRxK7pw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 29, 2015 at 3:51 PM, Ricardo Ribalda Delgado
<ricardo.ribalda@gmail.com> wrote:
> IO functions prototypes may have different argument qualifiers
> on different architectures.
>
> This patch cast the assignment of the function, to match the one defined
> at iomap.h.

Adding casts is (usually) not the solution to the problem.

I think the definitions in include/asm-generic/iomap.h are actually wrong,
as they lack a const:

    extern unsigned int ioread8(void __iomem *);
    extern unsigned int ioread16(void __iomem *);
    extern unsigned int ioread16be(void __iomem *);
    extern unsigned int ioread32(void __iomem *);
    extern unsigned int ioread32be(void __iomem *);

Note that the definitions in include/asm-generic/io.h do have the const:

    static inline u8 ioread8(const volatile void __iomem *addr)
    static inline u16 ioread16(const volatile void __iomem *addr)
    static inline u32 ioread32(const volatile void __iomem *addr)
    static inline u16 ioread16be(const volatile void __iomem *addr)
    static inline u32 ioread32be(const volatile void __iomem *addr)

> Fixes: 99082eab63449f9d spi/xilinx: Remove iowrite/ioread wrappers
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> ---
>  drivers/spi/spi-xilinx.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
> index 0e8962c..418e730 100644
> --- a/drivers/spi/spi-xilinx.c
> +++ b/drivers/spi/spi-xilinx.c
> @@ -91,7 +91,7 @@ struct xilinx_spi {
>         u8 bytes_per_word;
>         int buffer_size;        /* buffer size in words */
>         u32 cs_inactive;        /* Level of the CS pins when inactive*/
> -       unsigned int (*read_fn)(void __iomem *);
> +       u32 (*read_fn)(void __iomem *);
>         void (*write_fn)(u32, void __iomem *);
>  };
>
> @@ -378,15 +378,15 @@ static int xilinx_spi_probe(struct platform_device *pdev)
>          * Setup little endian helper functions first and try to use them
>          * and check if bit was correctly setup or not.
>          */
> -       xspi->read_fn = ioread32;
> -       xspi->write_fn = iowrite32;
> +       xspi->read_fn = (u32 (*)(void __iomem *)) ioread32;
> +       xspi->write_fn = (void (*)(u32, void __iomem *)) iowrite32;
>
>         xspi->write_fn(XSPI_CR_LOOP, xspi->regs + XSPI_CR_OFFSET);
>         tmp = xspi->read_fn(xspi->regs + XSPI_CR_OFFSET);
>         tmp &= XSPI_CR_LOOP;
>         if (tmp != XSPI_CR_LOOP) {
> -               xspi->read_fn = ioread32be;
> -               xspi->write_fn = iowrite32be;
> +               xspi->read_fn = (u32 (*)(void __iomem *)) ioread32be;
> +               xspi->write_fn = (void (*)(u32, void __iomem *)) iowrite32be;
>         }
>
>         master->bits_per_word_mask = SPI_BPW_MASK(bits_per_word);
> --
> 2.1.4

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
