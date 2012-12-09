From: paul@pwsan.com (Paul Walmsley)
Date: Sun, 09 Dec 2012 13:03:30 -0700
Subject: [PATCH 10/12] ARM: OMAP2+: powerdomain: skip previous-power-state
 read if next_pwrst is ON
In-Reply-To: <20121209200108.3196.12452.stgit@dusk.lan>
References: <20121209200108.3196.12452.stgit@dusk.lan>
Message-ID: <20121209200328.3196.96843.stgit@dusk.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the powerdomain's next-power-state is set to ON, then we can skip
the powerdomain previous-power-state read during
pwrdm_post_transition().  This is both an optimization (for all OMAPs)
and a fix (for OMAP2xxx).  It turns out the OMAP2xxx previous power
state mechanism is slightly different than the OMAP3+ mechanism. The
bitfield can't be cleared, and it's only updated after a powerdomain
power state transition.  So reading this value before any powerdomain
power state transition occurred will always return OFF (the reset
value).  After this patch, if the power domain was programmed to stay
ON before pwrdm_pre_transition() is called, the previous power state
code will return ON during pwrdm_post_transition().

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/powerdomain.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index a4bb0bb..72d6ce0 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -681,7 +681,9 @@ static int _pwrdm_post_transition_cb(struct powerdomain *pwrdm, void *unused)
 	int prev, fpwrst;
 	int trace_state = 0;
 
-	prev = _pwrdm_read_prev_fpwrst(pwrdm);
+	prev = (pwrdm->next_fpwrst == PWRDM_FUNC_PWRST_ON) ?
+		PWRDM_FUNC_PWRST_ON : _pwrdm_read_prev_fpwrst(pwrdm);
+
 	if (pwrdm->fpwrst != prev)
 		pwrdm->fpwrst_counter[prev - PWRDM_FPWRST_OFFSET]++;
 
