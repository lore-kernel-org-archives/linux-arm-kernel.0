From: steve.capper@linaro.org (Steve Capper)
Date: Tue, 11 Mar 2014 14:17:59 +0000
Subject: [PATCH v3] ARM: vDSO gettimeofday using generic timer architecture
In-Reply-To: <1393813295-27376-1-git-send-email-nathan_lynch@mentor.com>
References: <1393813295-27376-1-git-send-email-nathan_lynch@mentor.com>
Message-ID: <20140311141759.GA11826@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 02, 2014 at 08:21:35PM -0600, Nathan Lynch wrote:
> Provide fast userspace implementations of gettimeofday and
> clock_gettime on systems that implement the generic timers extension
> defined in ARMv7.  This follows the example of arm64 in conception but
> significantly differs in some aspects of the implementation (C vs
> assembly, mainly).
> 
> Clocks supported:
> - CLOCK_REALTIME
> - CLOCK_MONOTONIC
> - CLOCK_REALTIME_COARSE
> - CLOCK_MONOTONIC_COARSE
> 
> This also provides clock_getres (as arm64 does).
> 
> Note that while the high-precision realtime and monotonic clock
> support depends on the generic timers extension, support for
> clock_getres and coarse clocks is independent of the timer
> implementation and is provided unconditionally.
> 
> Run-time tested on OMAP5 and i.MX6 using a patched glibc[1], verifying
> that results from the vDSO are consistent with results from the
> kernel.  Build-tested against arch/arm/configs/*_defconfig with GCC
> 4.4 and 4.8.  Build-tested with multi_v7_defconfig with GCC 4.[4-8].
> 
> [1] RFC glibc patch here:
> https://www.sourceware.org/ml/libc-alpha/2014-02/msg00680.html
> 
> Signed-off-by: Nathan Lynch <nathan_lynch@mentor.com>
> ---

Hi Nathan,
Thanks for sending in a V3.
I've given this a test with simple C program on an Arndale board
(running A15 with 3.14-rc6 and LPAE) and it worked well. I also short
circuited the VDSO to always fallback on syscalls and that worked well
too.

So please add:
Tested-by: Steve Capper <steve.capper@linaro.org>

Also, I have some feedback below.

[snip]

> diff --git a/arch/arm/kernel/vdso/vgettimeofday.c b/arch/arm/kernel/vdso/vgettimeofday.c
> new file mode 100644
> index 000000000000..d5d12528eed9
> --- /dev/null
> +++ b/arch/arm/kernel/vdso/vgettimeofday.c
> @@ -0,0 +1,330 @@

[snip]

> +int __kernel_gettimeofday(struct timeval *tv, struct timezone *tz)
> +{
> +	struct timespec ts;
> +	struct vdso_data *vdata;
> +	int ret;
> +
> +	vdata = __get_datapage();
> +
> +	ret = do_realtime(&ts, vdata);
> +	if (ret)
> +		return gettimeofday_fallback(tv, tz);
> +
> +	if (tv) {
> +		tv->tv_sec = ts.tv_sec;
> +		tv->tv_usec = ts.tv_nsec / 1000;
> +	}
> +	if (tz) {
> +		tz->tz_minuteswest = vdata->tz_minuteswest;
> +		tz->tz_dsttime = vdata->tz_dsttime;
> +	}
> +
> +	return ret;
> +}
> +
> +/* Avoid undefined symbols that can be referenced by routines brought
> + * in from libgcc.  libgcc's __div0, __aeabi_idiv0 and __aeabi_ldiv0
> + * can call raise(3); here they are defined to loop forever: divide by
> + * zero should not be possible in this code.
> + */

I can't see any way a divide by zero could occur with this code, but I
am paranoid that any future functions added to the vdso could divide by
zero and lead to hanging behaviour. Would it be better to fail more
explicitly?

> +void __div0(void)
> +{
> +	for (;;)
> +		;
> +}
> +
> +void __aeabi_idiv0(void)
> +{
> +	for (;;)
> +		;
> +}
> +
> +void __aeabi_ldiv0(void)
> +{
> +	for (;;)
> +		;
> +}
> +
> +void __aeabi_unwind_cpp_pr0(void)
> +{
> +}
> +
> +void __aeabi_unwind_cpp_pr1(void)
> +{
> +}
> +
> +void __aeabi_unwind_cpp_pr2(void)
> +{
> +}
> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> index 1f8fed94c2a4..84898cf4b030 100644
> --- a/arch/arm/mm/Kconfig
> +++ b/arch/arm/mm/Kconfig
> @@ -825,6 +825,21 @@ config KUSER_HELPERS
>  	  Say N here only if you are absolutely certain that you do not
>  	  need these helpers; otherwise, the safe option is to say Y.
>  
> +config VDSO
> +	bool "Enable vDSO for acceleration of some system calls"
> +	depends on AEABI && MMU
> +	default y if ARM_ARCH_TIMER

I would argue that it would be good to have the VDSO on consistently
for all AEABI with MMU as syscalls are used as fallbacks anyway.

> +	select GENERIC_TIME_VSYSCALL
> +	help
> +	  Place in the process address space an ELF shared object
> +	  providing fast implementations of several system calls,
> +	  including gettimeofday and clock_gettime.  Systems that
> +	  implement the ARM architected timer will receive maximum
> +	  benefit.
> +
> +	  You must have glibc 2.20 or later for programs to seamlessly
> +	  take advantage of this.
> +
>  config DMA_CACHE_RWFO
>  	bool "Enable read/write for ownership DMA cache maintenance"
>  	depends on CPU_V6K && SMP
> -- 
> 1.8.3.1
> 
