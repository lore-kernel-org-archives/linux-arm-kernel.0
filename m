From: fengguang.wu@intel.com (kbuild test robot)
Date: Mon, 31 Jul 2017 16:09:27 +0800
Subject: [xlnx:master 553/864] drivers/mtd/spi-nor/spi-nor.c:2000:4: error:
 implicit declaration of function 'of_get_next_parent'
Message-ID: <201707311626.CDmICK1A%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Naga,

FYI, the error/warning still remains.

tree:   https://github.com/Xilinx/linux-xlnx master
head:   00346d2eba7634f4fb2c2117ac371e0c104a2870
commit: d80f6153e7c446e0c7dc8400b06d199c50bfd509 [553/864] mtd: spi-nor: Disable 4-Byte addressing for axi_quad_spi
config: i386-randconfig-n0-201731 (attached as .config)
compiler: gcc-4.8 (Debian 4.8.4-1) 4.8.4
reproduce:
        git checkout d80f6153e7c446e0c7dc8400b06d199c50bfd509
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/mtd/spi-nor/spi-nor.c: In function 'spi_nor_scan':
>> drivers/mtd/spi-nor/spi-nor.c:2000:4: error: implicit declaration of function 'of_get_next_parent' [-Werror=implicit-function-declaration]
       np_spi = of_get_next_parent(np);
       ^
   drivers/mtd/spi-nor/spi-nor.c:2000:11: warning: assignment makes pointer from integer without a cast [enabled by default]
       np_spi = of_get_next_parent(np);
              ^
   drivers/mtd/spi-nor/spi-nor.c:1728:6: warning: unused variable 'is_dual' [-Wunused-variable]
     u32 is_dual;
         ^
   drivers/mtd/spi-nor/spi-nor.c: At top level:
   drivers/mtd/spi-nor/spi-nor.c:266:12: warning: 'read_ear' defined but not used [-Wunused-function]
    static int read_ear(struct spi_nor *nor, struct flash_info *info)
               ^
   cc1: some warnings being treated as errors

