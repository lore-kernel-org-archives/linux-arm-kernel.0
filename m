From: lkp@intel.com (kbuild test robot)
Date: Thu, 21 Jan 2016 01:06:16 +0800
Subject: [alsa-devel] [PATCH v2] ASoC: avoid unused variable warning for
 rt5659_acpi_match
In-Reply-To: <1477393.QDzvbob2TI@wuerfel>
Message-ID: <201601210126.aw42va8J%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

[auto build test WARNING on asoc/for-next]
[also build test WARNING on next-20160120]
[cannot apply to v4.4]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Arnd-Bergmann/ASoC-avoid-unused-variable-warning-for-rt5659_acpi_match/20160120-190911
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
config: parisc-allmodconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=parisc 

All warnings (new ones prefixed by >>):

   sound/soc/codecs/rt5659.c:4204:1: error: expected ',' or ';' before 'struct'
    struct i2c_driver rt5659_i2c_driver = {
    ^
   In file included from sound/soc/codecs/rt5659.c:17:0:
   sound/soc/codecs/rt5659.c: In function 'rt5659_i2c_driver_init':
   sound/soc/codecs/rt5659.c:4216:19: error: 'rt5659_i2c_driver' undeclared (first use in this function)
    module_i2c_driver(rt5659_i2c_driver);
                      ^
   include/linux/i2c.h:592:35: note: in definition of macro 'i2c_add_driver'
     i2c_register_driver(THIS_MODULE, driver)
                                      ^
>> include/linux/i2c.h:633:2: note: in expansion of macro 'module_driver'
     module_driver(__i2c_driver, i2c_add_driver, \
     ^
>> sound/soc/codecs/rt5659.c:4216:1: note: in expansion of macro 'module_i2c_driver'
    module_i2c_driver(rt5659_i2c_driver);
    ^
   sound/soc/codecs/rt5659.c:4216:19: note: each undeclared identifier is reported only once for each function it appears in
    module_i2c_driver(rt5659_i2c_driver);
                      ^
   include/linux/i2c.h:592:35: note: in definition of macro 'i2c_add_driver'
     i2c_register_driver(THIS_MODULE, driver)
                                      ^
>> include/linux/i2c.h:633:2: note: in expansion of macro 'module_driver'
     module_driver(__i2c_driver, i2c_add_driver, \
     ^
>> sound/soc/codecs/rt5659.c:4216:1: note: in expansion of macro 'module_i2c_driver'
    module_i2c_driver(rt5659_i2c_driver);
    ^
   In file included from include/linux/i2c.h:30:0,
                    from sound/soc/codecs/rt5659.c:17:
   sound/soc/codecs/rt5659.c: In function 'rt5659_i2c_driver_exit':
   sound/soc/codecs/rt5659.c:4216:19: error: 'rt5659_i2c_driver' undeclared (first use in this function)
    module_i2c_driver(rt5659_i2c_driver);
                      ^
   include/linux/device.h:1332:17: note: in definition of macro 'module_driver'
     __unregister(&(__driver) , ##__VA_ARGS__); \
                    ^
>> sound/soc/codecs/rt5659.c:4216:1: note: in expansion of macro 'module_i2c_driver'
    module_i2c_driver(rt5659_i2c_driver);
    ^
   sound/soc/codecs/rt5659.c: At top level:
   sound/soc/codecs/rt5659.c:3974:12: warning: 'rt5659_i2c_probe' defined but not used [-Wunused-function]
    static int rt5659_i2c_probe(struct i2c_client *i2c,
               ^
   sound/soc/codecs/rt5659.c:4172:12: warning: 'rt5659_i2c_remove' defined but not used [-Wunused-function]
    static int rt5659_i2c_remove(struct i2c_client *i2c)
               ^
   sound/soc/codecs/rt5659.c: In function 'rt5659_i2c_driver_init':
   sound/soc/codecs/rt5659.c:4216:1: warning: control reaches end of non-void function [-Wreturn-type]
    module_i2c_driver(rt5659_i2c_driver);
    ^

vim +/module_i2c_driver +4216 sound/soc/codecs/rt5659.c

d3cb2de2 Bard Liao     2015-11-09  4200  };
d3cb2de2 Bard Liao     2015-11-09  4201  MODULE_DEVICE_TABLE(acpi, rt5659_acpi_match);
51bb9d21 Arnd Bergmann 2016-01-20  4202  #endif
d3cb2de2 Bard Liao     2015-11-09  4203  
d3cb2de2 Bard Liao     2015-11-09  4204  struct i2c_driver rt5659_i2c_driver = {
d3cb2de2 Bard Liao     2015-11-09  4205  	.driver = {
d3cb2de2 Bard Liao     2015-11-09  4206  		.name = "rt5659",
d3cb2de2 Bard Liao     2015-11-09  4207  		.owner = THIS_MODULE,
51bb9d21 Arnd Bergmann 2016-01-20  4208  		.of_match_table = of_match_ptr(rt5659_of_match),
d3cb2de2 Bard Liao     2015-11-09  4209  		.acpi_match_table = ACPI_PTR(rt5659_acpi_match),
d3cb2de2 Bard Liao     2015-11-09  4210  	},
d3cb2de2 Bard Liao     2015-11-09  4211  	.probe = rt5659_i2c_probe,
d3cb2de2 Bard Liao     2015-11-09  4212  	.remove = rt5659_i2c_remove,
d3cb2de2 Bard Liao     2015-11-09  4213  	.shutdown = rt5659_i2c_shutdown,
d3cb2de2 Bard Liao     2015-11-09  4214  	.id_table = rt5659_i2c_id,
d3cb2de2 Bard Liao     2015-11-09  4215  };
d3cb2de2 Bard Liao     2015-11-09 @4216  module_i2c_driver(rt5659_i2c_driver);
d3cb2de2 Bard Liao     2015-11-09  4217  
d3cb2de2 Bard Liao     2015-11-09  4218  MODULE_DESCRIPTION("ASoC RT5659 driver");
d3cb2de2 Bard Liao     2015-11-09  4219  MODULE_AUTHOR("Bard Liao <bardliao@realtek.com>");
d3cb2de2 Bard Liao     2015-11-09  4220  MODULE_LICENSE("GPL v2");

:::::: The code at line 4216 was first introduced by commit
:::::: d3cb2de2479bbbde29391393d68f2e313e1f0504 ASoC: rt5659: add rt5659 codec driver

:::::: TO: Bard Liao <bardliao@realtek.com>
:::::: CC: Mark Brown <broonie@kernel.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 42828 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160121/1d2b8f1c/attachment-0001.obj>
