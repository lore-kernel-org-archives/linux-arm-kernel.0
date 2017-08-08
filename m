From: lkp@intel.com (kbuild test robot)
Date: Tue, 8 Aug 2017 17:18:24 +0800
Subject: [PATCH v4 3/6] coresight: of: Use of_cpu_node_to_id helper
In-Reply-To: <1502099560-6267-4-git-send-email-suzuki.poulose@arm.com>
Message-ID: <201708081748.bujrMOmJ%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suzuki,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.13-rc4 next-20170807]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Suzuki-K-Poulose/perf-Support-for-ARM-DynamIQ-Shared-Unit-PMU/20170808-124822
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

Note: the linux-review/Suzuki-K-Poulose/perf-Support-for-ARM-DynamIQ-Shared-Unit-PMU/20170808-124822 HEAD 5757d34d451ed5a1452526b27b0f36664a8f2007 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   drivers//hwtracing/coresight/of_coresight.c: In function 'of_coresight_get_cpu':
>> drivers//hwtracing/coresight/of_coresight.c:117:19: error: expected ';' before numeric constant
     return (cpu < 0) 0 : cpu;
                      ^

vim +117 drivers//hwtracing/coresight/of_coresight.c

   103	
   104	int of_coresight_get_cpu(const struct device_node *node)
   105	{
   106		int cpu;
   107		struct device_node *dn;
   108	
   109		dn = of_parse_phandle(node, "cpu", 0);
   110		/* Affinity defaults to CPU0 */
   111		if (!dn)
   112			return 0;
   113		cpu = of_cpu_node_to_id(dn);
   114		of_node_put(dn);
   115	
   116		/* Affinity to CPU0 if no cpu nodes are found */
 > 117		return (cpu < 0) 0 : cpu;
   118	}
   119	EXPORT_SYMBOL_GPL(of_coresight_get_cpu);
   120	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 63428 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170808/2ab06265/attachment-0001.gz>
