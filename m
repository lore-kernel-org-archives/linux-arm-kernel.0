From: ben@decadent.org.uk (Ben Hutchings)
Date: Mon, 15 Sep 2014 16:07:07 +0100
Subject: [PATCH 5/5] m25p80,spi-nor: Share the list of supported chip
 type names again
In-Reply-To: <CAMuHMdUs+7uidcD6tivnq6+TbD4_piixLVqwuSa0Z1u3sF7EoA@mail.gmail.com>
References: <1410714624.3040.38.camel@decadent.org.uk>
 <1410714708.3040.43.camel@decadent.org.uk>
 <CAMuHMdUs+7uidcD6tivnq6+TbD4_piixLVqwuSa0Z1u3sF7EoA@mail.gmail.com>
Message-ID: <1410793627.3040.61.camel@decadent.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-09-15 at 09:55 +0200, Geert Uytterhoeven wrote:
> Hi Ben,
> 
> On Sun, Sep 14, 2014 at 7:11 PM, Ben Hutchings <ben@decadent.org.uk> wrote:
> > Move the list of chip type names to spi-nor.h.  To avoid putting all
> > the chip type information there, we define this list as a macro
> > SPI_NOR_ENUM_TYPES() that invokes another macro SPI_NOR_ENUM_TYPE()
> > that must be defined to expand each name to whatever form it's needed.
> >
> > In spi-nor.c, use it to define enumerators, then use the enumerators
> > as indices when defining spi_nor_info so that we cannot accidentally
> > use a name that's not on the list.
> >
> > This is somewhat complicated by the fact that some names include
> > hyphens.  SPI_NOR_ENUM_TYPE() therefore takes separate string and C
> > identifier parameters.
> 
> Thanks for doing this!
> 
> However, the table generation still looks overly complicated to me, with
> too much duplication which needs to be kept in sync.

It does need to be kept in sync, but the compiler will check that.

[...]
> > --- a/include/linux/mtd/spi-nor.h
> > +++ b/include/linux/mtd/spi-nor.h
> > @@ -198,4 +198,76 @@ struct spi_nor {
> >   */
> >  int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode);
> >
> > +#define __SPI_NOR_ENUM_TYPES(c_id, str_and_c_id)                         \
> > +       c_id(at25fs010)         c_id(at25fs040)         c_id(at25df041a)  \
> > +       c_id(at25df321a)        c_id(at25df641)         c_id(at26f004)    \
> 
> Can't you just have the IDs in a header file only, and let the header file
> generate either a struct flash_info or a struct spi_device_id table, using
> a macro defined by the file that includes it?

How would we match up the rest of the struct flash_info to the name?

> Cfr. include/uapi/asm-generic/unistd.h and its use of __SYSCALL()?
> 
> Or am I missing something (e.g. this is impossible due to the hyphens in the
> names?).

Well the hyphens are only a problem because we want C identifiers.  But
we only need C identifiers so we can enforce that each struct flash_info
matches a name on the list.  If you can find a way to match them up
without having to define enumerators, that would of course be
preferable.

Ben.

-- 
Ben Hutchings
Make three consecutive correct guesses and you will be considered an expert.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 811 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140915/90366ebe/attachment.sig>
