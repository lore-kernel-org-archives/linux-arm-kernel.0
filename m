From: lkp@intel.com (kbuild test robot)
Date: Thu, 8 Dec 2016 18:47:17 +0800
Subject: [PATCH v5 2/5] i2c: Add STM32F4 I2C driver
In-Reply-To: <1481185563-8735-3-git-send-email-cedric.madianga@gmail.com>
Message-ID: <201612081812.ctflB7YA%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi M'boumba,

[auto build test WARNING on wsa/i2c/for-next]
[also build test WARNING on v4.9-rc8 next-20161208]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/M-boumba-Cedric-Madianga/Add-support-for-the-STM32F4-I2C/20161208-173240
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-next
config: i386-allmodconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   In file included from include/linux/clk.h:16:0,
                    from drivers/i2c/busses/i2c-stm32f4.c:12:
   drivers/i2c/busses/i2c-stm32f4.c: In function 'stm32f4_i2c_set_periph_clk_freq':
   include/linux/kernel.h:749:16: warning: comparison of distinct pointer types lacks a cast
     (void) (&max1 == &max2);   \
                   ^
   include/linux/kernel.h:737:2: note: in definition of macro '__min'
     t1 min1 = (x);     \
     ^~
   include/linux/kernel.h:778:28: note: in expansion of macro 'min'
    #define clamp(val, lo, hi) min((typeof(val))max(val, lo), hi)
                               ^~~
>> include/linux/kernel.h:752:2: note: in expansion of macro '__max'
     __max(typeof(x), typeof(y),   \
     ^~~~~
>> include/linux/kernel.h:778:45: note: in expansion of macro 'max'
    #define clamp(val, lo, hi) min((typeof(val))max(val, lo), hi)
                                                ^~~
>> drivers/i2c/busses/i2c-stm32f4.c:201:9: note: in expansion of macro 'clamp'
     freq = clamp(freq, STM32F4_I2C_MIN_FREQ, STM32F4_I2C_MAX_FREQ);
            ^~~~~
   include/linux/kernel.h:749:16: warning: comparison of distinct pointer types lacks a cast
     (void) (&max1 == &max2);   \
                   ^
   include/linux/kernel.h:737:13: note: in definition of macro '__min'
     t1 min1 = (x);     \
                ^
   include/linux/kernel.h:778:28: note: in expansion of macro 'min'
    #define clamp(val, lo, hi) min((typeof(val))max(val, lo), hi)
                               ^~~
>> include/linux/kernel.h:752:2: note: in expansion of macro '__max'
     __max(typeof(x), typeof(y),   \
     ^~~~~
>> include/linux/kernel.h:778:45: note: in expansion of macro 'max'
    #define clamp(val, lo, hi) min((typeof(val))max(val, lo), hi)
                                                ^~~
>> drivers/i2c/busses/i2c-stm32f4.c:201:9: note: in expansion of macro 'clamp'
     freq = clamp(freq, STM32F4_I2C_MIN_FREQ, STM32F4_I2C_MAX_FREQ);
            ^~~~~
   include/linux/kernel.h:739:16: warning: comparison of distinct pointer types lacks a cast
     (void) (&min1 == &min2);   \
                   ^
   include/linux/kernel.h:742:2: note: in expansion of macro '__min'
     __min(typeof(x), typeof(y),   \
     ^~~~~
   include/linux/kernel.h:778:28: note: in expansion of macro 'min'
    #define clamp(val, lo, hi) min((typeof(val))max(val, lo), hi)
                               ^~~
>> drivers/i2c/busses/i2c-stm32f4.c:201:9: note: in expansion of macro 'clamp'
     freq = clamp(freq, STM32F4_I2C_MIN_FREQ, STM32F4_I2C_MAX_FREQ);
            ^~~~~

vim +/clamp +201 drivers/i2c/busses/i2c-stm32f4.c

   185	
   186	static void stm32f4_i2c_disable_it(struct stm32f4_i2c_dev *i2c_dev)
   187	{
   188		void __iomem *reg = i2c_dev->base + STM32F4_I2C_CR2;
   189	
   190		stm32f4_i2c_clr_bits(reg, STM32F4_I2C_CR2_IRQ_MASK);
   191	}
   192	
   193	static void stm32f4_i2c_set_periph_clk_freq(struct stm32f4_i2c_dev *i2c_dev)
   194	{
   195		u32 clk_rate, cr2, freq;
   196	
   197		cr2 = readl_relaxed(i2c_dev->base + STM32F4_I2C_CR2);
   198		cr2 &= ~STM32F4_I2C_CR2_FREQ_MASK;
   199		clk_rate = clk_get_rate(i2c_dev->clk);
   200		freq = clk_rate / MHZ_TO_HZ;
 > 201		freq = clamp(freq, STM32F4_I2C_MIN_FREQ, STM32F4_I2C_MAX_FREQ);
   202		cr2 |= STM32F4_I2C_CR2_FREQ(freq);
   203		writel_relaxed(cr2, i2c_dev->base + STM32F4_I2C_CR2);
   204	}
   205	
   206	static void stm32f4_i2c_set_rise_time(struct stm32f4_i2c_dev *i2c_dev)
   207	{
   208		u32 trise, freq, cr2, val;
   209	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 56838 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161208/776da99e/attachment-0001.gz>
