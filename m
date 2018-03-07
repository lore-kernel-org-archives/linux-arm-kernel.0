From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Wed, 7 Mar 2018 14:59:34 +0000
Subject: [PATCH v11 8/8] perf: ARM DynamIQ Shared Unit PMU support
In-Reply-To: <5A9DC03B.8020201@codeaurora.org>
References: <20180102112533.13640-1-suzuki.poulose@arm.com>
 <20180102112533.13640-9-suzuki.poulose@arm.com>
 <5A90B77E.8040105@codeaurora.org> <20180225143653.peb4quk3ha5h3t5x@salmiak>
 <5A972A7D.9020301@codeaurora.org>
 <20180301114911.fundyuqxtj5klk4e@lakrids.cambridge.arm.com>
 <5A986425.9080007@codeaurora.org>
 <20180302104223.7tpsyhsum7nej237@lakrids.cambridge.arm.com>
 <5A99A3DC.9020400@codeaurora.org>
 <20180305105925.4cjiqejfid7rswe6@lakrids.cambridge.arm.com>
 <5A9DC03B.8020201@codeaurora.org>
Message-ID: <f340190f-8286-bd3c-c743-79a3d48cc33d@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Hi Saravana,

Sorry for the late response, I was out on vacation.

On 05/03/18 22:10, Saravana Kannan wrote:
> On 03/05/2018 02:59 AM, Mark Rutland wrote:
>> On Fri, Mar 02, 2018 at 11:19:56AM -0800, Saravana Kannan wrote:
>>> On 03/02/2018 02:42 AM, Mark Rutland wrote:
>>>> It's important to note that the DSU PMU's event_init() ensures events
>>>> are affine to a single CPU, and the perf core code serializes operations
>>>> on those events via the context lock.
>>>
>>> Ah, I see that now. Thanks!
>>>
>>>> Therefore, two CPUs *won't* try to access the registers simultaneously.
>>>
>>> Right, and this driver seems to be going through a lot of work to make sure
>>> all events are read in one CPU.
>>>
>>> Do you even have an upstream target where there are multiple DSU's in a
>>> system?
>>
>> I have no idea, though I do beleive that it's possible for a system to
>> have multiple DSUs.
>>
>>> If not, we can simplify a ton of this code (no hotplug notifiers, no
>>> migrating PMUs, no SMP calls, etc) by just adding a spinlock and letting any
>>> CPU read these DSU counters.
>>
>> Regardless of whether we allow arbitrary CPUs to read the counters,
>> other logic still needs to be CPU affine, and we'll still need hotplug
>> notifiers and event migration.
> 
> If you have to support multiple DSUs in a system, then the need is obvious. But if you don't have to support multiple DSU, it's not obvious to me on why you still need CPU affining or hotplug notifiers. Could you please provide me pointers for general understanding?
> 

We need to support multiple DSUs as such configurations are possible.

> 
>> I am not necessarily opposed to allowing read() calls from associated
>> CPUs, but as before, I'll leave that to Suzuki.

I am fine with reading the registers from any of the associated CPUs.

> 
> Can you make sure this thread is on Suzuki's radar?
> 
> Suzuki,
> 
> Could please respond? IPI for DSUs are definitely a pain for us.

Thanks
Suzuki
