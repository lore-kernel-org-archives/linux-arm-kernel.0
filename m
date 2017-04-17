From: kimran@codeaurora.org (Imran Khan)
Date: Mon, 17 Apr 2017 13:05:09 +0530
Subject: [PATCH] Revert "arm64: Increase the max granular size"
In-Reply-To: <725F073F-025B-48B9-9935-24EFEBF2B7DC@caviumnetworks.com>
References: <1458120743-12145-1-git-send-email-opensource.ganesh@gmail.com>
 <DA22064C-45A7-4F79-A433-84054AF182DF@caviumnetworks.com>
 <20160321171403.GE25466@e104818-lin.cambridge.arm.com>
 <CAPub14-sFgx=oCHzJPb9h9b_V0rbn5UAMDNJ-yTkjhz38JPqMQ@mail.gmail.com>
 <10fef112-37f1-0a1b-b5af-435acd032f01@codeaurora.org>
 <4525901c-45d4-6bd8-eec6-ae92977f16d1@codeaurora.org>
 <20170406155825.GA7705@e104818-lin.cambridge.arm.com>
 <CADAEsF_Hr=mPspvuPsQtKWiSDu6oCjfyy0rGwWrF9EJo-ZO1JA@mail.gmail.com>
 <08fa98de-760b-15bc-5220-fa449b08c118@codeaurora.org>
 <725F073F-025B-48B9-9935-24EFEBF2B7DC@caviumnetworks.com>
