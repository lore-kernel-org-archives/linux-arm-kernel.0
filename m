From: lkp@intel.com (kbuild test robot)
Date: Fri, 23 Nov 2018 05:40:23 +0800
Subject: [PATCH v2 1/2] bpf: add __weak hook for allocating executable
 memory
In-Reply-To: <20181121131733.14910-2-ard.biesheuvel@linaro.org>
References: <20181121131733.14910-2-ard.biesheuvel@linaro.org>
Message-ID: <201811230557.PsL96owu%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

I love your patch! Yet something to improve:

[auto build test ERROR on bpf-next/master]
[also build test ERROR on v4.20-rc3]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Ard-Biesheuvel/bpf-permit-JIT-allocations-to-be-served-outside-the-module-region/20181123-033144
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
config: i386-randconfig-s0-11191736 (attached as .config)
compiler: gcc-6 (Debian 6.4.0-9) 6.4.0 20171026
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   kernel/bpf/core.c: In function 'bpf_jit_free_exec':
>> kernel/bpf/core.c:632:24: error: 'size' undeclared (first use in this function)
     return module_memfree(size);
                           ^~~~
   kernel/bpf/core.c:632:24: note: each undeclared identifier is reported only once for each function it appears in
   kernel/bpf/core.c:632:9: warning: 'return' with a value, in function returning void
     return module_memfree(size);
            ^~~~~~~~~~~~~~
   kernel/bpf/core.c:630:13: note: declared here
    void __weak bpf_jit_free_exec(const void *addr)
                ^~~~~~~~~~~~~~~~~

vim +/size +632 kernel/bpf/core.c

   629	
   630	void __weak bpf_jit_free_exec(const void *addr)
   631	{
 > 632		return module_memfree(size);
   633	}
   634	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 36733 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181123/479932ec/attachment-0001.gz>
