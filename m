From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 26 Jun 2014 14:45:06 +0100
Subject: [PATCH] arm64: do not force irq affinity setting
In-Reply-To: <20140626102055.GD376@arm.com>
References: <1403765395-16978-1-git-send-email-pgaikwad@nvidia.com>
 <20140626102055.GD376@arm.com>
Message-ID: <53AC23E2.6070306@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 26/06/14 11:20, Will Deacon wrote:
> Hello,
>
> On Thu, Jun 26, 2014 at 07:49:55AM +0100, Prashant Gaikwad wrote:
>> Unconditional copying cpu_online_mask to affinity
>> may result in migrating affinity to wrong CPU.
>
> We have a bug, but I don't follow your reasoning.
>
>> For example, IRQ 5 affinity mask contains CPU 4-7,
>
> Ok, so d->affinity is 0xf0...
>
>> it was affined to CPU4 and CPU 0-7 are online.
>
> ...and cpu_online_mask is 0xff.
>
>> Now if we hot-unplug CPU4 then with current
>> implementation affinity mask will contain
>> CPU 0-3,5-7 and IRQ 5 will be affined to CPU0.
>
> cpumask_any_and(affinity, cpu_online_mask) will give return < nr_cpu_ids
> since there is an intersection of 0xf0. That means ret is false.
>
> The bug is that we then do affinity = cpu_online_mask; unconditionally,
> but we *won't* do the cpumask_copy, since ret is false.
>
> You can fix this by simply bringing the arm64 code into line with the arm
> code, which begs the question as to why this has to exist in the arch/
> backend at all!
>

The unconditional assignment was added by me to fix CPU0 hotplug issue explained 
in commit 601c942176d8 which is wrong and evident from the above
usecase. It was added to retain the forced irq_set_affinity. The difference 
between arm and arm64 is because the arm doesn't have the patch [1]

We can move to irq_set_affinity without force option as this patch does.
I had mentioned similar solution[2], but Russell wants to get feedback from
tglx[3]

And yes I see similar implementations for many architectures, definitely
can be unified.

Regards,
Sudeep

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-May/254838.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-May/259255.html
[3] http://www.spinics.net/lists/arm-kernel/msg340279.html
