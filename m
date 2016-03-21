From: will.deacon@arm.com (Will Deacon)
Date: Mon, 21 Mar 2016 17:23:01 +0000
Subject: [PATCH] Revert "arm64: Increase the max granular size"
In-Reply-To: <20160321171403.GE25466@e104818-lin.cambridge.arm.com>
References: <1458120743-12145-1-git-send-email-opensource.ganesh@gmail.com>
 <DA22064C-45A7-4F79-A433-84054AF182DF@caviumnetworks.com>
 <20160321171403.GE25466@e104818-lin.cambridge.arm.com>
Message-ID: <20160321172301.GP23397@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 21, 2016 at 05:14:03PM +0000, Catalin Marinas wrote:
> On Fri, Mar 18, 2016 at 09:05:37PM +0000, Chalamarla, Tirumalesh wrote:
> > On 3/16/16, 2:32 AM, "linux-arm-kernel on behalf of Ganesh Mahendran" <linux-arm-kernel-bounces at lists.infradead.org on behalf of opensource.ganesh@gmail.com> wrote:
> > >Reverts commit 97303480753e ("arm64: Increase the max granular size").
> > >
> > >The commit 97303480753e ("arm64: Increase the max granular size") will
> > >degrade system performente in some cpus.
> > >
> > >We test wifi network throughput with iperf on Qualcomm msm8996 CPU:
> > >----------------
> > >run on host:
> > >  # iperf -s
> > >run on device:
> > >  # iperf -c <device-ip-addr> -t 100 -i 1
> > >----------------
> > >
> > >Test result:
> > >----------------
> > >with commit 97303480753e ("arm64: Increase the max granular size"):
> > >    172MBits/sec
> > >
> > >without commit 97303480753e ("arm64: Increase the max granular size"):
> > >    230MBits/sec
> > >----------------
> > >
> > >Some module like slab/net will use the L1_CACHE_SHIFT, so if we do not
> > >set the parameter correctly, it may affect the system performance.
> > >
> > >So revert the commit.
> > 
> > Is there any explanation why is this so? May be there is an
> > alternative to this, apart from reverting the commit.
> 
> I agree we need an explanation but in the meantime, this patch has
> caused a regression on certain systems.
> 
> > Until now it seems L1_CACHE_SHIFT is the max of supported chips. But
> > now we are making it 64byte, is there any reason why not 32. 
> 
> We may have to revisit this logic and consider L1_CACHE_BYTES the
> _minimum_ of cache line sizes in arm64 systems supported by the kernel.
> Do you have any benchmarks on Cavium boards that would show significant
> degradation with 64-byte L1_CACHE_BYTES vs 128?
> 
> For non-coherent DMA, the simplest is to make ARCH_DMA_MINALIGN the
> _maximum_ of the supported systems:
> 
> diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
> index 5082b30bc2c0..4b5d7b27edaf 100644
> --- a/arch/arm64/include/asm/cache.h
> +++ b/arch/arm64/include/asm/cache.h
> @@ -18,17 +18,17 @@
>  
>  #include <asm/cachetype.h>
>  
> -#define L1_CACHE_SHIFT		7
> +#define L1_CACHE_SHIFT		6
>  #define L1_CACHE_BYTES		(1 << L1_CACHE_SHIFT)
>  
>  /*
>   * Memory returned by kmalloc() may be used for DMA, so we must make
> - * sure that all such allocations are cache aligned. Otherwise,
> - * unrelated code may cause parts of the buffer to be read into the
> - * cache before the transfer is done, causing old data to be seen by
> - * the CPU.
> + * sure that all such allocations are aligned to the maximum *known*
> + * cache line size on ARMv8 systems. Otherwise, unrelated code may cause
> + * parts of the buffer to be read into the cache before the transfer is
> + * done, causing old data to be seen by the CPU.
>   */
> -#define ARCH_DMA_MINALIGN	L1_CACHE_BYTES
> +#define ARCH_DMA_MINALIGN	(128)

Does this actually fix the reported iperf regression? My assumption was
that ARCH_DMA_MINALIGN is the problem, but I could be wrong.

Will
