From: akhilesh.lxr@gmail.com (Akhilesh Kumar)
Date: Fri, 03 Aug 2012 22:05:38 -0000
Subject: [Memory leak]: memory leak in sys_oabi_semtimedo
Message-ID: <CADArhcBEjbv-NUUvGJ5aDBe2_9JpKDt=2M0av9Ud8dpx9MwtLw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

I found some memory leak arch/arm/kernel/sys_oabi-compat.c file
please review below patch for main line and share ur comments,

Thanks,
Akhilesh




>From 86acd014680ae7127cb504387bee1824669a4744 Mon Sep 17 00:00:00 2001
From: Akhilesh Kumar <akhilesh.lxr@gmail.com>
Date: SAT, 4 Aug 2012 03:15:16 +0530
Subject: [Memory leak]: memory leak in sys_oabi_semtimedo

if (err) {
         err = -EFAULT;
} // return without free the memory

Signed-off-by: Akhilesh Kumar <akhilesh.lxr@gmail.com>
---
 arch/arm/kernel/sys_oabi-compat.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/sys_oabi-compat.c
b/arch/arm/kernel/sys_oabi-compat.c
index 3e94811..e34f953 100644
--- a/arch/arm/kernel/sys_oabi-compat.c
+++ b/arch/arm/kernel/sys_oabi-compat.c
@@ -329,6 +329,7 @@ asmlinkage long sys_oabi_semtimedop(int semid,
  timeout = &local_timeout;
  }
  if (err) {
+ kfree(sops);
  err = -EFAULT;
  } else {
  mm_segment_t fs = get_fs();
-- 
1.7.8.4
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120803/ba3a8e47/attachment.html>
