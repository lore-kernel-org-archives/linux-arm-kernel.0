From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 26 Jun 2018 10:23:33 +0100
Subject: [PATCH v2 0/7] arm64: numa/topology/smp: update the cpumasks for
 CPU hotplug
In-Reply-To: <d6812552-f27c-83d8-900d-5849e5c6d141@huawei.com>
References: <1529327923-17911-1-git-send-email-sudeep.holla@arm.com>
 <d6812552-f27c-83d8-900d-5849e5c6d141@huawei.com>
Message-ID: <b40f9a03-e416-f4e6-707b-257f4d29d893@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 26/06/18 07:50, Hanjun Guo wrote:
> Hi Sudeep,
> 
> On 2018/6/18 21:18, Sudeep Holla wrote:
>> Hi,
>>
>> Commit 37c3ec2d810f ("arm64: topology: divorce MC scheduling domain from core_siblings")
>> was reported to cause some hotplug and system suspend regressions when
>> it was merged. On investigation, it was found that unlike x86/PPC,
>> arm64 doesn't update the cpu and numa masks on CPU hotplug. That's
>> somewhat expected from the scheduler.
>>
>> Since these changes were bit invasive as a solution to the above
>> mentioned regression, as small change was temporarily applied as a fix.
>> This series updates the cpu and numa masks on CPU hotplug and reverts
>> that temporary fix.
>>
>> It would be good to get this tested(CPU hotplug - few and all CPUs in
>> a socket) on multi-socket/NUMA systems from Cavium and Huawei/Hisilicon.
> 
> Sorry for the late response, tons of other work just distracted me.
> 
> I tested this patch set on top of 4.18-rc2, CPU hotplug (online/offline)
> works, but the "Core(s) per socket:" of lscpu is not right, for example,
> the system with 4 NUMA nodes and 4 sockets, each socket has 16 CPU cores,
> from the beginning, everything looks correct:
> 
> localhost:~ # lscpu
> Architecture:          aarch64
> Byte Order:            Little Endian
> CPU(s):                64
> On-line CPU(s) list:   0-63
> Thread(s) per core:    1
> Core(s) per socket:    16    // 16 is the right value, and should be unchanged when CPU hotpluging
> Socket(s):             4
> NUMA node(s):          4
> L1d cache:             32K
> L1i cache:             48K
> L2 cache:              1024K
> L3 cache:              16384K
> NUMA node0 CPU(s):     0-15
> NUMA node1 CPU(s):     16-31
> NUMA node2 CPU(s):     32-47
> NUMA node3 CPU(s):     48-63
> 
> But when I offlined one CPU:
> localhost:/sys/devices/system/cpu # echo 0 > cpu22/online
> localhost:/sys/devices/system/cpu # lscpu
> Architecture:          aarch64
> Byte Order:            Little Endian
> CPU(s):                64
> On-line CPU(s) list:   0-21,23-63
> Off-line CPU(s) list:  22
> Thread(s) per core:    1
> Core(s) per socket:    15      //it's 15 now...

I know exactly what's the problem. And I think that's exactly the
behavior on my x86 box too. Further you might see another issue
as most of these applications like lstopo and lscpu parse only CPU0
sysfs, things fall apart if CPU0 is hotplugged out which is not allowed
on most of x86 boxes I have tried.

So, for me, that's issue with the application TBH.

[..]

> Offlined 16 cores on NUMA node 0, everything backs to normal:

Expected :)

> but when onlined CPU15 after,
> Architecture:          aarch64
> Byte Order:            Little Endian
> CPU(s):                64
> On-line CPU(s) list:   15-63
> Off-line CPU(s) list:  0-14
> Thread(s) per core:    1
> Core(s) per socket:    12     // it's 12, hmm...

I had to looks at the lscpu code and I think that explains why you can
get 12 here. We have
	add_summary_n(tb, _("Core(s) per socket:"),
		cores_per_socket ?: desc->ncores / desc->nsockets);

Now cores_per_socket because we don't have procfs entry, so ncores=49
and nsockets=4, which means you get 12. TBH lscpu should be used only
when all CPUs are online. Lots of inaccurate assumptions in it.

> 
> I think maybe the cpumask for the socket is changed in a
> wrong way when online/offline CPUs, didn't take a deep look into
> that, hope the test helps.
> 

I am not convinced if there's any issue unless you see discrepancy in
sysfs entries themselves and not though applications interpreting the
values for you based on some wrong assumptions.

-- 
Regards,
Sudeep
