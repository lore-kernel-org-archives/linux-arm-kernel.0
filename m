From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Thu, 23 Mar 2017 11:30:16 +0000
Subject: [RFC PATCH v2 21/41] arm64/sve: Enable SVE on demand for userspace
In-Reply-To: <20170323112404.GC3750@e103592.cambridge.arm.com>
References: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
 <1490194274-30569-22-git-send-email-Dave.Martin@arm.com>
 <20170322164809.GC19950@leverpostej>
 <20170323112404.GC3750@e103592.cambridge.arm.com>
Message-ID: <98bf1730-7579-d9f9-37c0-75ccfc29087b@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/03/17 11:24, Dave Martin wrote:
> On Wed, Mar 22, 2017 at 04:48:10PM +0000, Mark Rutland wrote:
>> Hi,
>>
>> On Wed, Mar 22, 2017 at 02:50:51PM +0000, Dave Martin wrote:
>>> This patch tracks whether a task has ever attempted to use the
>>> Scalable Vector Extension.  If and only if SVE is in use by a task,
>>> it will be enabled for userspace when scheduling the task in.  For
>>> other tasks, SVE is disabled when scheduling in.
>>
>>>  #define TIF_SYSCALL_AUDIT	9
>>>  #define TIF_SYSCALL_TRACEPOINT	10
>>>  #define TIF_SECCOMP		11
>>> +#define TIF_SVE			17	/* Scalable Vector Extension in use */
>>
>> Please don't skip ahead to bit 17. I see why you're doing that, but I
>> don't think that's a good idea. More on that below.
>
> Well, a comment here to explain the dependency would have been a good
> idea, but I agree it's better to drop this trickery...
>
>>> +void do_sve_acc(unsigned int esr, struct pt_regs *regs)
>>> +{
>>> +	unsigned long tmp;
>>> +
>>> +	if (test_and_set_thread_flag(TIF_SVE))
>>> +		BUG();
>>> +
>>> +	asm ("mrs %0, cpacr_el1" : "=r" (tmp));
>>> +	asm volatile ("msr cpacr_el1, %0" :: "r" (tmp | (1 << 17)));
>>
>> Please de-magic the number, e.g. with something like:
>>
>> #define CPACR_SVE_EN	(1 << 17)
>>
>> ... in <asm/sysreg.h>.
>>
>> Please also use {read,write}_sysreg(), e.g.
>
> TBH, I was confused about the status of these macros at the time I
> wrote this code.
>
> The naming clash with the cpufeature functions is unfortunate.  In my
> head these names all became associated with "do something behind the
> scenes that may or may not really read the underlying system reg".
>
> Would it be reasonable to rename read_system_reg() to something more
> different, like read_kernel_sysreg(), read_system_id(),
> read_sanitised_id_reg(), etc.?

I agree. read_system_reg() is not quite obvious name given all the other
similar names. We could go with either read_sanitised_id_reg() or read_system_safe_reg() ?

Suzuki
