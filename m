From: fengguang.wu@intel.com (kbuild test robot)
Date: Sat, 13 May 2017 11:29:05 +0800
Subject: [xlnx:master 332/592] drivers/of/configfs.c:153:11: warning: format
 '%u' expects argument of type 'unsigned int', but argument 5 has type
 'size_t {aka long unsigned int}'
Message-ID: <201705131101.WWnDzyxU%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx master
head:   17360fb326e0a7fa424286973d0afa8da24f7b99
commit: 380e5d653ab51a38af4411fb16f49cbd6eb3b690 [332/592] OF: DT-Overlay configfs interface (v7)
config: ia64-allmodconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 6.2.0
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 380e5d653ab51a38af4411fb16f49cbd6eb3b690
        # save the attached .config to linux build tree
        make.cross ARCH=ia64 

All warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:13:0,
                    from include/linux/list.h:8,
                    from include/linux/kobject.h:20,
                    from include/linux/device.h:17,
                    from include/linux/node.h:17,
                    from include/linux/cpu.h:16,
                    from drivers/of/configfs.c:12:
   drivers/of/configfs.c: In function 'cfs_overlay_item_dtbo_read':
>> drivers/of/configfs.c:153:11: warning: format '%u' expects argument of type 'unsigned int', but argument 5 has type 'size_t {aka long unsigned int}' [-Wformat=]
     pr_debug("%s: buf=%p max_count=%u\n", __func__,
              ^
   include/linux/printk.h:261:21: note: in definition of macro 'pr_fmt'
    #define pr_fmt(fmt) fmt
                        ^~~
   include/linux/printk.h:309:2: note: in expansion of macro 'dynamic_pr_debug'
     dynamic_pr_debug(fmt, ##__VA_ARGS__)
     ^~~~~~~~~~~~~~~~
>> drivers/of/configfs.c:153:2: note: in expansion of macro 'pr_debug'
     pr_debug("%s: buf=%p max_count=%u\n", __func__,
     ^~~~~~~~

vim +153 drivers/of/configfs.c

     6	 * This program is free software; you can redistribute it and/or
     7	 * modify it under the terms of the GNU General Public License
     8	 * as published by the Free Software Foundation; either version
     9	 * 2 of the License, or (at your option) any later version.
    10	 */
    11	#include <linux/ctype.h>
  > 12	#include <linux/cpu.h>
    13	#include <linux/module.h>
    14	#include <linux/of.h>
    15	#include <linux/of_fdt.h>
    16	#include <linux/spinlock.h>
    17	#include <linux/sizes.h>
    18	#include <linux/slab.h>
    19	#include <linux/proc_fs.h>
    20	#include <linux/configfs.h>
    21	#include <linux/types.h>
    22	#include <linux/stat.h>
    23	#include <linux/limits.h>
    24	#include <linux/file.h>
    25	#include <linux/vmalloc.h>
    26	#include <linux/firmware.h>
    27	
    28	#include "of_private.h"
    29	
    30	struct cfs_overlay_item {
    31		struct config_item	item;
    32	
    33		char			path[PATH_MAX];
    34	
    35		const struct firmware	*fw;
    36		struct device_node	*overlay;
    37		int			ov_id;
    38	
    39		void			*dtbo;
    40		int			dtbo_size;
    41	};
    42	
    43	static int create_overlay(struct cfs_overlay_item *overlay, void *blob)
    44	{
    45		int err;
    46	
    47		/* unflatten the tree */
    48		of_fdt_unflatten_tree(blob, NULL, &overlay->overlay);
    49		if (overlay->overlay == NULL) {
    50			pr_err("%s: failed to unflatten tree\n", __func__);
    51			err = -EINVAL;
    52			goto out_err;
    53		}
    54		pr_debug("%s: unflattened OK\n", __func__);
    55	
    56		/* mark it as detached */
    57		of_node_set_flag(overlay->overlay, OF_DETACHED);
    58	
    59		/* perform resolution */
    60		err = of_resolve_phandles(overlay->overlay);
    61		if (err != 0) {
    62			pr_err("%s: Failed to resolve tree\n", __func__);
    63			goto out_err;
    64		}
    65		pr_debug("%s: resolved OK\n", __func__);
    66	
    67		err = of_overlay_create(overlay->overlay);
    68		if (err < 0) {
    69			pr_err("%s: Failed to create overlay (err=%d)\n",
    70					__func__, err);
    71			goto out_err;
    72		}
    73		overlay->ov_id = err;
    74	
    75	out_err:
    76		return err;
    77	}
    78	
    79	static inline struct cfs_overlay_item *to_cfs_overlay_item(
    80			struct config_item *item)
    81	{
    82		return item ? container_of(item, struct cfs_overlay_item, item) : NULL;
    83	}
    84	
    85	static ssize_t cfs_overlay_item_path_show(struct config_item *item, char *page)
    86	{
    87		return sprintf(page, "%s\n", to_cfs_overlay_item(item)->path);
    88	}
    89	
    90	static ssize_t cfs_overlay_item_path_store(struct config_item *item,
    91			const char *page, size_t count)
    92	{
    93		struct cfs_overlay_item *overlay = to_cfs_overlay_item(item);
    94		const char *p = page;
    95		char *s;
    96		int err;
    97	
    98		/* if it's set do not allow changes */
    99		if (overlay->path[0] != '\0' || overlay->dtbo_size > 0)
   100			return -EPERM;
   101	
   102		/* copy to path buffer (and make sure it's always zero terminated */
   103		count = snprintf(overlay->path, sizeof(overlay->path) - 1, "%s", p);
   104		overlay->path[sizeof(overlay->path) - 1] = '\0';
   105	
   106		/* strip trailing newlines */
   107		s = overlay->path + strlen(overlay->path);
   108		while (s > overlay->path && *--s == '\n')
   109			*s = '\0';
   110	
   111		pr_debug("%s: path is '%s'\n", __func__, overlay->path);
   112	
   113		err = request_firmware(&overlay->fw, overlay->path, NULL);
   114		if (err != 0)
   115			goto out_err;
   116	
   117		err = create_overlay(overlay, (void *)overlay->fw->data);
   118		if (err < 0)
   119			goto out_err;
   120	
   121		return count;
   122	
   123	out_err:
   124	
   125		release_firmware(overlay->fw);
   126		overlay->fw = NULL;
   127	
   128		overlay->path[0] = '\0';
   129		return err;
   130	}
   131	
   132	static ssize_t cfs_overlay_item_status_show(struct config_item *item,
   133			char *page)
   134	{
   135		return sprintf(page, "%s\n", to_cfs_overlay_item(item)->ov_id >= 0 ?
   136						"applied" : "unapplied");
   137	}
   138	
   139	CONFIGFS_ATTR(cfs_overlay_item_, path);
   140	CONFIGFS_ATTR_RO(cfs_overlay_item_, status);
   141	
   142	static struct configfs_attribute *cfs_overlay_attrs[] = {
   143		&cfs_overlay_item_attr_path,
   144		&cfs_overlay_item_attr_status,
   145		NULL,
   146	};
   147	
   148	ssize_t cfs_overlay_item_dtbo_read(struct config_item *item, void *buf,
   149			size_t max_count)
   150	{
   151		struct cfs_overlay_item *overlay = to_cfs_overlay_item(item);
   152	
 > 153		pr_debug("%s: buf=%p max_count=%u\n", __func__,
   154				buf, max_count);
   155	
   156		if (overlay->dtbo == NULL)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 45258 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170513/22724255/attachment-0001.gz>
