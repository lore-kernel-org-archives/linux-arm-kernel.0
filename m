From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Thu, 23 Jun 2016 11:23:50 +0800
Subject: [PATCH] arm64: Add support ARCH_SUPPORTS_INT128
In-Reply-To: <20160622105749.GA6521@e104818-lin.cambridge.arm.com>
References: <1466492123-3356-1-git-send-email-wangkefeng.wang@huawei.com>
 <20160622105749.GA6521@e104818-lin.cambridge.arm.com>
Message-ID: <576B5646.2080002@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/6/22 18:57, Catalin Marinas wrote:
> On Tue, Jun 21, 2016 at 02:55:23PM +0800, Kefeng Wang wrote:
>> The gcc support __SIZEOF_INT128__ and __int128 in arm64, thus,
>> enable ARCH_SUPPORTS_INT128 to make mul_u64_u32_shr() a bit
>> more efficient in scheduler.
>>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>>  arch/arm64/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 5a0a691..ab319eb 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -11,6 +11,7 @@ config ARM64
>>  	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
>>  	select ARCH_USE_CMPXCHG_LOCKREF
>>  	select ARCH_SUPPORTS_ATOMIC_RMW
>> +	select ARCH_SUPPORTS_INT128
>>  	select ARCH_SUPPORTS_NUMA_BALANCING
>>  	select ARCH_WANT_OPTIONAL_GPIOLIB
>>  	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION
> 
> With this patch and UBSAN+KASAN enabled, Linux fails to link with:

Hi Catalin,

I use an old gcc version[1], after enable CONFIG_UBSAN, I got some build error,

wkf at linux:~/work/linux/build-64> ../scripts/diffconfig .config*
 UBSAN n -> y
+UBSAN_ALIGNMENT n
+UBSAN_SANITIZE_ALL y

arch/arm64/kernel/built-in.o: In function `c_show':
/home/wkf/work/linux/build-64/../arch/arm64/kernel/cpuinfo.c:125:(.text+0xfb28): relocation truncated to fit: R_AARCH64_LDST64_ABS_LO12_NC against symbol `loops_per_jiffy' defined in .data section in init/built-in.o
/home/wkf/work/linux/build-64/../arch/arm64/kernel/cpuinfo.c:125:(.text+0xfccc): relocation truncated to fit: R_AARCH64_LDST64_ABS_LO12_NC against symbol `loops_per_jiffy' defined in .data section in init/built-in.o
drivers/built-in.o: In function `_until_dmac_idle':
/home/wkf/work/linux/build-64/../drivers/dma/pl330.c:916:(.text+0x1920e0): relocation truncated to fit: R_AARCH64_LDST64_ABS_LO12_NC against symbol `loops_per_jiffy' defined in .data section in init/built-in.o
drivers/built-in.o: In function `xen_alloc_coherent_pages':
/home/wkf/work/linux/build-64/../arch/arm64/include/../../arm/include/asm/xen/page-coherent.h:24:(.text+0x1f3b2c): relocation truncated to fit: R_AARCH64_LDST64_ABS_LO12_NC against symbol `dummy_dma_ops' defined in .data section in arch/arm64/mm/built-in.o
drivers/built-in.o: In function `flush':
/home/wkf/work/linux/build-64/../drivers/spi/spi-pl022.c:549:(.text+0x4080f8): relocation truncated to fit: R_AARCH64_LDST64_ABS_LO12_NC against symbol `loops_per_jiffy' defined in .data section in init/built-in.o
drivers/built-in.o: In function `e1000_clean_rx_irq_ps':
/home/wkf/work/linux/build-64/../drivers/net/ethernet/intel/e1000e/netdev.c:1394:(.text+0x49a864): relocation truncated to fit: R_AARCH64_LDST32_ABS_LO12_NC against symbol `copybreak' defined in .data section in drivers/built-in.o
drivers/built-in.o: In function `e1000_clean_rx_irq':
/home/wkf/work/linux/build-64/../drivers/net/ethernet/intel/e1000e/netdev.c:1018:(.text+0x49c408): relocation truncated to fit: R_AARCH64_LDST32_ABS_LO12_NC against symbol `copybreak' defined in .data section in drivers/built-in.o
drivers/built-in.o: In function `e1000_clean_jumbo_rx_irq':
/home/wkf/work/linux/build-64/../drivers/net/ethernet/intel/e1000e/netdev.c:1609:(.text+0x49d28c): relocation truncated to fit: R_AARCH64_LDST32_ABS_LO12_NC against symbol `copybreak' defined in .data section in drivers/built-in.o
drivers/built-in.o: In function `led_trigger_unregister':
/home/wkf/work/linux/build-64/../drivers/leds/led-triggers.c:233:(.text+0x7865e0): relocation truncated to fit: R_AARCH64_LDST64_ABS_LO12_NC against symbol `leds_list' defined in .data section in drivers/built-in.o
drivers/built-in.o: In function `led_trigger_register':
/home/wkf/work/linux/build-64/../drivers/leds/led-triggers.c:206:(.text+0x78693c): relocation truncated to fit: R_AARCH64_LDST64_ABS_LO12_NC against symbol `leds_list' defined in .data section in drivers/built-in.o
drivers/built-in.o: In function `tegra124_132_clock_init_post':
/home/wkf/work/linux/build-64/../drivers/clk/tegra/clk-tegra124.c:1641:(.init.text+0x3bd34): additional relocation overflows omitted from the output
make[2]: *** [vmlinux] Error 1
make[1]: *** [sub-make] Error 2
make: *** [__sub-make] Error 2


