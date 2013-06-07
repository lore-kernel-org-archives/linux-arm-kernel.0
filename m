From: robherring2@gmail.com (Rob Herring)
Date: Fri, 07 Jun 2013 09:20:20 -0500
Subject: [PATCH] arm/dt: Don't add disabled CPUs to system topology
In-Reply-To: <20130607102326.GA3111@e102568-lin.cambridge.arm.com>
References: <1370538685-22386-1-git-send-email-james.king@linaro.org>
 <20130607102326.GA3111@e102568-lin.cambridge.arm.com>
Message-ID: <51B1EC24.3010909@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/07/2013 05:23 AM, Lorenzo Pieralisi wrote:
> Hi James,
> 
> On Thu, Jun 06, 2013 at 06:11:25PM +0100, James King wrote:
>> If CPUs are marked as disabled in the devicetree, make sure they do
>> not exist in the system CPU information and CPU topology information.
>> In this case these CPUs will not be able to be added to the system later
>> using hot-plug. This allows a single chip with many CPUs to be easily
>> used in a variety of hardware devices where they may have different
>> actual processing requirements (eg for thermal/cost reasons).
>>
>> - Change devicetree.c to ignore any cpu nodes marked as disabled,
>>   this effectively limits the number of active cpu cores so no need
>>   for the max_cpus=x in the chosen node.
>> - Change topology.c to ignore any cpu nodes marked as disabled, this
>>   is where the scheduler would learn about big/LITTLE cores so this
>>   effectively keeps the scheduler in sync.
>>
> 
> I have two questions:
> 
> 1) Since with this approach the DT should change anyway if on different
>    hardware devices based on the same chip you want to allow booting a
>    different number of CPUs, why do not we remove the cpu nodes instead of
>    disabling them ? Put it another way: cpu nodes define a cpu as
>    possible (currently), we can simply remove the node if we do not want
>    that cpu to be seen by the kernel.
> 2) If we go for the "status" property, why do not we use it to set present
>    mask ? That way the cpu is possible but not present, you cannot
>    hotplug it in. It is a bit of a stretch, granted, the cpu _is_ present,
>    we just want to disable it, do not know how this is handled in x86
>    and other archs though.

The meaning of disabled for cpus in ePAPR is that the cpu is offline
(i.e. in a spinloop or wfi), not that the cpu is unavailable. This is a
bit of a departure and inconsistency from how status for devices are
used. That would imply that we should be setting status to disabled for
all secondary cores and that possibly the status value should get
updated to reflect the state of the cpu.

Rob

> I am just asking, since it is something I thought about while writing
> code that parses the DT cpu map, basically we do not have a way to
> "disable" a cpu in the DT and that's what you are doing, I just would like
> to understand the best way to put it into DT bindings.
> 
> Thanks,
> Lorenzo
> 
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss at lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
> 
