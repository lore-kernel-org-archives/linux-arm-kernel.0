From: lkp@intel.com (kbuild test robot)
Date: Mon, 26 Nov 2018 03:17:45 +0800
Subject: [PATCH v3 1/2] bpf: add __weak hook for allocating executable
 memory
In-Reply-To: <20181123094152.21368-2-ard.biesheuvel@linaro.org>
References: <20181123094152.21368-2-ard.biesheuvel@linaro.org>
Message-ID: <201811260345.7q7d6M1C%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

I love your patch! Perhaps something to improve:

[auto build test WARNING on arm64/for-next/core]
[also build test WARNING on v4.20-rc3 next-20181123]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Ard-Biesheuvel/bpf-permit-JIT-allocations-to-be-served-outside-the-module-region/20181126-024110
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
config: x86_64-randconfig-x007-201847 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

   kernel//bpf/core.c: In function 'bpf_jit_free_exec':
>> kernel//bpf/core.c:619:17: warning: passing argument 1 of 'module_memfree' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     module_memfree(addr);
                    ^~~~
   In file included from kernel//bpf/core.c:28:0:
   include/linux/moduleloader.h:30:6: note: expected 'void *' but argument is of type 'const void *'
    void module_memfree(void *module_region);
         ^~~~~~~~~~~~~~

vim +619 kernel//bpf/core.c

   616	
   617	void __weak bpf_jit_free_exec(const void *addr)
   618	{
 > 619		module_memfree(addr);
   620	}
   621	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 28772 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181126/3406027b/attachment-0001.gz>
