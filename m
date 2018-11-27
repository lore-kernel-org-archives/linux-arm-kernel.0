From: lkp@intel.com (kbuild test robot)
Date: Tue, 27 Nov 2018 13:38:41 +0800
Subject: [PATCH v5 2/4] kgdb: Fix kgdb_roundup_cpus() for arches who used
 smp_call_function()
In-Reply-To: <20181127035133.225592-3-dianders@chromium.org>
References: <20181127035133.225592-3-dianders@chromium.org>
Message-ID: <201811271333.8ZTVxYUT%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Douglas,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on kgdb/kgdb-next]
[also build test ERROR on v4.20-rc4 next-20181126]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Douglas-Anderson/kgdb-Fix-kgdb_roundup_cpus/20181127-115425
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jwessel/kgdb.git kgdb-next
config: sparc64-allyesconfig (attached as .config)
compiler: sparc64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=sparc64 

Note: the linux-review/Douglas-Anderson/kgdb-Fix-kgdb_roundup_cpus/20181127-115425 HEAD b8d0502e65f2d7a2187baa69870146a6fbf18c9f builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   kernel/debug/debug_core.c: In function 'kgdb_roundup_cpus':
>> kernel/debug/debug_core.c:261:18: error: 'struct debuggerinfo_struct' has no member named 'rounding_up'
       kgdb_info[cpu].rounding_up = false;
                     ^

vim +261 kernel/debug/debug_core.c

   244	
   245	void __weak kgdb_roundup_cpus(void)
   246	{
   247		call_single_data_t *csd;
   248		int this_cpu = raw_smp_processor_id();
   249		int cpu;
   250		int ret;
   251	
   252		for_each_online_cpu(cpu) {
   253			/* No need to roundup ourselves */
   254			if (cpu == this_cpu)
   255				continue;
   256	
   257			csd = &per_cpu(kgdb_roundup_csd, cpu);
   258			csd->func = kgdb_call_nmi_hook;
   259			ret = smp_call_function_single_async(cpu, csd);
   260			if (ret)
 > 261				kgdb_info[cpu].rounding_up = false;
   262		}
   263	}
   264	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 55426 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181127/a09a6228/attachment-0001.gz>
