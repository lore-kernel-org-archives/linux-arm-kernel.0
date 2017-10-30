From: lkp@intel.com (kbuild test robot)
Date: Mon, 30 Oct 2017 14:57:00 +0800
Subject: [PATCH v2 1/2] media: i2c: Add the ov7740 image sensor driver
In-Reply-To: <20171027074220.23839-2-wenyou.yang@microchip.com>
References: <20171027074220.23839-2-wenyou.yang@microchip.com>
Message-ID: <201710301443.I7CA4dcJ%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wenyou,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linuxtv-media/master]
[also build test WARNING on v4.14-rc7 next-20171018]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Wenyou-Yang/media-i2c-Add-the-ov7740-image-sensor-driver/20171030-140347
base:   git://linuxtv.org/media_tree.git master
config: blackfin-allyesconfig (attached as .config)
compiler: bfin-uclinux-gcc (GCC) 6.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=blackfin 

Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings

All warnings (new ones prefixed by >>):

   In file included from drivers/media//i2c/ov7740.c:21:0:
   drivers/media//i2c/ov7740.c: In function 'ov7740_set_ctrl':
>> include/linux/regmap.h:73:2: warning: 'val' may be used uninitialized in this function [-Wmaybe-uninitialized]
     regmap_update_bits_base(map, reg, mask, val, NULL, false, false)
     ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/media//i2c/ov7740.c:512:5: note: 'val' was declared here
     u8 val;
        ^~~
--
   In file included from drivers/media/i2c/ov7740.c:21:0:
   drivers/media/i2c/ov7740.c: In function 'ov7740_set_ctrl':
>> include/linux/regmap.h:73:2: warning: 'val' may be used uninitialized in this function [-Wmaybe-uninitialized]
     regmap_update_bits_base(map, reg, mask, val, NULL, false, false)
     ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/i2c/ov7740.c:512:5: note: 'val' was declared here
     u8 val;
        ^~~

vim +/val +73 include/linux/regmap.h

8019ff6cf Nariman Poushin   2015-07-16  71  
ca7a94464 Kuninori Morimoto 2016-02-15  72  #define	regmap_update_bits(map, reg, mask, val) \
ca7a94464 Kuninori Morimoto 2016-02-15 @73  	regmap_update_bits_base(map, reg, mask, val, NULL, false, false)
30ed9cb7a Kuninori Morimoto 2016-02-15  74  #define	regmap_update_bits_async(map, reg, mask, val)\
30ed9cb7a Kuninori Morimoto 2016-02-15  75  	regmap_update_bits_base(map, reg, mask, val, NULL, true, false)
98c2dc486 Kuninori Morimoto 2016-02-15  76  #define	regmap_update_bits_check(map, reg, mask, val, change)\
98c2dc486 Kuninori Morimoto 2016-02-15  77  	regmap_update_bits_base(map, reg, mask, val, change, false, false)
89d8d4b83 Kuninori Morimoto 2016-02-15  78  #define	regmap_update_bits_check_async(map, reg, mask, val, change)\
89d8d4b83 Kuninori Morimoto 2016-02-15  79  	regmap_update_bits_base(map, reg, mask, val, change, true, false)
ca7a94464 Kuninori Morimoto 2016-02-15  80  

:::::: The code at line 73 was first introduced by commit
:::::: ca7a94464b5457a8dc5add19f6fc3bea59d6193f regmap: merge regmap_update_bits() into macro

:::::: TO: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
:::::: CC: Mark Brown <broonie@kernel.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 46053 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171030/a5031113/attachment-0001.gz>
