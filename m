From: kimran@codeaurora.org (Imran Khan)
Date: Thu, 6 Apr 2017 12:52:13 +0530
Subject: [PATCH] Revert "arm64: Increase the max granular size"
In-Reply-To: <10fef112-37f1-0a1b-b5af-435acd032f01@codeaurora.org>
References: <1458120743-12145-1-git-send-email-opensource.ganesh@gmail.com>
 <DA22064C-45A7-4F79-A433-84054AF182DF@caviumnetworks.com>
 <20160321171403.GE25466@e104818-lin.cambridge.arm.com>
 <CAPub14-sFgx=oCHzJPb9h9b_V0rbn5UAMDNJ-yTkjhz38JPqMQ@mail.gmail.com>
 <10fef112-37f1-0a1b-b5af-435acd032f01@codeaurora.org>
Message-ID: <4525901c-45d4-6bd8-eec6-ae92977f16d1@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/5/2017 10:13 AM, Imran Khan wrote:
Hi Catalin,

> Hi Catalin,
> 
>> From: Catalin Marinas <catalin.marinas@arm.com>
>> Date: Mon, Mar 21, 2016 at 10:44 PM
>> Subject: Re: [PATCH] Revert "arm64: Increase the max granular size"
>> To: "Chalamarla, Tirumalesh" <Tirumalesh.Chalamarla@caviumnetworks.com>
>> Cc: Ganesh Mahendran <opensource.ganesh@gmail.com>, "will.deacon at arm.com" <
>> will.deacon at arm.com>, "linux-arm-kernel at lists.infradead.org" <
>> linux-arm-kernel at lists.infradead.org>, "linux-kernel at vger.kernel.org" <
>>> , "stable at vger.kernel.org" <
>> stable at vger.kernel.org>
>>
>>
>> On Fri, Mar 18, 2016 at 09:05:37PM +0000, Chalamarla, Tirumalesh wrote:
>>> On 3/16/16, 2:32 AM, "linux-arm-kernel on behalf of Ganesh Mahendran" <
>> linux-arm-kernel-bounces at lists.infradead.org on behalf of
>> opensource.ganesh at gmail.com> wrote:
>>>> Reverts commit 97303480753e ("arm64: Increase the max granular size").
>>>>
>>>> The commit 97303480753e ("arm64: Increase the max granular size") will
>>>> degrade system performente in some cpus.
>>>>
>>>> We test wifi network throughput with iperf on Qualcomm msm8996 CPU:
>>>> ----------------
>>>> run on host:
>>>>  # iperf -s
>>>> run on device:
>>>>  # iperf -c <device-ip-addr> -t 100 -i 1
>>>> ----------------
>>>>
>>>> Test result:
>>>> ----------------
>>>> with commit 97303480753e ("arm64: Increase the max granular size"):
>>>>    172MBits/sec
>>>>
>>>> without commit 97303480753e ("arm64: Increase the max granular size"):
>>>>    230MBits/sec
>>>> ----------------
>>>>
>>>> Some module like slab/net will use the L1_CACHE_SHIFT, so if we do not
>>>> set the parameter correctly, it may affect the system performance.
>>>>
>>>> So revert the commit.
>>>
>>> Is there any explanation why is this so? May be there is an
>>> alternative to this, apart from reverting the commit.
>>
>> I agree we need an explanation but in the meantime, this patch has
>> caused a regression on certain systems.
>>
>>> Until now it seems L1_CACHE_SHIFT is the max of supported chips. But
>>> now we are making it 64byte, is there any reason why not 32.
>>
>> We may have to revisit this logic and consider L1_CACHE_BYTES the
>> _minimum_ of cache line sizes in arm64 systems supported by the kernel.
>> Do you have any benchmarks on Cavium boards that would show significant
>> degradation with 64-byte L1_CACHE_BYTES vs 128?
>>
>> For non-coherent DMA, the simplest is to make ARCH_DMA_MINALIGN the
>> _maximum_ of the supported systems:
>>
>> diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
>> index 5082b30bc2c0..4b5d7b27edaf 100644
>> --- a/arch/arm64/include/asm/cache.h
>> +++ b/arch/arm64/include/asm/cache.h
>> @@ -18,17 +18,17 @@
>>
>>  #include <asm/cachetype.h>
>>
>> -#define L1_CACHE_SHIFT         7
>> +#define L1_CACHE_SHIFT         6
>>  #define L1_CACHE_BYTES         (1 << L1_CACHE_SHIFT)
>>
>>  /*
>>   * Memory returned by kmalloc() may be used for DMA, so we must make
>> - * sure that all such allocations are cache aligned. Otherwise,
>> - * unrelated code may cause parts of the buffer to be read into the
>> - * cache before the transfer is done, causing old data to be seen by
>> - * the CPU.
>> + * sure that all such allocations are aligned to the maximum *known*
>> + * cache line size on ARMv8 systems. Otherwise, unrelated code may cause
>> + * parts of the buffer to be read into the cache before the transfer is
>> + * done, causing old data to be seen by the CPU.
>>   */
>> -#define ARCH_DMA_MINALIGN      L1_CACHE_BYTES
>> +#define ARCH_DMA_MINALIGN      (128)
>>
>>  #ifndef __ASSEMBLY__
>>
>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>> index 392c67eb9fa6..30bafca1aebf 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -976,9 +976,9 @@ void __init setup_cpu_features(void)
>>         if (!cwg)
>>                 pr_warn("No Cache Writeback Granule information, assuming
>> cache line size %d\n",
>>                         cls);
>> -       if (L1_CACHE_BYTES < cls)
>> -               pr_warn("L1_CACHE_BYTES smaller than the Cache Writeback
>> Granule (%d < %d)\n",
>> -                       L1_CACHE_BYTES, cls);
>> +       if (ARCH_DMA_MINALIGN < cls)
>> +               pr_warn("ARCH_DMA_MINALIGN smaller than the Cache Writeback
>> Granule (%d < %d)\n",
>> +                       ARCH_DMA_MINALIGN, cls);
>>  }
>>
>>  static bool __maybe_unused
>>
>>
>>
> 
> This change was discussed at: [1] but was not concluded as apparently no one
> came back with test report and numbers. After including this change in our 
> local kernel we are seeing significant throughput improvement. For example with:
> 
> iperf -c 192.168.1.181 -i 1 -w 128K -t 60
> 
> The average throughput is improving by about 30% (230Mbps from 180Mbps).
> Could you please let us know if this change can be included in upstream kernel.
> 
> [1]: https://groups.google.com/forum/#!topic/linux.kernel/P40yDB90ePs
> 

Could you please provide some feedback about the above mentioned query ?


> Thanks and Regards,
> Imran
> 
> 
> 
> 


-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a\nmember of the Code Aurora Forum, hosted by The Linux Foundation
