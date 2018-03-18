From: lkp@intel.com (kbuild test robot)
Date: Mon, 19 Mar 2018 04:31:13 +0800
Subject: [PATCH v5 08/12] clk: actions: Add factor clock support
In-Reply-To: <20180317100952.28538-9-manivannan.sadhasivam@linaro.org>
References: <20180317100952.28538-9-manivannan.sadhasivam@linaro.org>
Message-ID: <201803190427.HYS0Djpl%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Manivannan,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on v4.16-rc4]
[cannot apply to next-20180316]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Manivannan-Sadhasivam/Add-clock-driver-for-Actions-S900-SoC/20180319-015124
config: sh-allmodconfig (attached as .config)
compiler: sh4-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=sh 

All warnings (new ones prefixed by >>):

   In file included from ./arch/sh/include/generated/asm/div64.h:1:0,
                    from include/linux/kernel.h:173,
                    from include/asm-generic/bug.h:18,
                    from arch/sh/include/asm/bug.h:112,
                    from include/linux/bug.h:5,
                    from include/linux/io.h:23,
                    from include/linux/clk-provider.h:14,
                    from drivers/clk/actions/owl-factor.c:11:
   drivers/clk/actions/owl-factor.c: In function 'owl_factor_helper_recalc_rate':
   include/asm-generic/div64.h:222:28: warning: comparison of distinct pointer types lacks a cast
     (void)(((typeof((n)) *)0) == ((uint64_t *)0)); \
                               ^
