From: riel@redhat.com (riel at redhat.com)
Date: Wed, 24 May 2017 11:57:48 -0400
Subject: [PATCH 2/5] fork,
 random: use get_random_canary to set tsk->stack_canary
In-Reply-To: <20170524155751.424-1-riel@redhat.com>
References: <20170524155751.424-1-riel@redhat.com>
Message-ID: <20170524155751.424-3-riel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rik van Riel <riel@redhat.com>

Use the ascii-armor canary to prevent unterminated C string overflows
from being able to successfully overwrite the canary, even if they
somehow obtain the canary value.

Inspired by execshield ascii-armor and Daniel Micay's linux-hardened tree.

Signed-off-by: Rik van Riel <riel@redhat.com>
---
 kernel/fork.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index aa1076c5e4a9..b3591e9250a8 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -560,7 +560,7 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	set_task_stack_end_magic(tsk);
 
 #ifdef CONFIG_CC_STACKPROTECTOR
-	tsk->stack_canary = get_random_long();
+	tsk->stack_canary = get_random_canary();
 #endif
 
 	/*
-- 
2.9.3
