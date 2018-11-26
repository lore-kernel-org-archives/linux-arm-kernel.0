From: lkp@intel.com (kbuild test robot)
Date: Mon, 26 Nov 2018 10:22:41 +0800
Subject: [PATCH v3 2/2] arm64/bpf: don't allocate BPF JIT programs in
 module memory
In-Reply-To: <20181123094152.21368-3-ard.biesheuvel@linaro.org>
References: <20181123094152.21368-3-ard.biesheuvel@linaro.org>
Message-ID: <201811261045.VYtat2yg%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

I love your patch! Perhaps something to improve:

[auto build test WARNING on arm64/for-next/core]
[also build test WARNING on v4.20-rc4 next-20181123]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Ard-Biesheuvel/bpf-permit-JIT-allocations-to-be-served-outside-the-module-region/20181126-024110
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
config: x86_64-allmodconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

   include/linux/slab.h:332:43: warning: dubious: x & !y
   kernel/bpf/core.c:612:6: warning: symbol 'bpf_jit_alloc_exec' was not declared. Should it be static?
>> kernel/bpf/core.c:619:24: warning: incorrect type in argument 1 (different modifiers)
   kernel/bpf/core.c:619:24:    expected void *module_region
   kernel/bpf/core.c:619:24:    got void const *addr
   kernel/bpf/core.c:617:13: warning: symbol 'bpf_jit_free_exec' was not declared. Should it be static?
   include/linux/slab.h:332:43: warning: dubious: x & !y
   kernel/bpf/core.c:1608:9: warning: incorrect type in argument 1 (different address spaces)
   kernel/bpf/core.c:1608:9:    expected struct callback_head *head
   kernel/bpf/core.c:1608:9:    got struct callback_head [noderef] <asn:4>*<noident>
   include/linux/slab.h:332:43: warning: dubious: x & !y
   kernel/bpf/core.c:1682:44: warning: incorrect type in initializer (different address spaces)
   kernel/bpf/core.c:1682:44:    expected struct bpf_prog_array_item *item
   kernel/bpf/core.c:1682:44:    got struct bpf_prog_array_item [noderef] <asn:4>*<noident>
   kernel/bpf/core.c:1706:26: warning: incorrect type in assignment (different address spaces)
   kernel/bpf/core.c:1706:26:    expected struct bpf_prog_array_item *existing
   kernel/bpf/core.c:1706:26:    got struct bpf_prog_array_item [noderef] <asn:4>*<noident>
   kernel/bpf/core.c:1740:26: warning: incorrect type in assignment (different address spaces)
   kernel/bpf/core.c:1740:26:    expected struct bpf_prog_array_item *[assigned] existing
   kernel/bpf/core.c:1740:26:    got struct bpf_prog_array_item [noderef] <asn:4>*<noident>
   include/trace/events/xdp.h:28:1: warning: Using plain integer as NULL pointer
   include/trace/events/xdp.h:53:1: warning: Using plain integer as NULL pointer
   include/trace/events/xdp.h:111:1: warning: Using plain integer as NULL pointer
   include/trace/events/xdp.h:126:1: warning: Using plain integer as NULL pointer
   include/trace/events/xdp.h:161:1: warning: Using plain integer as NULL pointer
   include/trace/events/xdp.h:196:1: warning: Using plain integer as NULL pointer
   include/trace/events/xdp.h:231:1: warning: Using plain integer as NULL pointer
   kernel/bpf/core.c:999:18: warning: Initializer entry defined twice
   kernel/bpf/core.c:1001:17:   also defined here
   kernel/bpf/core.c: In function 'bpf_jit_free_exec':
   kernel/bpf/core.c:619:17: warning: passing argument 1 of 'module_memfree' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     module_memfree(addr);
                    ^~~~
   In file included from kernel/bpf/core.c:28:0:
   include/linux/moduleloader.h:30:6: note: expected 'void *' but argument is of type 'const void *'
    void module_memfree(void *module_region);
         ^~~~~~~~~~~~~~

vim +619 kernel/bpf/core.c

ede95a63b Daniel Borkmann 2018-10-23  611  
eff59cbcb Ard Biesheuvel  2018-11-23 @612  void *__weak bpf_jit_alloc_exec(unsigned long size)
eff59cbcb Ard Biesheuvel  2018-11-23  613  {
eff59cbcb Ard Biesheuvel  2018-11-23  614  	return module_alloc(size);
eff59cbcb Ard Biesheuvel  2018-11-23  615  }
eff59cbcb Ard Biesheuvel  2018-11-23  616  
eff59cbcb Ard Biesheuvel  2018-11-23  617  void __weak bpf_jit_free_exec(const void *addr)
eff59cbcb Ard Biesheuvel  2018-11-23  618  {
eff59cbcb Ard Biesheuvel  2018-11-23 @619  	module_memfree(addr);
eff59cbcb Ard Biesheuvel  2018-11-23  620  }
eff59cbcb Ard Biesheuvel  2018-11-23  621  

:::::: The code at line 619 was first introduced by commit
:::::: eff59cbcb348cb3df3fd41aba28df574c6cf7c27 bpf: add __weak hook for allocating executable memory

:::::: TO: Ard Biesheuvel <ard.biesheuvel@linaro.org>
:::::: CC: 0day robot <lkp@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 66620 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181126/00c6c7fd/attachment-0001.gz>
