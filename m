From: js@sig21.net (Johannes Stezenbach)
Date: Fri, 5 Jul 2013 16:34:52 +0200
Subject: SPI: DUAL/QUAD support
In-Reply-To: <CAHSAbzP1-RVot+hhtY_DcBK=u5n2234eb9WOKLESwvUNax7+pA@mail.gmail.com>
References: <OFAD729A05.8C915625-ONC1257B9E.00576B25-C1257B9E.0058477D@rohde-schwarz.com>
 <CAHSAbzOg+uHndydSC43moF7pijc67pqzB2rPnY69ynXHEzw79g@mail.gmail.com>
 <51D67851.8020402@ti.com>
 <CAHSAbzNvMo_oeaqtzO8-xDm-L-f8wVccVqfuVqbR=OwqWJhVwg@mail.gmail.com>
 <51D689F3.3070605@ti.com>
 <CAHSAbzM1PGoMXFNOmB7guDsVWYnRoRy89-bufHYpPz5+odnd8w@mail.gmail.com>
 <51D68D14.7090606@ti.com>
 <CAHSAbzMfvfdDtTh=3zeBni4fNMAHEMdTJLJU-Oc13HJUqCUj0A@mail.gmail.com>
 <51D69197.7060802@ti.com>
 <CAHSAbzP1-RVot+hhtY_DcBK=u5n2234eb9WOKLESwvUNax7+pA@mail.gmail.com>
Message-ID: <20130705143452.GA7738@sig21.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 05, 2013 at 06:24:40PM +0800, yuhang wang wrote:
> 
> 2 Questions here:
> 1.In m25p80.c probe, the kmalloc below I feel very strange.
>       flash->command = kmalloc(MAX_CMD_SIZE + (flash->fast_read ? 1 : 0),
>                                       GFP_KERNEL);
> 
>  (flash->fast_read ? 1 : 0) must be 0! So why do it like that.

Maybe just increase MAX_CMD_SIZE by 1 unconditonally?
Yeah, looks like a bug in m25p80.c, flash->fast_read
is initialized too late.

> +#define        OPCODE_DOR              0x3B    /* Dual Output Read */
> +#define        OPCODE_QOR              0x6B    /* Quad Output Read */
> +#define        OPCODE_QPP              0x32    /* Quad Page Programming */
> +#define        OPCODE_QEN              0x02 /* Quad Mode Enable Flag */

Which flash chip are these for?  The OPCODE_DOR and OPCODE_QOR
match MX25L25635E, but OPCODE_QPP not (Macronix uses 0x38).



> +#ifdef CONFIG_M25PXX_USE_FAST_READ
> +#define OPCODE_READ    OPCODE_FAST_READ
> +#define FAST_READ_DUMMY_BYTE 1
> +#else
> +#define OPCODE_READ    OPCODE_NORM_READ
> +#define FAST_READ_DUMMY_BYTE 0
> +#endif

this doesn't work with the flash->fast_read setting from DT

BTW, if we add "bitwidths" to spi_board_info, wouldn't
it make sense to also add "use_fast_read" and remove the
CONFIG_M25PXX_USE_FAST_READ option?

> +/*
> + * Write configuration register 2 byte
> + * Returns negative if error occurred.
> + */
> +static int write_cr(struct m25p *flash, u16 val)
> +{
> +       flash->command[0] = OPCODE_WRSR;
> +       flash->command[1] = val >> 8;
> +       flash->command[2] = val;
> +
> +       return spi_write(flash->spi, flash->command, 3);
> +}

> +       if ((flash->spi->rx_bitwidth == SPI_BITWIDTH_QUAD) ||
> +               (flash->spi->tx_bitwidth == SPI_BITWIDTH_QUAD)) {
> +               write_enable(flash);
> +               write_cr(flash, OPCODE_QEN);
> +       }

MX25L25635E doesn't have a cr, instead a bit needs to be set in the sr

Maybe we need to add some fields to m25p_ids[] to manage variation
between flash devices.


Thanks,
Johannes
