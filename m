From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Wed, 25 Apr 2018 15:26:29 +0900
Subject: [PATCH v9 11/11] arm64: kexec_file: add kaslr support
In-Reply-To: <20180425062629.29404-1-takahiro.akashi@linaro.org>
References: <20180425062629.29404-1-takahiro.akashi@linaro.org>
Message-ID: <20180425062629.29404-12-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding "kalsr-seed" to dtb enables triggering kaslr, or kernel virtual
address randomization, at secondary kernel boot. We always do this as
it wll have no harm on kaslr-incapable kernel.

We don't have any "switch" to turn off this feature directly, but still
can suppress it by passing "nokaslr" as a kernel boot argument.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/machine_kexec_file.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index ec674f4d267c..762f9102899c 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -16,6 +16,7 @@
 #include <linux/libfdt.h>
 #include <linux/memblock.h>
 #include <linux/of_fdt.h>
+#include <linux/random.h>
 #include <linux/types.h>
 #include <linux/vmalloc.h>
 #include <asm/byteorder.h>
@@ -246,6 +247,12 @@ static int setup_dtb(struct kimage *image,
 			goto out_err;
 	}
 
+	/* add kaslr-seed */
+	get_random_bytes(&value, sizeof(value));
+	ret = fdt_setprop(buf, nodeoffset, "kaslr-seed", &value, sizeof(value));
+	if (ret)
+		goto out_err;
+
 	/* trim a buffer */
 	fdt_pack(buf);
 	*dtb_buf = buf;
-- 
2.17.0
