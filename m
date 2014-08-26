From: will.deacon@arm.com (Will Deacon)
Date: Tue, 26 Aug 2014 15:13:29 +0100
Subject: [PATCH 10/11] arm64: ptrace: fix compat reg getter/setter return
 values
In-Reply-To: <1409062410-25891-1-git-send-email-will.deacon@arm.com>
References: <1409062410-25891-1-git-send-email-will.deacon@arm.com>
Message-ID: <1409062410-25891-11-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

copy_{to,from}_user return the number of bytes remaining on failure, not
an error code.

This patch returns -EFAULT when the copy operation didn't complete,
rather than expose the number of bytes not copied directly to userspace.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/ptrace.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 2ac998878001..fe63ac5e9bf5 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -663,8 +663,10 @@ static int compat_gpr_get(struct task_struct *target,
 			kbuf += sizeof(reg);
 		} else {
 			ret = copy_to_user(ubuf, &reg, sizeof(reg));
-			if (ret)
+			if (ret) {
+				ret = -EFAULT;
 				break;
+			}
 
 			ubuf += sizeof(reg);
 		}
@@ -702,8 +704,10 @@ static int compat_gpr_set(struct task_struct *target,
 			kbuf += sizeof(reg);
 		} else {
 			ret = copy_from_user(&reg, ubuf, sizeof(reg));
-			if (ret)
-				return ret;
+			if (ret) {
+				ret = -EFAULT;
+				break;
+			}
 
 			ubuf += sizeof(reg);
 		}
-- 
2.1.0.rc1
