From: Sudeep.KarkadaNagesha@arm.com (Sudeep KarkadaNagesha)
Date: Wed, 28 Aug 2013 14:12:46 +0100
Subject: [PATCH 01/02] ARM: shmobile: Add r8a73a4 SMP support using APMU
 code
In-Reply-To: <CANqRtoQaSJN+DSv9Uj=Dxv6RutS4aYVY8AM9J=6LqUQjyo3STw@mail.gmail.com>
References: <20130807225531.9856.18974.sendpatchset@w520>
 <20130807225540.9856.67383.sendpatchset@w520>	<52162638.5080107@arm.com>
 <CANqRtoQaSJN+DSv9Uj=Dxv6RutS4aYVY8AM9J=6LqUQjyo3STw@mail.gmail.com>
Message-ID: <521DF74E.6090902@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/08/13 07:13, Magnus Damm wrote:
> Hi again Sudeep,
> 
> On Thu, Aug 22, 2013 at 11:54 PM, Sudeep KarkadaNagesha
> <Sudeep.KarkadaNagesha@arm.com> wrote:
>> On 07/08/13 23:55, Magnus Damm wrote:
>>> From: Magnus Damm <damm@opensource.se>
>>>
>>> Add r8a73a4 SMP support using the shared APMU code. To enable
>>> SMP the r8a73a4 specific DTS needs to be updated to include
>>> CPU cores, and this is happening in a separate patch.
>>>
>>> Signed-off-by: Magnus Damm <damm@opensource.se>
>>> ---
>>>
>>>  arch/arm/mach-shmobile/Makefile               |    1
>>>  arch/arm/mach-shmobile/include/mach/r8a73a4.h |    1
>>>  arch/arm/mach-shmobile/setup-r8a73a4.c        |    3 +
>>>  arch/arm/mach-shmobile/smp-r8a73a4.c          |   75 +++++++++++++++++++++++++
>>>  4 files changed, 80 insertions(+)
>>>
>>> --- 0001/arch/arm/mach-shmobile/Makefile
>>> +++ work/arch/arm/mach-shmobile/Makefile      2013-08-07 20:07:31.000000000 +0900
>>> @@ -33,6 +33,7 @@ endif
>>>  # SMP objects
>>>  smp-y                                := platsmp.o headsmp.o
>>>  smp-$(CONFIG_ARCH_SH73A0)    += smp-sh73a0.o headsmp-scu.o platsmp-scu.o
>>> +smp-$(CONFIG_ARCH_R8A73A4)   += smp-r8a73a4.o platsmp-apmu.o
>> platsmp-apmu.c is introducing new bindings which IMO is not required.
> 
> I guess we will have to discuss a bit more how to support the APMU
> hardware. Regarding using DT or static configuration, I believe
> starting out with static and incrementally adding DT binding support
> is the easiest way forward.
> 
As I mentioned in the other email, you need use APMU as part of MCPM
platform ops. You still need APMU DT node and all the necessary
functions to access it. I said only 'cpus' property in DT node is
unnecessary and the way its used.

>> I have responded to that patch, but it would be nice to combine that
>> patch in a single series for easier review for at least one platform
>> using it.
> 
> Good idea. I will resend a the next version as a single series to make
> future review easier.
> 
Good.

[...]
>>> +}
>>> +
>>> +struct smp_operations r8a73a4_smp_ops __initdata = {
>>> +     .smp_prepare_cpus       = r8a73a4_smp_prepare_cpus,
>>> +     .smp_boot_secondary     = shmobile_smp_apmu_boot_secondary,
>>> +#ifdef CONFIG_HOTPLUG_CPU
>>> +     .cpu_disable            = shmobile_smp_cpu_disable,
>>> +     .cpu_die                = shmobile_smp_apmu_cpu_die,
>>> +     .cpu_kill               = shmobile_smp_apmu_cpu_kill,
>>> +#endif
>>> +};
>> If you are running Linux in secure mode, you can reuse mcpm_smp_ops and
>> define these as part of mcpm_platform_ops
> 
> Thanks for pointing that out, but we're not running in secure more.
> 
Again I am not sure if you want to avoid supporting PSCI. I understand
it needs secure firmware but that's unavoidable if any of the CPU PM
functionality on that hardware is accessible only in secure mode and you
are running Linux in non-secure mode.

Regards,
Sudeep
