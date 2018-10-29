From: lkp@intel.com (kbuild test robot)
Date: Tue, 30 Oct 2018 06:49:39 +0800
Subject: [PATCH i2c-next v8 5/5] i2c: aspeed: Add bus idle waiting logic
 for multi-master use cases
In-Reply-To: <20181029211414.20771-6-jae.hyun.yoo@linux.intel.com>
References: <20181029211414.20771-6-jae.hyun.yoo@linux.intel.com>
Message-ID: <201810300628.VVJxhkq6%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jae,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on wsa/i2c/for-next]
[also build test WARNING on v4.19 next-20181029]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jae-Hyun-Yoo/i2c-aspeed-Add-bus-idle-waiting-logic-for-multi-master-use-cases/20181030-051719
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-next
config: xtensa-allyesconfig (attached as .config)
compiler: xtensa-linux-gcc (GCC) 8.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=8.1.0 make.cross ARCH=xtensa 

Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings

All warnings (new ones prefixed by >>):

   In file included from include/linux/ktime.h:25,
                    from include/linux/rcutiny.h:28,
                    from include/linux/rcupdate.h:209,
                    from include/linux/srcu.h:33,
                    from include/linux/notifier.h:16,
                    from include/linux/clk.h:17,
                    from drivers/i2c/busses/i2c-aspeed.c:13:
   drivers/i2c/busses/i2c-aspeed.c: In function 'aspeed_i2c_master_xfer':
>> include/linux/jiffies.h:108:15: warning: 'check_started' may be used uninitialized in this function [-Wmaybe-uninitialized]
      ((long)((b) - (a)) < 0))
                  ^
   drivers/i2c/busses/i2c-aspeed.c:607:16: note: 'check_started' was declared here
     unsigned long check_started;
                   ^~~~~~~~~~~~~
--
   In file included from include/linux/ktime.h:25,
                    from include/linux/rcutiny.h:28,
                    from include/linux/rcupdate.h:209,
                    from include/linux/srcu.h:33,
                    from include/linux/notifier.h:16,
                    from include/linux/clk.h:17,
                    from drivers/i2c//busses/i2c-aspeed.c:13:
   drivers/i2c//busses/i2c-aspeed.c: In function 'aspeed_i2c_master_xfer':
>> include/linux/jiffies.h:108:15: warning: 'check_started' may be used uninitialized in this function [-Wmaybe-uninitialized]
      ((long)((b) - (a)) < 0))
                  ^
   drivers/i2c//busses/i2c-aspeed.c:607:16: note: 'check_started' was declared here
     unsigned long check_started;
                   ^~~~~~~~~~~~~

vim +/check_started +108 include/linux/jiffies.h

^1da177e Linus Torvalds   2005-04-16   91  
^1da177e Linus Torvalds   2005-04-16   92  /*
^1da177e Linus Torvalds   2005-04-16   93   *	These inlines deal with timer wrapping correctly. You are 
^1da177e Linus Torvalds   2005-04-16   94   *	strongly encouraged to use them
^1da177e Linus Torvalds   2005-04-16   95   *	1. Because people otherwise forget
^1da177e Linus Torvalds   2005-04-16   96   *	2. Because if the timer wrap changes in future you won't have to
^1da177e Linus Torvalds   2005-04-16   97   *	   alter your driver code.
^1da177e Linus Torvalds   2005-04-16   98   *
^1da177e Linus Torvalds   2005-04-16   99   * time_after(a,b) returns true if the time a is after time b.
^1da177e Linus Torvalds   2005-04-16  100   *
^1da177e Linus Torvalds   2005-04-16  101   * Do this with "<0" and ">=0" to only test the sign of the result. A
^1da177e Linus Torvalds   2005-04-16  102   * good compiler would generate better code (and a really good compiler
^1da177e Linus Torvalds   2005-04-16  103   * wouldn't care). Gcc is currently neither.
^1da177e Linus Torvalds   2005-04-16  104   */
^1da177e Linus Torvalds   2005-04-16  105  #define time_after(a,b)		\
^1da177e Linus Torvalds   2005-04-16  106  	(typecheck(unsigned long, a) && \
^1da177e Linus Torvalds   2005-04-16  107  	 typecheck(unsigned long, b) && \
5a581b36 Paul E. McKenney 2013-07-27 @108  	 ((long)((b) - (a)) < 0))
^1da177e Linus Torvalds   2005-04-16  109  #define time_before(a,b)	time_after(b,a)
^1da177e Linus Torvalds   2005-04-16  110  

:::::: The code at line 108 was first introduced by commit
:::::: 5a581b367b5df0531265311fc681c2abd377e5e6 jiffies: Avoid undefined behavior from signed overflow

:::::: TO: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
:::::: CC: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 55213 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181030/29fa56c7/attachment-0001.gz>
