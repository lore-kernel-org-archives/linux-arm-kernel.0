From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 22 Nov 2018 22:08:00 +0100
Subject: [PATCH v2 1/2] bpf: add __weak hook for allocating executable
 memory
In-Reply-To: <201811230404.yavKPUOn%fengguang.wu@intel.com>
References: <20181121131733.14910-2-ard.biesheuvel@linaro.org>
 <201811230404.yavKPUOn%fengguang.wu@intel.com>
Message-ID: <800264DE-658A-46B4-8FA1-CD1CF314AA7A@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> On 22 Nov 2018, at 21:01, kbuild test robot <lkp@intel.com> wrote:
> 
> Hi Ard,
> 
> I love your patch! Yet something to improve:
> 

Ugh, apologies for this. I?m sure i build tested /something/ but clearly not what i should have tested.

In any case, following up on the discussion I?ll have to respin this in any case. I?ll triple check next time that what i send out was tested properly.


> [auto build test ERROR on bpf-next/master]
> [also build test ERROR on v4.20-rc3 next-20181122]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Ard-Biesheuvel/bpf-permit-JIT-allocations-to-be-served-outside-the-module-region/20181123-033144
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
> config: x86_64-randconfig-x002-201846 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>        # save the attached .config to linux build tree
>        make ARCH=x86_64 
> 
> All error/warnings (new ones prefixed by >>):
> 
>   kernel//bpf/core.c: In function 'bpf_jit_free_exec':
>>> kernel//bpf/core.c:632:24: error: 'size' undeclared (first use in this function); did you mean 'ksize'?
>     return module_memfree(size);
>                           ^~~~
>                           ksize
>   kernel//bpf/core.c:632:24: note: each undeclared identifier is reported only once for each function it appears in
>>> kernel//bpf/core.c:632:9: warning: 'return' with a value, in function returning void
>     return module_memfree(size);
>            ^~~~~~~~~~~~~~
>   kernel//bpf/core.c:630:13: note: declared here
>    void __weak bpf_jit_free_exec(const void *addr)
>                ^~~~~~~~~~~~~~~~~
> 
> vim +632 kernel//bpf/core.c
> 
>   629    
>   630    void __weak bpf_jit_free_exec(const void *addr)
>   631    {
>> 632        return module_memfree(size);
>   633    }
>   634    
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> <.config.gz>
