From: lkp@intel.com (kbuild test robot)
Date: Tue, 9 May 2017 03:09:39 +0800
Subject: [PATCH 2/2] drivers: pwm: pwm-atmel: implement pwm dead-times
In-Reply-To: <1494253463-26993-3-git-send-email-claudiu.beznea@microchip.com>
Message-ID: <201705090302.c80lEjnN%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Claudiu,

[auto build test WARNING on pwm/for-next]
[also build test WARNING on next-20170508]
[cannot apply to v4.11]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Claudiu-Beznea/extends-PWM-framework-to-support-PWM-dead-times/20170509-000624
base:   https://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git for-next
config: arm-multi_v5_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings

All warnings (new ones prefixed by >>):

   In file included from include/linux/io.h:25:0,
                    from drivers/pwm/pwm-atmel.c:13:
   drivers/pwm/pwm-atmel.c: In function 'atmel_pwm_apply':
>> arch/arm/include/asm/io.h:100:2: warning: 'dt' may be used uninitialized in this function [-Wmaybe-uninitialized]
     asm volatile("str %1, %0"
     ^~~
   drivers/pwm/pwm-atmel.c:246:28: note: 'dt' was declared here
     unsigned long cprd, cdty, dt;
                               ^~
--
   In file included from include/linux/io.h:25:0,
                    from drivers//pwm/pwm-atmel.c:13:
   drivers//pwm/pwm-atmel.c: In function 'atmel_pwm_apply':
>> arch/arm/include/asm/io.h:100:2: warning: 'dt' may be used uninitialized in this function [-Wmaybe-uninitialized]
     asm volatile("str %1, %0"
     ^~~
   drivers//pwm/pwm-atmel.c:246:28: note: 'dt' was declared here
     unsigned long cprd, cdty, dt;
                               ^~

vim +/dt +100 arch/arm/include/asm/io.h

5bb5d66d8 Peter Hurley   2015-04-13   84  		     : "=r" (val)
5bb5d66d8 Peter Hurley   2015-04-13   85  		     : "Q" (*(volatile u16 __force *)addr));
195bbcac2 Will Deacon    2012-08-24   86  	return val;
195bbcac2 Will Deacon    2012-08-24   87  }
195bbcac2 Will Deacon    2012-08-24   88  #endif
195bbcac2 Will Deacon    2012-08-24   89  
84c4d3a6d Thierry Reding 2014-07-28   90  #define __raw_writeb __raw_writeb
195bbcac2 Will Deacon    2012-08-24   91  static inline void __raw_writeb(u8 val, volatile void __iomem *addr)
195bbcac2 Will Deacon    2012-08-24   92  {
195bbcac2 Will Deacon    2012-08-24   93  	asm volatile("strb %1, %0"
5bb5d66d8 Peter Hurley   2015-04-13   94  		     : : "Qo" (*(volatile u8 __force *)addr), "r" (val));
195bbcac2 Will Deacon    2012-08-24   95  }
195bbcac2 Will Deacon    2012-08-24   96  
84c4d3a6d Thierry Reding 2014-07-28   97  #define __raw_writel __raw_writel
195bbcac2 Will Deacon    2012-08-24   98  static inline void __raw_writel(u32 val, volatile void __iomem *addr)
195bbcac2 Will Deacon    2012-08-24   99  {
195bbcac2 Will Deacon    2012-08-24 @100  	asm volatile("str %1, %0"
5bb5d66d8 Peter Hurley   2015-04-13  101  		     : : "Qo" (*(volatile u32 __force *)addr), "r" (val));
195bbcac2 Will Deacon    2012-08-24  102  }
195bbcac2 Will Deacon    2012-08-24  103  
84c4d3a6d Thierry Reding 2014-07-28  104  #define __raw_readb __raw_readb
195bbcac2 Will Deacon    2012-08-24  105  static inline u8 __raw_readb(const volatile void __iomem *addr)
195bbcac2 Will Deacon    2012-08-24  106  {
195bbcac2 Will Deacon    2012-08-24  107  	u8 val;
5bb5d66d8 Peter Hurley   2015-04-13  108  	asm volatile("ldrb %0, %1"

:::::: The code at line 100 was first introduced by commit
:::::: 195bbcac2e5c12f7fb99cdcc492c3000c5537f4a ARM: 7500/1: io: avoid writeback addressing modes for __raw_ accessors

:::::: TO: Will Deacon <will.deacon@arm.com>
:::::: CC: Russell King <rmk+kernel@arm.linux.org.uk>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 28670 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170509/887ab9c4/attachment-0001.gz>
