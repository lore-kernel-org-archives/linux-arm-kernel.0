From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Wed, 16 Dec 2015 14:51:09 +0900
Subject: [PATCH v12 16/16] arm64: kdump: relax BUG_ON() if more than one
 cpus are still active
In-Reply-To: <20151215170523.GA353@arm.com>
References: <cover.1448403503.git.geoff@infradead.org>
 <83db66df70fc1f7cd4da8b580d264b9320991cf0.1448403503.git.geoff@infradead.org>
 <20151215170523.GA353@arm.com>
Message-ID: <5670FBCD.2030600@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/16/2015 02:05 AM, Will Deacon wrote:
> On Tue, Nov 24, 2015 at 10:25:34PM +0000, Geoff Levand wrote:
>> From: AKASHI Takahiro <takahiro.akashi@linaro.org>
>>
>> We should try best in case of kdump.
>> So even if not all secondary cpus have shut down, we do kdump anyway.
>> ---
>>   arch/arm64/kernel/machine_kexec.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
>> index d2d7e90..482aae7 100644
>> --- a/arch/arm64/kernel/machine_kexec.c
>> +++ b/arch/arm64/kernel/machine_kexec.c
>> @@ -148,7 +148,13 @@ void machine_kexec(struct kimage *kimage)
>>   	phys_addr_t reboot_code_buffer_phys;
>>   	void *reboot_code_buffer;
>>
>> -	BUG_ON(num_online_cpus() > 1);
>> +	if (num_online_cpus() > 1) {
>> +		if (in_crash_kexec)
>> +			pr_warn("kdump might fail because %d cpus are still online\n",
>> +					num_online_cpus());
>> +		else
>> +			BUG();
>> +	}
>
> Can you just rewrite the existing BUG_ON as:
>
>    BUG_ON(num_online_cpus() && !WARN_ON(in_crash_kexec));
>
> ?

Yes, but
      BUG_ON((num_online_cpus() > 1) && !WARN_ON(in_crash_kexec));

Thanks,
-Takahiro AKASHI

> Will
>
