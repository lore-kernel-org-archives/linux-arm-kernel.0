From: hoan@os.amperecomputing.com (Hoan Tran)
Date: Wed, 21 Nov 2018 16:52:36 +0000
Subject: [PATCH v3] perf: xgene: Add CPU hotplug support
In-Reply-To: <20181121161704.GC24883@arm.com>
References: <1541619650-5953-1-git-send-email-hoan@os.amperecomputing.com>
 <20181121160814.u2vrkbtdxzsz5o4j@lakrids.cambridge.arm.com>
 <20181121161704.GC24883@arm.com>
Message-ID: <a8f7b18c-dc72-7fc6-2bbc-0c7eb6197044@os.amperecomputing.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks, Mark and Will !


Regards

Hoan

On 11/21/18 8:17 AM, Will Deacon wrote:
> On Wed, Nov 21, 2018 at 04:08:14PM +0000, Mark Rutland wrote:
>> On Wed, Nov 07, 2018 at 07:40:58PM +0000, Hoan Tran wrote:
>>> From: Hoan Tran <Hoan@os.amperecomputing.com>
>>>
>>> This patch adds CPU hotplug support where the PMU migrates the context to
>>> another online CPU when its CPU is offline.
>>>
>>> It fixes the below issue where the user does offline the CPU which is assigned
>>> to this PMU.
>>>
>>> Assuming, CPU0 is assigned for this PMU. When the user does offline CPU0
>>> 	[root@(none) ~]# echo 0 > /sys/devices/system/cpu/cpu0/online
>>> This PMU does not work anymore and shows the below error.
>>> 	[root@(none) ~]# perf stat -a -e l3c0/cycle-count/,l3c0/write/ sleep 1
>>> 	Error:
>>> 	The sys_perf_event_open() syscall returned with 19 (No such device) for event (l3c0/cycle-count/).
>>> 	/bin/dmesg may provide additional information.
>>> 	No CONFIG_PERF_EVENTS=y kernel support configured?
>>>
>>> With this patch, when CPU0 is offline, PMU migrates to another online CPU and
>>> works on that CPU.
>>>
>>> Signed-off-by: Hoan Tran <hoan.tran@amperecomputing.com>
>>> ---
>>> v3:
>>>   * Remove email footer
>>>   * Fix the space issue
>>>
>>> v2:
>>>   * Remove the cpuhp instance when unregistering the PMU
>> Aside from one minor fixup below, this looks good to me, and with that
>> applied:
>>
>> Acked-by: Mark Rutland <mark.rutland@arm.com>
>>
>> Will, are you happy to apply that fixup when picking the patch?
> Thanks, Mark. I'll queue this up and fix the naming of the enum entry.
>
> Will
