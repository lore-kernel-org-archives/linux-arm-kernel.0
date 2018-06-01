From: mark.rutland@arm.com (Mark Rutland)
Date: Fri,  1 Jun 2018 12:24:35 +0100
Subject: [PATCHv2 13/19] kernel: add ksys_personality()
In-Reply-To: <20180601112441.37810-1-mark.rutland@arm.com>
References: <20180601112441.37810-1-mark.rutland@arm.com>
Message-ID: <20180601112441.37810-14-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using this helper allows us to avoid the in-kernel call to the
sys_personality() syscall. The ksys_ prefix denotes that this function
is meant as a drop-in replacement for the syscall. In particular, it
uses the same calling convention as sys_personality().

Since ksys_personality is trivial, it is implemented directly in
<linux/syscalls.h>, as we do for ksys_close() and friends.

This helper is necessary to enable conversion of arm64's syscall
handling to use pt_regs wrappers.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Dave Martin <dave.martin@arm.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
---
 include/linux/syscalls.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 70fcda1a9049..652e166deb64 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -79,6 +79,7 @@ union bpf_attr;
 #include <linux/unistd.h>
 #include <linux/quota.h>
 #include <linux/key.h>
+#include <linux/personality.h>
 #include <trace/syscall.h>
 
 #ifdef CONFIG_ARCH_HAS_SYSCALL_WRAPPER
@@ -1268,4 +1269,14 @@ static inline long ksys_truncate(const char __user *pathname, loff_t length)
 	return do_sys_truncate(pathname, length);
 }
 
+static inline unsigned int ksys_personality(unsigned int personality)
+{
+	unsigned int old = current->personality;
+
+	if (personality != 0xffffffff)
+		set_personality(personality);
+
+	return old;
+}
+
 #endif
-- 
2.11.0
