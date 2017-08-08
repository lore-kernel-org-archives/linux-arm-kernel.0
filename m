From: lkp@intel.com (kbuild test robot)
Date: Tue, 8 Aug 2017 18:57:50 +0800
Subject: [PATCH v4 6/6] perf: ARM DynamIQ Shared Unit PMU support
In-Reply-To: <1502099560-6267-7-git-send-email-suzuki.poulose@arm.com>
Message-ID: <201708081851.zkRaPAIn%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suzuki,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.13-rc4 next-20170807]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Suzuki-K-Poulose/perf-Support-for-ARM-DynamIQ-Shared-Unit-PMU/20170808-124822
config: arm64-allmodconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   drivers//perf/arm_dsu_pmu.c: In function 'dsu_pmu_dt_get_cpus':
>> drivers//perf/arm_dsu_pmu.c:685:9: error: implicit declaration of function 'of_device_node_get_cpu' [-Werror=implicit-function-declaration]
      cpu = of_device_node_get_cpu(cpu_node);
            ^~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/of_device_node_get_cpu +685 drivers//perf/arm_dsu_pmu.c

   669	
   670	/**
   671	 * dsu_pmu_dt_get_cpus: Get the list of CPUs in the cluster.
   672	 */
   673	static int dsu_pmu_dt_get_cpus(struct device_node *dev, cpumask_t *mask)
   674	{
   675		int i = 0, n, cpu;
   676		struct device_node *cpu_node;
   677	
   678		n = of_count_phandle_with_args(dev, "cpus", NULL);
   679		if (n <= 0)
   680			return -ENODEV;
   681		for (; i < n; i++) {
   682			cpu_node = of_parse_phandle(dev, "cpus", i);
   683			if (!cpu_node)
   684				break;
 > 685			cpu = of_device_node_get_cpu(cpu_node);
   686			of_node_put(cpu_node);
   687			if (cpu >= nr_cpu_ids)
   688				break;
   689			cpumask_set_cpu(cpu, mask);
   690		}
   691		if (i != n)
   692			return -EINVAL;
   693		return 0;
   694	}
   695	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 56860 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170808/f26af28c/attachment-0001.gz>
