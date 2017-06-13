From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 13 Jun 2017 09:48:44 +0800
Subject: [nomadik:gemini-dir-685-tve200 31/31]
 drivers/gpu//drm/panel/panel-ilitek-ili9322.c:230:2: warning: format '%d'
 expects argument of type 'int', but argument 4 has type 'size_t'
Message-ID: <201706130941.3kte3oOy%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git gemini-dir-685-tve200
head:   454df5dcbcb83585bb77898eea3a0afa6288e441
commit: 454df5dcbcb83585bb77898eea3a0afa6288e441 [31/31] stab
config: tile-allyesconfig (attached as .config)
compiler: tilegx-linux-gcc (GCC) 4.6.2
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 454df5dcbcb83585bb77898eea3a0afa6288e441
        # save the attached .config to linux build tree
        make.cross ARCH=tile 

All warnings (new ones prefixed by >>):

   drivers/gpu//drm/panel/panel-ilitek-ili9322.c: In function 'ili9322_regmap_spi_read':
>> drivers/gpu//drm/panel/panel-ilitek-ili9322.c:230:2: warning: format '%d' expects argument of type 'int', but argument 4 has type 'size_t' [-Wformat]
   drivers/gpu//drm/panel/panel-ilitek-ili9322.c:230:2: warning: format '%d' expects argument of type 'int', but argument 5 has type 'size_t' [-Wformat]

vim +230 drivers/gpu//drm/panel/panel-ilitek-ili9322.c

   214		memcpy(buf, data, 2);
   215		buf[0] &= ~0x80;
   216	
   217		dev_info(dev, "WRITE: %02x %02x\n", buf[0], buf[1]);
   218		return spi_write_then_read(spi, buf, 2, NULL, 0);
   219	}
   220	
   221	static int ili9322_regmap_spi_read(void *context, const void *reg,
   222					   size_t reg_size, void *val, size_t val_size)
   223	{
   224		struct device *dev = context;
   225		struct spi_device *spi = to_spi_device(dev);
   226		u8 buf[1];
   227	
   228		/* Set bit 7 to 1 to read */
   229		memcpy(buf, reg, 1);
 > 230		dev_info(dev, "READ: %02x reg size = %d, val size = %d\n",
   231			 buf[0], reg_size, val_size);
   232		buf[0] |= 0x80;
   233	
   234		return spi_write_then_read(spi, buf, 1, val, 1);
   235	}
   236	
   237	static struct regmap_bus ili9322_regmap_bus = {
   238		.write = ili9322_regmap_spi_write,

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 49179 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170613/c3355ac1/attachment-0001.gz>
