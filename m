From: broonie@kernel.org (Mark Brown)
Date: Wed, 19 Mar 2014 18:02:19 +0000
Subject: [PATCH 3/3] arm64: topology: Provide relative power numbers for cores
In-Reply-To: <1395252139-16239-1-git-send-email-broonie@kernel.org>
References: <1395252139-16239-1-git-send-email-broonie@kernel.org>
Message-ID: <1395252139-16239-3-git-send-email-broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Brown <broonie@linaro.org>

Provide performance numbers to the scheduler to help it fill the cores in
the system on big.LITTLE systems. With the current scheduler this may
perform poorly for applications that try to do OpenMP style work over all
cores but should help for more common workloads. The current 32 bit ARM
implementation provides a similar estimate so this helps ensure that
work to improve big.LITTLE systems on ARMv7 systems performs similarly
on ARMv8 systems.

The power numbers are the same as for ARMv7 since it seems that the
expected differential between the big and little cores is very similar on
both ARMv7 and ARMv8.  In both ARMv7 and ARMv8 cases the numbers were
based on the published DMIPS numbers.

These numbers are just an initial and basic approximation for use with
the current scheduler, it is likely that both experience with silicon
and ongoing work on improving the scheduler will lead to further tuning
or will tune automatically at runtime and so make the specific choice of
numbers here less critical.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 arch/arm64/kernel/topology.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 6713c7de4be3..01ab52be2764 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -190,6 +190,8 @@ struct cpu_efficiency {
  * use the default SCHED_POWER_SCALE value for cpu_scale.
  */
 static const struct cpu_efficiency table_efficiency[] = {
+	{ "arm,cortex-a57", 3891 },
+	{ "arm,cortex-a53", 2048 },
 	{ NULL, },
 };
 
-- 
1.9.0
