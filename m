From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Thu, 7 Apr 2016 10:26:49 +0100
Subject: [PATCH 5/5] arm64: Fix behavior of maxcpus=N
In-Reply-To: <570625FE.4040001@arm.com>
References: <1459941854-5190-1-git-send-email-suzuki.poulose@arm.com>
 <1459941854-5190-6-git-send-email-suzuki.poulose@arm.com>
 <570625FE.4040001@arm.com>
Message-ID: <570627D9.6080805@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/04/16 10:18, James Morse wrote:
> Hi Suzuki,
>
> On 06/04/16 12:24, Suzuki K Poulose wrote:
>> maxcpu=n sets the number of CPUs activated at boot time to a max of n,
>> but allowing the remaining CPUs to be brought up later if the user
>> decides to do so. However, on arm64 due to various reasons, we disallowed
>> hotplugging CPUs beyond n, by marking them not present. Now that
>> we have checks in place to make sure the hotplugged CPUs have compatible
>> features with system and requires no new errata, relax the restriction.
>
>> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
>> index b2d5f4e..0988ccc 100644
>> --- a/arch/arm64/kernel/smp.c
>> +++ b/arch/arm64/kernel/smp.c
>> @@ -659,21 +659,12 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
>>   	if (max_cpus > ncores)
>>   		max_cpus = ncores;
>
> This "if (max_cpus > ncores)" is the only user of max_cpus left in this
> function, and 'ncores' isn't used for anything else. Dead code?

Yes, it is. We already do for_each_possible_cpu() and ncores was set to num_possible_cpus().
So, the ncores was kind of superfluous to begin with. Thanks for pointing it
out, I will remove it.

Cheers
Suzuki
