From: will.deacon@arm.com (Will Deacon)
Date: Wed, 25 Jul 2018 15:27:38 +0100
Subject: [PATCH v2 1/1] iommu/arm-smmu-v3: Set GBPA to abort all
 transactions
In-Reply-To: <1529980239-1950-1-git-send-email-sgoel@codeaurora.org>
References: <1529980239-1950-1-git-send-email-sgoel@codeaurora.org>
Message-ID: <20180725142737.GA6866@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sameer,

On Mon, Jun 25, 2018 at 08:30:39PM -0600, Sameer Goel wrote:
> Set SMMU_GBPA to abort all incoming translations during the SMMU reset
> when SMMUEN==0.
> 
> This prevents a race condition where a stray DMA from the crashed primary
> kernel can try to access an IOVA address as an invalid PA when SMMU is
> disabled during reset in the crash kernel.
> 
> Signed-off-by: Sameer Goel <sgoel@codeaurora.org>
> ---
>  drivers/iommu/arm-smmu-v3.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 1d64710..5fedb8e 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -2395,6 +2395,20 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
>  	if (reg & CR0_SMMUEN)
>  		dev_warn(smmu->dev, "SMMU currently enabled! Resetting...\n");
>  
> +	/*
> +	 * Abort all incoming translations. This can happen in a kdump case
> +	 * where SMMU is initialized when a prior DMA is pending. Just
> +	 * disabling the SMMU in this case might result in writes to invalid
> +	 * PAs. Do this only if bypass is not set.
> +	 */
> +	if(!bypass || disable_bypass) {
> +		ret = arm_smmu_update_gbpa(smmu, 1, GBPA_ABORT);

I really don't understand what this is trying to accomplish!

As far as I understood, the problem you're trying to solve is when we
kexec a crash kernel without cleanly shutting down the SMMU. In this case,
we want to avoid resetting the SMMU when we find it enabled, because doing
so would put it into bypass and any ongoing DMA could corrupt memory being
uses by the crash kernel. Is that correct? If so, how about the diff below
instead of this patch?

Cheers,

Will

--->8

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 7fb5230cd145..3ce841c5cae3 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -24,6 +24,7 @@
 #include <linux/acpi_iort.h>
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
+#include <linux/crash_dump.h>
 #include <linux/delay.h>
 #include <linux/dma-iommu.h>
 #include <linux/err.h>
@@ -2212,8 +2213,12 @@ static int arm_smmu_update_gbpa(struct arm_smmu_device *smmu, u32 set, u32 clr)
 	reg &= ~clr;
 	reg |= set;
 	writel_relaxed(reg | GBPA_UPDATE, gbpa);
-	return readl_relaxed_poll_timeout(gbpa, reg, !(reg & GBPA_UPDATE),
-					  1, ARM_SMMU_POLL_TIMEOUT_US);
+	ret = readl_relaxed_poll_timeout(gbpa, reg, !(reg & GBPA_UPDATE),
+					 1, ARM_SMMU_POLL_TIMEOUT_US);
+
+	if (ret)
+		dev_err(smmu->dev, "GBPA not responding to update\n");
+	return ret;
 }
 
 static void arm_smmu_free_msis(void *data)
@@ -2393,8 +2398,14 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 
 	/* Clear CR0 and sync (disables SMMU and queue processing) */
 	reg = readl_relaxed(smmu->base + ARM_SMMU_CR0);
-	if (reg & CR0_SMMUEN)
+	if (reg & CR0_SMMUEN) {
+		if (is_kdump_kernel()) {
+			arm_smmu_update_gbpa(smmu, GBPA_ABORT, 0);
+			return -EBUSY;
+		}
+
 		dev_warn(smmu->dev, "SMMU currently enabled! Resetting...\n");
+	}
 
 	ret = arm_smmu_device_disable(smmu);
 	if (ret)
@@ -2492,10 +2503,8 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 		enables |= CR0_SMMUEN;
 	} else {
 		ret = arm_smmu_update_gbpa(smmu, 0, GBPA_ABORT);
-		if (ret) {
-			dev_err(smmu->dev, "GBPA not responding to update\n");
+		if (ret)
 			return ret;
-		}
 	}
 	ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
 				      ARM_SMMU_CR0ACK);
