From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 09 Jul 2015 11:05:34 +0100
Subject: [PATCH 01/13] arm/arm64: Add new is_kernel_in_hyp_mode predicate
In-Reply-To: <20150709094230.GA20105@leverpostej>
References: <1436372356-30410-1-git-send-email-marc.zyngier@arm.com>
 <1436372356-30410-2-git-send-email-marc.zyngier@arm.com>
 <20150709094230.GA20105@leverpostej>
Message-ID: <559E476E.2000306@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/07/15 10:42, Mark Rutland wrote:
> Hi,
> 
>> +static inline bool is_kernel_in_hyp_mode(void)
>> +{
>> +	u64 el;
>> +
>> +	asm("mrs %0, CurrentEL" : "=r" (el));
>> +	return el == CurrentEL_EL2;
>> +}
> 
> If you can include cputype.h, I think this can be:
> 
> static inline bool is_kernel_in_hyp_mode(void)
> {
> 	return read_cpuid(CurrentEL) == CurrentEL_EL2;
> }

This would indeed work, but CurrentEL is hardly an ID register. I feel
slightly uncomfortable using read_cpuid (which might return a cached
version at some point) for random system registers.

Thoughts?

	M.
-- 
Jazz is not dead. It just smells funny...
