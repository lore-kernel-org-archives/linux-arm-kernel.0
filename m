From: Andrew.Pinski@caviumnetworks.com (Pinski, Andrew)
Date: Tue, 1 Sep 2015 17:06:32 +0000
Subject: [PATCHv2] ARM64: Add AT_ARM64_MIDR to the aux vector
In-Reply-To: <A9115CAF-0C57-4810-97F6-6245E7D0CE48@gmail.com>
References: <1440873982-44062-1-git-send-email-apinski@cavium.com>
 <20150901163304.GC16430@leverpostej>,
 <A9115CAF-0C57-4810-97F6-6245E7D0CE48@gmail.com>
Message-ID: <4C8DD5E0-E1EA-40C6-B947-72189241023C@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org





> On Sep 2, 2015, at 12:51 AM, "pinskia at gmail.com" <pinskia@gmail.com> wrote:
> 
> 
> 
> 
> 
>> On Sep 2, 2015, at 12:33 AM, Mark Rutland <mark.rutland@arm.com> wrote:
>> 
>> Hi,
>> 
>>> On Sat, Aug 29, 2015 at 07:46:22PM +0100, Andrew Pinski wrote:
>>> It is useful to pass down MIDR register down to userland if all of
>>> the online cores are all the same type.  This adds AT_ARM64_MIDR
>>> aux vector type and passes down the midr system register.
>>> 
>>> This is alternative to MIDR_EL1 part of
>>> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/358995.html.
>>> It allows for faster access to midr_el1 than going through a trap and
>>> does not exist if the set of cores are not the same.
>> 
>> I'm not sure I follow the rationale. If speed is important the
>> application can cache the value the first time it reads it with a trap.
> 
> It is also about compatibility also. Exposing the register is not backwards compatible but using the aux vector is. 

That would also break big.little too. So either break it with hot plug or break it in userland, your choice. 


> 
>> 
>> This also means that the behaviour is different across homogeneous and
>> heterogeneous systems.

That should be ok because it is still backwards compatible with what was done before.  My goal here is just to allow quick easy access to midr in the case of a homogeneous system which I care about, thunderx and to allow glibc to select a memcpy/memset that is better for thunderx. 

Thanks,
Andrew

>> 
>>> Changes from v1:
>>> Forgot to include the auxvec.h part.
>>> 
>>> Signed-off-by: Andrew Pinski <apinski@cavium.com>
>>> ---
>>> arch/arm64/include/asm/cpu.h         |    1 +
>>> arch/arm64/include/asm/elf.h         |    6 ++++++
>>> arch/arm64/include/uapi/asm/auxvec.h |    3 +++
>>> arch/arm64/kernel/cpuinfo.c          |   22 ++++++++++++++++++++++
>>> 4 files changed, 32 insertions(+)
>>> 
>>> diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
>>> index 8e797b2..fab0aa1 100644
>>> --- a/arch/arm64/include/asm/cpu.h
>>> +++ b/arch/arm64/include/asm/cpu.h
>>> @@ -62,5 +62,6 @@ DECLARE_PER_CPU(struct cpuinfo_arm64, cpu_data);
>>> 
>>> void cpuinfo_store_cpu(void);
>>> void __init cpuinfo_store_boot_cpu(void);
>>> +u32 get_arm64_midr(void);
>>> 
>>> #endif /* __ASM_CPU_H */
>>> diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
>>> index faad6df..d3549de 100644
>>> --- a/arch/arm64/include/asm/elf.h
>>> +++ b/arch/arm64/include/asm/elf.h
>>> @@ -17,6 +17,7 @@
>>> #define __ASM_ELF_H
>>> 
>>> #include <asm/hwcap.h>
>>> +#include <asm/cpu.h>
>>> 
>>> /*
>>> * ELF register definitions..
>>> @@ -138,8 +139,13 @@ typedef struct user_fpsimd_state elf_fpregset_t;
>>> 
>>> #define ARCH_DLINFO                            \
>>> do {                                    \
>>> +    u32 midr;                            \
>>> +                                    \
>>>   NEW_AUX_ENT(AT_SYSINFO_EHDR,                    \
>>>           (elf_addr_t)current->mm->context.vdso);        \
>>> +    midr = get_arm64_midr();                    \
>>> +    if (midr != 0)                            \
>>> +        NEW_AUX_ENT(AT_ARM64_MIDR, (elf_addr_t)midr);        \
>>> } while (0)
>>> 
>>> #define ARCH_HAS_SETUP_ADDITIONAL_PAGES
>>> diff --git a/arch/arm64/include/uapi/asm/auxvec.h b/arch/arm64/include/uapi/asm/auxvec.h
>>> index 22d6d88..dc55c56 100644
>>> --- a/arch/arm64/include/uapi/asm/auxvec.h
>>> +++ b/arch/arm64/include/uapi/asm/auxvec.h
>>> @@ -19,4 +19,7 @@
>>> /* vDSO location */
>>> #define AT_SYSINFO_EHDR    33
>>> 
>>> +/* Machine IDenfier Register (MDIR). */
>>> +#define AT_ARM64_MIDR 38
>>> +
>>> #endif
>>> diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
>>> index 75d5a86..b14c87d 100644
>>> --- a/arch/arm64/kernel/cpuinfo.c
>>> +++ b/arch/arm64/kernel/cpuinfo.c
>>> @@ -254,3 +254,25 @@ void __init cpuinfo_store_boot_cpu(void)
>>> 
>>>   boot_cpu_data = *info;
>>> }
>>> +
>>> +u32 get_arm64_midr(void)
>>> +{
>>> +    int i;
>>> +    u32 midr = 0;
>>> +
>>> +    for_each_online_cpu(i) {
>>> +        struct cpuinfo_arm64 *cpuinfo = &per_cpu(cpu_data, i);
>>> +        u32 oldmidr = midr;
>>> +
>>> +        midr = cpuinfo->reg_midr;
>>> +        /*
>>> +         * If there are cpus which have a different
>>> +         * midr just return 0.
>>> +         */
>>> +        if (oldmidr && oldmidr != midr)
>>> +            return 0;
>>> +    }
>>> +
>>> +    return midr;
>>> +}
>> 
>> If I have a big.LITTLE system where all the big CPUs are currently
>> offline, this will leave the MIDR the little CPUs in the auxvec.
>> However, at any point after this has run, I could hotplug the big CPUs
>> on and the little CPUs off, leaving this reporting a MIDR that
>> represents none of the online CPUs.
>> 
>> Given big.LITTLE and the potential for physical/dynamic hotplug (where
>> we won't know all the MIDRs in advance), I don't think that we can
>> generally expose a common MIDR in this fashion, and I don't think that
>> we should give the impression that we can.
> 
> This is standard issue with hot plug and big.little. Really big.little is a design flaw but I am not going into that here. 
> 
> 
>> 
>> I think that the only things we can do are expose the MIDR for CPU the
>> code is currently executing on (as Suzuki's patches do), and/or expose
>> all the MIDRs for currently online CPUs (as Steve's [1] patch does).
>> Anything else leaves us trying to provide semantics that we cannot
>> guarantee.
> 
> Except they are not backwards compatible which means nobody in their right mind would use the register to get the midr that way. I am sorry but having a newer version of glibc working on a year old kernel is not going to fly. 
> 
> Thanks,
> Andrew
> 
> 
>> 
>> Thanks,
>> Mark.
>> 
>> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/359127.html
