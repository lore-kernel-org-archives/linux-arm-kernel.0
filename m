From: will.deacon@arm.com (Will Deacon)
Date: Mon, 23 Jul 2018 15:42:21 +0100
Subject: [PATCH] drivers/perf: hisi: update the sccl_id/ccl_id when MT is
 supported
In-Reply-To: <1531999600-24266-1-git-send-email-zhangshaokun@hisilicon.com>
References: <1531999600-24266-1-git-send-email-zhangshaokun@hisilicon.com>
Message-ID: <20180723144220.GB9450@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 19, 2018 at 07:26:40PM +0800, Shaokun Zhang wrote:
> MT bit in MPIDR_EL1 is now supported in certain HiSilicon platforms, so
> the mapping between sccl_id/ccl_id and affinity level needs to be updated
> from the generic encoding we originally used.
> 
> Cc: John Garry <john.garry@huawei.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
> ---
>  drivers/perf/hisilicon/hisi_uncore_pmu.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pmu.c
> index 44df613..b3c5ae9 100644
> --- a/drivers/perf/hisilicon/hisi_uncore_pmu.c
> +++ b/drivers/perf/hisilicon/hisi_uncore_pmu.c
> @@ -350,19 +350,22 @@ void hisi_uncore_pmu_disable(struct pmu *pmu)
>  
>  /*
>   * Read Super CPU cluster and CPU cluster ID from MPIDR_EL1.
> - * If multi-threading is supported, SCCL_ID is in MPIDR[aff3] and CCL_ID
> - * is in MPIDR[aff2]; if not, SCCL_ID is in MPIDR[aff2] and CCL_ID is
> - * in MPIDR[aff1]. If this changes in future, this shall be updated.
> + * If multi-threading is supported, CCL_ID is the low 3-bits in MPIDR[Aff2]
> + * and SCCL_ID is the upper 5-bits of Aff2 field; if not, SCCL_ID
> + * is in MPIDR[Aff2] and CCL_ID is in MPIDR[Aff1]. If this changes in
> + * future, this shall be updated.
>   */
>  static void hisi_read_sccl_and_ccl_id(int *sccl_id, int *ccl_id)
>  {
>  	u64 mpidr = read_cpuid_mpidr();
>  
>  	if (mpidr & MPIDR_MT_BITMASK) {

So, to be clear, you're saying that the MT bit was not set in any previous
SoC with this PMU, and therefore changing this logic doesn't introduce a
functional regression?

Assuming that's the case, and you now have an SoC with MT set, then I don't
think the comment above which says "If this changes in future, this shall be
updated" can be correct, because changing the mapping will regress an older
platform, won't it?

In my opinion, you'd be much better off describing the PMU topology explicitly
in firmware tables.

Will
