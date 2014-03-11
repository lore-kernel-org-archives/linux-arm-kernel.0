From: Nathan_Lynch@mentor.com (Nathan Lynch)
Date: Tue, 11 Mar 2014 13:24:59 -0500
Subject: [PATCH v3] ARM: vDSO gettimeofday using generic timer architecture
In-Reply-To: <20140311141759.GA11826@linaro.org>
References: <1393813295-27376-1-git-send-email-nathan_lynch@mentor.com>
 <20140311141759.GA11826@linaro.org>
Message-ID: <531F54FB.2040707@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/11/2014 09:17 AM, Steve Capper wrote:
> On Sun, Mar 02, 2014 at 08:21:35PM -0600, Nathan Lynch wrote:
>> Provide fast userspace implementations of gettimeofday and
>> clock_gettime on systems that implement the generic timers extension
>> defined in ARMv7.  This follows the example of arm64 in conception but
>> significantly differs in some aspects of the implementation (C vs
>> assembly, mainly).
>
> I've given this a test with simple C program on an Arndale board
> (running A15 with 3.14-rc6 and LPAE) and it worked well. I also short
> circuited the VDSO to always fallback on syscalls and that worked well
> too.
> 
> So please add:
> Tested-by: Steve Capper <steve.capper@linaro.org>

Thank you Steve!


>> +/* Avoid undefined symbols that can be referenced by routines brought
>> + * in from libgcc.  libgcc's __div0, __aeabi_idiv0 and __aeabi_ldiv0
>> + * can call raise(3); here they are defined to loop forever: divide by
>> + * zero should not be possible in this code.
>> + */
> 
> I can't see any way a divide by zero could occur with this code, but I
> am paranoid that any future functions added to the vdso could divide by
> zero and lead to hanging behaviour. Would it be better to fail more
> explicitly?

Probably.  It puzzles me that these __*div0 routines are pulled in when
the file has only a division by constant, and I haven't found a way to
suppress this.  But if we're stuck with it, some kind of trap is likely
better, I agree.


>> +void __div0(void)
>> +{
>> +	for (;;)
>> +		;
>> +}
>> +
>> +void __aeabi_idiv0(void)
>> +{
>> +	for (;;)
>> +		;
>> +}
>> +
>> +void __aeabi_ldiv0(void)
>> +{
>> +	for (;;)
>> +		;
>> +}
>> +
>> +void __aeabi_unwind_cpp_pr0(void)
>> +{
>> +}
>> +
>> +void __aeabi_unwind_cpp_pr1(void)
>> +{
>> +}
>> +
>> +void __aeabi_unwind_cpp_pr2(void)
>> +{
>> +}
>> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
>> index 1f8fed94c2a4..84898cf4b030 100644
>> --- a/arch/arm/mm/Kconfig
>> +++ b/arch/arm/mm/Kconfig
>> @@ -825,6 +825,21 @@ config KUSER_HELPERS
>>  	  Say N here only if you are absolutely certain that you do not
>>  	  need these helpers; otherwise, the safe option is to say Y.
>>  
>> +config VDSO
>> +	bool "Enable vDSO for acceleration of some system calls"
>> +	depends on AEABI && MMU
>> +	default y if ARM_ARCH_TIMER
> 
> I would argue that it would be good to have the VDSO on consistently
> for all AEABI with MMU as syscalls are used as fallbacks anyway.

Falling back to syscall when conditions require it (e.g. a clock id the
vDSO doesn't handle, or clocksource != generic timer) is essential to
correct operation of the vDSO.  So while I don't necessarily disagree
with making CONFIG_VDSO default to y unconditionally, I don't follow
your reasoning :-)

My reasoning for 'default y if ARM_ARCH_TIMER' is that the vDSO without
the generic timer imposes a small overhead without much benefit.  The
_COARSE clock ids are handled regardless of clocksource, but I have the
impression that users of those are rare.

Anyway, I don't have a strongly-held position on the default setting for
CONFIG_VDSO.  Just thought I would explain how I arrived at what I wrote.