vim +/of_get_next_parent +2000 drivers/mtd/spi-nor/spi-nor.c

  1862	
  1863		/* NOR protection support for STmicro/Micron chips and similar */
  1864		if (JEDEC_MFR(info) == SNOR_MFR_MICRON ||
  1865				info->flags & SPI_NOR_HAS_LOCK) {
  1866			nor->flash_lock = stm_lock;
  1867			nor->flash_unlock = stm_unlock;
  1868			nor->flash_is_locked = stm_is_locked;
  1869		}
  1870	
  1871		if (nor->flash_lock && nor->flash_unlock && nor->flash_is_locked) {
  1872			mtd->_lock = spi_nor_lock;
  1873			mtd->_unlock = spi_nor_unlock;
  1874			mtd->_is_locked = spi_nor_is_locked;
  1875		}
  1876	
  1877		/* sst nor chips use AAI word program */
  1878		if (info->flags & SST_WRITE)
  1879			mtd->_write = sst_write;
  1880		else
  1881			mtd->_write = spi_nor_write;
  1882	
  1883		if (info->flags & USE_FSR)
  1884			nor->flags |= SNOR_F_USE_FSR;
  1885		if (info->flags & SPI_NOR_HAS_TB)
  1886			nor->flags |= SNOR_F_HAS_SR_TB;
  1887	
  1888	#ifdef CONFIG_MTD_SPI_NOR_USE_4K_SECTORS
  1889		/* prefer "small sector" erase if possible */
  1890		if (info->flags & SECT_4K) {
  1891			nor->erase_opcode = SPINOR_OP_BE_4K;
  1892			mtd->erasesize = 4096 << nor->shift;
  1893		} else if (info->flags & SECT_4K_PMC) {
  1894			nor->erase_opcode = SPINOR_OP_BE_4K_PMC;
  1895			mtd->erasesize = 4096 << nor->shift;
  1896		} else
  1897	#endif
  1898		{
  1899			nor->erase_opcode = SPINOR_OP_SE;
  1900			mtd->erasesize = info->sector_size;
  1901		}
  1902	
  1903		if (info->flags & SPI_NOR_NO_ERASE)
  1904			mtd->flags |= MTD_NO_ERASE;
  1905	
  1906		nor->jedec_id = info->id[0];
  1907		mtd->dev.parent = dev;
  1908		nor->page_size = info->page_size;
  1909		mtd->writebufsize = nor->page_size;
  1910	
  1911		if (np) {
  1912			/* If we were instantiated by DT, use it */
  1913			if (of_property_read_bool(np, "m25p,fast-read"))
  1914				nor->flash_read = SPI_NOR_FAST;
  1915			else
  1916				nor->flash_read = SPI_NOR_NORMAL;
  1917		} else {
  1918			/* If we weren't instantiated by DT, default to fast-read */
  1919			nor->flash_read = SPI_NOR_FAST;
  1920		}
  1921	
  1922		/* Some devices cannot do fast-read, no matter what DT tells us */
  1923		if (info->flags & SPI_NOR_NO_FR)
  1924			nor->flash_read = SPI_NOR_NORMAL;
  1925	
  1926		/* Quad/Dual-read mode takes precedence over fast/normal */
  1927		if (mode == SPI_NOR_QUAD && info->flags & SPI_NOR_QUAD_READ) {
  1928			ret = set_quad_mode(nor, info);
  1929			if (ret) {
  1930				dev_err(dev, "quad mode not supported\n");
  1931				return ret;
  1932			}
  1933			nor->flash_read = SPI_NOR_QUAD;
  1934		} else if (mode == SPI_NOR_DUAL && info->flags & SPI_NOR_DUAL_READ) {
  1935			nor->flash_read = SPI_NOR_DUAL;
  1936		}
  1937	
  1938		/* Default commands */
  1939		switch (nor->flash_read) {
  1940		case SPI_NOR_QUAD:
  1941			nor->read_opcode = SPINOR_OP_READ_1_1_4;
  1942			break;
  1943		case SPI_NOR_DUAL:
  1944			nor->read_opcode = SPINOR_OP_READ_1_1_2;
  1945			break;
  1946		case SPI_NOR_FAST:
  1947			nor->read_opcode = SPINOR_OP_READ_FAST;
  1948			break;
  1949		case SPI_NOR_NORMAL:
  1950			nor->read_opcode = SPINOR_OP_READ;
  1951			break;
  1952		default:
  1953			dev_err(dev, "No Read opcode defined\n");
  1954			return -EINVAL;
  1955		}
  1956	
  1957		nor->program_opcode = SPINOR_OP_PP;
  1958	
  1959		if (info->addr_width)
  1960			nor->addr_width = info->addr_width;
  1961		else if (mtd->size > 0x1000000) {
  1962	#ifdef CONFIG_OF
  1963			np_spi = of_get_next_parent(np);
  1964			if (of_property_match_string(np_spi, "compatible",
  1965						     "xlnx,zynq-qspi-1.0") >= 0) {
  1966				int status;
  1967	
  1968				nor->addr_width = 3;
  1969				set_4byte(nor, info, 0);
  1970				status = read_ear(nor, info);
  1971				if (status < 0)
  1972					dev_warn(dev, "failed to read ear reg\n");
  1973				else
  1974					nor->curbank = status & EAR_SEGMENT_MASK;
  1975			} else {
  1976	#endif
  1977			/* enable 4-byte addressing if the device exceeds 16MiB */
  1978			nor->addr_width = 4;
  1979			if (JEDEC_MFR(info) == SNOR_MFR_SPANSION) {
  1980				/* Dedicated 4-byte command set */
  1981				switch (nor->flash_read) {
  1982				case SPI_NOR_QUAD:
  1983					nor->read_opcode = SPINOR_OP_READ4_1_1_4;
  1984					break;
  1985				case SPI_NOR_DUAL:
  1986					nor->read_opcode = SPINOR_OP_READ4_1_1_2;
  1987					break;
  1988				case SPI_NOR_FAST:
  1989					nor->read_opcode = SPINOR_OP_READ4_FAST;
  1990					break;
  1991				case SPI_NOR_NORMAL:
  1992					nor->read_opcode = SPINOR_OP_READ4;
  1993					break;
  1994				}
  1995				nor->program_opcode = SPINOR_OP_PP_4B;
  1996				/* No small sector erase for 4-byte command set */
  1997				nor->erase_opcode = SPINOR_OP_SE_4B;
  1998				mtd->erasesize = info->sector_size;
  1999			} else {
> 2000				np_spi = of_get_next_parent(np);
  2001				if (of_property_match_string(np_spi, "compatible",
  2002							"xlnx,xps-spi-2.00.a") >= 0) {
  2003					nor->addr_width = 3;
  2004					set_4byte(nor, info, 0);
  2005				} else {
  2006					set_4byte(nor, info, 1);
  2007					if (nor->isstacked) {
  2008						nor->spi->master->flags |=
  2009								SPI_MASTER_U_PAGE;
  2010						set_4byte(nor, info, 1);
  2011						nor->spi->master->flags &=
  2012								~SPI_MASTER_U_PAGE;
  2013					}
  2014				}
  2015			}
  2016	#ifdef CONFIG_OF
  2017			}
  2018	#endif
  2019		} else {
  2020			nor->addr_width = 3;
  2021		}
  2022	
  2023		if (nor->addr_width > SPI_NOR_MAX_ADDR_WIDTH) {
  2024			dev_err(dev, "address width is too large: %u\n",
  2025				nor->addr_width);
  2026			return -EINVAL;
  2027		}
  2028	
  2029		nor->read_dummy = spi_nor_read_dummy_cycles(nor);
  2030	
  2031		dev_info(dev, "%s (%lld Kbytes)\n", info->name,
  2032				(long long)mtd->size >> 10);
  2033	
  2034		dev_dbg(dev,
  2035			"mtd .name = %s, .size = 0x%llx (%lldMiB), "
  2036			".erasesize = 0x%.8x (%uKiB) .numeraseregions = %d\n",
  2037			mtd->name, (long long)mtd->size, (long long)(mtd->size >> 20),
  2038			mtd->erasesize, mtd->erasesize / 1024, mtd->numeraseregions);
  2039	
  2040		if (mtd->numeraseregions)
  2041			for (i = 0; i < mtd->numeraseregions; i++)
  2042				dev_dbg(dev,
  2043					"mtd.eraseregions[%d] = { .offset = 0x%llx, "
  2044					".erasesize = 0x%.8x (%uKiB), "
  2045					".numblocks = %d }\n",
  2046					i, (long long)mtd->eraseregions[i].offset,
  2047					mtd->eraseregions[i].erasesize,
  2048					mtd->eraseregions[i].erasesize / 1024,
  2049					mtd->eraseregions[i].numblocks);
  2050		return 0;
  2051	}
  2052	EXPORT_SYMBOL_GPL(spi_nor_scan);
  2053	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 25044 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170731/fe9dbda3/attachment-0001.gz>
