From: james.morse@arm.com (James Morse)
Date: Tue, 21 Jul 2015 13:23:28 +0100
Subject: [PATCH v3 3/6] arm64: kernel: Add cpufeature 'enable' callback
In-Reply-To: <1437481411-1595-1-git-send-email-james.morse@arm.com>
References: <1437481411-1595-1-git-send-email-james.morse@arm.com>
Message-ID: <1437481411-1595-4-git-send-email-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds an 'enable()' callback to cpu capability/feature
detection, allowing features that require some setup or configuration
to get this opportunity once the feature has been detected.

Signed-off-by: James Morse <james.morse@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/cpufeature.h | 1 +
 arch/arm64/kernel/cpufeature.c      | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 9fafa7537997..484fa9425314 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -34,6 +34,7 @@ struct arm64_cpu_capabilities {
 	const char *desc;
 	u16 capability;
 	bool (*matches)(const struct arm64_cpu_capabilities *);
+	void (*enable)(void);
 	union {
 		struct {	/* To be used for erratum handling only */
 			u32 midr_model;
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 5ad86ceac010..650ffc28bedc 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -55,6 +55,12 @@ void check_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
 			pr_info("%s %s\n", info, caps[i].desc);
 		cpus_set_cap(caps[i].capability);
 	}
+
+	/* second pass allows enable() to consider interacting capabilities */
+	for (i = 0; caps[i].desc; i++) {
+		if (cpus_have_cap(caps[i].capability) && caps[i].enable)
+			caps[i].enable();
+	}
 }
 
 void check_local_cpu_features(void)
-- 
2.1.4
