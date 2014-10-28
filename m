From: m.smarduch@samsung.com (Mario Smarduch)
Date: Tue, 28 Oct 2014 09:15:17 -0700
Subject: [PATCH v12 0/6] arm/KVM: dirty page logging support for ARMv7
 (3.17.0-rc1)
In-Reply-To: <20141028012431.GA28244@kernel>
References: <1414017251-5772-1-git-send-email-m.smarduch@samsung.com>
 <20141027232644.GA27081@kernel> <544EE32C.3060701@samsung.com>
 <20141028012431.GA28244@kernel>
Message-ID: <544FC115.6080904@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/27/2014 06:24 PM, Wanpeng Li wrote:
> On Mon, Oct 27, 2014 at 05:28:28PM -0700, Mario Smarduch wrote:
>> Hi Wanpeng,
>>
>> On 10/27/2014 04:26 PM, Wanpeng Li wrote:
>> [...]
>>>>
>>>> Testing:
>>>> - Generally live migration + checksumming of source/destination memory regions 
>>>>  is used validate correctness. 
>>>
>>> Could you tell me where to get the checksum you are using? In addition,
>>> checksum should be used at which point of live migration?
>>>
>>> Regards,
>>> Wanpeng Li 
>> qemu in https://github.com/mjsmar/arm-dirtylog-tests/tree/master/v7/test
>> is instrumented to save the guest ram on source and destination.
>>
>> On source it dumps ram to file (ramimage0) from ram VMHandler
>> save_live_complete, right after source has stopped iterating and
>> remaining memory (and other VM state) to transfer is within
>> downtime threshold (about 70-90mS).
>>
>> On destination guest ram is dumped to file qemu_loadvm_state() just
>> before the guest is started.
> 
> Do you mean the file on destination include the guest ram which right after 
> source has stopped iterating and remaining memory(and other VM state), however,
> the file on source just include the guest ram which right after source has 
> stopped iterating? 
Sorry I don't follow the question exactly but essentially what
happens is
a) on source you save guest ram to a file just after it completed
   iterating/migrating last dirty pages to target.
b) on target you save guest ram just before it's ready to resume
   the guest, and continue to resume the guest once you've saved
   the guest ram.

But keep in mind that guest ram at target is the sum of initial
pre-copy + delta of dirty pages migrated over several iterations
based on kernel dirty page logging. If dirty page logging is off,
checksums won't match.


> 
> In addition, how to get the checksum which you are using?

Yes so as I mentioned a file called (/root/ramimage0) is created
on both source/target - I run these tests upto 2GB of ram so they're
pretty large files. And then run 'sum -r' on source and target
and they need to match.

For ARMv8 I use a little bit different approach.

> 
> Regards,
> Wanpeng Li 
> 
>>
>> It works for 'machvirt' and 'VExpress' machine models, the start
>> addresses are hardcoded while walking ram_list searching for a matching
>> RAMBlock.
>>
>> Unless you have armv7 hardware I'm not sure how you can reproduce
>> it, it may be possible on Fast Models but I have not tried it, most
>> likely it would be extremely slow.
>>
>> - Mario
>>
>>
>>>
>>>> - qemu machvirt, VExpress - Exynos 5440, FastModels - lmbench + dirty guest
>>>>  memory cycling.
>>>> - ARMv8 Foundation Model/kvmtool - Due to slight overlap in 2nd stage handlers
>>>>  did a basic bringup using qemu.
>>>> - x86_64 qemu  default machine model, tested migration on HP Z620, tested 
>>>>  convergence for several dirty page rates
>>>>
>>>> See https://github.com/mjsmar/arm-dirtylog-tests
>>>>    - Dirtlogtest-setup.pdf for ARMv7
>>>>    - https://github.com/mjsmar/arm-dirtylog-tests/tree/master/v7 - README
>>>>
>> [...]
>>>>
>>>> -- 
>>>> 1.7.9.5
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe kvm" in
>>>> the body of a message to majordomo at vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
