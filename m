From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 23 May 2018 18:46:55 +0100
Subject: [PATCH v4 1/2] arm64/sve: Thin out initialisation sanity-checks for
 sve_max_vl
In-Reply-To: <1527097616-25214-1-git-send-email-Dave.Martin@arm.com>
References: <1527097616-25214-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1527097616-25214-2-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the kernel SVE support is reasonably mature, it is
excessive to default sve_max_vl to the invalid value -1 and then
sprinkle WARN_ON()s around the place to make sure it has been
initialised before use.  The cpufeatures code already runs pretty
early, and will ensure sve_max_vl gets initialised.

This patch initialises sve_max_vl to something sane that will be
supported by every SVE implementation, and removes most of the
sanity checks.

The checks in find_supported_vector_length() are retained for now.
If anything goes horribly wrong, we are likely to trip a check here
sooner or later.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/kernel/fpsimd.c | 17 ++++-------------
 arch/arm64/kernel/ptrace.c |  3 ---
 2 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 87a3536..f9ec640 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -129,7 +129,7 @@ static int sve_default_vl = -1;
 #ifdef CONFIG_ARM64_SVE
 
 /* Maximum supported vector length across all CPUs (initially poisoned) */
-int __ro_after_init sve_max_vl = -1;
+int __ro_after_init sve_max_vl = SVE_VL_MIN;
 /* Set of available vector lengths, as vq_to_bit(vq): */
 static __ro_after_init DECLARE_BITMAP(sve_vq_map, SVE_VQ_MAX);
 static void __percpu *efi_sve_state;
@@ -360,22 +360,13 @@ static int sve_proc_do_default_vl(struct ctl_table *table, int write,
 		return ret;
 
 	/* Writing -1 has the special meaning "set to max": */
-	if (vl == -1) {
-		/* Fail safe if sve_max_vl wasn't initialised */
-		if (WARN_ON(!sve_vl_valid(sve_max_vl)))
-			vl = SVE_VL_MIN;
-		else
-			vl = sve_max_vl;
-
-		goto chosen;
-	}
+	if (vl == -1)
+		vl = sve_max_vl;
 
 	if (!sve_vl_valid(vl))
 		return -EINVAL;
 
-	vl = find_supported_vector_length(vl);
-chosen:
-	sve_default_vl = vl;
+	sve_default_vl = find_supported_vector_length(vl);
 	return 0;
 }
 
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 7ff81fe..577deb0 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -766,9 +766,6 @@ static void sve_init_header_from_task(struct user_sve_header *header,
 	vq = sve_vq_from_vl(header->vl);
 
 	header->max_vl = sve_max_vl;
-	if (WARN_ON(!sve_vl_valid(sve_max_vl)))
-		header->max_vl = header->vl;
-
 	header->size = SVE_PT_SIZE(vq, header->flags);
 	header->max_size = SVE_PT_SIZE(sve_vq_from_vl(header->max_vl),
 				      SVE_PT_REGS_SVE);
-- 
2.1.4
