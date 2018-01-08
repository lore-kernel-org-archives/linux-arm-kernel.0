From: ynorov@caviumnetworks.com (Yury Norov)
Date: Mon, 8 Jan 2018 18:32:25 +0300
Subject: [PATCH] perf: arm_dsu_pmu: convert to bitmap_from_arr32
In-Reply-To: <20180108151547.GJ25869@arm.com>
References: <20180108124902.3854110-1-arnd@arndb.de>
 <6521819f-6812-7e70-8b8d-3828992ba551@arm.com>
 <20180108151547.GJ25869@arm.com>
Message-ID: <20180108153225.zduqdgokcnz5k7yg@yury-thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 08, 2018 at 03:15:47PM +0000, Will Deacon wrote:
> On Mon, Jan 08, 2018 at 02:56:24PM +0000, Suzuki K Poulose wrote:
> > On 08/01/18 12:48, Arnd Bergmann wrote:
> > >The bitmap_from_u32array() interface got replaced in a global
> > >change, but the arm_dsu_pmu driver adds another instance,
> > >resulting in a build failure:
> > >
> > >drivers/perf/arm_dsu_pmu.c: In function 'dsu_pmu_probe_pmu':
> > >drivers/perf/arm_dsu_pmu.c:661:2: error: implicit declaration of function 'bitmap_from_u32array'; did you mean 'bitmap_from_arr32'? [-Werror=implicit-function-declaration]
> > >
> > >This changes the new instance accordingly.
> > >
> > >Fixes: mmotm ("bitmap: replace bitmap_{from,to}_u32array")
> > >Fixes: 7520fa99246d ("perf: ARM DynamIQ Shared Unit PMU support")
> > >Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > >---
> > >The global change is currently in linux-mm, so it should be
> > >possible to just fold this patch into it, without causing
> > >extra work.
> > >---
> > >  drivers/perf/arm_dsu_pmu.c | 6 ++----
> > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > >
> > >diff --git a/drivers/perf/arm_dsu_pmu.c b/drivers/perf/arm_dsu_pmu.c
> > >index 37c0526c93d5..e2700888a7d9 100644
> > >--- a/drivers/perf/arm_dsu_pmu.c
> > >+++ b/drivers/perf/arm_dsu_pmu.c
> > >@@ -658,10 +658,8 @@ static void dsu_pmu_probe_pmu(struct dsu_pmu *dsu_pmu)
> > >  		return;
> > >  	cpmceid[0] = __dsu_pmu_read_pmceid(0);
> > >  	cpmceid[1] = __dsu_pmu_read_pmceid(1);
> > >-	bitmap_from_u32array(dsu_pmu->cpmceid_bitmap,
> > >-				DSU_PMU_MAX_COMMON_EVENTS,
> > >-				cpmceid,
> > >-				ARRAY_SIZE(cpmceid));
> > >+	bitmap_from_arr32(dsu_pmu->cpmceid_bitmap, cpmceid,
> > >+			  DSU_PMU_MAX_COMMON_EVENTS);
> > >  }
> > >  static void dsu_pmu_set_active_cpu(int cpu, struct dsu_pmu *dsu_pmu)
> > >
> > 
> > Arnd,
> > 
> > Thanks for fixing this. FWIW,
> > 
> > Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> Hmm, what's the best way to get this upstream? The PMU driver is likely to
> be queued via arm64 soon, but this fixup doesn't apply there.

Hi Will,

If driver will be merged in linux-next prior to my rework, I can resend
it with this patch melded. Is it OK for you?

Yury
