From: naga.sureshkumar.relli@xilinx.com (Naga Sureshkumar Relli)
Date: Mon, 5 Dec 2016 07:02:21 +0000
Subject: [LINUX RFC v4 3/4] mtd: spi-nor: add stripe support
In-Reply-To: <504cd632-022b-3e6b-8c50-563a585e1a08@atmel.com>
References: <1480235616-34038-1-git-send-email-nagasure@xilinx.com>
 <68ca0f19-e534-3361-11f0-6566626380fe@atmel.com>
 <DA6901612C71B84D91459DE817C418AE26E0B5E2@XAP-PVEXMBX01.xlnx.xilinx.com>
 <504cd632-022b-3e6b-8c50-563a585e1a08@atmel.com>
Message-ID: <DA6901612C71B84D91459DE817C418AE26E0C110@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Cyrille,

> > Hi Cyrille,
> >
> >> I have not finished to review the whole series yet but here some
> >> first
> >> comments:
> >
> > Thanks for reviewing these patch series.
> >
> >>
> >> Le 27/11/2016 ? 09:33, Naga Sureshkumar Relli a ?crit :
> >>> This patch adds stripe support and it is needed for GQSPI parallel
> >>> configuration mode by:
> >>>
> >>> - Adding required parameters like stripe and shift to spi_nor
> >>>   structure.
> >>> - Initializing all added parameters in spi_nor_scan()
> >>> - Updating read_sr() and read_fsr() for getting status from both
> >>>   flashes
> >>> - Increasing page_size, sector_size, erase_size and toatal flash
> >>>   size as and when required.
> >>> - Dividing address by 2
> >>> - Updating spi->master->flags for qspi driver to change CS
> >>>
> >>> Signed-off-by: Naga Sureshkumar Relli <nagasure@xilinx.com>
> >>> ---
> >>> Changes for v4:
> >>>  - rename isparallel to stripe
> >>> Changes for v3:
> >>>  - No change
> >>> Changes for v2:
> >>>  - Splitted to separate MTD layer changes from SPI core changes
> >>> ---
> >>>  drivers/mtd/spi-nor/spi-nor.c | 130
> >> ++++++++++++++++++++++++++++++++----------
> >>>  include/linux/mtd/spi-nor.h   |   2 +
> >>>  2 files changed, 103 insertions(+), 29 deletions(-)
> >>>
> >>> diff --git a/drivers/mtd/spi-nor/spi-nor.c
> >>> b/drivers/mtd/spi-nor/spi-nor.c index d0fc165..4252239 100644
> >>> --- a/drivers/mtd/spi-nor/spi-nor.c
> >>> +++ b/drivers/mtd/spi-nor/spi-nor.c
> >>> @@ -22,6 +22,7 @@
> >>>  #include <linux/of_platform.h>
> >>>  #include <linux/spi/flash.h>
> >>>  #include <linux/mtd/spi-nor.h>
> >>> +#include <linux/spi/spi.h>
> >>>
> >>>  /* Define max times to check status register before we give up. */
> >>>
> >>> @@ -89,15 +90,24 @@ static const struct flash_info
> >>> *spi_nor_match_id(const char *name);  static int read_sr(struct
> >>> spi_nor *nor)  {
> >>>   int ret;
> >>> - u8 val;
> >>> + u8 val[2];
> >>>
> >>> - ret = nor->read_reg(nor, SPINOR_OP_RDSR, &val, 1);
> >>> - if (ret < 0) {
> >>> -         pr_err("error %d reading SR\n", (int) ret);
> >>> -         return ret;
> >>> + if (nor->stripe) {
> >>> +         ret = nor->read_reg(nor, SPINOR_OP_RDSR, &val[0], 2);
> >>> +         if (ret < 0) {
> >>> +                 pr_err("error %d reading SR\n", (int) ret);
> >>> +                 return ret;
> >>> +         }
> >>> +         val[0] |= val[1];
> >> Why '|' rather than '&' ?
> >> I guess because of the 'Write In Progress/Busy' bit: when called by
> >> spi_nor_sr_ready(), you want to be sure that this 'BUSY' bit is
> >> cleared on both memories.
> >>
> >> But what about when the Status Register is read for purpose other
> >> than checking the state of the 'BUSY' bit?
> >>
> > Yes you are correct, I will change this.
> >
> >> What about SPI controllers supporting more than 2 memories in parallel?
> >>
> >> This solution might fit the ZynqMP controller but doesn't look so generic.
> >>
> >>> + } else {
> >>> +         ret = nor->read_reg(nor, SPINOR_OP_RDSR, &val[0], 1);
> >>> +         if (ret < 0) {
> >>> +                 pr_err("error %d reading SR\n", (int) ret);
> >>> +                 return ret;
> >>> +         }
> >>>   }
> >>>
> >>> - return val;
> >>> + return val[0];
> >>>  }
> >>>
> >>>  /*
> >>> @@ -108,15 +118,24 @@ static int read_sr(struct spi_nor *nor)
> >>> static int read_fsr(struct spi_nor *nor)  {
> >>>   int ret;
> >>> - u8 val;
> >>> + u8 val[2];
> >>>
> >>> - ret = nor->read_reg(nor, SPINOR_OP_RDFSR, &val, 1);
> >>> - if (ret < 0) {
> >>> -         pr_err("error %d reading FSR\n", ret);
> >>> -         return ret;
> >>> + if (nor->stripe) {
> >>> +         ret = nor->read_reg(nor, SPINOR_OP_RDFSR, &val[0], 2);
> >>> +         if (ret < 0) {
> >>> +                 pr_err("error %d reading FSR\n", ret);
> >>> +                 return ret;
> >>> +         }
> >>> +         val[0] &= val[1];
> >> Same comment here: why '&' rather than '|'?
> >> Surely because of the the 'READY' bit which should be set for both
> memories.
> > I will update this also.
> >>
> >>> + } else {
> >>> +         ret = nor->read_reg(nor, SPINOR_OP_RDFSR, &val[0], 1);
> >>> +         if (ret < 0) {
> >>> +                 pr_err("error %d reading FSR\n", ret);
> >>> +                 return ret;
> >>> +         }
> >>>   }
> >>>
> >>> - return val;
> >>> + return val[0];
> >>>  }
> >>>
> >>>  /*
> >>> @@ -290,9 +309,16 @@ static int spi_nor_wait_till_ready(struct
> >>> spi_nor
> >> *nor)
> >>>   */
> >>>  static int erase_chip(struct spi_nor *nor)  {
> >>> + u32 ret;
> >>> +
> >>>   dev_dbg(nor->dev, " %lldKiB\n", (long long)(nor->mtd.size >> 10));
> >>>
> >>> - return nor->write_reg(nor, SPINOR_OP_CHIP_ERASE, NULL, 0);
> >>> + ret = nor->write_reg(nor, SPINOR_OP_CHIP_ERASE, NULL, 0);
> >>> + if (ret)
> >>> +         return ret;
> >>> +
> >>> + return ret;
> >>> +
> >>
> >>    if (ret)
> >>            return ret;
> >>    else
> >>            return ret;
> >>
> >> This chunk should be removed, it doesn't ease the patch review ;)
> > Ok, I will remove.
> >>
> >>>  }
> >>>
> >>>  static int spi_nor_lock_and_prep(struct spi_nor *nor, enum
> >>> spi_nor_ops ops) @@ -349,7 +375,7 @@ static int
> >>> spi_nor_erase_sector(struct spi_nor *nor, u32 addr)  static int
> >>> spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)  {
> >>>   struct spi_nor *nor = mtd_to_spi_nor(mtd);
> >>> - u32 addr, len;
> >>> + u32 addr, len, offset;
> >>>   uint32_t rem;
> >>>   int ret;
> >>>
> >>> @@ -399,9 +425,13 @@ static int spi_nor_erase(struct mtd_info *mtd,
> >> struct erase_info *instr)
> >>>   /* "sector"-at-a-time erase */
> >>>   } else {
> >>>           while (len) {
> >>> +
> >>>                   write_enable(nor);
> >>> +                 offset = addr;
> >>> +                 if (nor->stripe)
> >>> +                         offset /= 2;
> >>
> >> I guess this should be /= 4 for controllers supporting 4 memories in
> parallel.
> >> Shouldn't you use nor->shift and define shift as an unsigned int
> >> instead of a bool?
> >> offset >>= nor->shift;
> >>
> > Yes we can use this shift, I will update
> >
> >> Anyway, by tuning the address here in spi-nor.c rather than in the
> >> SPI controller driver, you impose a model to support parallel
> >> memories that might not be suited to other controllers.
> >
> > For this ZynqMP GQSPI controller parallel configuration, globally
> > spi-nor should know about this stripe feature And based on that address
> has to change.
> > As I mentioned in cover letter, this controller in parallel configuration will
> work with even addresses only.
> > i.e. Before creating address format(m25p_addr2cmd) in mtd layer, spi-nor
> should change that address based on stripe option.
> >
> > I am updating this offset based on stripe option, and stripe option will
> update by reading dt property in nor_scan().
> > So the controller which doesn't support, then the stripe will be zero.
> > Or Can you please suggest any other way?
> >
> >>
> >>>
> >>> -                 ret = spi_nor_erase_sector(nor, addr);
> >>> +                 ret = spi_nor_erase_sector(nor, offset);
> >>>                   if (ret)
> >>>                           goto erase_err;
> >>>
> >>> @@ -525,6 +555,8 @@ static int stm_lock(struct spi_nor *nor, loff_t
> >>> ofs,
> >> uint64_t len)
> >>>   bool use_top;
> >>>   int ret;
> >>>
> >>> + ofs = ofs >> nor->shift;
> >>> +
> >>>   status_old = read_sr(nor);
> >>>   if (status_old < 0)
> >>>           return status_old;
> >>> @@ -610,6 +642,8 @@ static int stm_unlock(struct spi_nor *nor,
> >>> loff_t ofs,
> >> uint64_t len)
> >>>   bool use_top;
> >>>   int ret;
> >>>
> >>> + ofs = ofs >> nor->shift;
> >>> +
> >>>   status_old = read_sr(nor);
> >>>   if (status_old < 0)
> >>>           return status_old;
> >>> @@ -709,6 +743,8 @@ static int spi_nor_lock(struct mtd_info *mtd,
> >>> loff_t
> >> ofs, uint64_t len)
> >>>   if (ret)
> >>>           return ret;
> >>>
> >>> + ofs = ofs >> nor->shift;
> >>> +
> >>>   ret = nor->flash_lock(nor, ofs, len);
> >>>
> >>>   spi_nor_unlock_and_unprep(nor, SPI_NOR_OPS_UNLOCK); @@ -
> >> 724,6 +760,8
> >>> @@ static int spi_nor_unlock(struct mtd_info *mtd, loff_t ofs,
> >>> uint64_t
> >> len)
> >>>   if (ret)
> >>>           return ret;
> >>>
> >>> + ofs = ofs >> nor->shift;
> >>> +
> >>>   ret = nor->flash_unlock(nor, ofs, len);
> >>>
> >>>   spi_nor_unlock_and_unprep(nor, SPI_NOR_OPS_LOCK); @@ -
> >> 1018,6 +1056,9
> >>> @@ static const struct flash_info *spi_nor_read_id(struct spi_nor *nor)
> >>>   u8                      id[SPI_NOR_MAX_ID_LEN];
> >>>   const struct flash_info *info;
> >>>
> >>> + nor->spi->master->flags &= ~(SPI_MASTER_BOTH_CS |
> >>> +                                 SPI_MASTER_DATA_STRIPE);
> >>> +
> >>>   tmp = nor->read_reg(nor, SPINOR_OP_RDID, id,
> >> SPI_NOR_MAX_ID_LEN);
> >>>   if (tmp < 0) {
> >>>           dev_dbg(nor->dev, "error %d reading JEDEC ID\n", tmp);
> >> @@ -1041,6
> >>> +1082,7 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t
> >>> +from,
> >>> size_t len,  {
> >>>   struct spi_nor *nor = mtd_to_spi_nor(mtd);
> >>>   int ret;
> >>> + u32 offset = from;
> >>>
> >>>   dev_dbg(nor->dev, "from 0x%08x, len %zd\n", (u32)from, len);
> >>>
> >>> @@ -1049,7 +1091,13 @@ static int spi_nor_read(struct mtd_info *mtd,
> >> loff_t from, size_t len,
> >>>           return ret;
> >>>
> >>>   while (len) {
> >>> -         ret = nor->read(nor, from, len, buf);
> >>> +
> >>> +         offset = from;
> >>> +
> >>> +         if (nor->stripe)
> >>> +                 offset /= 2;
> >>> +
> >>> +         ret = nor->read(nor, offset, len, buf);
> >>>           if (ret == 0) {
> >>>                   /* We shouldn't see 0-length reads */
> >>>                   ret = -EIO;
> >>> @@ -1161,6 +1209,7 @@ static int spi_nor_write(struct mtd_info *mtd,
> >> loff_t to, size_t len,
> >>>   struct spi_nor *nor = mtd_to_spi_nor(mtd);
> >>>   size_t page_offset, page_remain, i;
> >>>   ssize_t ret;
> >>> + u32 offset;
> >>>
> >>>   dev_dbg(nor->dev, "to 0x%08x, len %zd\n", (u32)to, len);
> >>>
> >>> @@ -1178,9 +1227,13 @@ static int spi_nor_write(struct mtd_info
> >>> *mtd,
> >> loff_t to, size_t len,
> >>>           /* the size of data remaining on the first page */
> >>>           page_remain = min_t(size_t,
> >>>                               nor->page_size - page_offset, len - i);
> >>> +         offset = (to + i);
> >>> +
> >>> +         if (nor->stripe)
> >>> +                 offset /= 2;
> >>>
> >>>           write_enable(nor);
> >>> -         ret = nor->write(nor, to + i, page_remain, buf + i);
> >>> +         ret = nor->write(nor, (offset), page_remain, buf + i);
> >>>           if (ret < 0)
> >>>                   goto write_err;
> >>>           written = ret;
> >>> @@ -1302,22 +1355,22 @@ static int spi_nor_check(struct spi_nor
> >>> *nor)
> >>>
> >>>  int spi_nor_scan(struct spi_nor *nor, const char *name, enum
> >>> read_mode mode)  {
> >>> - const struct flash_info *info = NULL;
> >>> + struct flash_info *info = NULL;
> >>
> >> You should not remove the const and should not try to modify members
> >> of *info.
> >>
> >>>   struct device *dev = nor->dev;
> >>>   struct mtd_info *mtd = &nor->mtd;
> >>>   struct device_node *np = spi_nor_get_flash_node(nor);
> >>> - int ret;
> >>> - int i;
> >>> + struct device_node *np_spi;
> >>> + int ret, i, xlnx_qspi_mode;
> >>>
> >>>   ret = spi_nor_check(nor);
> >>>   if (ret)
> >>>           return ret;
> >>>
> >>>   if (name)
> >>> -         info = spi_nor_match_id(name);
> >>> +         info = (struct flash_info *)spi_nor_match_id(name);
> >>>   /* Try to auto-detect if chip name wasn't specified or not found */
> >>>   if (!info)
> >>> -         info = spi_nor_read_id(nor);
> >>> +         info = (struct flash_info *)spi_nor_read_id(nor);
> >>>   if (IS_ERR_OR_NULL(info))
> >>>           return -ENOENT;
> >>>
> >> Both spi_nor_match_id() and spi_nor_read_id(), when they succeed,
> >> return a pointer to an entry of the spi_nor_ids[] array, which is
> >> located in a read- only memory area.
> >>
> >> Since your patch doesn't remove the const attribute of the
> >> spi_nor_ids[], I wonder whether it has been tested. I expect it not
> >> to work on most architecture.
> >>
> >> Anyway spi_nor_ids[] should remain const. Let's take the case of
> >> eXecution In Place (XIP) from an external memory: if spi_nor_ids[] is
> >> const, it can be read directly from this external (read-only) memory
> >> and we never need to copy the array in RAM, so we save some KB of
> RAM.
> >> This is just an example but I guess we can find other reasons to keep
> >> this array const.
> >>
> >>> @@ -1341,7 +1394,7 @@ int spi_nor_scan(struct spi_nor *nor, const
> >>> char
> >> *name, enum read_mode mode)
> >>>                    */
> >>>                   dev_warn(dev, "found %s, expected %s\n",
> >>>                            jinfo->name, info->name);
> >>> -                 info = jinfo;
> >>> +                 info = (struct flash_info *)jinfo;
> >>>           }
> >>>   }
> >>>
> >>> @@ -1370,6 +1423,27 @@ int spi_nor_scan(struct spi_nor *nor, const
> >>> char
> >> *name, enum read_mode mode)
> >>>   mtd->size = info->sector_size * info->n_sectors;
> >>>   mtd->_erase = spi_nor_erase;
> >>>   mtd->_read = spi_nor_read;
> >>> +#ifdef CONFIG_OF
> >>> + np_spi = of_get_next_parent(np);
> >>> +
> >>> + if (of_property_read_u32(np_spi, "xlnx,qspi-mode",
> >>> +                         &xlnx_qspi_mode) < 0) {
> >> This really looks controller specific so should not be placed in the
> >> generic spi- nor.c file.
> >
> > Const is removed in info struct, because to update info members based
> parallel configuration.
> > As I mentioned above,  for this parallel configuration, mtd and
> > spi-nor should know the details like
> > mtd->size, info->sectors, sector_size and page_size.
>
> You can tune the values of nor->mtd.size, nor->mtd.erasesize, nor-
> >page_size or whatever member of nor/nor.mtd as needed without ever
> modifying members of *info.
>
> If you modify *info then spi_nor_scan() is called a 2nd time to probe and
> configure SPI memories of the same part but connected to another
> controller, the values of the modified members in this *info would not be
> those expected.
> So *info and the spi_nor_ids[] array must remain const.
>
> The *info structure is not used outside spi_nor_scan(); none of
> spi_nor_read(),
> spi_nor_write() and spi_nor_erase() refers to *info hence every relevant
> value can be set only nor or nor->mtd members.
>
>
> Anyway, I think OR'ing or AND'ing values of memory registers depending on
> the relevant bit we want to check is not the right solution.
> If done in spi-nor.c, there would be a specific case for each memory register
> we read, each register bit would have to be handled differently.
>
> spi-nor.c tries to support as much memory parts as possible, it deals with
> many registers and bits: Status/Control registers, Quad Enable bits...
>
> If we start to OR or AND each of these register values to support the
> stripping mode, spi-nor will become really hard to maintain.
>
> I don't know whether it could be done with the xilinx controller but I thought
> about first configuring the two memories independently calling
> spi_nor_scan() twice; one call for each memory.
>
> Then the xilinx driver could register only one struct mtd_info, overriding
> mtd->_read() [and likely mtd->_write() and mtd->_erase() too] set by
> spi_nor_scan() with a xilinx driver custom implementation so this driver
> supports its controller stripping mode as it wants.
>
> Of course, this solution assumes that the SPI controller has one dedicated
> chip-select line for each memory and not a single chip-select line shared by
> both memories. The memories should be configured independently: you
> can't assume multiple instances of the very same memory part always return
> the exact same value when reading one of their register. Logical AND/OR is
> not a generic solution, IMHO.
>
> If the xilinx controller has only one shared chip-select line then let's see
> whether 2 GPIO lines could be used as independent chip-select lines.
>
>
In parallel configuration, Physically we have two flashes but mtd will see as single flash memory (sum of both memories)
If we call spi_nor_scan(), twice then read/write will override but nor->mtd.size, nor->mtd.erasesize, nor->page_size  will remain same, I,e they will also override, they won't append.
I tried calling spi_nor_scan() twice by some hacks but nor->mtd.size, nor->mtd.erasesize, nor->page_size are not changing
Also the same issue we are getting for flash address, need to shift the address to work in this configuration.
Also to tune  nor->mtd.size, nor->mtd.erasesize, nor->page_size, we need to touch this spi-nor.c

Please kindly suggest, if I am wrong.

Thanks,
Naga Sureshkumar Relli

> Best regards,
>
> Cyrille


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
