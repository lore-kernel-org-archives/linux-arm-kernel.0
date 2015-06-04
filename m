From: lina.iyer@linaro.org (Lina Iyer)
Date: Thu, 4 Jun 2015 10:15:10 -0600
Subject: [PATCH v2 2/2] soc: qcom: spm: Fix idle on THUMB2 kernels
In-Reply-To: <1433272378-8470-3-git-send-email-sboyd@codeaurora.org>
References: <1433272378-8470-1-git-send-email-sboyd@codeaurora.org>
 <1433272378-8470-3-git-send-email-sboyd@codeaurora.org>
Message-ID: <20150604161510.GS32700@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 02 2015 at 13:13 -0600, Stephen Boyd wrote:
>The ifc6410 firmware always enters the kernel in ARM state from
>deep idle. Use the cpu_resume_arm() wrapper instead of
>cpu_resume() to property switch into the THUMB2 state when we
>wake up from idle.
>
>This fixes a problem reported by Kevin Hilman on next-20150601
>where the ifc6410 fails to boot a THUMB2 kernel because the
>platform's firmware always enters the kernel in ARM mode from
>deep idle states.
>
>Reported-by: Kevin Hilman <khilman@linaro.org>
>Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>Cc: Lina Iyer <lina.iyer@linaro.org>
>Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Reviewd-by: Lina Iyer <lina.iyer@linaro.org>

>---
> drivers/soc/qcom/spm.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/soc/qcom/spm.c b/drivers/soc/qcom/spm.c
>index b562af816c0a..b04b05a0904e 100644
>--- a/drivers/soc/qcom/spm.c
>+++ b/drivers/soc/qcom/spm.c
>@@ -260,7 +260,7 @@ static int __init qcom_cpuidle_init(struct device_node *cpu_node, int cpu)
> 		/* We have atleast one power down mode */
> 		cpumask_clear(&mask);
> 		cpumask_set_cpu(cpu, &mask);
>-		qcom_scm_set_warm_boot_addr(cpu_resume, &mask);
>+		qcom_scm_set_warm_boot_addr(cpu_resume_arm, &mask);
> 	}
>
> 	per_cpu(qcom_idle_ops, cpu) = fns;
>-- 
>The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>a Linux Foundation Collaborative Project
>
