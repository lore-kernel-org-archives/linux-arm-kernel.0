From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 7 Apr 2017 09:59:10 +0100
Subject: [PATCH] Revert "arm64: Increase the max granular size"
In-Reply-To: <CADAEsF_Hr=mPspvuPsQtKWiSDu6oCjfyy0rGwWrF9EJo-ZO1JA@mail.gmail.com>
References: <1458120743-12145-1-git-send-email-opensource.ganesh@gmail.com>
 <DA22064C-45A7-4F79-A433-84054AF182DF@caviumnetworks.com>
 <20160321171403.GE25466@e104818-lin.cambridge.arm.com>
 <CAPub14-sFgx=oCHzJPb9h9b_V0rbn5UAMDNJ-yTkjhz38JPqMQ@mail.gmail.com>
 <10fef112-37f1-0a1b-b5af-435acd032f01@codeaurora.org>
 <4525901c-45d4-6bd8-eec6-ae92977f16d1@codeaurora.org>
 <20170406155825.GA7705@e104818-lin.cambridge.arm.com>
 <CADAEsF_Hr=mPspvuPsQtKWiSDu6oCjfyy0rGwWrF9EJo-ZO1JA@mail.gmail.com>
Message-ID: <20170407085909.GB18291@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 07, 2017 at 10:06:31AM +0800, Ganesh Mahendran wrote:
> 2017-04-06 23:58 GMT+08:00 Catalin Marinas <catalin.marinas@arm.com>:
> > On Thu, Apr 06, 2017 at 12:52:13PM +0530, Imran Khan wrote:
> >> On 4/5/2017 10:13 AM, Imran Khan wrote:
> >> >> We may have to revisit this logic and consider L1_CACHE_BYTES the
> >> >> _minimum_ of cache line sizes in arm64 systems supported by the kernel.
> >> >> Do you have any benchmarks on Cavium boards that would show significant
> >> >> degradation with 64-byte L1_CACHE_BYTES vs 128?
> >> >>
> >> >> For non-coherent DMA, the simplest is to make ARCH_DMA_MINALIGN the
> >> >> _maximum_ of the supported systems:
> >> >>
> >> >> diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
> >> >> index 5082b30bc2c0..4b5d7b27edaf 100644
> >> >> --- a/arch/arm64/include/asm/cache.h
> >> >> +++ b/arch/arm64/include/asm/cache.h
> >> >> @@ -18,17 +18,17 @@
> >> >>
> >> >>  #include <asm/cachetype.h>
> >> >>
> >> >> -#define L1_CACHE_SHIFT         7
> >> >> +#define L1_CACHE_SHIFT         6
> >> >>  #define L1_CACHE_BYTES         (1 << L1_CACHE_SHIFT)
> >> >>
> >> >>  /*
> >> >>   * Memory returned by kmalloc() may be used for DMA, so we must make
> >> >> - * sure that all such allocations are cache aligned. Otherwise,
> >> >> - * unrelated code may cause parts of the buffer to be read into the
> >> >> - * cache before the transfer is done, causing old data to be seen by
> >> >> - * the CPU.
> >> >> + * sure that all such allocations are aligned to the maximum *known*
> >> >> + * cache line size on ARMv8 systems. Otherwise, unrelated code may cause
> >> >> + * parts of the buffer to be read into the cache before the transfer is
> >> >> + * done, causing old data to be seen by the CPU.
> >> >>   */
> >> >> -#define ARCH_DMA_MINALIGN      L1_CACHE_BYTES
> >> >> +#define ARCH_DMA_MINALIGN      (128)
> >> >>
> >> >>  #ifndef __ASSEMBLY__
> >> >>
> >> >> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> >> >> index 392c67eb9fa6..30bafca1aebf 100644
> >> >> --- a/arch/arm64/kernel/cpufeature.c
> >> >> +++ b/arch/arm64/kernel/cpufeature.c
> >> >> @@ -976,9 +976,9 @@ void __init setup_cpu_features(void)
> >> >>         if (!cwg)
> >> >>                 pr_warn("No Cache Writeback Granule information, assuming
> >> >> cache line size %d\n",
> >> >>                         cls);
> >> >> -       if (L1_CACHE_BYTES < cls)
> >> >> -               pr_warn("L1_CACHE_BYTES smaller than the Cache Writeback Granule (%d < %d)\n",
> >> >> -                       L1_CACHE_BYTES, cls);
> >> >> +       if (ARCH_DMA_MINALIGN < cls)
> >> >> +               pr_warn("ARCH_DMA_MINALIGN smaller than the Cache Writeback Granule (%d < %d)\n",
> >> >> +                       ARCH_DMA_MINALIGN, cls);
> >> >>  }
> >> >>
> >> >>  static bool __maybe_unused
> >> >
> >> > This change was discussed at: [1] but was not concluded as apparently no one
> >> > came back with test report and numbers. After including this change in our
> >> > local kernel we are seeing significant throughput improvement. For example with:
> >> >
> >> > iperf -c 192.168.1.181 -i 1 -w 128K -t 60
> >> >
> >> > The average throughput is improving by about 30% (230Mbps from 180Mbps).
> >> > Could you please let us know if this change can be included in upstream kernel.
> >> >
> >> > [1]: https://groups.google.com/forum/#!topic/linux.kernel/P40yDB90ePs
> >>
> >> Could you please provide some feedback about the above mentioned query ?
> >
> > Do you have an explanation on the performance variation when
> > L1_CACHE_BYTES is changed? We'd need to understand how the network stack
> > is affected by L1_CACHE_BYTES, in which context it uses it (is it for
> > non-coherent DMA?).
> 
> network stack use SKB_DATA_ALIGN to align.
> ---
> #define SKB_DATA_ALIGN(X) (((X) + (SMP_CACHE_BYTES - 1)) & \
> ~(SMP_CACHE_BYTES - 1))
> 
> #define SMP_CACHE_BYTES L1_CACHE_BYTES
> ---
> I think this is the reason of performance regression.

And is this alignment required for DMA coherency? (I hope not since
SMP_CACHE_BYTES doesn't give this).

Anyway, to be sure, it's worth changing SKB_DATA_ALIGN to use 64 bytes
(hard-coded) and check the results again.

> > The Cavium guys haven't shown any numbers (IIUC) to back the
> > L1_CACHE_BYTES performance improvement but I would not revert the
> > original commit since ARCH_DMA_MINALIGN definitely needs to cover the
> > maximum available cache line size, which is 128 for them.
> 
> how about define L1_CACHE_SHIFT like below:
> ---
> #ifdef CONFIG_ARM64_L1_CACHE_SHIFT
> #define L1_CACHE_SHIFT CONFIG_ARM64_L1_CACHE_SHIFT
> #else
> #define L1_CACHE_SHIFT 7
> endif
> ---

I'd very much like to avoid this, still aiming for a single kernel
image.

My suggestion is to check whether L1_CACHE_BYTES is wrongly used for DMA
buffer alignment in the network code and, if not, move it back to 64
bytes while keeping ARCH_DMA_MINALIGN to 128 (as per my patch above). If
the performance on the Cavium system is affected by the L1_CACHE_BYTES
change, further patches would need to be backed by some numbers.

-- 
Catalin
