From: lkp@intel.com (kbuild test robot)
Date: Sat, 24 Nov 2018 10:57:46 +0800
Subject: [PATCH v2 2/2] arm64/bpf: don't allocate BPF JIT programs in
 module memory
In-Reply-To: <20181121131733.14910-3-ard.biesheuvel@linaro.org>
References: <20181121131733.14910-3-ard.biesheuvel@linaro.org>
Message-ID: <201811241058.juYoIaEF%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

I love your patch! Yet something to improve:

[auto build test ERROR on bpf-next/master]
[also build test ERROR on v4.20-rc3 next-20181123]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Ard-Biesheuvel/bpf-permit-JIT-allocations-to-be-served-outside-the-module-region/20181123-033144
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
config: x86_64-allmodconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   include/linux/slab.h:332:43: warning: dubious: x & !y
   kernel/bpf/core.c:625:6: warning: symbol 'bpf_jit_alloc_exec' was not declared. Should it be static?
>> kernel/bpf/core.c:632:31: error: undefined identifier 'size'
>> kernel/bpf/core.c:632:30: error: return expression in void function
   include/linux/slab.h:332:43: warning: dubious: x & !y
   kernel/bpf/core.c:1621:9: warning: incorrect type in argument 1 (different address spaces)
   include/linux/slab.h:332:43: warning: dubious: x & !y
   kernel/bpf/core.c:1695:44: warning: incorrect type in initializer (different address spaces)
   kernel/bpf/core.c:1719:26: warning: incorrect type in assignment (different address spaces)
   kernel/bpf/core.c:1753:26: warning: incorrect type in assignment (different address spaces)
   include/trace/events/xdp.h:28:1: warning: Using plain integer as NULL pointer
   include/trace/events/xdp.h:53:1: warning: Using plain integer as NULL pointer
   include/trace/events/xdp.h:111:1: warning: Using plain integer as NULL pointer
   include/trace/events/xdp.h:126:1: warning: Using plain integer as NULL pointer
   include/trace/events/xdp.h:161:1: warning: Using plain integer as NULL pointer
   include/trace/events/xdp.h:196:1: warning: Using plain integer as NULL pointer
   include/trace/events/xdp.h:231:1: warning: Using plain integer as NULL pointer
   kernel/bpf/core.c:1012:18: warning: Initializer entry defined twice
   kernel/bpf/core.c: In function 'bpf_jit_free_exec':
   kernel/bpf/core.c:632:24: error: 'size' undeclared (first use in this function); did you mean 'ksize'?
     return module_memfree(size);
                           ^~~~
                           ksize
   kernel/bpf/core.c:632:24: note: each undeclared identifier is reported only once for each function it appears in
   kernel/bpf/core.c:632:9: warning: 'return' with a value, in function returning void
     return module_memfree(size);
            ^~~~~~~~~~~~~~
   kernel/bpf/core.c:630:13: note: declared here
    void __weak bpf_jit_free_exec(const void *addr)
                ^~~~~~~~~~~~~~~~~

vim +/size +632 kernel/bpf/core.c

ede95a63b Daniel Borkmann 2018-10-23  624  
f65149135 Ard Biesheuvel  2018-11-21 @625  void *__weak bpf_jit_alloc_exec(unsigned long size)
f65149135 Ard Biesheuvel  2018-11-21  626  {
f65149135 Ard Biesheuvel  2018-11-21  627  	return module_alloc(size);
f65149135 Ard Biesheuvel  2018-11-21  628  }
f65149135 Ard Biesheuvel  2018-11-21  629  
f65149135 Ard Biesheuvel  2018-11-21  630  void __weak bpf_jit_free_exec(const void *addr)
f65149135 Ard Biesheuvel  2018-11-21  631  {
f65149135 Ard Biesheuvel  2018-11-21 @632  	return module_memfree(size);
f65149135 Ard Biesheuvel  2018-11-21  633  }
f65149135 Ard Biesheuvel  2018-11-21  634  

:::::: The code at line 632 was first introduced by commit
:::::: f6514913515dca448eb8ebd150918cc6d0a5515e bpf: add __weak hook for allocating executable memory

:::::: TO: Ard Biesheuvel <ard.biesheuvel@linaro.org>
:::::: CC: 0day robot <lkp@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 66569 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181124/65a7e461/attachment-0001.gz>
