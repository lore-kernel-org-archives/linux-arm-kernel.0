From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 30 Jan 2012 02:43:17 -0700
Subject: [PATCH 1/2] ARM: OMAP3: PM: remove superfluous calls to
 pwrdm_clear_all_prev_pwrst()
In-Reply-To: <20120130093931.11027.31048.stgit@dusk>
References: <20120130093931.11027.31048.stgit@dusk>
Message-ID: <20120130094312.11027.31050.stgit@dusk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove some superfluous calls to pwrdm_clear_all_prev_pwrst().
pwrdm_pre_transition(), which appears a few lines after these calls,
invokes pwrdm_clear_all_prev_pwrst() on each powerdomain -- there's no
need to do it twice.

N.B.: some of us have observed that accesses to the previous
powerstate registers seem to be quite slow.  Although the writes
removed by this patch should be buffered by the write buffer, there is
a read to a PRM register immediately afterwards.  That will block the
OMAP3 MPU until all of those writes complete.  So this patch should
result in a minor performance improvement during idle entry.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index fc69875..463eb6c 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -290,11 +290,6 @@ void omap_sram_idle(void)
 	int core_prev_state, per_prev_state;
 	u32 sdrc_pwr = 0;
 
-	pwrdm_clear_all_prev_pwrst(mpu_pwrdm);
-	pwrdm_clear_all_prev_pwrst(neon_pwrdm);
-	pwrdm_clear_all_prev_pwrst(core_pwrdm);
-	pwrdm_clear_all_prev_pwrst(per_pwrdm);
-
 	mpu_next_state = pwrdm_read_next_pwrst(mpu_pwrdm);
 	switch (mpu_next_state) {
 	case PWRDM_POWER_ON:
