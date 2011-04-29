From: drosenberg@vsecurity.com (Dan Rosenberg)
Date: Fri, 29 Apr 2011 10:48:07 -0400
Subject: [PATCH] arm: prevent heap corruption in OABI semtimedop
Message-ID: <1304088487.28093.7.camel@dan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When CONFIG_OABI_COMPAT is set, the wrapper for semtimedop does not
bound the nsops argument.  A sufficiently large value will cause an
integer overflow in allocation size, followed by copying too much data
into the allocated buffer.  Fix this by restricting nsops to SEMOPM.
Untested.

Signed-off-by: Dan Rosenberg <drosenberg@vsecurity.com>
Cc: stable at kernel.org
---
 arch/arm/kernel/sys_oabi-compat.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/sys_oabi-compat.c b/arch/arm/kernel/sys_oabi-compat.c
index 4ad8da1..af0aaeb 100644
--- a/arch/arm/kernel/sys_oabi-compat.c
+++ b/arch/arm/kernel/sys_oabi-compat.c
@@ -311,7 +311,7 @@ asmlinkage long sys_oabi_semtimedop(int semid,
 	long err;
 	int i;
 
-	if (nsops < 1)
+	if (nsops < 1 || nsops > SEMOPM)
 		return -EINVAL;
 	sops = kmalloc(sizeof(*sops) * nsops, GFP_KERNEL);
 	if (!sops)
