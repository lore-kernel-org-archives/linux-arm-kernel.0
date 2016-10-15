From: fengguang.wu@intel.com (kbuild test robot)
Date: Sat, 15 Oct 2016 16:12:02 +0800
Subject: [arm-soc:to-build 23/23] arch/sh/kernel/cpu/clock.c:25:6: warning:
 'ret' may be used uninitialized in this function
Message-ID: <201610151651.uAeRGaCR%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git to-build
head:   0f460ef4d0b0e50f64b03962048dec6fa1d40d20
commit: 0f460ef4d0b0e50f64b03962048dec6fa1d40d20 [23/23] Revert "Disable "maybe-uninitialized" warning globally"
config: sh-allmodconfig (attached as .config)
compiler: sh4-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 0f460ef4d0b0e50f64b03962048dec6fa1d40d20
        # save the attached .config to linux build tree
        make.cross ARCH=sh 

Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings

All warnings (new ones prefixed by >>):

   arch/sh/kernel/cpu/clock.c: In function 'clk_init':
>> arch/sh/kernel/cpu/clock.c:25:6: warning: 'ret' may be used uninitialized in this function [-Wmaybe-uninitialized]
     int ret;
         ^~~

vim +/ret +25 arch/sh/kernel/cpu/clock.c

36ddf31b6 Paul Mundt  2006-01-16   9   *	Written by Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>
36ddf31b6 Paul Mundt  2006-01-16  10   *
1d118562c Paul Mundt  2006-12-01  11   *  Modified for omap shared clock framework by Tony Lindgren <tony@atomide.com>
1d118562c Paul Mundt  2006-12-01  12   *
36ddf31b6 Paul Mundt  2006-01-16  13   * This file is subject to the terms and conditions of the GNU General Public
36ddf31b6 Paul Mundt  2006-01-16  14   * License.  See the file "COPYING" in the main directory of this archive
36ddf31b6 Paul Mundt  2006-01-16  15   * for more details.
36ddf31b6 Paul Mundt  2006-01-16  16   */
36ddf31b6 Paul Mundt  2006-01-16  17  #include <linux/kernel.h>
36ddf31b6 Paul Mundt  2006-01-16  18  #include <linux/init.h>
51a5006af Paul Mundt  2010-03-08  19  #include <linux/clk.h>
36ddf31b6 Paul Mundt  2006-01-16  20  #include <asm/clock.h>
253b0887b Paul Mundt  2009-05-13  21  #include <asm/machvec.h>
36ddf31b6 Paul Mundt  2006-01-16  22  
36ddf31b6 Paul Mundt  2006-01-16  23  int __init clk_init(void)
36ddf31b6 Paul Mundt  2006-01-16  24  {
253b0887b Paul Mundt  2009-05-13 @25  	int ret;
36ddf31b6 Paul Mundt  2006-01-16  26  
15f0c8f2f Rich Felker 2016-07-31  27  #ifndef CONFIG_COMMON_CLK
253b0887b Paul Mundt  2009-05-13  28  	ret = arch_clk_init();
253b0887b Paul Mundt  2009-05-13  29  	if (unlikely(ret)) {
253b0887b Paul Mundt  2009-05-13  30  		pr_err("%s: CPU clock registration failed.\n", __func__);
253b0887b Paul Mundt  2009-05-13  31  		return ret;
36ddf31b6 Paul Mundt  2006-01-16  32  	}
15f0c8f2f Rich Felker 2016-07-31  33  #endif

:::::: The code at line 25 was first introduced by commit
:::::: 253b0887b3736160feac9ccdcf146a2073e41463 sh: clkfwk: Rework legacy CPG clock handling.

:::::: TO: Paul Mundt <lethal@linux-sh.org>
:::::: CC: Paul Mundt <lethal@linux-sh.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 42098 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161015/dd2d2730/attachment-0001.gz>
