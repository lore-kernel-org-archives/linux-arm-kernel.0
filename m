From: marex@denx.de (Marek Vasut)
Date: Wed, 11 Dec 2013 15:36:31 +0100
Subject: [PATCH V2 2/4] mtd: spi-nor: add the basic data structures
In-Reply-To: <20131211143356.GA1719@gmail.com>
References: <1386318764-15882-1-git-send-email-b32955@freescale.com>
 <201312111102.18554.marex@denx.de> <20131211143356.GA1719@gmail.com>
Message-ID: <201312111536.32091.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, December 11, 2013 at 03:33:58 PM, Huang Shijie wrote:
> On Wed, Dec 11, 2013 at 11:02:18AM +0100, Marek Vasut wrote:
> > > > > +
> > > > > +	/* the two fundamental primitives */
> > > > > +	int (*read_xfer)(struct spi_nor *nor, struct spi_nor_xfer_cfg
> > > > > *cfg, +			 u8 *buf, size_t len);
> > > > > +	int (*write_xfer)(struct spi_nor *nor, struct spi_nor_xfer_cfg
> > > > > *cfg, +			  u8 *buf, size_t len);
> > > > > +
> > > > > +	int (*read_reg)(struct spi_nor *nor, u8 opcode, u8 *buf, int
> > > > > len); +	int (*write_reg)(struct spi_nor *nor, u8 opcode, u8 
*buf,
> > > > > int len, +			int write_enable);
> > 
> > This stuff -- I mean 'read SPI NOR register' and 'write SPI NOR
> > register'. I would love to see an API which grows as needed, not an API
> > which is bloated by unused function right from the start.
> 
> I should send out my fsl-quadspi driver in the next version.
> 
> The read_reg/write_reg are implemented by the m25p80 and fsl-quadspi
> now.
> 
> I think Lee's driver can implemente the read_xfer/write_xfer.

OK
 
> > > > > +	const struct spi_device_id *(*read_id)(struct spi_nor *nor);
> > > > > +	int (*wait_till_ready)(struct spi_nor *nor);
> > > > > +
> > > > > +	/* write */
> > > > > +	void (*write)(struct spi_nor *nor, loff_t to,
> > > > > +			size_t len, size_t *retlen, const u_char *buf);
> > > > > +	/* read */
> > > > > +	int (*read)(struct spi_nor *nor, loff_t from,
> > > > > +			size_t len, size_t *retlen, u_char *buf);
> > > > > +	/* erase */
> > > > > +	int (*erase)(struct spi_nor *nor, loff_t offs);
> > > > 
> > > > How do you specify what to erase (sub-sector, sector, whole chip)
> > > > here ?
> > > 
> > > I use a write_reg(OPCODE_ERASE_CHIP) to erase the whole chip.
> > > Please read the patch 3.
> > > 
> > > This hook is used to erase a sector.
> > 
> > I suspect we might need a much better documentation for this structure,
> > it is hardly clear which function does what ;-)
> 
> sorry, i will add more comment in the next version.

Thanks ;-)

> > > Btw, what is the sub-sector mean? which opcodes for the sub-sector?
> > 
> > On large chips with for example 64K big sectors, you can erase a
> > sub-sector area, usually a 4K one. This reduces the wear of the chip.
> > See these defines in
> > 
> > m25p80.c :
> >   46 #define OPCODE_BE_4K            0x20    /* Erase 4KiB block */
> >   48 #define OPCODE_BE_32K           0x52    /* Erase 32KiB block */
> >   49 #define OPCODE_CHIP_ERASE       0xc7    /* Erase whole flash chip */
> 
> ok.
> 
> the @erase hook can be used for sub-sector too.

I don't quite get how, but maybe you can elaborate on that one more in the next 
version of the patches :)

Best regards,
Marek Vasut
