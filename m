From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 4 Nov 2015 11:39:19 +0000
Subject: [RFC] arm64: perf: associate LL with L2 cache accesses and refills
In-Reply-To: <1446636253-7519-1-git-send-email-hw.claudio@gmail.com>
References: <1446636253-7519-1-git-send-email-hw.claudio@gmail.com>
Message-ID: <20151104113918.GB23860@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 04, 2015 at 12:24:13PM +0100, hw.claudio at gmail.com wrote:
> From: Claudio Fontana <claudio.fontana@huawei.com>
> 
> Signed-off-by: Claudio Fontana <claudio.fontana@huawei.com>
> Cc: Ammar Saeed <ammar.saeed@huawei.com>
> ---
> 
> Hello,

Hi,
 
> as part of some experiments with the Juno ARM64 board, we needed to get
> readings from the PMU regarding L2 Cache hits and misses, but we noticed
> that the L2 Cache Access and Refill performance counters were not hooked
> up in the perf API. We just did that, and that seems to produce correct
> results on the Juno.
> 
> However I guess that these registers are not hooked up by default due to
> differences between different boards...how could this be done taking
> account of the different possible implementations? 

The events we list for PMUv3 are those which are required to be
implemented (see "D5.10.6 Required events" in ARM DDI 0487A.h). All
others (including the L2 events you add) are optional and may or may not
be implemented, so we can't expose them for all PMUv3 implementations.

To account for different events, we will shortly be exposing separate
logical PMUs (see [1]), which will allow us to support each CPU's set
of supported events independently. That's queued in the arm64 tree [2]
currently.

I see that per their respective TRMs, both Cortex-A53 and Cortex-A57
support these L2 events. It looks like when I added specialised support
[3,4] I simply missed them. Fancy sending a patch to correct that?

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/374053.html
[2] https://git.kernel.org/cgit/linux/kernel/git/arm64/linux.git/log/?h=for-next/core
[3] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/374052.html
[4] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/374056.html

> I send this as an initial RFC to try to kickoff discussion about this.
> 
> Thank you,
> 
> Claudio Fontana
> 
>  arch/arm64/kernel/perf_event.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> index f9a74d4..f72f2ff 100644
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -728,6 +728,11 @@ static const unsigned armv8_pmuv3_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
>  	[C(L1D)][C(OP_WRITE)][C(RESULT_ACCESS)]	= ARMV8_PMUV3_PERFCTR_L1_DCACHE_ACCESS,
>  	[C(L1D)][C(OP_WRITE)][C(RESULT_MISS)]	= ARMV8_PMUV3_PERFCTR_L1_DCACHE_REFILL,
>  
> +	[C(LL)][C(OP_READ)][C(RESULT_ACCESS)]	= ARMV8_PMUV3_PERFCTR_L2_CACHE_ACCESS,
> +	[C(LL)][C(OP_READ)][C(RESULT_MISS)]	= ARMV8_PMUV3_PERFCTR_L2_CACHE_REFILL,
> +	[C(LL)][C(OP_WRITE)][C(RESULT_ACCESS)]	= ARMV8_PMUV3_PERFCTR_L2_CACHE_ACCESS,
> +	[C(LL)][C(OP_WRITE)][C(RESULT_MISS)]	= ARMV8_PMUV3_PERFCTR_L2_CACHE_REFILL,
> +
>  	[C(BPU)][C(OP_READ)][C(RESULT_ACCESS)]	= ARMV8_PMUV3_PERFCTR_PC_BRANCH_PRED,
>  	[C(BPU)][C(OP_READ)][C(RESULT_MISS)]	= ARMV8_PMUV3_PERFCTR_PC_BRANCH_MIS_PRED,
>  	[C(BPU)][C(OP_WRITE)][C(RESULT_ACCESS)]	= ARMV8_PMUV3_PERFCTR_PC_BRANCH_PRED,
> -- 
> 1.8.5.3
> 
