From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Wed, 10 Oct 2018 18:27:04 +0100
Subject: [PATCH 5/6] arm64: perf: Move event definitions into perf_event.h
In-Reply-To: <1539189115-16221-6-git-send-email-will.deacon@arm.com>
References: <1539189115-16221-1-git-send-email-will.deacon@arm.com>
 <1539189115-16221-6-git-send-email-will.deacon@arm.com>
Message-ID: <7fa991a1-40b2-08cf-11cf-8c41124496d8@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 10/10/18 17:31, Will Deacon wrote:
> The PMU event numbers are split between perf_event.h and perf_event.c,
> which makes it difficult to spot any gaps in the numbers which may be
> allocated in the future.
> 
> This patch sorts the events numerically, adds some missing events and
> moves the definitions into perf_event.h.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>   arch/arm64/include/asm/perf_event.h | 164 +++++++++++++++++++++++++++++++++---
>   arch/arm64/kernel/perf_event.c      | 145 +------------------------------
>   2 files changed, 155 insertions(+), 154 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/perf_event.h b/arch/arm64/include/asm/perf_event.h
> index f9ccc36d3dc3..6bad0f6173df 100644
> --- a/arch/arm64/include/asm/perf_event.h
> +++ b/arch/arm64/include/asm/perf_event.h
> @@ -24,6 +24,160 @@
>   #define	ARMV8_PMU_COUNTER_MASK	(ARMV8_PMU_MAX_COUNTERS - 1)
>   
>   /*
> + * Common architectural and microarchitectural event numbers.
> + */
> +#define ARMV8_PMUV3_PERFCTR_SW_INCR				0x00
> +#define ARMV8_PMUV3_PERFCTR_L1I_CACHE_REFILL			0x01
> +#define ARMV8_PMUV3_PERFCTR_L1I_TLB_REFILL			0x02
> +#define ARMV8_PMUV3_PERFCTR_L1D_CACHE_REFILL			0x03
> +#define ARMV8_PMUV3_PERFCTR_L1D_CACHE				0x04
> +#define ARMV8_PMUV3_PERFCTR_L1D_TLB_REFILL			0x05
> +#define ARMV8_PMUV3_PERFCTR_LD_RETIRED				0x06
> +#define ARMV8_PMUV3_PERFCTR_ST_RETIRED				0x07
> +#define ARMV8_PMUV3_PERFCTR_INST_RETIRED			0x08
> +#define ARMV8_PMUV3_PERFCTR_EXC_TAKEN				0x09
> +#define ARMV8_PMUV3_PERFCTR_EXC_RETURN				0x0A
> +#define ARMV8_PMUV3_PERFCTR_CID_WRITE_RETIRED			0x0B
> +#define ARMV8_PMUV3_PERFCTR_PC_WRITE_RETIRED			0x0C
> +#define ARMV8_PMUV3_PERFCTR_BR_IMMED_RETIRED			0x0D
> +#define ARMV8_PMUV3_PERFCTR_BR_RETURN_RETIRED			0x0E
> +#define ARMV8_PMUV3_PERFCTR_UNALIGNED_LDST_RETIRED		0x0F
> +#define ARMV8_PMUV3_PERFCTR_BR_MIS_PRED				0x10
> +#define ARMV8_PMUV3_PERFCTR_CPU_CYCLES				0x11
> +#define ARMV8_PMUV3_PERFCTR_BR_PRED				0x12
> +#define ARMV8_PMUV3_PERFCTR_MEM_ACCESS				0x13
> +#define ARMV8_PMUV3_PERFCTR_L1I_CACHE				0x14
> +#define ARMV8_PMUV3_PERFCTR_L1D_CACHE_WB			0x15
> +#define ARMV8_PMUV3_PERFCTR_L2D_CACHE				0x16
> +#define ARMV8_PMUV3_PERFCTR_L2D_CACHE_REFILL			0x17
> +#define ARMV8_PMUV3_PERFCTR_L2D_CACHE_WB			0x18
> +#define ARMV8_PMUV3_PERFCTR_BUS_ACCESS				0x19
> +#define ARMV8_PMUV3_PERFCTR_MEMORY_ERROR			0x1A
> +#define ARMV8_PMUV3_PERFCTR_INST_SPEC				0x1B
> +#define ARMV8_PMUV3_PERFCTR_TTBR_WRITE_RETIRED			0x1C
> +#define ARMV8_PMUV3_PERFCTR_BUS_CYCLES				0x1D
> +#define ARMV8_PMUV3_PERFCTR_CHAIN				0x1E
> +#define ARMV8_PMUV3_PERFCTR_L1D_CACHE_ALLOCATE			0x1F
> +#define ARMV8_PMUV3_PERFCTR_L2D_CACHE_ALLOCATE			0x20
> +#define ARMV8_PMUV3_PERFCTR_BR_RETIRED				0x21
> +#define ARMV8_PMUV3_PERFCTR_BR_MIS_PRED_RETIRED			0x22
> +#define ARMV8_PMUV3_PERFCTR_STALL_FRONTEND			0x23
> +#define ARMV8_PMUV3_PERFCTR_STALL_BACKEND			0x24
> +#define ARMV8_PMUV3_PERFCTR_L1D_TLB				0x25
> +#define ARMV8_PMUV3_PERFCTR_L1I_TLB				0x26
> +#define ARMV8_PMUV3_PERFCTR_L2I_CACHE				0x27
> +#define ARMV8_PMUV3_PERFCTR_L2I_CACHE_REFILL			0x28
> +#define ARMV8_PMUV3_PERFCTR_L3D_CACHE_ALLOCATE			0x29
> +#define ARMV8_PMUV3_PERFCTR_L3D_CACHE_REFILL			0x2A
> +#define ARMV8_PMUV3_PERFCTR_L3D_CACHE				0x2B
> +#define ARMV8_PMUV3_PERFCTR_L3D_CACHE_WB			0x2C
> +#define ARMV8_PMUV3_PERFCTR_L2D_TLB_REFILL			0x2D
> +#define ARMV8_PMUV3_PERFCTR_L2I_TLB_REFILL			0x2E
> +#define ARMV8_PMUV3_PERFCTR_L2D_TLB				0x2F
> +#define ARMV8_PMUV3_PERFCTR_L2I_TLB				0x30
> +#define ARMV8_PMUV3_PERFCTR_REMOTE_ACCESS			0x31
> +#define ARMV8_PMUV3_PERFCTR_LL_CACHE				0x32
> +#define ARMV8_PMUV3_PERFCTR_LL_CACHE_MISS			0x33
> +#define ARMV8_PMUV3_PERFCTR_DTLB_WALK				0x34
> +#define ARMV8_PMUV3_PERFCTR_ITLB_WALK				0x35
> +#define ARMV8_PMUV3_PERFCTR_LL_CACHE_RD				0x36
> +#define ARMV8_PMUV3_PERFCTR_LL_CACHE_MISS_RD			0x37
> +#define ARMV8_PMUV3_PERFCTR_REMOTE_ACCESS_RD			0x38
> +
> +/* Statistical profiling extension microarchitectural events */
> +#define	ARMV8_SPE_PERFCTR_SAMPLE_POP				0x4000
> +#define	ARMV8_SPE_PERFCTR_SAMPLE_FEED				0x4000
> +#define	ARMV8_SPE_PERFCTR_SAMPLE_FILTRATE			0x4000
> +#define	ARMV8_SPE_PERFCTR_SAMPLE_COLLISION			0x4000

This appears to be a mistake of copy-paste. The numbers must be

+#define	ARMV8_SPE_PERFCTR_SAMPLE_POP			0x4000
+#define	ARMV8_SPE_PERFCTR_SAMPLE_FEED			0x4001
+#define	ARMV8_SPE_PERFCTR_SAMPLE_FILTRATE		0x4002
+#define	ARMV8_SPE_PERFCTR_SAMPLE_COLLISION		0x4003

Otherwise looks good to me.

Suzuki
