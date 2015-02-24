From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 24 Feb 2015 16:09:06 +0100
Subject: [PATCH] ARM: mvebu: Disable CPU Idle on Armada 38x
In-Reply-To: <20150223201215.039fa38b@free-electrons.com>
References: <1423245844-28701-1-git-send-email-gregory.clement@free-electrons.com>
 <20150223201215.039fa38b@free-electrons.com>
Message-ID: <54EC9412.7020501@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 23/02/2015 20:12, Thomas Petazzoni wrote:
> Dear Gregory CLEMENT,
> 
> On Fri,  6 Feb 2015 19:04:04 +0100, Gregory CLEMENT wrote:
>> On Armada 38x SoCs, under heavy I/O load, the system hangs when CPU
>> Idle is enabled. Waiting for a solution to this issue, this patch
>> disables the CPU Idle support for this SoC.
>>
>> As CPU Hot plug support also uses some of the CPU Idle functions it is
>> also affected by the same issue. This patch disables it also for the
>> Armada 38x SoCs.
>>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> Cc: <stable@vger.kernel.org> # v3.17 +
>> ---
>>  arch/arm/mach-mvebu/pmsu.c | 14 ++++++++++++--
>>  1 file changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
>> index d8ab605a44fa..05c8625bbc40 100644
>> --- a/arch/arm/mach-mvebu/pmsu.c
>> +++ b/arch/arm/mach-mvebu/pmsu.c
>> @@ -476,12 +476,22 @@ static int __init mvebu_v7_cpu_pm_init(void)
>>  		return 0;
>>  	of_node_put(np);
>>  
>> +	/*
>> +	 * Currently the CPU Idle support for Armada 38x is broken, as
>> +	 * the CPU Hotplug uses some of the CPU Idle functions it is
>> +	 * broken too, so let's disable it
>> +	 */
>> +	if (of_machine_is_compatible("marvell,armada380")) {
>> +		cpu_hotplug_disable();
>> +		pr_warn("CPU Hotplug support is currently broken on Armada 38x: disabling");
>> +	}
> 
> There's one thing that annoys me with this part disabling CPU hotplug:
> it will prevent suspend to RAM, even though suspend to RAM is most

Actually cpu_hotplug_disable() only disables the "regular" cpu hotlplog operation.
This function set the value of cpu_hotplug_disabled variable which is tested only
in cpu_up and cpu_down whereas during suspend(and resume) _cpu_down(and _cpu_up)
are directly called.

However it raises an interesting point. The suspend/resume function modifies the
value of cpu_hotplug_disabled and resets it unconditionally during resume. So
when enabling suspend to RAM for Armada 38x, if the CPU idle issue is not solved,
we will have to call cpu_hotplug_disable() in the post resume path.

> likely safe with regard to the PCIe/PL310 deadlock problem. CPU hotplug
> support is needed for suspend to RAM, as secondary CPUs are all turned
> off towards the end of the suspend process, before really entering the
> suspend to RAM state.
> 
> And since this happens after calling the ->suspend() hook on all
> devices, we are normally in a quiet state in terms of PCIe traffic,
> which should normally avoid the PL310 issue.
> 
> So, we would have basically to discriminate between CPU hotplug done at
> "run time" and CPU hotplug done as part of the suspend to RAM and
> resume sequence. Maybe this cpu_hotplug_disable() still allows the form
> of CPU hotplug needed by suspend to RAM, but since would have to be
> verified.

As indicated below, cpu_hotplug_disable() won't prevent using suspend to RAM.
However as is, there was other part of this patch which will prevent it. In the
Armada 38x case, the function returns before calling the function
mvebu_v7_pmsu_enable_l2_powerdown_onidle() which should be needed for the suspend
to RAM. I also think that registering the mvebu_v7_cpu_pm_notifier would be needed
for the suspend to RAM.

However currently there is no support for suspend to RAM for Armada 38x in mainline,
and I would like to keep this patch simple to apply it on the stable version.

What about making the changes I listed in the suspend to RAM series for the Armada 38x?


Thanks,

Gregory



> 
> Best regards,
> 
> Thomas
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
