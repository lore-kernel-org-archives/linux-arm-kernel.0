From: m.smarduch@samsung.com (Mario Smarduch)
Date: Mon, 27 Oct 2014 17:28:28 -0700
Subject: [PATCH v12 0/6] arm/KVM: dirty page logging support for ARMv7
 (3.17.0-rc1)
In-Reply-To: <20141027232644.GA27081@kernel>
References: <1414017251-5772-1-git-send-email-m.smarduch@samsung.com>
 <20141027232644.GA27081@kernel>
Message-ID: <544EE32C.3060701@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wanpeng,

On 10/27/2014 04:26 PM, Wanpeng Li wrote:
[...]
>>
>> Testing:
>> - Generally live migration + checksumming of source/destination memory regions 
>>  is used validate correctness. 
> 
> Could you tell me where to get the checksum you are using? In addition,
> checksum should be used at which point of live migration?
> 
> Regards,
> Wanpeng Li 
qemu in https://github.com/mjsmar/arm-dirtylog-tests/tree/master/v7/test
is instrumented to save the guest ram on source and destination.

On source it dumps ram to file (ramimage0) from ram VMHandler
save_live_complete, right after source has stopped iterating and
remaining memory (and other VM state) to transfer is within
downtime threshold (about 70-90mS).

On destination guest ram is dumped to file qemu_loadvm_state() just
before the guest is started.

It works for 'machvirt' and 'VExpress' machine models, the start
addresses are hardcoded while walking ram_list searching for a matching
RAMBlock.

Unless you have armv7 hardware I'm not sure how you can reproduce
it, it may be possible on Fast Models but I have not tried it, most
likely it would be extremely slow.

- Mario


> 
>> - qemu machvirt, VExpress - Exynos 5440, FastModels - lmbench + dirty guest
>>  memory cycling.
>> - ARMv8 Foundation Model/kvmtool - Due to slight overlap in 2nd stage handlers
>>  did a basic bringup using qemu.
>> - x86_64 qemu  default machine model, tested migration on HP Z620, tested 
>>  convergence for several dirty page rates
>>
>> See https://github.com/mjsmar/arm-dirtylog-tests
>>    - Dirtlogtest-setup.pdf for ARMv7
>>    - https://github.com/mjsmar/arm-dirtylog-tests/tree/master/v7 - README
>>
[...]
>>
>> -- 
>> 1.7.9.5
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe kvm" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