>> drivers/clk/actions/owl-factor.c:170:2: note: in expansion of macro 'do_div'
     do_div(rate, div);
     ^~~~~~
   In file included from include/linux/init.h:5:0,
                    from include/linux/io.h:22,
                    from include/linux/clk-provider.h:14,
                    from drivers/clk/actions/owl-factor.c:11:
   include/asm-generic/div64.h:235:25: warning: right shift count >= width of type [-Wshift-count-overflow]
     } else if (likely(((n) >> 32) == 0)) {  \
                            ^
   include/linux/compiler.h:76:40: note: in definition of macro 'likely'
    # define likely(x) __builtin_expect(!!(x), 1)
                                           ^
>> drivers/clk/actions/owl-factor.c:170:2: note: in expansion of macro 'do_div'
     do_div(rate, div);
     ^~~~~~
   In file included from ./arch/sh/include/generated/asm/div64.h:1:0,
                    from include/linux/kernel.h:173,
                    from include/asm-generic/bug.h:18,
                    from arch/sh/include/asm/bug.h:112,
                    from include/linux/bug.h:5,
                    from include/linux/io.h:23,
                    from include/linux/clk-provider.h:14,
                    from drivers/clk/actions/owl-factor.c:11:
   include/asm-generic/div64.h:239:22: error: passing argument 1 of '__div64_32' from incompatible pointer type [-Werror=incompatible-pointer-types]
      __rem = __div64_32(&(n), __base); \
                         ^
>> drivers/clk/actions/owl-factor.c:170:2: note: in expansion of macro 'do_div'
     do_div(rate, div);
     ^~~~~~
   include/asm-generic/div64.h:213:17: note: expected 'uint64_t * {aka long long unsigned int *}' but argument is of type 'long unsigned int *'
    extern uint32_t __div64_32(uint64_t *dividend, uint32_t divisor);
                    ^~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/do_div +170 drivers/clk/actions/owl-factor.c

    10	
  > 11	#include <linux/clk-provider.h>
    12	#include <linux/regmap.h>
    13	#include <linux/slab.h>
    14	
    15	#include "owl-factor.h"
    16	
    17	static unsigned int _get_table_maxval(const struct clk_factor_table *table)
    18	{
    19		unsigned int maxval = 0;
    20		const struct clk_factor_table *clkt;
    21	
    22		for (clkt = table; clkt->div; clkt++)
    23			if (clkt->val > maxval)
    24				maxval = clkt->val;
    25		return maxval;
    26	}
    27	
    28	static int _get_table_div_mul(const struct clk_factor_table *table,
    29				unsigned int val, unsigned int *mul, unsigned int *div)
    30	{
    31		const struct clk_factor_table *clkt;
    32	
    33		for (clkt = table; clkt->div; clkt++) {
    34			if (clkt->val == val) {
    35				*mul = clkt->mul;
    36				*div = clkt->div;
    37				return 1;
    38			}
    39		}
    40	
    41		return 0;
    42	}
    43	
    44	static unsigned int _get_table_val(const struct clk_factor_table *table,
    45				unsigned long rate, unsigned long parent_rate)
    46	{
    47		const struct clk_factor_table *clkt;
    48		int val = -1;
    49		u64 calc_rate;
    50	
    51		for (clkt = table; clkt->div; clkt++) {
    52			calc_rate = parent_rate * clkt->mul;
    53			do_div(calc_rate, clkt->div);
    54	
    55			if ((unsigned long)calc_rate <= rate) {
    56				val = clkt->val;
    57				break;
    58			}
    59		}
    60	
    61		if (val == -1)
    62			val = _get_table_maxval(table);
    63	
    64		return val;
    65	}
    66	
    67	static int clk_val_best(struct clk_hw *hw, unsigned long rate,
    68				unsigned long *best_parent_rate)
    69	{
    70		struct owl_factor *factor = hw_to_owl_factor(hw);
    71		struct owl_factor_hw *factor_hw = &factor->factor_hw;
    72		const struct clk_factor_table *clkt = factor_hw->table;
    73		unsigned long parent_rate, try_parent_rate, best = 0, cur_rate;
    74		unsigned long parent_rate_saved = *best_parent_rate;
    75		int bestval = 0;
    76	
    77		if (!rate)
    78			rate = 1;
    79	
    80		if (!(clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT)) {
    81			parent_rate = *best_parent_rate;
    82			bestval = _get_table_val(clkt, rate, parent_rate);
    83			return bestval;
    84		}
    85	
    86		for (clkt = factor_hw->table; clkt->div; clkt++) {
    87			try_parent_rate = rate * clkt->div / clkt->mul;
    88	
    89			if (try_parent_rate == parent_rate_saved) {
    90				pr_debug("%s: [%d %d %d] found try_parent_rate %ld\n",
    91					__func__, clkt->val, clkt->mul, clkt->div,
    92					try_parent_rate);
    93				/*
    94				 * It's the most ideal case if the requested rate can be
    95				 * divided from parent clock without any need to change
    96				 * parent rate, so return the divider immediately.
    97				 */
    98				*best_parent_rate = parent_rate_saved;
    99				return clkt->val;
   100			}
   101	
   102			parent_rate = clk_hw_round_rate(clk_hw_get_parent(hw),
   103					try_parent_rate);
   104			cur_rate = DIV_ROUND_UP(parent_rate, clkt->div) * clkt->mul;
   105			if (cur_rate <= rate && cur_rate > best) {
   106				bestval = clkt->val;
   107				best = cur_rate;
   108				*best_parent_rate = parent_rate;
   109			}
   110		}
   111	
   112		if (!bestval) {
   113			bestval = _get_table_maxval(clkt);
   114			*best_parent_rate = clk_hw_round_rate(
   115					clk_hw_get_parent(hw), 1);
   116		}
   117	
   118		return bestval;
   119	}
   120	
   121	long owl_factor_helper_round_rate(struct owl_clk_common *common,
   122					const struct owl_factor_hw *factor_hw,
   123					unsigned long rate,
   124					unsigned long *parent_rate)
   125	{
   126		const struct clk_factor_table *clkt = factor_hw->table;
   127		unsigned int val, mul = 0, div = 1;
   128	
   129		val = clk_val_best(&common->hw, rate, parent_rate);
   130		_get_table_div_mul(clkt, val, &mul, &div);
   131	
   132		return *parent_rate * mul / div;
   133	}
   134	
   135	static long owl_factor_round_rate(struct clk_hw *hw, unsigned long rate,
   136				unsigned long *parent_rate)
   137	{
   138		struct owl_factor *factor = hw_to_owl_factor(hw);
   139		struct owl_factor_hw *factor_hw = &factor->factor_hw;
   140	
   141		return owl_factor_helper_round_rate(&factor->common, factor_hw,
   142						rate, parent_rate);
   143	}
   144	
   145	unsigned long owl_factor_helper_recalc_rate(struct owl_clk_common *common,
   146						 const struct owl_factor_hw *factor_hw,
   147						 unsigned long parent_rate)
   148	{
   149		const struct clk_factor_table *clkt = factor_hw->table;
   150		unsigned long rate;
   151		u32 reg, val, mul, div;
   152	
   153		div = 0;
   154		mul = 0;
   155	
   156		regmap_read(common->regmap, factor_hw->reg, &reg);
   157	
   158		val = reg >> factor_hw->shift;
   159		val &= div_mask(factor_hw);
   160	
   161		_get_table_div_mul(clkt, val, &mul, &div);
   162		if (!div) {
   163			WARN(!(factor_hw->fct_flags & CLK_DIVIDER_ALLOW_ZERO),
   164				"%s: Zero divisor and CLK_DIVIDER_ALLOW_ZERO not set\n",
   165				__clk_get_name(common->hw.clk));
   166			return parent_rate;
   167		}
   168	
   169		rate = parent_rate * mul;
 > 170		do_div(rate, div);
   171	
   172		return rate;
   173	}
   174	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 48064 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180319/6edfec35/attachment-0001.gz>