Message-ID: <93d2819a-95b1-6606-74d4-0bc0a64db29e@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/12/2017 7:30 PM, Chalamarla, Tirumalesh wrote:
> 
> 
> On 4/11/17, 10:13 PM, "linux-arm-kernel on behalf of Imran Khan" <linux-arm-kernel-bounces at lists.infradead.org on behalf of kimran@codeaurora.org> wrote:
> 
>     On 4/7/2017 7:36 AM, Ganesh Mahendran wrote:
>     > 2017-04-06 23:58 GMT+08:00 Catalin Marinas <catalin.marinas@arm.com>:
>     >> On Thu, Apr 06, 2017 at 12:52:13PM +0530, Imran Khan wrote:
>     >>> On 4/5/2017 10:13 AM, Imran Khan wrote:
>     >>>>> We may have to revisit this logic and consider L1_CACHE_BYTES the
>     >>>>> _minimum_ of cache line sizes in arm64 systems supported by the kernel.
>     >>>>> Do you have any benchmarks on Cavium boards that would show significant
>     >>>>> degradation with 64-byte L1_CACHE_BYTES vs 128?
>     >>>>>
>     >>>>> For non-coherent DMA, the simplest is to make ARCH_DMA_MINALIGN the
>     >>>>> _maximum_ of the supported systems:
>     >>>>>
>     >>>>> diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
>     >>>>> index 5082b30bc2c0..4b5d7b27edaf 100644
>     >>>>> --- a/arch/arm64/include/asm/cache.h
>     >>>>> +++ b/arch/arm64/include/asm/cache.h
>     >>>>> @@ -18,17 +18,17 @@
>     >>>>>
>     >>>>>  #include <asm/cachetype.h>
>     >>>>>
>     >>>>> -#define L1_CACHE_SHIFT         7
>     >>>>> +#define L1_CACHE_SHIFT         6
>     >>>>>  #define L1_CACHE_BYTES         (1 << L1_CACHE_SHIFT)
>     >>>>>
>     >>>>>  /*
>     >>>>>   * Memory returned by kmalloc() may be used for DMA, so we must make
>     >>>>> - * sure that all such allocations are cache aligned. Otherwise,
>     >>>>> - * unrelated code may cause parts of the buffer to be read into the
>     >>>>> - * cache before the transfer is done, causing old data to be seen by
>     >>>>> - * the CPU.
>     >>>>> + * sure that all such allocations are aligned to the maximum *known*
>     >>>>> + * cache line size on ARMv8 systems. Otherwise, unrelated code may cause
>     >>>>> + * parts of the buffer to be read into the cache before the transfer is
>     >>>>> + * done, causing old data to be seen by the CPU.
>     >>>>>   */
>     >>>>> -#define ARCH_DMA_MINALIGN      L1_CACHE_BYTES
>     >>>>> +#define ARCH_DMA_MINALIGN      (128)
>     >>>>>
>     >>>>>  #ifndef __ASSEMBLY__
>     >>>>>
>     >>>>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>     >>>>> index 392c67eb9fa6..30bafca1aebf 100644
>     >>>>> --- a/arch/arm64/kernel/cpufeature.c
>     >>>>> +++ b/arch/arm64/kernel/cpufeature.c
>     >>>>> @@ -976,9 +976,9 @@ void __init setup_cpu_features(void)
>     >>>>>         if (!cwg)
>     >>>>>                 pr_warn("No Cache Writeback Granule information, assuming
>     >>>>> cache line size %d\n",
>     >>>>>                         cls);
>     >>>>> -       if (L1_CACHE_BYTES < cls)
>     >>>>> -               pr_warn("L1_CACHE_BYTES smaller than the Cache Writeback Granule (%d < %d)\n",
>     >>>>> -                       L1_CACHE_BYTES, cls);
>     >>>>> +       if (ARCH_DMA_MINALIGN < cls)
>     >>>>> +               pr_warn("ARCH_DMA_MINALIGN smaller than the Cache Writeback Granule (%d < %d)\n",
>     >>>>> +                       ARCH_DMA_MINALIGN, cls);
>     >>>>>  }
>     >>>>>
>     >>>>>  static bool __maybe_unused
>     >>>>
>     >>>> This change was discussed at: [1] but was not concluded as apparently no one
>     >>>> came back with test report and numbers. After including this change in our
>     >>>> local kernel we are seeing significant throughput improvement. For example with:
>     >>>>
>     >>>> iperf -c 192.168.1.181 -i 1 -w 128K -t 60
>     >>>>
>     >>>> The average throughput is improving by about 30% (230Mbps from 180Mbps).
>     >>>> Could you please let us know if this change can be included in upstream kernel.
>     >>>>
>     >>>> [1]: https://groups.google.com/forum/#!topic/linux.kernel/P40yDB90ePs
>     >>>
>     >>> Could you please provide some feedback about the above mentioned query ?
>     >>
>     >> Do you have an explanation on the performance variation when
>     >> L1_CACHE_BYTES is changed? We'd need to understand how the network stack
>     >> is affected by L1_CACHE_BYTES, in which context it uses it (is it for
>     >> non-coherent DMA?).
>     > 
>     > network stack use SKB_DATA_ALIGN to align.
>     > ---
>     > #define SKB_DATA_ALIGN(X) (((X) + (SMP_CACHE_BYTES - 1)) & \
>     > ~(SMP_CACHE_BYTES - 1))
>     > 
>     > #define SMP_CACHE_BYTES L1_CACHE_BYTES
>     > ---
>     > I think this is the reason of performance regression.
>     > 
>     
>     Yes this is the reason for performance regression. Due to increases L1 cache alignment the 
>     object is coming from next kmalloc slab and skb->truesize is changing from 2304 bytes to 
>     4352 bytes. This in turn increases sk_wmem_alloc which causes queuing of less send buffers.
>     
> We tried different benchmarks and found none which really affects with Cache line change. If there is no correctness issue,
> I think we are fine with reverting the patch.
> 
So, can we revert the patch that makes L1_CACHE_SHIFT 7 or should the patch suggested by Catalin should be mainlined.
We have verified the throughput degradation on 3.18 and 4.4 but I am afraid that this issue will be seen on other
kernels too.
> Though I still think it is beneficiary to do some more investigation for the perf loss, who knows 32 bit align or no align might 
> Give even more perf benefit. 
> 
Which perf loss you are referring to here. Did you mean throughput loss here or some other perf benchmarking ?

Thanks,
Imran

> 
> Thanks,
> Tirumalesh.  
>     >>
>     >> The Cavium guys haven't shown any numbers (IIUC) to back the
>     >> L1_CACHE_BYTES performance improvement but I would not revert the
>     >> original commit since ARCH_DMA_MINALIGN definitely needs to cover the
>     >> maximum available cache line size, which is 128 for them.
>     > 
>     > how about define L1_CACHE_SHIFT like below:
>     > ---
>     > #ifdef CONFIG_ARM64_L1_CACHE_SHIFT
>     > #define L1_CACHE_SHIFT CONFIG_ARM64_L1_CACHE_SHIFT
>     > #else
>     > #define L1_CACHE_SHIFT 7
>     > endif
>     > ---
>     > 
>     > Thanks
>     > 
>     >>
>     >> --
>     >> Catalin
>     
>     
>     -- 
>     QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a\nmember of the Code Aurora Forum, hosted by The Linux Foundation
>     
>     _______________________________________________
>     linux-arm-kernel mailing list
>     linux-arm-kernel at lists.infradead.org
>     http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>     
> 


-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a\nmember of the Code Aurora Forum, hosted by The Linux Foundation
