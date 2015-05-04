From: hillf.zj@alibaba-inc.com (Hillf Danton)
Date: Mon, 04 May 2015 10:52:31 +0800
Subject: [patch] ARM: fix module-bound check in setting page attributes
In-Reply-To: <5543C529.4080203@labbott.name>
References: <042801d066b3$0ca78a30$25f69e90$@alibaba-inc.com>
 <5543C529.4080203@labbott.name>
Message-ID: <019401d08615$5e093000$1a1b9000$@alibaba-inc.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It was introduced in commit f2ca09f381a59
(ARM: 8311/1: Don't use is_module_addr in setting page attributes)

We have no need to check start twice, but see if end is also in range.

Signed-off-by: Hillf Danton <hillf.zj@alibaba-inc.com>
Acked-by: Laura Abbott <laura@labbott.name>
---

--- a/arch/arm/mm/pageattr.c	Mon May  4 10:33:49 2015
+++ b/arch/arm/mm/pageattr.c	Mon May  4 10:35:32 2015
@@ -52,7 +52,7 @@ static int change_memory_common(unsigned
 	if (start < MODULES_VADDR || start >= MODULES_END)
 		return -EINVAL;
 
-	if (end < MODULES_VADDR || start >= MODULES_END)
+	if (end < MODULES_VADDR || end >= MODULES_END)
 		return -EINVAL;
 
 	data.set_mask = set_mask;
--
