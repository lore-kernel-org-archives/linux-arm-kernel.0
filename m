From: cristian.birsan@microchip.com (Cristian Birsan)
Date: Wed, 10 Aug 2016 15:15:20 +0300
Subject: Applied "regmap: debugfs: Add support for dumping write only
 device registers" to the regmap tree
In-Reply-To: <201608092110.TpRzOy7C%fengguang.wu@intel.com>
References: <201608092110.TpRzOy7C%fengguang.wu@intel.com>
Message-ID: <57AB1AD8.9040907@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

It seems like a false alarm. The 0-DAY tree does not contain the same content as regmap/for-next tree.

>From the patch series "regmap: debugfs: Add support for dumping write only device registers the" the PATCH v2 1/2 is missing form 0-DAY tree while the PATCH v2 2/2 is applied. This triggered the warning. Let's wait for a new build ...

Cristi

On 08/09/2016 04:18 PM, kbuild test robot wrote:
> Hi Mark,
> 
> [auto build test WARNING on regmap/for-next]
> [also build test WARNING on v4.8-rc1 next-20160809]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Mark-Brown/Applied-regmap-debugfs-Add-support-for-dumping-write-only-device-registers-to-the-regmap-tree/20160809-205351
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next
> config: x86_64-randconfig-x019-201632 (attached as .config)
> compiler: gcc-6 (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from include/asm-generic/bug.h:4:0,
>                     from arch/x86/include/asm/bug.h:35,
>                     from include/linux/bug.h:4,
>                     from include/linux/mmdebug.h:4,
>                     from include/linux/gfp.h:4,
>                     from include/linux/slab.h:14,
>                     from drivers/base/regmap/regmap-debugfs.c:13:
>    drivers/base/regmap/regmap-debugfs.c: In function 'regmap_printable':
>    drivers/base/regmap/regmap-debugfs.c:85:37: error: implicit declaration of function 'regmap_cached' [-Werror=implicit-function-declaration]
>      if (!regmap_readable(map, reg) && !regmap_cached(map, reg))
>                                         ^
>    include/linux/compiler.h:151:30: note: in definition of macro '__trace_if'
>      if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
>                                  ^~~~
>>> drivers/base/regmap/regmap-debugfs.c:85:2: note: in expansion of macro 'if'
>      if (!regmap_readable(map, reg) && !regmap_cached(map, reg))
>      ^~
>    cc1: some warnings being treated as errors
> 
> vim +/if +85 drivers/base/regmap/regmap-debugfs.c
> 
>      7	 *
>      8	 * This program is free software; you can redistribute it and/or modify
>      9	 * it under the terms of the GNU General Public License version 2 as
>     10	 * published by the Free Software Foundation.
>     11	 */
>     12	
>   > 13	#include <linux/slab.h>
>     14	#include <linux/mutex.h>
>     15	#include <linux/debugfs.h>
>     16	#include <linux/uaccess.h>
>     17	#include <linux/device.h>
>     18	#include <linux/list.h>
>     19	
>     20	#include "internal.h"
>     21	
>     22	struct regmap_debugfs_node {
>     23		struct regmap *map;
>     24		const char *name;
>     25		struct list_head link;
>     26	};
>     27	
>     28	static struct dentry *regmap_debugfs_root;
>     29	static LIST_HEAD(regmap_debugfs_early_list);
>     30	static DEFINE_MUTEX(regmap_debugfs_early_lock);
>     31	
>     32	/* Calculate the length of a fixed format  */
>     33	static size_t regmap_calc_reg_len(int max_val)
>     34	{
>     35		return snprintf(NULL, 0, "%x", max_val);
>     36	}
>     37	
>     38	static ssize_t regmap_name_read_file(struct file *file,
>     39					     char __user *user_buf, size_t count,
>     40					     loff_t *ppos)
>     41	{
>     42		struct regmap *map = file->private_data;
>     43		int ret;
>     44		char *buf;
>     45	
>     46		buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
>     47		if (!buf)
>     48			return -ENOMEM;
>     49	
>     50		ret = snprintf(buf, PAGE_SIZE, "%s\n", map->dev->driver->name);
>     51		if (ret < 0) {
>     52			kfree(buf);
>     53			return ret;
>     54		}
>     55	
>     56		ret = simple_read_from_buffer(user_buf, count, ppos, buf, ret);
>     57		kfree(buf);
>     58		return ret;
>     59	}
>     60	
>     61	static const struct file_operations regmap_name_fops = {
>     62		.open = simple_open,
>     63		.read = regmap_name_read_file,
>     64		.llseek = default_llseek,
>     65	};
>     66	
>     67	static void regmap_debugfs_free_dump_cache(struct regmap *map)
>     68	{
>     69		struct regmap_debugfs_off_cache *c;
>     70	
>     71		while (!list_empty(&map->debugfs_off_cache)) {
>     72			c = list_first_entry(&map->debugfs_off_cache,
>     73					     struct regmap_debugfs_off_cache,
>     74					     list);
>     75			list_del(&c->list);
>     76			kfree(c);
>     77		}
>     78	}
>     79	
>     80	static bool regmap_printable(struct regmap *map, unsigned int reg)
>     81	{
>     82		if (regmap_precious(map, reg))
>     83			return false;
>     84	
>   > 85		if (!regmap_readable(map, reg) && !regmap_cached(map, reg))
>     86			return false;
>     87	
>     88		return true;
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
