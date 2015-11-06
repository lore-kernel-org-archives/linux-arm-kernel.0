From: lkp@intel.com (kbuild test robot)
Date: Sat, 7 Nov 2015 01:19:13 +0800
Subject: [PATCH v6 2/3] mtd: mtk-nor: mtk serial flash controller driver
In-Reply-To: <1446824889-16144-3-git-send-email-bayi.cheng@mediatek.com>
Message-ID: <201511070104.OaJ5fn5L%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bayi,

[auto build test ERROR on mtd/master]
[also build test ERROR on v4.3 next-20151106]

url:    https://github.com/0day-ci/linux/commits/Bayi-Cheng/Mediatek-SPI-NOR-flash-driver/20151106-235157
base:   git://git.infradead.org/linux-mtd.git master
config: i386-allmodconfig (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/mtd/spi-nor/mtk-quadspi.c: In function 'mtk_nor_init':
>> drivers/mtd/spi-nor/mtk-quadspi.c:381:5: error: 'struct spi_nor' has no member named 'flash_node'
     nor->flash_node = flash_node;
        ^
   drivers/mtd/spi-nor/mtk-quadspi.c:387:17: warning: assignment from incompatible pointer type [-Wincompatible-pointer-types]
     nor->write_reg = mt8173_nor_write_reg;
                    ^
>> drivers/mtd/spi-nor/mtk-quadspi.c:388:10: error: request for member 'owner' in something not a structure or union
     nor->mtd.owner = THIS_MODULE;
             ^
>> drivers/mtd/spi-nor/mtk-quadspi.c:389:10: error: request for member 'name' in something not a structure or union
     nor->mtd.name = "mtk_nor";
             ^
   drivers/mtd/spi-nor/mtk-quadspi.c:395:35: warning: passing argument 1 of 'mtd_device_parse_register' from incompatible pointer type [-Wincompatible-pointer-types]
     return mtd_device_parse_register(&nor->mtd, NULL, &ppdata, NULL, 0);
                                      ^
   In file included from drivers/mtd/spi-nor/mtk-quadspi.c:24:0:
   include/linux/mtd/mtd.h:372:12: note: expected 'struct mtd_info *' but argument is of type 'struct mtd_info **'
    extern int mtd_device_parse_register(struct mtd_info *mtd,
               ^

coccinelle warnings: (new ones prefixed by >>)

>> drivers/mtd/spi-nor/mtk-quadspi.c:223:6-28: Move constant to right.
   drivers/mtd/spi-nor/mtk-quadspi.c:214:6-10: Move constant to right.

Please review and possibly fold the followup patch.

vim +381 drivers/mtd/spi-nor/mtk-quadspi.c

   217	static int mt8173_nor_write_buffer_disable(struct mt8173_nor *mt8173_nor)
   218	{
   219		u8 reg;
   220	
   221		writel(MTK_NOR_WR_BUF_DISABLE, mt8173_nor->base + MTK_NOR_CFG2_REG);
   222		return readb_poll_timeout(mt8173_nor->base + MTK_NOR_CFG2_REG, reg,
 > 223					  MTK_NOR_WR_BUF_DISABLE == (reg & 0x1), 100,
   224					  10000);
   225	}
   226	
   227	static void mt8173_nor_set_addr(struct mt8173_nor *mt8173_nor, u32 addr)
   228	{
   229		int i;
   230	
   231		for (i = 0; i < 3; i++) {
   232			writeb(addr & 0xff, mt8173_nor->base + MTK_NOR_RADR0_REG + i * 4);
   233			addr >>= 8;
   234		}
   235		/* Last register is non-contiguous */
   236		writeb(addr & 0xff, mt8173_nor->base + MTK_NOR_RADR3_REG);
   237	}
   238	
   239	static int mt8173_nor_read(struct spi_nor *nor, loff_t from, size_t length,
   240				   size_t *retlen, u_char *buffer)
   241	{
   242		int i, ret;
   243		int addr = (int)from;
   244		u8 *buf = (u8 *)buffer;
   245		struct mt8173_nor *mt8173_nor = nor->priv;
   246	
   247		/* set mode for fast read mode ,dual mode or quad mode */
   248		mt8173_nor_set_read_mode(mt8173_nor);
   249		mt8173_nor_set_addr(mt8173_nor, addr);
   250	
   251		for (i = 0; i < length; i++, (*retlen)++) {
   252			ret = mt8173_nor_execute_cmd(mt8173_nor, MTK_NOR_PIO_READ_CMD);
   253			if (ret < 0)
   254				return ret;
   255			buf[i] = readb(mt8173_nor->base + MTK_NOR_RDATA_REG);
   256		}
   257		return 0;
   258	}
   259	
   260	static int mt8173_nor_write_single_byte(struct mt8173_nor *mt8173_nor,
   261						int addr, int length, u8 *data)
   262	{
   263		int i, ret;
   264	
   265		mt8173_nor_set_addr(mt8173_nor, addr);
   266	
   267		for (i = 0; i < length; i++) {
   268			ret = mt8173_nor_execute_cmd(mt8173_nor, MTK_NOR_PIO_WR_CMD);
   269			if (ret < 0)
   270				return ret;
   271			writeb(*data++, mt8173_nor->base + MTK_NOR_WDATA_REG);
   272		}
   273		return 0;
   274	}
   275	
   276	static int mt8173_nor_write_buffer(struct mt8173_nor *mt8173_nor, int addr,
   277					   const u8 *buf)
   278	{
   279		int i, bufidx, data;
   280	
   281		mt8173_nor_set_addr(mt8173_nor, addr);
   282	
   283		bufidx = 0;
   284		for (i = 0; i < SFLASH_WRBUF_SIZE; i += 4) {
   285			data = buf[bufidx + 3]<<24 | buf[bufidx + 2]<<16 |
   286			       buf[bufidx + 1]<<8 | buf[bufidx];
   287			bufidx += 4;
   288			writel(data, mt8173_nor->base + MTK_NOR_PP_DATA_REG);
   289		}
   290		return mt8173_nor_execute_cmd(mt8173_nor, MTK_NOR_WR_CMD);
   291	}
   292	
   293	static void mt8173_nor_write(struct spi_nor *nor, loff_t to, size_t len,
   294				     size_t *retlen, const u_char *buf)
   295	{
   296		int ret;
   297		struct mt8173_nor *mt8173_nor = nor->priv;
   298	
   299		ret = mt8173_nor_write_buffer_enable(mt8173_nor);
   300		if (ret < 0)
   301			dev_warn(mt8173_nor->dev, "write buffer enable failed!\n");
   302	
   303		while (len >= SFLASH_WRBUF_SIZE) {
   304			ret = mt8173_nor_write_buffer(mt8173_nor, to, buf);
   305			if (ret < 0)
   306				dev_err(mt8173_nor->dev, "write buffer failed!\n");
   307			len -= SFLASH_WRBUF_SIZE;
   308			to += SFLASH_WRBUF_SIZE;
   309			buf += SFLASH_WRBUF_SIZE;
   310			(*retlen) += SFLASH_WRBUF_SIZE;
   311		}
   312		ret = mt8173_nor_write_buffer_disable(mt8173_nor);
   313		if (ret < 0)
   314			dev_warn(mt8173_nor->dev, "write buffer disable failed!\n");
   315	
   316		if (len) {
   317			ret = mt8173_nor_write_single_byte(mt8173_nor, to, (int)len,
   318							   (u8 *)buf);
   319			if (ret < 0)
   320				dev_err(mt8173_nor->dev, "write single byte failed!\n");
   321			(*retlen) += len;
   322		}
   323	}
   324	
   325	static int mt8173_nor_read_reg(struct spi_nor *nor, u8 opcode, u8 *buf, int len)
   326	{
   327		int ret;
   328		struct mt8173_nor *mt8173_nor = nor->priv;
   329	
   330		switch (opcode) {
   331		case SPINOR_OP_RDSR:
   332			ret = mt8173_nor_execute_cmd(mt8173_nor, MTK_NOR_RDSR_CMD);
   333			if (ret < 0)
   334				return ret;
   335			if (len == 1)
   336				*buf = readb(mt8173_nor->base + MTK_NOR_RDSR_REG);
   337			else
   338				dev_err(mt8173_nor->dev, "len should be 1 for read status!\n");
   339			break;
   340		default:
   341			ret = mt8173_nor_do_tx_rx(mt8173_nor, opcode, NULL, 0, buf, len);
   342			break;
   343		}
   344		return ret;
   345	}
   346	
   347	static int mt8173_nor_write_reg(struct spi_nor *nor, u8 opcode, u8 *buf,
   348					int len)
   349	{
   350		int ret;
   351		struct mt8173_nor *mt8173_nor = nor->priv;
   352	
   353		switch (opcode) {
   354		case SPINOR_OP_WRSR:
   355			/* We only handle 1 byte */
   356			ret = mt8173_nor_wr_sr(mt8173_nor, *buf);
   357			break;
   358		default:
   359			ret = mt8173_nor_do_tx_rx(mt8173_nor, opcode, buf, len, NULL, 0);
   360			if (ret)
   361				dev_warn(mt8173_nor->dev, "write reg failure!\n");
   362			break;
   363		}
   364		return ret;
   365	}
   366	
   367	static int __init mtk_nor_init(struct mt8173_nor *mt8173_nor,
   368				       struct device_node *flash_node)
   369	{
   370		struct mtd_part_parser_data ppdata = {
   371			.of_node = flash_node,
   372		};
   373		int ret;
   374		struct spi_nor *nor;
   375		/* initialize controller to accept commands */
   376		writel(MTK_NOR_ENABLE_SF_CMD, mt8173_nor->base + MTK_NOR_WRPROT_REG);
   377	
   378		nor = &mt8173_nor->nor;
   379		nor->dev = mt8173_nor->dev;
   380		nor->priv = mt8173_nor;
 > 381		nor->flash_node = flash_node;
   382	
   383		/* fill the hooks to spi nor */
   384		nor->read = mt8173_nor_read;
   385		nor->read_reg = mt8173_nor_read_reg;
   386		nor->write = mt8173_nor_write;
   387		nor->write_reg = mt8173_nor_write_reg;
 > 388		nor->mtd.owner = THIS_MODULE;
 > 389		nor->mtd.name = "mtk_nor";
   390		/* initialized with NULL */
   391		ret = spi_nor_scan(nor, NULL, SPI_NOR_DUAL);
   392		if (ret)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 51507 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151107/2856d2b0/attachment-0001.obj>
