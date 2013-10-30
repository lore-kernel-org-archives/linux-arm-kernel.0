From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 30 Oct 2013 20:08:54 +0100
Subject: [PATCH 29/51] DMA-API: ata: pata_octeon_cf: convert to use
 dma_coerce_mask_and_coherent()
In-Reply-To: <E1VMmAk-0007iq-IU@rmk-PC.arm.linux.org.uk>
References: <20130919212235.GD12758@n2100.arm.linux.org.uk>
 <E1VMmAk-0007iq-IU@rmk-PC.arm.linux.org.uk>
Message-ID: <CAMuHMdWqAL6MN5VJrpAPC1fq3QtRWZ3UUMG3+6W5vEKSEm5N9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 19, 2013 at 11:54 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:
> diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
> index c51bbb9..6231d43 100644
> --- a/drivers/ata/pata_octeon_cf.c
> +++ b/drivers/ata/pata_octeon_cf.c
> @@ -1014,8 +1014,9 @@ static int octeon_cf_probe(struct platform_device *pdev)
>         }
>         cf_port->c0 = ap->ioaddr.ctl_addr;
>
> -       pdev->dev.coherent_dma_mask = DMA_BIT_MASK(64);
> -       pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
> +       rv = dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> +       if (rv)
> +               return ret;

return rv;

http://kisskb.ellerman.id.au/kisskb/buildresult/9959184/

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
