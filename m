From: andreyknvl@google.com (Andrey Konovalov)
Date: Thu,  3 May 2018 16:15:42 +0200
Subject: [PATCH v2 4/6] mm, arm64: untag user addresses in mm/gup.c
In-Reply-To: <cover.1525356769.git.andreyknvl@google.com>
References: <cover.1525356769.git.andreyknvl@google.com>
Message-ID: <24ab244adc196fda8536cf2efb59cc654e1c234b.1525356769.git.andreyknvl@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mm/gup.c provides a kernel interface that accepts user addresses and
manipulates user pages directly (for example get_user_pages, that is used
by the futex syscall). Here we also need to handle the case of tagged user
pointers.

Add untagging to gup.c functions that use user pointers for vma lookup.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/gup.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/gup.c b/mm/gup.c
index 76af4cfeaf68..65a9566c96d3 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -647,6 +647,8 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 	if (!nr_pages)
 		return 0;
 
+	start = untagged_addr(start);
+
 	VM_BUG_ON(!!pages != !!(gup_flags & FOLL_GET));
 
 	/*
@@ -801,6 +803,8 @@ int fixup_user_fault(struct task_struct *tsk, struct mm_struct *mm,
 	struct vm_area_struct *vma;
 	int ret, major = 0;
 
+	address = untagged_addr(address);
+
 	if (unlocked)
 		fault_flags |= FAULT_FLAG_ALLOW_RETRY;
 
-- 
2.17.0.441.gb46fe60e1d-goog
