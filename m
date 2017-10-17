From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Tue, 17 Oct 2017 17:20:32 +0100
Subject: [PATCH v8 5/8] arm64: Use of_cpu_node_to_id helper for CPU
 topology parsing
In-Reply-To: <20171017161140.GD19711@arm.com>
References: <20171010103303.32436-1-suzuki.poulose@arm.com>
 <20171010103303.32436-6-suzuki.poulose@arm.com>
 <20171017152422.fawwvx6e3nn4dsej@lakrids.cambridge.arm.com>
 <20171017161140.GD19711@arm.com>
Message-ID: <9ecc1b51-b729-836a-5dde-c8ca9b36de40@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/10/17 17:11, Will Deacon wrote:
> On Tue, Oct 17, 2017 at 04:24:23PM +0100, Mark Rutland wrote:
>> On Tue, Oct 10, 2017 at 11:33:00AM +0100, Suzuki K Poulose wrote:
>>> Make use of the new generic helper to convert an of_node of a CPU
>>> to the logical CPU id in parsing the topology.
>>>
>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>> Cc: Leo Yan <leo.yan@linaro.org>
>>> Cc: Will Deacon <will.deacon@arm.com>
>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>
>> This looks sane to me, but it will need an ack from Will or Catalin.
>>
>> FWIW:
>>
>> Acked-by: Mark Rutland <mark.rutland@arm.com>
>>
>> Thanks,
>> Mark.
>>
>>> ---
>>>   arch/arm64/kernel/topology.c | 16 ++++++----------
>>>   1 file changed, 6 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
>>> index 8d48b233e6ce..21868530018e 100644
>>> --- a/arch/arm64/kernel/topology.c
>>> +++ b/arch/arm64/kernel/topology.c
>>> @@ -37,18 +37,14 @@ static int __init get_cpu_for_node(struct device_node *node)
>>>   	if (!cpu_node)
>>>   		return -1;
>>>   
>>> -	for_each_possible_cpu(cpu) {
>>> -		if (of_get_cpu_node(cpu, NULL) == cpu_node) {
>>> -			topology_parse_cpu_capacity(cpu_node, cpu);
>>> -			of_node_put(cpu_node);
>>> -			return cpu;
>>> -		}
>>> -	}
>>> -
>>> -	pr_crit("Unable to find CPU node for %pOF\n", cpu_node);
>>> +	cpu = of_cpu_node_to_id(cpu_node);
>>> +	if (cpu >= 0)
>>> +		topology_parse_cpu_capacity(cpu_node, cpu);
>>> +	else
>>> +		pr_crit("Unable to find CPU node for %pOF\n", cpu_node);
>>>   
>>>   	of_node_put(cpu_node);
> 
> This of_node_put is confusing me. Since of_cpu_node_to_id appears to be
> balanced with its use of the node refcount, is this one intended to pair
> with the earlier call to of_parse_phandle?

Yes.

  If so, does that mainline is
> currently broken here because it doesn't drop the refcount twice for the
> matching node?

No. This of_node_put is for the failure case where we couldn't match a CPU.
In the success case, it is dropped just before we return the result within
the loop.

Cheers
Suzuki


  Or do we need to return with that held?
> 
> Will
> 
