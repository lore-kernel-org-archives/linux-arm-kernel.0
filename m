From: lkp@intel.com (kbuild test robot)
Date: Wed, 9 May 2018 20:25:10 +0800
Subject: [xlnx:xlnx_rebase_v4.14 367/917]
 drivers/mtd//spi-nor/spi-nor.c:3325:14: error: implicit declaration of
 function 'of_get_next_parent'; did you mean 'of_get_parent'?
Message-ID: <201805092007.PorAH6DM%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx xlnx_rebase_v4.14
head:   a24ae3acb778c948234fa8f227bacd818034055d
commit: d3a1372dc6bd249b722ff7250753b5df07262028 [367/917] mtd: spi-nor: Disable 4-Byte addressing for axi_quad_spi
config: i386-randconfig-i0-201818 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        git checkout d3a1372dc6bd249b722ff7250753b5df07262028
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/mtd//spi-nor/spi-nor.c: In function 'spi_nor_scan':
>> drivers/mtd//spi-nor/spi-nor.c:3325:14: error: implicit declaration of function 'of_get_next_parent'; did you mean 'of_get_parent'? [-Werror=implicit-function-declaration]
        np_spi = of_get_next_parent(np);
                 ^~~~~~~~~~~~~~~~~~
                 of_get_parent
   drivers/mtd//spi-nor/spi-nor.c:3325:12: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
        np_spi = of_get_next_parent(np);
               ^
   drivers/mtd//spi-nor/spi-nor.c:3071:6: warning: unused variable 'is_dual' [-Wunused-variable]
     u32 is_dual;
         ^~~~~~~
   At top level:
   drivers/mtd//spi-nor/spi-nor.c:323:12: warning: 'read_ear' defined but not used [-Wunused-function]
    static int read_ear(struct spi_nor *nor, struct flash_info *info)
               ^~~~~~~~
   cc1: some warnings being treated as errors

vim +3325 drivers/mtd//spi-nor/spi-nor.c

  3261	
  3262		if (info->flags & SPI_NOR_NO_ERASE)
  3263			mtd->flags |= MTD_NO_ERASE;
  3264	
  3265		nor->jedec_id = info->id[0];
  3266		mtd->dev.parent = dev;
  3267		nor->page_size = params.page_size;
  3268		mtd->writebufsize = nor->page_size;
  3269	
  3270		if (np) {
  3271			/* If we were instantiated by DT, use it */
  3272			if (of_property_read_bool(np, "m25p,fast-read"))
  3273				params.hwcaps.mask |= SNOR_HWCAPS_READ_FAST;
  3274			else
  3275				params.hwcaps.mask &= ~SNOR_HWCAPS_READ_FAST;
  3276		} else {
  3277			/* If we weren't instantiated by DT, default to fast-read */
  3278			params.hwcaps.mask |= SNOR_HWCAPS_READ_FAST;
  3279		}
  3280	
  3281		/* Some devices cannot do fast-read, no matter what DT tells us */
  3282		if (info->flags & SPI_NOR_NO_FR)
  3283			params.hwcaps.mask &= ~SNOR_HWCAPS_READ_FAST;
  3284	
  3285		/*
  3286		 * Configure the SPI memory:
  3287		 * - select op codes for (Fast) Read, Page Program and Sector Erase.
  3288		 * - set the number of dummy cycles (mode cycles + wait states).
  3289		 * - set the SPI protocols for register and memory accesses.
  3290		 * - set the Quad Enable bit if needed (required by SPI x-y-4 protos).
  3291		 */
  3292		ret = spi_nor_setup(nor, info, &params, hwcaps);
  3293		if (ret)
  3294			return ret;
  3295	
  3296		if (nor->addr_width) {
  3297			/* already configured from SFDP */
  3298		} else if (info->addr_width) {
  3299			nor->addr_width = info->addr_width;
  3300		} else if (mtd->size > 0x1000000) {
  3301	#ifdef CONFIG_OF
  3302			np_spi = of_get_next_parent(np);
  3303			if (of_property_match_string(np_spi, "compatible",
  3304						     "xlnx,zynq-qspi-1.0") >= 0) {
  3305				int status;
  3306	
  3307				nor->addr_width = 3;
  3308				set_4byte(nor, info, 0);
  3309				status = read_ear(nor, info);
  3310				if (status < 0)
  3311					dev_warn(dev, "failed to read ear reg\n");
  3312				else
  3313					nor->curbank = status & EAR_SEGMENT_MASK;
  3314			} else {
  3315	#endif
  3316				/*
  3317				 * enable 4-byte addressing
  3318				 * if the device exceeds 16MiB
  3319				 */
  3320				nor->addr_width = 4;
  3321				if (JEDEC_MFR(info) == SNOR_MFR_SPANSION ||
  3322				    info->flags & SPI_NOR_4B_OPCODES)
  3323					spi_nor_set_4byte_opcodes(nor, info);
  3324				else {
> 3325					np_spi = of_get_next_parent(np);
  3326					if (of_property_match_string(np_spi,
  3327							"compatible",
  3328							"xlnx,xps-spi-2.00.a") >= 0) {
  3329						nor->addr_width = 3;
  3330						set_4byte(nor, info, 0);
  3331					} else {
  3332						set_4byte(nor, info, 1);
  3333						if (nor->isstacked) {
  3334							nor->spi->master->flags |=
  3335								SPI_MASTER_U_PAGE;
  3336							set_4byte(nor, info, 1);
  3337							nor->spi->master->flags &=
  3338								~SPI_MASTER_U_PAGE;
  3339						}
  3340					}
  3341				}
  3342	#ifdef CONFIG_OF
  3343			}
  3344	#endif
  3345		} else {
  3346			nor->addr_width = 3;
  3347		}
  3348	
  3349		if (nor->addr_width > SPI_NOR_MAX_ADDR_WIDTH) {
  3350			dev_err(dev, "address width is too large: %u\n",
  3351				nor->addr_width);
  3352			return -EINVAL;
  3353		}
  3354	
  3355		if (info->flags & SPI_S3AN) {
  3356			ret = s3an_nor_scan(info, nor);
  3357			if (ret)
  3358				return ret;
  3359		}
  3360	
  3361		dev_info(dev, "%s (%lld Kbytes)\n", info->name,
  3362				(long long)mtd->size >> 10);
  3363	
  3364		dev_dbg(dev,
  3365			"mtd .name = %s, .size = 0x%llx (%lldMiB), "
  3366			".erasesize = 0x%.8x (%uKiB) .numeraseregions = %d\n",
  3367			mtd->name, (long long)mtd->size, (long long)(mtd->size >> 20),
  3368			mtd->erasesize, mtd->erasesize / 1024, mtd->numeraseregions);
  3369	
  3370		if (mtd->numeraseregions)
  3371			for (i = 0; i < mtd->numeraseregions; i++)
  3372				dev_dbg(dev,
  3373					"mtd.eraseregions[%d] = { .offset = 0x%llx, "
  3374					".erasesize = 0x%.8x (%uKiB), "
  3375					".numblocks = %d }\n",
  3376					i, (long long)mtd->eraseregions[i].offset,
  3377					mtd->eraseregions[i].erasesize,
  3378					mtd->eraseregions[i].erasesize / 1024,
  3379					mtd->eraseregions[i].numblocks);
  3380		return 0;
  3381	}
  3382	EXPORT_SYMBOL_GPL(spi_nor_scan);
  3383	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 30173 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180509/6efa93db/attachment-0001.gz>
