From: andre.przywara@arm.com (Andre Przywara)
Date: Wed, 19 Oct 2016 11:26:27 +0100
Subject: [PATCH] arm64: Cortex-A53 errata workaround: check for kernel
 addresses
In-Reply-To: <20161018130047.GC15639@leverpostej>
References: <20161018111627.17366-1-andre.przywara@arm.com>
 <20161018130047.GC15639@leverpostej>
Message-ID: <f9985f93-7aef-5d29-a53e-9536ad8989de@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 18/10/16 14:00, Mark Rutland wrote:
> On Tue, Oct 18, 2016 at 12:16:27PM +0100, Andre Przywara wrote:
>> Commit 7dd01aef0557 ("arm64: trap userspace "dc cvau" cache operation on
>> errata-affected core") adds code to execute cache maintenance instructions
>> in the kernel on behalf of userland on CPUs with certain ARM CPU errata.
>> It turns out that the address hasn't been checked to be a valid user
>> space address, allowing userland to clean cache lines in kernel space.
>> Fix this by introducing an access_ok() check before executing the
>> instructions on behalf of userland, taking care of tagged pointers on
>> the way.
> 
> It would be worth calling out why we need access_ok_tagged here (i.e.
> since this is not a syscall, the tag bits may validly be set, and we
> must mask them out to check the "real" address).

Agreed.

> 
>> Reported-by: Kristina Martsenko <kristina.martsenko@arm.com>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>> Cc: <stable@vger.kernel.org> # 4.8.x
> 
> It would be good to have an explicit:
> 
> Fixes: 7dd01aef0557 ("arm64: trap userspace "dc cvau" cache operation on errata-affected core")
> 
>> ---
>>  arch/arm64/include/asm/uaccess.h |  4 ++++
>>  arch/arm64/kernel/traps.c        | 32 ++++++++++++++++++++++++++++----
>>  2 files changed, 32 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
>> index bcaf6fb..f842b47 100644
>> --- a/arch/arm64/include/asm/uaccess.h
>> +++ b/arch/arm64/include/asm/uaccess.h
>> @@ -21,6 +21,7 @@
>>  /*
>>   * User space memory access functions
>>   */
>> +#include <linux/bitops.h>
>>  #include <linux/kasan-checks.h>
>>  #include <linux/string.h>
>>  #include <linux/thread_info.h>
>> @@ -103,6 +104,9 @@ static inline void set_fs(mm_segment_t fs)
>>  })
>>  
>>  #define access_ok(type, addr, size)	__range_ok(addr, size)
>> +#define access_ok_tagged(type, addr, size)  access_ok(type,		       \
>> +						      sign_extend64(addr, 55), \
>> +						      size)
>>  #define user_addr_max			get_fs
>>  
>>  #define _ASM_EXTABLE(from, to)						\
>> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
>> index 5ff020f..04ea0d7 100644
>> --- a/arch/arm64/kernel/traps.c
>> +++ b/arch/arm64/kernel/traps.c
>> @@ -447,6 +447,30 @@ void cpu_enable_cache_maint_trap(void *__unused)
>>  		: "=r" (res)					\
>>  		: "r" (address), "i" (-EFAULT) )
>>  
>> +enum {USER_CACHE_MAINT_DC_CIVAC, USER_CACHE_MAINT_IC_IVAU};
>> +
>> +static int do_user_cache_maint(int ins_type, unsigned long address)
>> +{
>> +	int ret;
>> +	unsigned long cl_size = cache_line_size();
>> +
>> +	if (!access_ok_tagged(VERIFY_READ,
>> +			      round_down(address, cl_size),
>> +			      cl_size))
>> +		return -EFAULT;
> 
> We're only checking the D$ line size here; the I$ is not reported by
> cache_line_size().
> 
> We may as well use PAGE_SIZE here, given cache lines have to be
> naturally aligned and permissions are at page granularity. There's no
> functional difference, but the value can't change under our feet, and
> the compiler may be able to better optimize by folding the contant in.

Yeah, I was thinking about that as well, but found cache_line_size() to
be more readable. I will replace this with PAGE_SIZE and a comment.

>> +
>> +	switch (ins_type) {
>> +	case USER_CACHE_MAINT_DC_CIVAC:
>> +		__user_cache_maint("dc civac", address, ret);
>> +		break;
>> +	case USER_CACHE_MAINT_IC_IVAU:
>> +		__user_cache_maint("ic ivau", address, ret);
>> +		break;
>> +	}
>> +
>> +	return ret;
>> +}
> 
> We could make this function a macro (passing in the instruction
> explicitly), and avoid the enum and switch.

I am not a big fan of putting too much stuff into a macro. After all the
kernel is written in C, not CPP ;-)

But now that the access check can use PAGE_SIZE, it should be much
simpler, so I will give it a try.

> 
> Other than that, this looks good to me.

Thanks for looking at this!

Cheers,
Andre.

> 
> Thanks,
> Mark.
> 
>> +
>>  static void user_cache_maint_handler(unsigned int esr, struct pt_regs *regs)
>>  {
>>  	unsigned long address;
>> @@ -458,16 +482,16 @@ static void user_cache_maint_handler(unsigned int esr, struct pt_regs *regs)
>>  
>>  	switch (crm) {
>>  	case ESR_ELx_SYS64_ISS_CRM_DC_CVAU:	/* DC CVAU, gets promoted */
>> -		__user_cache_maint("dc civac", address, ret);
>> +		ret = do_user_cache_maint(USER_CACHE_MAINT_DC_CIVAC, address);
>>  		break;
>>  	case ESR_ELx_SYS64_ISS_CRM_DC_CVAC:	/* DC CVAC, gets promoted */
>> -		__user_cache_maint("dc civac", address, ret);
>> +		ret = do_user_cache_maint(USER_CACHE_MAINT_DC_CIVAC, address);
>>  		break;
>>  	case ESR_ELx_SYS64_ISS_CRM_DC_CIVAC:	/* DC CIVAC */
>> -		__user_cache_maint("dc civac", address, ret);
>> +		ret = do_user_cache_maint(USER_CACHE_MAINT_DC_CIVAC, address);
>>  		break;
>>  	case ESR_ELx_SYS64_ISS_CRM_IC_IVAU:	/* IC IVAU */
>> -		__user_cache_maint("ic ivau", address, ret);
>> +		ret = do_user_cache_maint(USER_CACHE_MAINT_IC_IVAU, address);
>>  		break;
>>  	default:
>>  		force_signal_inject(SIGILL, ILL_ILLOPC, regs, 0);
>> -- 
>> 2.9.0
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
> 
