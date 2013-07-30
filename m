From: gang.chen@asianux.com (Chen Gang)
Date: Tue, 30 Jul 2013 16:11:50 +0800
Subject: [PATCH] ARM64: include: asm: use 'int' instead of 'u32' for
 variable 'target' in kvm_host.h.
In-Reply-To: <51F76E2E.9050707@arm.com>
References: <51ECA9B6.3010808@asianux.com> <20130730034945.GD5471@cbox>
 <51F76E2E.9050707@arm.com>
Message-ID: <51F77546.1020906@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/30/2013 03:41 PM, Marc Zyngier wrote:
> On 30/07/13 04:49, Christoffer Dall wrote:
>> On Mon, Jul 22, 2013 at 11:40:38AM +0800, Chen Gang wrote:
>>> 'target' will be set to '-1' in kvm_arch_vcpu_init(), and it need check
>>> 'target' whether less than zero or not in kvm_vcpu_initialized().
>>>
>>> So need define target as 'int' instead of 'u32', just like ARM has done.
>>>
>>>
>>> The related warning:
>>>
>>>   arch/arm64/kvm/../../../arch/arm/kvm/arm.c:497:2: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
>>>
>>> Signed-off-by: Chen Gang <gang.chen@asianux.com>
>>> ---
>>>  arch/arm64/include/asm/kvm_host.h |    2 +-
>>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
>>> index 644d739..0859a4d 100644
>>> --- a/arch/arm64/include/asm/kvm_host.h
>>> +++ b/arch/arm64/include/asm/kvm_host.h
>>> @@ -129,7 +129,7 @@ struct kvm_vcpu_arch {
>>>  	struct kvm_mmu_memory_cache mmu_page_cache;
>>>  
>>>  	/* Target CPU and feature flags */
>>> -	u32 target;
>>> +	int target;
>>>  	DECLARE_BITMAP(features, KVM_VCPU_MAX_FEATURES);
>>>  
>>>  	/* Detect first run of a vcpu */
>>> -- 
>>> 1.7.7.6
>>
>> This looks ok to me, Marc, was there any reason to declare target a u32
>> on arm64?
> 
> No, that's simply a bug. I really wonder why my compiler doesn't scream
> at something that obvious...
> 

I make with "EXTRA_CFLAGS=-W", normal make will not report this
warning.  ;-)

> Chen: what compiler version are you using?
> 

[root at gchenlinux linux-next]# aarch64-linux-gnu-gcc -v
Using built-in specs.
COLLECT_GCC=aarch64-linux-gnu-gcc
COLLECT_LTO_WRAPPER=/usr/bin/../libexec/gcc/aarch64-linux-gnu/4.7.3/lto-wrapper
Target: aarch64-linux-gnu
Configured with: /cbuild/slaves/oorts/crosstool-ng/builds/aarch64-linux-gnu-linux/.build/src/gcc-linaro-4.7-2013.02/configure --build=i686-build_pc-linux-gnu --host=i686-build_pc-linux-gnu --target=aarch64-linux-gnu --prefix=/cbuild/slaves/oorts/crosstool-ng/builds/aarch64-linux-gnu-linux/install --with-sysroot=/cbuild/slaves/oorts/crosstool-ng/builds/aarch64-linux-gnu-linux/install/aarch64-linux-gnu/libc --enable-languages=c,c++,fortran --disable-multilib --with-pkgversion='crosstool-NG linaro-1.13.1-4.7-2013.02-01-20130221 - ARM aarch64 via Linaro' --with-bugurl=https://bugs.launchpad.net/gcc-linaro --enable-__cxa_atexit --disable-libmudflap --disable-libgomp --disable-libssp --with-gmp=/cbuild/slaves/oorts/crosstool-ng/builds/aarch64-linux-gnu-linux/.build/aarch64-linux-gnu/build/static --with-mpfr=/cbuild/slaves/oorts/crosstool-ng/builds/aarch64-linux-gnu-linux/.build/aarch64-linux-gnu/build/static --with-mpc=/cbuild/slaves/oorts/crosstool-ng/builds/aarch64-linux-gnu-linu
 x/.build/
aarch64-linux-gnu/build/static --with-ppl=/cbuild/slaves/oorts/crosstool-ng/builds/aarch64-linux-gnu-linux/.build/aarch64-linux-gnu/build/static --with-cloog=/cbuild/slaves/oorts/crosstool-ng/builds/aarch64-linux-gnu-linux/.build/aarch64-linux-gnu/build/static --with-libelf=/cbuild/slaves/oorts/crosstool-ng/builds/aarch64-linux-gnu-linux/.build/aarch64-linux-gnu/build/static --with-host-libstdcxx='-L/cbuild/slaves/oorts/crosstool-ng/builds/aarch64-linux-gnu-linux/.build/aarch64-linux-gnu/build/static/lib -lpwl' --enable-threads=posix --disable-libstdcxx-pch --enable-linker-build-id --enable-plugin --with-local-prefix=/cbuild/slaves/oorts/crosstool-ng/builds/aarch64-linux-gnu-linux/install/aarch64-linux-gnu/libc --enable-c99 --enable-long-long
Thread model: posix
gcc version 4.7.3 20130205 (prerelease) (crosstool-NG linaro-1.13.1-4.7-2013.02-01-20130221 - ARM aarch64 via Linaro) 


> I'll queue this fix.
> 
> Thanks,
> 
> 	M.
> 

Thank you too.

-- 
Chen Gang
