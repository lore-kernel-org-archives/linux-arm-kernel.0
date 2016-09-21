From: lkp@intel.com (kbuild test robot)
Date: Thu, 22 Sep 2016 04:17:01 +0800
Subject: [PATCH v5] soc: qcom: add l2 cache perf events driver
In-Reply-To: <1474470350-25818-1-git-send-email-nleeder@codeaurora.org>
Message-ID: <201609220417.E9RcTnj9%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Neil,

[auto build test ERROR on next-20160921]
[cannot apply to linus/master linux/master v4.8-rc7 v4.8-rc6 v4.8-rc5 v4.8-rc7]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
[Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
[Check https://git-scm.com/docs/git-format-patch for more information]

url:    https://github.com/0day-ci/linux/commits/Neil-Leeder/soc-qcom-add-l2-cache-perf-events-driver/20160922-000500
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All error/warnings (new ones prefixed by >>):

   drivers/soc/qcom/perf_event_l2.c: In function 'set_l2_indirect_reg':
>> drivers/soc/qcom/perf_event_l2.c:92:2: error: implicit declaration of function 'write_sysreg' [-Werror=implicit-function-declaration]
     write_sysreg(reg, L2CPUSRSELR_EL1);
     ^~~~~~~~~~~~
>> drivers/soc/qcom/perf_event_l2.c:74:33: error: 'S3_3_c15_c0_6' undeclared (first use in this function)
    #define L2CPUSRSELR_EL1         S3_3_c15_c0_6
                                    ^
>> drivers/soc/qcom/perf_event_l2.c:92:20: note: in expansion of macro 'L2CPUSRSELR_EL1'
     write_sysreg(reg, L2CPUSRSELR_EL1);
                       ^~~~~~~~~~~~~~~
   drivers/soc/qcom/perf_event_l2.c:74:33: note: each undeclared identifier is reported only once for each function it appears in
    #define L2CPUSRSELR_EL1         S3_3_c15_c0_6
                                    ^
>> drivers/soc/qcom/perf_event_l2.c:92:20: note: in expansion of macro 'L2CPUSRSELR_EL1'
     write_sysreg(reg, L2CPUSRSELR_EL1);
                       ^~~~~~~~~~~~~~~
>> drivers/soc/qcom/perf_event_l2.c:75:33: error: 'S3_3_c15_c0_7' undeclared (first use in this function)
    #define L2CPUSRDR_EL1           S3_3_c15_c0_7
                                    ^
>> drivers/soc/qcom/perf_event_l2.c:94:20: note: in expansion of macro 'L2CPUSRDR_EL1'
     write_sysreg(val, L2CPUSRDR_EL1);
                       ^~~~~~~~~~~~~
   drivers/soc/qcom/perf_event_l2.c: In function 'get_l2_indirect_reg':
>> drivers/soc/qcom/perf_event_l2.c:74:33: error: 'S3_3_c15_c0_6' undeclared (first use in this function)
    #define L2CPUSRSELR_EL1         S3_3_c15_c0_6
                                    ^
   drivers/soc/qcom/perf_event_l2.c:112:20: note: in expansion of macro 'L2CPUSRSELR_EL1'
     write_sysreg(reg, L2CPUSRSELR_EL1);
                       ^~~~~~~~~~~~~~~
>> drivers/soc/qcom/perf_event_l2.c:114:8: error: implicit declaration of function 'read_sysreg' [-Werror=implicit-function-declaration]
     val = read_sysreg(L2CPUSRDR_EL1);
           ^~~~~~~~~~~
>> drivers/soc/qcom/perf_event_l2.c:75:33: error: 'S3_3_c15_c0_7' undeclared (first use in this function)
    #define L2CPUSRDR_EL1           S3_3_c15_c0_7
                                    ^
   drivers/soc/qcom/perf_event_l2.c:114:20: note: in expansion of macro 'L2CPUSRDR_EL1'
     val = read_sysreg(L2CPUSRDR_EL1);
                       ^~~~~~~~~~~~~
   drivers/soc/qcom/perf_event_l2.c: In function 'l2_cache_pmu_probe_cluster':
>> drivers/soc/qcom/perf_event_l2.c:787:6: error: implicit declaration of function 'acpi_bus_get_device' [-Werror=implicit-function-declaration]
     if (acpi_bus_get_device(ACPI_HANDLE(dev), &device))
         ^~~~~~~~~~~~~~~~~~~
>> drivers/soc/qcom/perf_event_l2.c:790:20: error: dereferencing pointer to incomplete type 'struct acpi_device'
     if (kstrtol(device->pnp.unique_id, 10, &fw_cluster_id) < 0) {
                       ^~
   cc1: some warnings being treated as errors

vim +/write_sysreg +92 drivers/soc/qcom/perf_event_l2.c

    68	
    69	#define L2_EVT_GROUP_MAX        7
    70	
    71	#define L2_MAX_PERIOD           U32_MAX
    72	#define L2_CNT_PERIOD           (U32_MAX - GENMASK(26, 0))
    73	
  > 74	#define L2CPUSRSELR_EL1         S3_3_c15_c0_6
  > 75	#define L2CPUSRDR_EL1           S3_3_c15_c0_7
    76	
    77	static DEFINE_RAW_SPINLOCK(l2_access_lock);
    78	
    79	/**
    80	 * set_l2_indirect_reg: write value to an L2 register
    81	 * @reg: Address of L2 register.
    82	 * @value: Value to be written to register.
    83	 *
    84	 * Use architecturally required barriers for ordering between system register
    85	 * accesses
    86	 */
    87	static void set_l2_indirect_reg(u64 reg, u64 val)
    88	{
    89		unsigned long flags;
    90	
    91		raw_spin_lock_irqsave(&l2_access_lock, flags);
  > 92		write_sysreg(reg, L2CPUSRSELR_EL1);
    93		isb();
  > 94		write_sysreg(val, L2CPUSRDR_EL1);
    95		isb();
    96		raw_spin_unlock_irqrestore(&l2_access_lock, flags);
    97	}
    98	
    99	/**
   100	 * get_l2_indirect_reg: read an L2 register value
   101	 * @reg: Address of L2 register.
   102	 *
   103	 * Use architecturally required barriers for ordering between system register
   104	 * accesses
   105	 */
   106	static u64 get_l2_indirect_reg(u64 reg)
   107	{
   108		u64 val;
   109		unsigned long flags;
   110	
   111		raw_spin_lock_irqsave(&l2_access_lock, flags);
   112		write_sysreg(reg, L2CPUSRSELR_EL1);
   113		isb();
 > 114		val = read_sysreg(L2CPUSRDR_EL1);
   115		raw_spin_unlock_irqrestore(&l2_access_lock, flags);
   116	
   117		return val;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 59315 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160922/bf497f00/attachment-0001.gz>
