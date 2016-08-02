From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Tue, 2 Aug 2016 11:09:01 +0100
Subject: Can cores have different CPU features in a SMP system?
In-Reply-To: <CAP5Nno4CN18x_L-UQPm0Wp7hFSQAKtRobV94iBkcB9y4-UeRpg@mail.gmail.com>
References: <CAP5Nno430Jt3Ax2jUPP6ELpVBF-pK0Akxsa8sZ55f8GL7LQt=g@mail.gmail.com>
 <CAP5Nno4CN18x_L-UQPm0Wp7hFSQAKtRobV94iBkcB9y4-UeRpg@mail.gmail.com>
Message-ID: <b9577b33-0401-cf0f-bac2-f0315f520356@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/08/16 20:08, Jun Sun wrote:
> I looked at the kernel source code again.  Kernel currently only
> detects CPU features of CPU0 and use it for all other CPUs.   In other
> words, it is assuming all cores must have the same CPU features, which
> in a sense is a form of "enforcing".

On arm64 kernels, the CPU features are detected based on their availability
on all the CPUs. Hence, for e.g, if one cluster doesn't have crypto, kernel
doesn't expose the ELF AUX_HWCAP  crypto bits to the application (which should be
consulted by the application before doing a CPU Feature specific operation).

>
> As a result, it is definitely no-no to have cores with different CPU
> features, which is what I suspected.  Case closed. :)

It is not recommended to have cores with different CPU features, but as
mentioned above, arm64 kernel can cope up with the situation and disallow
any features that aren't available across all the CPUs.
See arch/arm64/kernel/cpufeature.c for more information.

Cheers
Suzuki



>
> Jun
>
> On Fri, Jul 29, 2016 at 2:30 PM, Jun Sun <jsun@junsun.net> wrote:
>> One specific example is that if a phone has two clusters.  Cores in
>> one cluster has v8 crypto extension and cores in the other don't.
>> Will this work?
>>
>> My gut feeling is no, since many apps query cpu features at run-time.
>> And process can migrate among cores.  If an app starts on a core with
>> CE and migrates to another core without CE.  Illegal instruction fault
>> will happen.
>>
>> Just wanna confirm if this is indeed the case.  Surprisingly google
>> search did not yield any meaningful answers.
>>
>> Cheers.
>>
>> Jun
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
