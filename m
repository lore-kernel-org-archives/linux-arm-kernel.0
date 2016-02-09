From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue,  9 Feb 2016 10:31:01 +0100
Subject: [PATCH v3 2/3] kallsyms: remove special lower address limit for
 CONFIG_ARM
In-Reply-To: <1455010262-28894-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1455010262-28894-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1455010262-28894-3-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we no longer emit .stubs symbols into a section VMA loaded
at absolute address 0x1000, we can drop the ARM-specific override that
sets a lower limit based on CONFIG_PAGE_OFFSET, below which symbols are
filtered from the kallsyms output.

Acked-by: Nicolas Pitre <nico@linaro.org>
Acked-by: Chris Brandt <chris.brandt@renesas.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 scripts/link-vmlinux.sh | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 49d61ade9425..f0f6d9d75435 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -82,10 +82,6 @@ kallsyms()
 		kallsymopt="${kallsymopt} --all-symbols"
 	fi
 
-	if [ -n "${CONFIG_ARM}" ] && [ -z "${CONFIG_XIP_KERNEL}" ] && [ -n "${CONFIG_PAGE_OFFSET}" ]; then
-		kallsymopt="${kallsymopt} --page-offset=$CONFIG_PAGE_OFFSET"
-	fi
-
 	if [ -n "${CONFIG_KALLSYMS_ABSOLUTE_PERCPU}" ]; then
 		kallsymopt="${kallsymopt} --absolute-percpu"
 	fi
-- 
2.5.0
