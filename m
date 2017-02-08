From: lkp@intel.com (kbuild test robot)
Date: Wed, 8 Feb 2017 19:19:25 +0800
Subject: [PATCH 2/2 v2] cpufreq: qoriq: Don't look at clock
 implementation details
In-Reply-To: <1486532585-36463-2-git-send-email-yuantian.tang@nxp.com>
Message-ID: <201702081937.6pnj3VE2%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tang,

[auto build test WARNING on pm/linux-next]
[also build test WARNING on v4.10-rc7 next-20170208]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/yuantian-tang-nxp-com/cpufreq-qoriq-added-arm64-socs-support/20170208-163748
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: arm-multi_v7_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings

All warnings (new ones prefixed by >>):

   drivers/cpufreq/qoriq-cpufreq.c: In function 'qoriq_cpufreq_cpu_init':
>> drivers/cpufreq/qoriq-cpufreq.c:230:2: warning: 'pnode' may be used uninitialized in this function [-Wmaybe-uninitialized]
     of_node_put(pnode);
     ^~~~~~~~~~~~~~~~~~

vim +/pnode +230 drivers/cpufreq/qoriq-cpufreq.c

defa4c73 drivers/cpufreq/ppc-corenet-cpufreq.c Tang Yuantian 2013-06-05  214  		pr_err("invalid frequency table: %d\n", ret);
defa4c73 drivers/cpufreq/ppc-corenet-cpufreq.c Tang Yuantian 2013-06-05  215  		goto err_nomem1;
defa4c73 drivers/cpufreq/ppc-corenet-cpufreq.c Tang Yuantian 2013-06-05  216  	}
defa4c73 drivers/cpufreq/ppc-corenet-cpufreq.c Tang Yuantian 2013-06-05  217  
defa4c73 drivers/cpufreq/ppc-corenet-cpufreq.c Tang Yuantian 2013-06-05  218  	data->table = table;
defa4c73 drivers/cpufreq/ppc-corenet-cpufreq.c Tang Yuantian 2013-06-05  219  
defa4c73 drivers/cpufreq/ppc-corenet-cpufreq.c Tang Yuantian 2013-06-05  220  	/* update ->cpus if we have cluster, no harm if not */
a4f20742 drivers/cpufreq/ppc-corenet-cpufreq.c Tang Yuantian 2015-03-13  221  	set_affected_cpus(policy);
a4f20742 drivers/cpufreq/ppc-corenet-cpufreq.c Tang Yuantian 2015-03-13  222  	policy->driver_data = data;
defa4c73 drivers/cpufreq/ppc-corenet-cpufreq.c Tang Yuantian 2013-06-05  223  
906fe033 drivers/cpufreq/ppc-corenet-cpufreq.c Ed Swarthout  2014-06-05  224  	/* Minimum transition latency is 12 platform clocks */
906fe033 drivers/cpufreq/ppc-corenet-cpufreq.c Ed Swarthout  2014-06-05  225  	u64temp = 12ULL * NSEC_PER_SEC;
a4f20742 drivers/cpufreq/ppc-corenet-cpufreq.c Tang Yuantian 2015-03-13  226  	do_div(u64temp, get_bus_freq());
906fe033 drivers/cpufreq/ppc-corenet-cpufreq.c Ed Swarthout  2014-06-05  227  	policy->cpuinfo.transition_latency = u64temp + 1;
6712d293 drivers/cpufreq/ppc-corenet-cpufreq.c Tim Gardner   2014-04-28  228  
defa4c73 drivers/cpufreq/ppc-corenet-cpufreq.c Tang Yuantian 2013-06-05  229  	of_node_put(np);
8a95c144 drivers/cpufreq/qoriq-cpufreq.c       Tang Yuantian 2015-06-04 @230  	of_node_put(pnode);
defa4c73 drivers/cpufreq/ppc-corenet-cpufreq.c Tang Yuantian 2013-06-05  231  
defa4c73 drivers/cpufreq/ppc-corenet-cpufreq.c Tang Yuantian 2013-06-05  232  	return 0;
defa4c73 drivers/cpufreq/ppc-corenet-cpufreq.c Tang Yuantian 2013-06-05  233  
defa4c73 drivers/cpufreq/ppc-corenet-cpufreq.c Tang Yuantian 2013-06-05  234  err_nomem1:
defa4c73 drivers/cpufreq/ppc-corenet-cpufreq.c Tang Yuantian 2013-06-05  235  	kfree(table);
8a95c144 drivers/cpufreq/qoriq-cpufreq.c       Tang Yuantian 2015-06-04  236  err_pclk:
8a95c144 drivers/cpufreq/qoriq-cpufreq.c       Tang Yuantian 2015-06-04  237  	kfree(data->pclk);
defa4c73 drivers/cpufreq/ppc-corenet-cpufreq.c Tang Yuantian 2013-06-05  238  err_nomem2:

:::::: The code at line 230 was first introduced by commit
:::::: 8a95c1441c799bb0f0d31cdb11523d91923d51a7 cpufreq: qoriq: optimize the CPU frequency switching time

:::::: TO: Tang Yuantian <Yuantian.Tang@freescale.com>
:::::: CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 39884 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170208/d515f106/attachment-0001.gz>
