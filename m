From: hukeping@huawei.com (Hu Keping)
Date: Wed, 5 Nov 2014 18:57:06 +0800
Subject: [RESEND PATCH] ARM: kexec: Fix validating CPU hotplug support
In-Reply-To: <20141104105525.GE4042@n2100.arm.linux.org.uk>
References: <1415094025-66180-1-git-send-email-hukeping@huawei.com>
 <20141104105525.GE4042@n2100.arm.linux.org.uk>
Message-ID: <545A0282.4070001@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2014/11/4 18:55, Russell King - ARM Linux ??:
> On Tue, Nov 04, 2014 at 05:40:25PM +0800, HuKeping wrote:
>> Commit 2103f6cba61a8b8bea3fc1b63661d830a2125e76 added a hotplug checking in
>> machine_kexec_prepare(), but it will lead a failure when loading the
>> crash-kernel in some cases.
>>
>> Kexec utility can load the crash kernel by two ways:
>> 1. kexec -l kernel-image
>> 2. kexec -p kernel-image
>>
>> In case #1, for rapid reboot, it's correct to do the hotplug checking things,
>> for it will shut down cpus in _cpu_down() later when command "kexec -e" be
>> sent, this routine needs the support of cpu hotplug.
>>
>> In case #2, for use on panic, it's unnecessary to do the same thing, the whole
>> routing has no business with cpu shutting down. Check for cpu hot plug will
>> lead a failure to load the kernel.
>
> So what happens to the other CPUs when you kexec into the new kernel,
> possibly overwriting the instructions which those CPUs are executing?
>

Actually, i do think there is something wrong in the panic-rountine:
when panic comes, we clear the cpu_online_bits of other CPUs and
keep them calling cpu_relax(). That's why I post that patch ,because
we do not really shut down the CPUs.

But as your mentioned , there is another problem:
what's in the pc register of each cpu is unknown after the MMU has been
shut down.

On X86, there is a halt() before the cpu_relax(), so do you think we
need a call wfi() before cpu_relax() to keep the other CPUs on
status-WFI on ARM?
