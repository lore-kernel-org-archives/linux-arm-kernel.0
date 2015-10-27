From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Tue, 27 Oct 2015 18:09:24 +0000
Subject: [PATCH v3 00/24] arm64: Consolidate CPU feature handling
In-Reply-To: <562C8D68.9040008@reserved-bit.com>
References: <1444756952-31145-1-git-send-email-suzuki.poulose@arm.com>
 <562C8D68.9040008@reserved-bit.com>
Message-ID: <562FBDD4.5030309@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/10/15 08:06, Siddhesh Poyarekar wrote:
> On Tuesday 13 October 2015 10:52 PM, Suzuki K. Poulose wrote:
>> Apart from the selected feature registers, we expose MIDR_EL1 (Main
>> ID Register). The user should be aware that, reading MIDR_EL1 can be
>> tricky on a heterogeneous system (just like getcpu()). We export the
>> value of the current CPU where 'MRS' is executed. REVIDR is not exposed
>> via MRS, since we cannot guarantee atomic access to both MIDR and REVIDR
>> (task migration). So they both are exposed via sysfs under :
>>
>> 	/sys/devices/system/cpu/cpu$ID/identification/
>> 							\- midr
>> 							\- revidr
>>
>> The ABI useful for the toolchains (e.g, gcc, dynamic linker, JIT) to make
>> better runtime decisions based on what is available.
>
> Thank you for doing this.  I'm prototyping glibc support to select
> optimal functions by micro-architecture and I had a couple of concerns.
>
> The midr emulation may not be sufficient for glibc to select optimal
> routines because there could theoretically be sufficient variance
> between cpus with only different revidr that vendors may write different
> optimal routines.

But then there is no way we can provide the midr/revidr pair reliably.
So I guess we can't do much about it.

>  Secondly, on a heterogeneous system, we won't be able
> to select a routine reliably using just the emulated instruction since
> we have no control where it runs and we would want to know what each of
> the cpus looks like.

On a heterogeneous system, we can't do much, as you will anyway need to know
which CPU you are running on to select the version, which itself is not
reliable (unless you are pinned to the CPU).

>
> The sysfs API solves this problem, but it doesn't seem like an optimal
> thing to do in an IFUNC resolver in glibc.  CPU information is scattered

I agree, the sysfs API is not suitable for low-level users like IFUNC, but
for tools like JIT to determine the CPUs present on the system.

>
> Would you be able to consolidate all cpu identification into a single
> file?  This would allow glibc to just map in the file and read in all of
> the information in one go, greatly reducing the number of syscalls.

I am afraid that would impose a new ABI with complications on how we
handle information about the CPUs in different states (online, offline,
etc). I am open to suggestions here.

>
> The other alternative I was thinking of was to have an additional hwcap
> HWCAP_HETEROGENEOUS_CPU which is set if there are different kinds of
> processor cores in the system, but that will force us to stick to
> default routines for heterogeneous cores.

See [1] for previous discussion on this topic.

[1] https://lkml.org/lkml/2015/9/1/391

Thanks
Suzuki
