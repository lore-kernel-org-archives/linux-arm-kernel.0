From: lkp@intel.com (kbuild test robot)
Date: Wed, 20 Sep 2017 08:44:40 +0800
Subject: [PATCH 2/2] tee: optee: allow selection of ti-smc as a calling
 method
In-Reply-To: <20170918205005.30235-2-afd@ti.com>
Message-ID: <201709200803.w8Fkzkuw%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.14-rc1 next-20170919]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Andrew-F-Davis/ARM-smccc-call-Use-r12-to-route-secure-monitor-calls-on-TI-platforms/20170920-052543
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   drivers/tee/optee/core.o: In function `get_invoke_func':
>> drivers/tee/optee/core.c:445: undefined reference to `arm_ti_smccc_smc'
   drivers/tee/optee/core.c:445:(.init.text+0xc0): relocation truncated to fit: R_AARCH64_ADR_PREL_PG_HI21 against undefined symbol `arm_ti_smccc_smc'
>> drivers/tee/optee/core.c:445: undefined reference to `arm_ti_smccc_smc'

vim +445 drivers/tee/optee/core.c

   428	
   429	static optee_invoke_fn *get_invoke_func(struct device_node *np)
   430	{
   431		const char *method;
   432	
   433		pr_info("probing for conduit method from DT.\n");
   434	
   435		if (of_property_read_string(np, "method", &method)) {
   436			pr_warn("missing \"method\" property\n");
   437			return ERR_PTR(-ENXIO);
   438		}
   439	
   440		if (!strcmp("hvc", method))
   441			return optee_smccc_hvc;
   442		else if (!strcmp("smc", method))
   443			return optee_smccc_smc;
   444		else if (!strcmp("ti-smc", method))
 > 445			return arm_ti_smccc_smc;
   446	
   447		pr_warn("invalid \"method\" property: %s\n", method);
   448		return ERR_PTR(-EINVAL);
   449	}
   450	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 36756 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170920/95051a8b/attachment-0001.gz>
