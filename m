From: lkp@intel.com (kbuild test robot)
Date: Tue, 13 Oct 2015 20:44:24 +0800
Subject: [PATCH v4 2/3] mtd: mtk-nor: mtk serial flash controller driver
In-Reply-To: <1444729160-26433-3-git-send-email-bayi.cheng@mediatek.com>
Message-ID: <201510132008.YqYdO9Pj%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bayi,

[auto build test ERROR on mtd/master -- if it's inappropriate base, please suggest rules for selecting the more suitable base]

url:    https://github.com/0day-ci/linux/commits/Bayi-Cheng/Mediatek-SPI-NOR-flash-driver/20151013-174438
config: x86_64-allmodconfig (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All error/warnings (new ones prefixed by >>):

   drivers/mtd/spi-nor/mtk-quadspi.c:391:18: sparse: incorrect type in assignment (different base types)
   drivers/mtd/spi-nor/mtk-quadspi.c:391:18:    expected struct mtd_info *mtd
   drivers/mtd/spi-nor/mtk-quadspi.c:391:18:    got struct mtd_info <noident>
   drivers/mtd/spi-nor/mtk-quadspi.c:400:24: sparse: incorrect type in assignment (different argument counts)
   drivers/mtd/spi-nor/mtk-quadspi.c:400:24:    expected int ( *write_reg )( ... )
   drivers/mtd/spi-nor/mtk-quadspi.c:400:24:    got int ( static [toplevel] *<noident> )( ... )
   drivers/mtd/spi-nor/mtk-quadspi.c:402:17: sparse: expected structure or union
   drivers/mtd/spi-nor/mtk-quadspi.c:403:17: sparse: expected structure or union
   drivers/mtd/spi-nor/mtk-quadspi.c: In function 'mtk_nor_init':
>> drivers/mtd/spi-nor/mtk-quadspi.c:391:11: error: incompatible types when assigning to type 'struct mtd_info *' from type 'struct mtd_info'
     nor->mtd = *mtd;
              ^
>> drivers/mtd/spi-nor/mtk-quadspi.c:400:17: warning: assignment from incompatible pointer type [-Wincompatible-pointer-types]
     nor->write_reg = mt8173_nor_write_reg;
                    ^
>> drivers/mtd/spi-nor/mtk-quadspi.c:402:10: error: request for member 'owner' in something not a structure or union
     nor->mtd.owner = THIS_MODULE;
             ^
>> drivers/mtd/spi-nor/mtk-quadspi.c:403:10: error: request for member 'name' in something not a structure or union
     nor->mtd.name = "mtk_nor";
             ^
   drivers/mtd/spi-nor/mtk-quadspi.c:410:36: warning: passing argument 1 of 'mtd_device_parse_register' from incompatible pointer type [-Wincompatible-pointer-types]
     return  mtd_device_parse_register(&nor->mtd, NULL, ppdata, NULL, 0);
                                       ^
   In file included from drivers/mtd/spi-nor/mtk-quadspi.c:24:0:
   include/linux/mtd/mtd.h:372:12: note: expected 'struct mtd_info *' but argument is of type 'struct mtd_info **'
    extern int mtd_device_parse_register(struct mtd_info *mtd,
               ^

sparse warnings: (new ones prefixed by >>)

   drivers/mtd/spi-nor/mtk-quadspi.c:391:18: sparse: incorrect type in assignment (different base types)
   drivers/mtd/spi-nor/mtk-quadspi.c:391:18:    expected struct mtd_info *mtd
   drivers/mtd/spi-nor/mtk-quadspi.c:391:18:    got struct mtd_info <noident>
>> drivers/mtd/spi-nor/mtk-quadspi.c:400:24: sparse: incorrect type in assignment (different argument counts)
   drivers/mtd/spi-nor/mtk-quadspi.c:400:24:    expected int ( *write_reg )( ... )
   drivers/mtd/spi-nor/mtk-quadspi.c:400:24:    got int ( static [toplevel] *<noident> )( ... )
   drivers/mtd/spi-nor/mtk-quadspi.c:402:17: sparse: expected structure or union
   drivers/mtd/spi-nor/mtk-quadspi.c:403:17: sparse: expected structure or union
   drivers/mtd/spi-nor/mtk-quadspi.c: In function 'mtk_nor_init':
   drivers/mtd/spi-nor/mtk-quadspi.c:391:11: error: incompatible types when assigning to type 'struct mtd_info *' from type 'struct mtd_info'
     nor->mtd = *mtd;
              ^
   drivers/mtd/spi-nor/mtk-quadspi.c:400:17: warning: assignment from incompatible pointer type [-Wincompatible-pointer-types]
     nor->write_reg = mt8173_nor_write_reg;
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

vim +391 drivers/mtd/spi-nor/mtk-quadspi.c

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
   395	
   396		/* fill the hooks to spi nor */
   397		nor->read = mt8173_nor_read;
   398		nor->read_reg = mt8173_nor_read_reg;
   399		nor->write = mt8173_nor_write;
 > 400		nor->write_reg = mt8173_nor_write_reg;
   401		nor->erase = mt8173_nor_erase_sector;
 > 402		nor->mtd.owner = THIS_MODULE;
 > 403		nor->mtd.name = "mtk_nor";
   404		/* initialized with NULL */
   405		ret = spi_nor_scan(nor, NULL, SPI_NOR_DUAL);
   406		if (ret)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 49968 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151013/48ac7590/attachment-0001.obj>
