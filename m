From: james.morse@arm.com (James Morse)
Date: Tue, 19 Sep 2017 10:55:55 +0100
Subject: [PATCH v2 04/11] arm64: alternatives: use tpidr_el2 on VHE hosts
In-Reply-To: <20170917144334.GB99021@lvm>
References: <20170808164616.25949-1-james.morse@arm.com>
 <20170808164616.25949-5-james.morse@arm.com> <20170917144334.GB99021@lvm>
Message-ID: <59C0E9AB.7040703@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoffer,

On 17/09/17 15:43, Christoffer Dall wrote:
> On Tue, Aug 08, 2017 at 05:46:09PM +0100, James Morse wrote:
>> Now that KVM uses tpidr_el2 in the same way as Linux's cpu_offset in
>> tpidr_el1, merge the two. This saves KVM from save/restoring tpidr_el1
>> on VHE hosts, and allows future code to blindly access per-cpu variables
>> without triggering world-switch.

>> Changes since v1:
>>  * cpu_copy_el2regs()'s 'have I been patched' test now always sets a register,
>>    just in case the compiler puts do_copyregs on the stack.

> I don't understand this?

Looks like this was a note to myself, translation below:


>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>> index 9f9e0064c8c1..1960706d2422 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -1295,3 +1296,25 @@ static int __init enable_mrs_emulation(void)
>>  }
>>  
>>  late_initcall(enable_mrs_emulation);
>> +
>> +int cpu_copy_el2regs(void *__unused)
>> +{
>> +	int do_copyregs = 0;
>> +
>> +	/*
>> +	 * Copy register values that aren't redirected by hardware.
>> +	 *
>> +	 * Before code patching, we only set tpidr_el1, all CPUs need to copy
>> +	 * this value to tpidr_el2 before we patch the code. Once we've done
>> +	 * that, freshly-onlined CPUs will set tpidr_el2, so we don't need to
>> +	 * do anything here.
>> +	 */
>> +	asm volatile(ALTERNATIVE("mov %0, #1", "mov %0, #0",
>> +				 ARM64_HAS_VIRT_HOST_EXTN)
>> +		    : "=r" (do_copyregs) : : );
>> +
>> +	if (do_copyregs)
>> +		write_sysreg(read_sysreg(tpidr_el1), tpidr_el2);
> 
> Could you just use has_vhe() here ?

This is the 'have I been patched' test.
Before patching the my_cpu_offset value will be in tpidr_el1, we copy it to
tpidr_el2.

Once smp_cpus_done() calls apply_alternatives_all(), set_my_cpu_offset() is
patched to write its value into tpidr_el2. CPUs that come online after this
point don't need the value copying, but this cpufeature enable call will still
be called.

The skimmed-over information is that cpufeature's enable methods are called
locally when any core comes online, even after the alternatives have been
applied. (we also modify pstate and set sctlr bits from these).

Would it be clearer if I rewrote the comment as:
> cpufeature's enable methods are called whenever a CPU comes online, but we
> only need to copy tpidr_el1 -> tpidr_el2 on CPUs that were online before the
> alternatives are applied. After that point a VHE system will only use
> tpidr_el2.


The change-since-v1 was paranoia as 'do_copyregs' wasn't always updated: I was
worried about the compiler ditching the '=0' initialisation as its written by
the asm() before being read... but not once we've patched in the alternative.
Having to put 'do_copyregs' on the stack, but then deciding to just allocate it
late was where I thought this might happen. Short-version: I don't trust the
compiler.


>> +
>> +	return 0;
>> +}



> Otherwise:
> 
> Reviewed-by: Christoffer Dall <cdall@linaro.org>

Thanks!

James
