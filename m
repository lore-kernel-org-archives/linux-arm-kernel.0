From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 2 Nov 2017 16:38:49 +0800
Subject: linux-next: manual merge of the spi-nor tree with the imx-mxs tree
In-Reply-To: <a91e5500-29d8-c336-f684-220c899d1ac2@wedev4u.fr>
References: <20171030181551.skcvt4mr4br7rtn2@sirena.co.uk>
 <d38cf683-c7a8-51b1-896a-ff1fda0f64f9@wedev4u.fr>
 <20171031021650.GC6270@dragon>
 <a91e5500-29d8-c336-f684-220c899d1ac2@wedev4u.fr>
Message-ID: <20171102083847.GA24292@x250>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 01, 2017 at 01:47:04PM +0100, Cyrille Pitchen wrote:
> >> So Shawn, could you please remove this patch from your tree ?
> > 
> > I have already sent the patch to my upstream maintainers (arm-soc).  I
> > guess it's okay to leave such trivial conflict to Linus.  @Arnd, what do
> > you think?
> >
> 
> My concern is not about the conflict, which indeed is trivial, but about
> the fact that this patch should not be applied at all. I would have
> like to discuss it on the linux-mtd mailing list since the
> jedec,spi-nor.txt is maintained by MTD / spi-nor folks.
> 
> Some memory parts like mr25h128 don't support at all the JEDEC READ ID
> (9Fh) command. In such a case, the "jedec,spi-nor" string is not suited
> as a value inside the 'compatible' DT property because the memory is
> not JEDEC compliant. In that precise case, we have no other choice but
> to use another 'compatible' value, that's why we rely on chip name.
> 
> However, for memory parts that do support the JEDEC READ ID command,
> like en25s64 and sst25wf040b, we require that the 'compatible' DT
> property includes the "jedec,spi-nor" string. I guess for *legacy
> reasons*, the chip name MAY be included too but this is not needed and
> actually may have side effects, especially when the SPI NOR memory is
> handled by the m25p80 driver. When possible, it's better to set the
> 2nd parameter of spi_nor_scan() to NULL. My understanding is that is
> parameter is there for historical reason and is only used for:
> 1 - backward compatibility, when DT and the "jedec,spi-nor" 'compatible'
>     string were not introduced yet.
> 2 - provide the chip name of non-JEDEC memories.
> 
> So currently, I advise to avoid adding the chip name in the 'compatible'
> string when not needed then to set it to "jedec,spi-nor" alone.
> Also I think we should add new chip names in the "jedec,spi-nor.txt"
> file only for non JEDEC memory parts, that is to say, when we have no
> other choice.
> 
> This is my current feeling and I would have like to have a chance to
> discuss it first with Marek and other MTD guys before taking a
> decision because at the spi-nor side we've already had bad surprises
> with chip names / Jedec ID mismatches. So IMHO, chip names are not so
> reliable and we should avoid to use them when possible.
> 
> For instance, as long as they are not used in device trees, we can still
> try to fix inconsistent naming in the entries of the spi_nor_ids[]
> array of the drivers/mtd/spi-nor/spi-nor.c. In most cases the
> name is only informational, not use for other purpose than display.
> However, when the 2nd parameter of spi_nor_scan() is not NULL, which
> is not true in the general case, the name is used as an index to find
> out the relevant entry from the spi_nor_ids[] array. Such mechanism
> should be used only for non-JEDEC memories, though the spi-nor driver
> can handle the case where the 'compatible' DT property is set to
> compatible = "<vendor>,<chip-name>", "jedec,spi-nor";
> In such a case, and only when driven by the m25p80 driver, the
> <chip-name> string is provided as the 2nd argument of spi_nor_scan().
> This function first tries to look up the proper spi_nor_ids[] entry
> based on the <chip-name> then reads the JEDEC ID and uses it as
> another index in the spi_nor_ids[] array to find the real entry.
> If both entries, the one found by name and the one found by JEDEC ID,
> don't match, the spi-nor driver display a warning and keep the entry
> found by ID. So adding the chip name in the 'compatible' string of
> JEDEC memories is in the best case useless.
> 
> That's why, for now, I still think this patch should not be applied at
> all, at least, not before having been reviewed and accepted by MTD guys.

Okay.  If people all agreed that the patch was doing something wrong,
maybe a revert patch is more appropriate at this point, I guess.

Shawn
