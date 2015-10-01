From: lkp@intel.com (kbuild test robot)
Date: Thu, 1 Oct 2015 16:17:30 +0800
Subject: [PATCH v3 2/3] mtd: mtk-nor: mtk serial flash controller driver
In-Reply-To: <1443685492-9996-3-git-send-email-bayi.cheng@mediatek.com>
Message-ID: <201510011630.yO6mbrG3%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bayi,

[auto build test results on v4.3-rc3 -- if it's inappropriate base, please ignore]

reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/mtd/spi-nor/mtk-quadspi.c:310:52: sparse: incorrect type in argument 4 (different modifiers)
   drivers/mtd/spi-nor/mtk-quadspi.c:310:52:    expected unsigned char [usertype] *[assigned] data
   drivers/mtd/spi-nor/mtk-quadspi.c:310:52:    got unsigned char const [usertype] *[assigned] buf
>> drivers/mtd/spi-nor/mtk-quadspi.c:391:18: sparse: incorrect type in assignment (different base types)
   drivers/mtd/spi-nor/mtk-quadspi.c:391:18:    expected struct mtd_info *mtd
   drivers/mtd/spi-nor/mtk-quadspi.c:391:18:    got struct mtd_info <noident>
   drivers/mtd/spi-nor/mtk-quadspi.c:402:17: sparse: expected structure or union
   drivers/mtd/spi-nor/mtk-quadspi.c:403:17: sparse: expected structure or union
   drivers/mtd/spi-nor/mtk-quadspi.c: In function 'mt8173_nor_write':
   drivers/mtd/spi-nor/mtk-quadspi.c:310:10: warning: passing argument 4 of 'mt8173_nor_write_single_byte' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
             buf);
             ^
   drivers/mtd/spi-nor/mtk-quadspi.c:246:12: note: expected 'u8 * {aka unsigned char *}' but argument is of type 'const u_char * {aka const unsigned char *}'
    static int mt8173_nor_write_single_byte(struct mt8173_nor *mt8173_nor,
               ^
   drivers/mtd/spi-nor/mtk-quadspi.c: In function 'mtk_nor_init':
   drivers/mtd/spi-nor/mtk-quadspi.c:391:11: error: incompatible types when assigning to type 'struct mtd_info *' from type 'struct mtd_info'
     nor->mtd = *mtd;
              ^
   drivers/mtd/spi-nor/mtk-quadspi.c:402:10: error: request for member 'owner' in something not a structure or union
     nor->mtd.owner = THIS_MODULE;
             ^
   drivers/mtd/spi-nor/mtk-quadspi.c:403:10: error: request for member 'name' in something not a structure or union
     nor->mtd.name = "mtk_nor";
             ^
   drivers/mtd/spi-nor/mtk-quadspi.c:410:36: warning: passing argument 1 of 'mtd_device_parse_register' from incompatible pointer type [-Wincompatible-pointer-types]
     return  mtd_device_parse_register(&nor->mtd, NULL, ppdata, NULL, 0);
                                       ^
   In file included from drivers/mtd/spi-nor/mtk-quadspi.c:24:0:
   include/linux/mtd/mtd.h:372:12: note: expected 'struct mtd_info *' but argument is of type 'struct mtd_info **'
    extern int mtd_device_parse_register(struct mtd_info *mtd,
               ^

vim +310 drivers/mtd/spi-nor/mtk-quadspi.c

   304		ret = mt8173_nor_write_buffer_disable(mt8173_nor);
   305		if (ret < 0)
   306			dev_warn(mt8173_nor->dev, "write buffer disable failed!\n");
   307	
   308		if (len) {
   309			ret = mt8173_nor_write_single_byte(mt8173_nor, to, (int)len,
 > 310							   buf);
   311			if (ret < 0)
   312				dev_warn(mt8173_nor->dev, "write single byte failed!\n");
   313			(*retlen) += len;
   314		}
   315	}
   316	
   317	static int mt8173_nor_read_reg(struct spi_nor *nor, u8 opcode, u8 *buf, int len)
   318	{
   319		int ret;
   320		struct mt8173_nor *mt8173_nor = nor->priv;
   321	
   322		/* mtk nor controller doesn't supoort SPINOR_OP_RDCR */
   323		switch (opcode) {
   324		case SPINOR_OP_RDID:
   325			/* read JEDEC ID need 4 bytes commands */
   326			ret = mt8173_nor_set_cmd(mt8173_nor, 0, 32, SPINOR_OP_RDID);
   327			if (ret < 0)
   328				return ret;
   329	
   330			/* mtk nor flash controller only support 3 bytes IDs */
   331			buf[2] = readb(mt8173_nor->base + MTK_NOR_SHREG0_REG);
   332			buf[1] = readb(mt8173_nor->base + MTK_NOR_SHREG1_REG);
   333			buf[0] = readb(mt8173_nor->base + MTK_NOR_SHREG2_REG);
   334			break;
   335		case SPINOR_OP_RDSR:
   336			ret = mt8173_nor_execute_cmd(mt8173_nor, MTK_NOR_RDSR_CMD);
   337			if (ret < 0)
   338				return ret;
   339			*buf = readb(mt8173_nor->base + MTK_NOR_RDSR_REG);
   340			break;
   341		default:
   342			ret = -EINVAL;
   343			break;
   344		}
   345		return ret;
   346	}
   347	
   348	static int mt8173_nor_write_reg(struct spi_nor *nor, u8 opcode, u8 *buf,
   349					int len, int write_enable)
   350	{
   351		int ret;
   352		struct mt8173_nor *mt8173_nor = nor->priv;
   353	
   354		switch (opcode) {
   355		case SPINOR_OP_WRSR:
   356			ret = mt8173_nor_set_para(mt8173_nor, *buf,
   357						  MTK_NOR_WRSR_CMD);
   358			break;
   359		case SPINOR_OP_CHIP_ERASE:
   360			ret = mt8173_nor_set_para(mt8173_nor, opcode,
   361						  MTK_NOR_PRG_CMD);
   362			break;
   363		case SPINOR_OP_WREN:
   364			ret = mt8173_nor_set_cmd(mt8173_nor, 0, 8, opcode);
   365			if (ret)
   366				dev_warn(mt8173_nor->dev, "set write enable fail!\n");
   367			break;
   368		case SPINOR_OP_WRDI:
   369			ret = mt8173_nor_set_cmd(mt8173_nor, 0, 8, opcode);
   370			if (ret)
   371				dev_warn(mt8173_nor->dev, "set write disable fail!\n");
   372			break;
   373		default:
   374			dev_warn(mt8173_nor->dev, "doesn't support cmd %d\n", opcode);
   375			ret = -EINVAL;
   376			break;
   377		}
   378		return ret;
   379	}
   380	
   381	static int __init mtk_nor_init(struct mt8173_nor *mt8173_nor,
   382				       struct mtd_part_parser_data *ppdata)
   383	{
   384		int ret;
   385		struct spi_nor *nor;
   386		struct mtd_info *mtd;
   387	
   388		writel(MTK_NOR_ENABLE_SF_CMD, mt8173_nor->base + MTK_NOR_WRPROT_REG);
   389		nor = &mt8173_nor->nor;
   390		mtd = &mt8173_nor->mtd;
 > 391		nor->mtd = *mtd;
   392		nor->dev = mt8173_nor->dev;
   393		nor->priv = mt8173_nor;
   394		mtd->priv = nor;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
