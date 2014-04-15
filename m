From: dingtianhong@huawei.com (Ding Tianhong)
Date: Tue, 15 Apr 2014 18:20:00 +0800
Subject: [PATCH] arm64: Flush the process's mm context TLB entries when
 switching
In-Reply-To: <20140415080217.GD17408@arm.com>
References: <534BCE80.3090406@huawei.com> <20140414130154.GE3530@arm.com>
 <534C92B8.30408@huawei.com> <20140415080217.GD17408@arm.com>
Message-ID: <534D07D0.1090807@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014/4/15 16:02, Will Deacon wrote:
> On Tue, Apr 15, 2014 at 03:00:24AM +0100, Ding Tianhong wrote:
>> On 2014/4/14 21:01, Will Deacon wrote:
>>> Hi Ding,
>>>
>>> On Mon, Apr 14, 2014 at 01:03:12PM +0100, Ding Tianhong wrote:
>>>> I met a problem when migrating process by following steps:
>>>>
>>>> 1) The process was already running on core 0.
>>>> 2) Set the CPU affinity of the process to 0x02 and move it to core 1,
>>>>    it could work well.
>>>> 3) Set the CPU affinity of the process to 0x01 and move it to core 0 again,
>>>>    the problem occurs and the process was killed.
>>>
>>> [...]
>>>
>>>> It was a very strange problem that the PC and LR are both 0, and the esr is
>>>> 0x83000006, it means that the used for instruction access generated MMU faults
>>>> and synchronous external aborts, including synchronous parity errors.
>>>>
>>>> I try to fix the problem by invalidating the process's TLB entries when switching,
>>>> it will make the context stale and pick new one, and then it could work well.
>>>>
>>>> So I think in some situation that after the process switching, the modification of
>>>> the TLB entries in the new core didn't inform all other cores to invalidate the old
>>>> TLB entries which was in the inner shareable caches, and then if the process schedule
>>>> to another core, the old TLB entries may occur MMU faults.
>>>
>>> Yes, it sounds like you don't have your TLBs configured correctly. Can you
>>> confirm that your EL3 firmware is configuring TLB broadcasting correctly
>>> please?
>>>
>>
>> Hi will:
>>
>> Do you mean the SCR_EL3.NS?
> 
> No, there's usually a CPU-specific register (called something like actlr or
> ectlr) which contains bit(s) to enable TLB broadcasting in hardware. Which
> CPU are you using?
> 
> Will
> 
Yes?I set the CPUECTLR.SMP to 1 and enable the core to receive TLB broadcast, then fix the problem,
thanks for your help, And I use arm64-A57.

Regards
Ding
> .
> 
