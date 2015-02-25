From: lauraa@codeaurora.org (Laura Abbott)
Date: Wed, 25 Feb 2015 14:14:56 -0800
Subject: [PATCH 2/3] arm: Don't use is_module_addr in setting page attributes
In-Reply-To: <1424902497-32141-1-git-send-email-lauraa@codeaurora.org>
References: <1424902497-32141-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <1424902497-32141-3-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The set_memory_* functions currently only support module
addresses. The addresses are validated using is_module_addr.
That function is special though and relies on internal state
in the module subsystem to work properly. At the time of
module initialization and calling set_memory_*, it's too early
for is_module_addr to work properly so it always returns
false. Rather than be subject to the whims of the module state,
just bounds check against the module virtual address range.

Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
 arch/arm/mm/pageattr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/pageattr.c b/arch/arm/mm/pageattr.c
index 004e35c..cf30daf 100644
--- a/arch/arm/mm/pageattr.c
+++ b/arch/arm/mm/pageattr.c
@@ -49,7 +49,10 @@ static int change_memory_common(unsigned long addr, int numpages,
 		WARN_ON_ONCE(1);
 	}
 
-	if (!is_module_address(start) || !is_module_address(end - 1))
+	if (start < MODULES_VADDR || start >= MODULES_END)
+		return -EINVAL;
+
+	if (end < MODULES_VADDR || start >= MODULES_END)
 		return -EINVAL;
 
 	data.set_mask = set_mask;
-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
