From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Tue, 23 Sep 2014 16:58:22 +0200
Subject: [PATCH v3 1/3] mtd: nand: gpmi: add gpmi_move_bits function
In-Reply-To: <20140923145413.GA1633@localhost.localdomain>
References: <1411481256-29141-1-git-send-email-boris.brezillon@free-electrons.com>
 <1411481256-29141-2-git-send-email-boris.brezillon@free-electrons.com>
 <20140923145413.GA1633@localhost.localdomain>
Message-ID: <20140923165822.27cfde69@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 23 Sep 2014 22:54:15 +0800
Huang Shijie <shijie8@gmail.com> wrote:

> On Tue, Sep 23, 2014 at 04:07:34PM +0200, Boris BREZILLON wrote:
> > Add a new function to move bits (not bytes) from a memory region to
> > another one.
> > This function is similar to memmove except it acts at bit level.
> > This function is needed to implement GPMI raw access functions, given the
> > fact that ECC engine does not pad ECC bits to the next byte boundary.
> sorry for not comment your v2 patch set.
> 
> > 
> > Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
> > ---
> >  drivers/mtd/nand/gpmi-nand/gpmi-lib.c  | 88 ++++++++++++++++++++++++++++++++++
> >  drivers/mtd/nand/gpmi-nand/gpmi-nand.h |  4 ++
> >  2 files changed, 92 insertions(+)
> > 
> > diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-lib.c b/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
> > index 87e658c..e2f706a 100644
> > --- a/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
> > +++ b/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
> > @@ -1353,3 +1353,91 @@ int gpmi_read_page(struct gpmi_nand_data *this,
> >  	set_dma_type(this, DMA_FOR_READ_ECC_PAGE);
> >  	return start_dma_with_bch_irq(this, desc);
> >  }
> > +
> > +void gpmi_move_bits(u8 *dst, size_t dst_bit_off,
> > +		    const u8 *src, size_t src_bit_off,
> > +		    size_t nbits)
> we can simplify the code.

Any suggestions ?

> 
> We could use the bytes to replace the @nbits.
> 
> The chunk data is always byte aligned.

This function is also used to store ECC bits in the OOB buffer and
these chunk of data are not byte aligned :-).

> 
> 
> Btw: please add more comments in this function.

Yep, I should definitely comment it, and I'll do.

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
