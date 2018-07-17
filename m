From: lkp@intel.com (kbuild test robot)
Date: Wed, 18 Jul 2018 04:36:28 +0800
Subject: [PATCH v5 06/11] soc: mediatek: add new flow for mtcmos power.
In-Reply-To: <1531817552-17221-7-git-send-email-mars.cheng@mediatek.com>
References: <1531817552-17221-7-git-send-email-mars.cheng@mediatek.com>
Message-ID: <201807180456.NRIktFD8%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Owen,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.18-rc5 next-20180717]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Mars-Cheng/Add-basic-SoC-support-for-mt6765/20180717-205540
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: openrisc-allyesconfig (attached as .config)
compiler: or1k-linux-gcc (GCC) 6.0.0 20160327 (experimental)
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=openrisc 

All errors (new ones prefixed by >>):

   In file included from include/linux/kernel.h:14:0,
                    from include/linux/clk.h:16,
                    from drivers/soc/mediatek/mtk-scpsys-ext.c:6:
   drivers/soc/mediatek/mtk-scpsys-ext.c: In function 'bus_clk_enable_disable':
>> drivers/soc/mediatek/mtk-scpsys-ext.c:141:12: error: implicit declaration of function '__clk_get_name' [-Werror=implicit-function-declaration]
               __clk_get_name(cc->clk));
               ^
   include/linux/printk.h:304:33: note: in definition of macro 'pr_err'
     printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
                                    ^~~~~~~~~~~
   In file included from include/linux/printk.h:7:0,
                    from include/linux/kernel.h:14,
                    from include/linux/clk.h:16,
                    from drivers/soc/mediatek/mtk-scpsys-ext.c:6:
   include/linux/kern_levels.h:5:18: warning: format '%s' expects argument of type 'char *', but argument 3 has type 'int' [-Wformat=]
    #define KERN_SOH "\001"  /* ASCII Start Of Header */
                     ^
   include/linux/kern_levels.h:11:18: note: in expansion of macro 'KERN_SOH'
    #define KERN_ERR KERN_SOH "3" /* error conditions */
                     ^~~~~~~~
   include/linux/printk.h:304:9: note: in expansion of macro 'KERN_ERR'
     printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
            ^~~~~~~~
   drivers/soc/mediatek/mtk-scpsys-ext.c:139:5: note: in expansion of macro 'pr_err'
        pr_err("Failed to  %s %s\n",
        ^~~~~~
   cc1: some warnings being treated as errors

vim +/__clk_get_name +141 drivers/soc/mediatek/mtk-scpsys-ext.c

   > 6	#include <linux/clk.h>
     7	#include <linux/clk-provider.h>
     8	#include <linux/slab.h>
     9	#include <linux/export.h>
    10	#include <linux/mfd/syscon.h>
    11	#include <linux/of_device.h>
    12	#include <linux/platform_device.h>
    13	#include <linux/regmap.h>
    14	#include <linux/soc/mediatek/infracfg.h>
    15	#include <linux/soc/mediatek/scpsys-ext.h>
    16	
    17	
    18	#define MAX_CLKS		10
    19	#define INFRA			"infracfg"
    20	#define SMIC			"smi_comm"
    21	
    22	static LIST_HEAD(ext_clk_map_list);
    23	static LIST_HEAD(ext_attr_map_list);
    24	
    25	static struct regmap *infracfg;
    26	static struct regmap *smi_comm;
    27	
    28	enum regmap_type {
    29		IFR_TYPE,
    30		SMI_TYPE,
    31		MAX_REGMAP_TYPE,
    32	};
    33	
    34	/**
    35	 * struct ext_reg_ctrl - set multiple register for bus protect
    36	 * @regmap: The bus protect regmap, 1: infracfg, 2: other master regmap
    37	 *                  such as SMI.
    38	 * @set_ofs: The set register offset to set corresponding bit to 1.
    39	 * @clr_ofs: The clr register offset to clear corresponding bit to 0.
    40	 * @sta_ofs: The status register offset to show bus protect enable/disable.
    41	 */
    42	struct ext_reg_ctrl {
    43		enum regmap_type type;
    44		u32 set_ofs;
    45		u32 clr_ofs;
    46		u32 sta_ofs;
    47	};
    48	
    49	/**
    50	 * struct ext_clk_ctrl - enable multiple clks for bus protect
    51	 * @clk: The clk need to enable before pwr on/bus protect.
    52	 * @scpd_n: The name present the scpsys domain where the clks belongs to.
    53	 * @clk_list: The list node linked to ext_clk_map_list.
    54	 */
    55	struct ext_clk_ctrl {
    56		struct clk *clk;
    57		const char *scpd_n;
    58		struct list_head clk_list;
    59	};
    60	
    61	struct bus_mask_ops {
    62		int	(*set)(struct regmap *regmap, u32 set_ofs,
    63			       u32 sta_ofs, u32 mask);
    64		int	(*release)(struct regmap *regmap, u32 clr_ofs,
    65				   u32 sta_ofs, u32 mask);
    66	};
    67	
    68	static struct scpsys_ext_attr *__get_attr_parent(const char *parent_n)
    69	{
    70		struct scpsys_ext_attr *attr;
    71	
    72		if (!parent_n)
    73			return ERR_PTR(-EINVAL);
    74	
    75		list_for_each_entry(attr, &ext_attr_map_list, attr_list) {
    76			if (attr->scpd_n && !strcmp(parent_n, attr->scpd_n))
    77				return attr;
    78		}
    79	
    80		return ERR_PTR(-EINVAL);
    81	}
    82	
    83	int bus_ctrl_set_release(struct scpsys_ext_attr *attr, bool set)
    84	{
    85		int i;
    86		int ret = 0;
    87	
    88		for (i = 0; i < MAX_STEP_NUM && attr->mask[i].mask; i++) {
    89			struct ext_reg_ctrl *rc = attr->mask[i].regs;
    90			struct regmap *regmap;
    91	
    92			if (rc->type == IFR_TYPE)
    93				regmap = infracfg;
    94			else if (rc->type == SMI_TYPE)
    95				regmap = smi_comm;
    96			else
    97				return -EINVAL;
    98	
    99			if (set)
   100				ret = attr->mask[i].ops->set(regmap,
   101							rc->set_ofs,
   102							rc->sta_ofs,
   103							attr->mask[i].mask);
   104			else
   105				ret = attr->mask[i].ops->release(regmap,
   106							rc->clr_ofs,
   107							rc->sta_ofs,
   108							attr->mask[i].mask);
   109		}
   110	
   111		return ret;
   112	}
   113	
   114	int bus_ctrl_set(struct scpsys_ext_attr *attr)
   115	{
   116		return bus_ctrl_set_release(attr, CMD_ENABLE);
   117	}
   118	
   119	int bus_ctrl_release(struct scpsys_ext_attr *attr)
   120	{
   121		return bus_ctrl_set_release(attr, CMD_DISABLE);
   122	}
   123	
   124	int bus_clk_enable_disable(struct scpsys_ext_attr *attr, bool enable)
   125	{
   126		int i = 0;
   127		int ret = 0;
   128		struct ext_clk_ctrl *cc;
   129		struct clk *clk[MAX_CLKS];
   130	
   131		list_for_each_entry(cc, &ext_clk_map_list, clk_list) {
   132			if (!strcmp(cc->scpd_n, attr->scpd_n)) {
   133				if (enable)
   134					ret = clk_prepare_enable(cc->clk);
   135				else
   136					clk_disable_unprepare(cc->clk);
   137	
   138				if (ret) {
   139					pr_err("Failed to  %s %s\n",
   140					       enable ? "enable" : "disable",
 > 141					       __clk_get_name(cc->clk));
   142					goto err;
   143				} else {
   144					clk[i] = cc->clk;
   145					i++;
   146				}
   147			}
   148		}
   149	
   150		return ret;
   151	
   152	err:
   153		for (--i; i >= 0; i--)
   154			if (enable)
   155				clk_disable_unprepare(clk[i]);
   156			else
   157				clk_prepare_enable(clk[i]);
   158		return ret;
   159	}
   160	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 45626 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180718/327cf1d5/attachment-0001.gz>
