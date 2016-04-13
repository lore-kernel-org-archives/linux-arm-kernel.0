From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Wed, 13 Apr 2016 12:16:26 +0100
Subject: [PATCH 2/2] arm64: vhe: Verify CPU Exception Levels
In-Reply-To: <20160413111424.GA17696@cbox>
References: <1460472361-28419-1-git-send-email-suzuki.poulose@arm.com>
 <1460472361-28419-2-git-send-email-suzuki.poulose@arm.com>
 <20160413111424.GA17696@cbox>
Message-ID: <570E2A8A.5050504@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/04/16 12:14, Christoffer Dall wrote:
> On Tue, Apr 12, 2016 at 03:46:01PM +0100, Suzuki K Poulose wrote:
>> With a VHE capable CPU, kernel can run at EL2 and is a decided at early
>> boot. If some of the CPUs didn't start it EL2 or doesn't have VHE, we
>> could have CPUs running at different exception levels, all in the same
>> kernel! This patch adds an early check for the secondary CPUs to detect
>> such situations.
>>
>> For each non-boot CPU add a sanity check to make sure we don't have
>> different run levels w.r.t the boot CPU. We save the information on
>> whether the boot CPU is running in hyp mode or not and ensure the
>> remaining CPUs match it.
>>
>> Applies on 4.6-rc3.

>> +#ifdef CONFIG_ARM64_VHE
>> +
>> +extern bool boot_cpu_hyp_mode;
>> +static inline bool is_boot_cpu_in_hyp_mode(void)
>> +{
>> +	return boot_cpu_hyp_mode;
>> +}
>
> would it make sense to move this to smp.c to avoid exporting
> boot_cpu_hyp_mode?

Sure, we can.

>
> Note that boot_cpu_hyp_mode is never set without CONFIG_SMP, but that
> shouldn't matter I suppose.

Right. The check will be invoked only by the secondary CPUs. I will
respin it.

Cheers
Suzuki
