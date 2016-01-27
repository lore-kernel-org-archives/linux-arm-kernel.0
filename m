From: lkp@intel.com (kbuild test robot)
Date: Wed, 27 Jan 2016 18:25:16 +0800
Subject: [PATCH] clk: Move vendor's Kconfig into CCF menu section
In-Reply-To: <1453879563-39500-1-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <201601271842.u96zDj37%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

[auto build test ERROR on clk/clk-next]
[also build test ERROR on v4.5-rc1 next-20160127]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/James-Liao/clk-Move-vendor-s-Kconfig-into-CCF-menu-section/20160127-152850
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
config: arm-s3c2410_defconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   drivers/built-in.o: In function `clk_disable_unprepare':
>> include/linux/clk.h:484: undefined reference to `clk_disable'
   drivers/built-in.o: In function `pwm_samsung_calc_tin':
>> drivers/pwm/pwm-samsung.c:179: undefined reference to `clk_get_rate'
   drivers/built-in.o: In function `pwm_samsung_get_tin_rate':
   drivers/pwm/pwm-samsung.c:158: undefined reference to `clk_get_rate'
   drivers/built-in.o: In function `clk_prepare_enable':
>> include/linux/clk.h:474: undefined reference to `clk_enable'
   drivers/built-in.o: In function `clk_disable_unprepare':
>> include/linux/clk.h:484: undefined reference to `clk_disable'
   drivers/built-in.o: In function `clk_prepare_enable':
>> include/linux/clk.h:474: undefined reference to `clk_enable'
   drivers/built-in.o: In function `clk_disable_unprepare':
>> include/linux/clk.h:484: undefined reference to `clk_disable'
>> include/linux/clk.h:484: undefined reference to `clk_disable'
   drivers/built-in.o: In function `clk_prepare_enable':
>> include/linux/clk.h:474: undefined reference to `clk_enable'
   drivers/built-in.o: In function `s3c24xxfb_probe':
>> drivers/video/fbdev/s3c2410fb.c:940: undefined reference to `clk_get_rate'
   drivers/built-in.o: In function `clk_disable_unprepare':
>> include/linux/clk.h:484: undefined reference to `clk_disable'
   drivers/built-in.o: In function `s3c24xx_serial_getclk':
>> drivers/tty/serial/samsung.c:1171: undefined reference to `clk_get_rate'
   drivers/built-in.o: In function `clk_disable_unprepare':
>> include/linux/clk.h:484: undefined reference to `clk_disable'
   drivers/built-in.o: In function `clk_prepare_enable':
>> include/linux/clk.h:474: undefined reference to `clk_enable'
   drivers/built-in.o: In function `s3c24xx_serial_set_termios':
   drivers/tty/serial/samsung.c:1276: undefined reference to `clk_get_rate'
   drivers/built-in.o: In function `clk_prepare_enable':
>> include/linux/clk.h:474: undefined reference to `clk_enable'
   drivers/built-in.o: In function `clk_disable_unprepare':
>> include/linux/clk.h:484: undefined reference to `clk_disable'
   drivers/built-in.o: In function `clk_prepare_enable':
>> include/linux/clk.h:474: undefined reference to `clk_enable'
   drivers/built-in.o: In function `clk_disable_unprepare':
>> include/linux/clk.h:484: undefined reference to `clk_disable'
>> include/linux/clk.h:484: undefined reference to `clk_disable'
>> include/linux/clk.h:484: undefined reference to `clk_disable'
   drivers/built-in.o: In function `clk_prepare_enable':
>> include/linux/clk.h:474: undefined reference to `clk_enable'

vim +484 include/linux/clk.h

93abe8e4 Viresh Kumar 2012-07-30  468  {
93abe8e4 Viresh Kumar 2012-07-30  469  	int ret;
93abe8e4 Viresh Kumar 2012-07-30  470  
93abe8e4 Viresh Kumar 2012-07-30  471  	ret = clk_prepare(clk);
93abe8e4 Viresh Kumar 2012-07-30  472  	if (ret)
93abe8e4 Viresh Kumar 2012-07-30  473  		return ret;
93abe8e4 Viresh Kumar 2012-07-30 @474  	ret = clk_enable(clk);
93abe8e4 Viresh Kumar 2012-07-30  475  	if (ret)
93abe8e4 Viresh Kumar 2012-07-30  476  		clk_unprepare(clk);
93abe8e4 Viresh Kumar 2012-07-30  477  
93abe8e4 Viresh Kumar 2012-07-30  478  	return ret;
93abe8e4 Viresh Kumar 2012-07-30  479  }
93abe8e4 Viresh Kumar 2012-07-30  480  
93abe8e4 Viresh Kumar 2012-07-30  481  /* clk_disable_unprepare helps cases using clk_disable in non-atomic context. */
93abe8e4 Viresh Kumar 2012-07-30  482  static inline void clk_disable_unprepare(struct clk *clk)
93abe8e4 Viresh Kumar 2012-07-30  483  {
93abe8e4 Viresh Kumar 2012-07-30 @484  	clk_disable(clk);
93abe8e4 Viresh Kumar 2012-07-30  485  	clk_unprepare(clk);
93abe8e4 Viresh Kumar 2012-07-30  486  }
93abe8e4 Viresh Kumar 2012-07-30  487  

:::::: The code at line 484 was first introduced by commit
:::::: 93abe8e4b13ae9a0428ce940a8a03ac72a7626f1 clk: add non CONFIG_HAVE_CLK routines

:::::: TO: Viresh Kumar <viresh.kumar@st.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 21249 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160127/64f5aa6b/attachment-0001.obj>
