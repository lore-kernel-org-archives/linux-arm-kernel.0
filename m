From: rvaswani@codeaurora.org (Rohit Vaswani)
Date: Tue, 13 May 2014 17:10:17 -0700
Subject: maxcpus behavior in arm64
In-Reply-To: <20140513210226.GB31201@arm.com>
References: <53726AC1.9030207@codeaurora.org> <20140513210226.GB31201@arm.com>
Message-ID: <5372B469.6020109@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/13/2014 2:02 PM, Catalin Marinas wrote:
> On Tue, May 13, 2014 at 07:56:01PM +0100, Rohit Vaswani wrote:
>> I notice that the maxcpus behavior is different in arm64 than from how
>> arm uses it.
>> in arm64/kernel/smp.c - in smp_prepare_cpus, maxcpus is used to limit
>> the cpu_present_mask.
>> However in arm/kernel/smp.c - maxcpus is not used as a decision maker to
>> set the cpu_preset_mask.
>>
>> Is this behavior expected and intentionally different in arm and arm64 ?
>> This also means that in arm64 (unlike arm)- maxcpus cannot be used to
>> boot a subset of total cpus with the
>> option of getting the secondary cores online at a later point from
>> userspace using hotplug.
>> It seems like maxcpus is being treated like nr_cpus in arm64 ?
> I don't think there is any particular reason, only that the code has
> been derived from arm long time ago and it probably inherited the
> original behaviour. In the meantime, arm got commit 7fa22bd5460 (ARM:
> 6993/1: platsmp: Allow secondary cpu hotplug with maxcpus=1).
>
> I'm happy to change the behaviour for arm64. Basically we still call
> cpu_prepare() for max_cpus but we initialise the present mask with
> init_cpu_present(cpu_possible_mask) as we don't have physical hotplug
> for the time being.
Thanks. Initializing the present mask with possible mask is good.
But, how would one call cpu_prepare on the other CPUS then ?
Currently cpu_prepare is called only from smp_prepare_cpus. I was going 
to suggest calling cpu_prepare for each possible CPU.
We could have the for_each_possible_cpu loop in smp_prepare_cpus not 
depend on max_cpus and call cpu_prepare for the possible cpus.
I didn't really understand the part of physical hotplug - we have 
config_hotplug enabled

Thanks,
Rohit Vaswani

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by The Linux Foundation