[1] gcc version
wkf at linux:~/work/linux/build-64> aarch64-linux-gnu-gcc -v
Using built-in specs.
COLLECT_GCC=aarch64-linux-gnu-gcc
COLLECT_LTO_WRAPPER=/opt/gcc-linaro-4.9-2014.11-x86_64_aarch64-linux-gnu/bin/../libexec/gcc/aarch64-linux-gnu/4.9.3/lto-wrapper
Target: aarch64-linux-gnu
Configured with: /home/buildslave/workspace/BinaryRelease/label/x86_64/target/aarch64-linux-gnu/snapshots/gcc-linaro-4.9-2014.11/configure SHELL=/bin/bash --with-bugurl=https://bugs.linaro.org --with-mpc=/home/buildslave/workspace/BinaryRelease/label/x86_64/target/aarch64-linux-gnu/_build/builds/destdir/x86_64-unknown-linux-gnu --with-mpfr=/home/buildslave/workspace/BinaryRelease/label/x86_64/target/aarch64-linux-gnu/_build/builds/destdir/x86_64-unknown-linux-gnu --with-gmp=/home/buildslave/workspace/BinaryRelease/label/x86_64/target/aarch64-linux-gnu/_build/builds/destdir/x86_64-unknown-linux-gnu --with-gnu-as --with-gnu-ld --disable-libstdcxx-pch --disable-libmudflap --with-cloog=no --with-ppl=no --with-isl=no --disable-nls --enable-multiarch --disable-multilib --enable-c99 --with-arch=armv8-a --disable-shared --enable-static --with-build-sysroot=/home/buildslave/workspace/BinaryRelease/label/x86_64/target/aarch64-linux-gnu/_build/sysroots/aarch64-linux-gnu --enable-lto --!
enable-l
inker-build-id --enable-long-long --enable-shared --with-sysroot=/home/buildslave/workspace/BinaryRelease/label/x86_64/target/aarch64-linux-gnu/_build/builds/destdir/x86_64-unknown-linux-gnu/libc --enable-languages=c,c++,fortran,lto -enable-fix-cortex-a53-835769 --enable-checking=release --with-bugurl=https://bugs.linaro.org --with-pkgversion='Linaro GCC 2014.11' --build=x86_64-unknown-linux-gnu --host=x86_64-unknown-linux-gnu --target=aarch64-linux-gnu --prefix=/home/buildslave/workspace/BinaryRelease/label/x86_64/target/aarch64-linux-gnu/_build/builds/destdir/x86_64-unknown-linux-gnu
Thread model: posix
gcc version 4.9.3 20141031 (prerelease) (Linaro GCC 2014.11)


> 
> lib/built-in.o: In function `get_signed_val':
> lib/ubsan.c:93: undefined reference to `__ashlti3'
> lib/ubsan.c:93: undefined reference to `__ashrti3'

Will update the new gcc and try again.

Thanks,
Kefeng

> 
> It succeeds if I revert commit d67703a8a69e ("arm64: kill off the libgcc
> dependency"). We may have to revisit that decision or implement the
> required library functions in the kernel. In general, I'd like to reduce
> the amount of code duplication if the functionality can be found
> elsewhere like in libgcc. There is a risk of not knowing precisely what
> ligbcc relies on (like libc functions), though there are other
> architectures linking against it.
> 
