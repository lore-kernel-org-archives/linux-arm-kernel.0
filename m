From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 14 Mar 2017 13:55:22 +0000
Subject: [PATCH v3 00/25] arm/arm64: KVM: Rework the hyp-stub API
In-Reply-To: <8493dac7-c9be-fd3b-c5c0-83fbbfa4af10@ti.com>
References: <20170306142458.8875-1-marc.zyngier@arm.com>
 <8493dac7-c9be-fd3b-c5c0-83fbbfa4af10@ti.com>
Message-ID: <8d2cf6fa-cac7-268b-bc26-2649f5696196@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 14/03/17 13:38, Keerthy wrote:
> 
> 
> On Monday 06 March 2017 07:54 PM, Marc Zyngier wrote:
>> As noticed by RMK in this thread[1], the hyp-stub API on 32bit ARM
>> could do with some TLC (it cannot perform a soft-restart at HYP, and
>> has holes in the hyp-stub support in a number of places). In general,
>> it would be desirable for the 32bit behaviour to align on 64bit, if
>> only to ease maintenance.
>>
>> This series implements the following:
>> - Add HVC_[GS]ET_VECTORS and HVC_SOFT_RESTART to the 32bit code
>> - Add HVC_RESET_VECTORS to both arm and arm64, removing the need for
>>   __hyp_reset_vectors
>> - Implement add the stub entry points in the KVM init code, which
>>   didn't implement any so far
>> - Convert the HYP code to use the init code stubs directly
>> - Some general cleanup as a result of these changes (which includes
>>   killing HVC_GET_VECTORS)
>> - Add some API documentation that covers the above
>>
>> Patches 9 to 11 would be better squashed into 7 and 8, but I've kept
>> separate so that I can take the blame for everything I've broken.
> 
> Tested for kexec booting with the patch series applied on linux-next.
> 
> kexec is working nicely with HYP and SVC modes. Tested for both modes by
> using different u-boot for booting in HYP and SVC modes. Kexec works well.
> 
> Tested on DRA7-EVM, AM57XX-EVM and KEYSTONE-K2E-EVM.
> 
> Tested-by: Keerthy <j-keerthy@ti.com>

Thanks a lot. I assume this Tested-by applies to the 32bit patches in
this series?

Cheers,

	M.
-- 
Jazz is not dead. It just smells funny...
