From: lkp@intel.com (kbuild test robot)
Date: Sun, 30 Jul 2017 01:15:55 +0800
Subject: [PATCH] soc: ti: knav: Add a NULL pointer check for kdev in
 knav_pool_create
In-Reply-To: <1501227556-21087-1-git-send-email-j-keerthy@ti.com>
Message-ID: <201707300147.Viwn0WDf%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Keerthy,

[auto build test WARNING on keystone/next]
[also build test WARNING on v4.13-rc2 next-20170728]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Keerthy/soc-ti-knav-Add-a-NULL-pointer-check-for-kdev-in-knav_pool_create/20170729-143239
base:   https://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git next
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All warnings (new ones prefixed by >>):

   drivers/soc/ti/knav_qmss_queue.c: In function 'knav_pool_create':
>> drivers/soc/ti/knav_qmss_queue.c:749:10: warning: return makes pointer from integer without a cast [-Wint-conversion]
      return -EPROBE_DEFER;
             ^

vim +749 drivers/soc/ti/knav_qmss_queue.c

   727	
   728	/**
   729	 * knav_pool_create()	- Create a pool of descriptors
   730	 * @name		- name to give the pool handle
   731	 * @num_desc		- numbers of descriptors in the pool
   732	 * @region_id		- QMSS region id from which the descriptors are to be
   733	 *			  allocated.
   734	 *
   735	 * Returns a pool handle on success.
   736	 * Use IS_ERR_OR_NULL() to identify error values on return.
   737	 */
   738	void *knav_pool_create(const char *name,
   739						int num_desc, int region_id)
   740	{
   741		struct knav_region *reg_itr, *region = NULL;
   742		struct knav_pool *pool, *pi;
   743		struct list_head *node;
   744		unsigned last_offset;
   745		bool slot_found;
   746		int ret;
   747	
   748		if (!kdev)
 > 749			return -EPROBE_DEFER;
   750	
   751		if (!kdev->dev)
   752			return ERR_PTR(-ENODEV);
   753	
   754		pool = devm_kzalloc(kdev->dev, sizeof(*pool), GFP_KERNEL);
   755		if (!pool) {
   756			dev_err(kdev->dev, "out of memory allocating pool\n");
   757			return ERR_PTR(-ENOMEM);
   758		}
   759	
   760		for_each_region(kdev, reg_itr) {
   761			if (reg_itr->id != region_id)
   762				continue;
   763			region = reg_itr;
   764			break;
   765		}
   766	
   767		if (!region) {
   768			dev_err(kdev->dev, "region-id(%d) not found\n", region_id);
   769			ret = -EINVAL;
   770			goto err;
   771		}
   772	
   773		pool->queue = knav_queue_open(name, KNAV_QUEUE_GP, 0);
   774		if (IS_ERR_OR_NULL(pool->queue)) {
   775			dev_err(kdev->dev,
   776				"failed to open queue for pool(%s), error %ld\n",
   777				name, PTR_ERR(pool->queue));
   778			ret = PTR_ERR(pool->queue);
   779			goto err;
   780		}
   781	
   782		pool->name = kstrndup(name, KNAV_NAME_SIZE, GFP_KERNEL);
   783		pool->kdev = kdev;
   784		pool->dev = kdev->dev;
   785	
   786		mutex_lock(&knav_dev_lock);
   787	
   788		if (num_desc > (region->num_desc - region->used_desc)) {
   789			dev_err(kdev->dev, "out of descs in region(%d) for pool(%s)\n",
   790				region_id, name);
   791			ret = -ENOMEM;
   792			goto err_unlock;
   793		}
   794	
   795		/* Region maintains a sorted (by region offset) list of pools
   796		 * use the first free slot which is large enough to accomodate
   797		 * the request
   798		 */
   799		last_offset = 0;
   800		slot_found = false;
   801		node = &region->pools;
   802		list_for_each_entry(pi, &region->pools, region_inst) {
   803			if ((pi->region_offset - last_offset) >= num_desc) {
   804				slot_found = true;
   805				break;
   806			}
   807			last_offset = pi->region_offset + pi->num_desc;
   808		}
   809		node = &pi->region_inst;
   810	
   811		if (slot_found) {
   812			pool->region = region;
   813			pool->num_desc = num_desc;
   814			pool->region_offset = last_offset;
   815			region->used_desc += num_desc;
   816			list_add_tail(&pool->list, &kdev->pools);
   817			list_add_tail(&pool->region_inst, node);
   818		} else {
   819			dev_err(kdev->dev, "pool(%s) create failed: fragmented desc pool in region(%d)\n",
   820				name, region_id);
   821			ret = -ENOMEM;
   822			goto err_unlock;
   823		}
   824	
   825		mutex_unlock(&knav_dev_lock);
   826		kdesc_fill_pool(pool);
   827		return pool;
   828	
   829	err_unlock:
   830		mutex_unlock(&knav_dev_lock);
   831	err:
   832		kfree(pool->name);
   833		devm_kfree(kdev->dev, pool);
   834		return ERR_PTR(ret);
   835	}
   836	EXPORT_SYMBOL_GPL(knav_pool_create);
   837	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 63414 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170730/b1378f24/attachment-0001.gz>
