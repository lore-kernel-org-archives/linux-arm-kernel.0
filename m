From: lkp@intel.com (kbuild test robot)
Date: Tue, 1 May 2018 07:15:37 +0800
Subject: [PATCH 2/3] platform: move the early platform device support to
 arch/sh
In-Reply-To: <20180430163556.2560-3-brgl@bgdev.pl>
References: <20180430163556.2560-3-brgl@bgdev.pl>
Message-ID: <201805010502.8vPPYqY1%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bartosz,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.17-rc3 next-20180430]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Bartosz-Golaszewski/sh-make-early_platform-code-SuperH-specific/20180501-025442
config: arm-shmobile_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All error/warnings (new ones prefixed by >>):

   drivers/tty/serial/sh-sci.c: In function 'sci_probe':
   drivers/tty/serial/sh-sci.c:3196:6: error: implicit declaration of function 'is_early_platform_device'; did you mean 'to_platform_device'? [-Werror=implicit-function-declaration]
     if (is_early_platform_device(dev))
         ^~~~~~~~~~~~~~~~~~~~~~~~
         to_platform_device
   drivers/tty/serial/sh-sci.c: At top level:
   drivers/tty/serial/sh-sci.c:3294:28: error: expected declaration specifiers or '...' before string constant
    early_platform_init_buffer("earlyprintk", &sci_driver,
                               ^~~~~~~~~~~~~
   drivers/tty/serial/sh-sci.c:3294:43: error: expected declaration specifiers or '...' before '&' token
    early_platform_init_buffer("earlyprintk", &sci_driver,
                                              ^
   drivers/tty/serial/sh-sci.c:3295:7: error: expected declaration specifiers or '...' before 'early_serial_buf'
          early_serial_buf, ARRAY_SIZE(early_serial_buf));
          ^~~~~~~~~~~~~~~~
   In file included from include/linux/clk.h:16:0,
                    from drivers/tty/serial/sh-sci.c:24:
>> include/linux/kernel.h:71:25: error: expected declaration specifiers or '...' before '(' token
    #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
                            ^
>> drivers/tty/serial/sh-sci.c:3295:25: note: in expansion of macro 'ARRAY_SIZE'
          early_serial_buf, ARRAY_SIZE(early_serial_buf));
                            ^~~~~~~~~~
   cc1: some warnings being treated as errors
--
   drivers/tty//serial/sh-sci.c: In function 'sci_probe':
   drivers/tty//serial/sh-sci.c:3196:6: error: implicit declaration of function 'is_early_platform_device'; did you mean 'to_platform_device'? [-Werror=implicit-function-declaration]
     if (is_early_platform_device(dev))
         ^~~~~~~~~~~~~~~~~~~~~~~~
         to_platform_device
   drivers/tty//serial/sh-sci.c: At top level:
   drivers/tty//serial/sh-sci.c:3294:28: error: expected declaration specifiers or '...' before string constant
    early_platform_init_buffer("earlyprintk", &sci_driver,
                               ^~~~~~~~~~~~~
   drivers/tty//serial/sh-sci.c:3294:43: error: expected declaration specifiers or '...' before '&' token
    early_platform_init_buffer("earlyprintk", &sci_driver,
                                              ^
   drivers/tty//serial/sh-sci.c:3295:7: error: expected declaration specifiers or '...' before 'early_serial_buf'
          early_serial_buf, ARRAY_SIZE(early_serial_buf));
          ^~~~~~~~~~~~~~~~
   In file included from include/linux/clk.h:16:0,
                    from drivers/tty//serial/sh-sci.c:24:
>> include/linux/kernel.h:71:25: error: expected declaration specifiers or '...' before '(' token
    #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
                            ^
   drivers/tty//serial/sh-sci.c:3295:25: note: in expansion of macro 'ARRAY_SIZE'
          early_serial_buf, ARRAY_SIZE(early_serial_buf));
                            ^~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/ARRAY_SIZE +3295 drivers/tty/serial/sh-sci.c

^1da177e drivers/serial/sh-sci.c     Linus Torvalds    2005-04-16  3292  
7b6fd3bf drivers/serial/sh-sci.c     Magnus Damm       2009-12-14  3293  #ifdef CONFIG_SERIAL_SH_SCI_CONSOLE
7b6fd3bf drivers/serial/sh-sci.c     Magnus Damm       2009-12-14  3294  early_platform_init_buffer("earlyprintk", &sci_driver,
7b6fd3bf drivers/serial/sh-sci.c     Magnus Damm       2009-12-14 @3295  			   early_serial_buf, ARRAY_SIZE(early_serial_buf));
7b6fd3bf drivers/serial/sh-sci.c     Magnus Damm       2009-12-14  3296  #endif
0b0cced1 drivers/tty/serial/sh-sci.c Yoshinori Sato    2015-12-24  3297  #ifdef CONFIG_SERIAL_SH_SCI_EARLYCON
dd076cff drivers/tty/serial/sh-sci.c Matthias Kaehlcke 2017-10-09  3298  static struct plat_sci_port port_cfg __initdata;
0b0cced1 drivers/tty/serial/sh-sci.c Yoshinori Sato    2015-12-24  3299  

:::::: The code at line 3295 was first introduced by commit
:::::: 7b6fd3bf82c4901f6ba0101ba71a5c507c24f9cf sh-sci: Extend sh-sci driver with early console V2

:::::: TO: Magnus Damm <damm@opensource.se>
:::::: CC: Paul Mundt <lethal@linux-sh.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 27660 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180501/82333889/attachment-0001.gz>
