From: james.hogan@imgtec.com (James Hogan)
Date: Fri, 2 May 2014 12:30:20 +0100
Subject: [PATCH] ARM: Fix non-uapi types.h export
Message-ID: <1399030220-13628-1-git-send-email-james.hogan@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The arch/arm/include/asm/types.h is being apparently unintentionally
exported in the kernel headers since commit 262576fffe42 (ARM: 7843/1:
drop asm/types.h from generic-y) which dropped the generic-y += types.h.
This happens because Makefile.headersinst still checks the old asm/
directory if the specified header doesn't exist in the uapi directory.

As far as I can tell the definitions in this file are intended only for
use in the kernel, so add back the generic-y += types.h so that the
generic asm/types.h is exported in kernel headers, but add it to the
uapi Kbuild file to make it clearer what its purpose is.

Also make the asm/types.h file include the generated <uapi/asm/types.h>
rather than <asm-generic/int-ll64.h>, so that the use of int-ll64.h
isn't duplicated between the asm-generic/types.h (for exported headers)
and asm/types.h (for the kernel build).

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: David Howells <dhowells@redhat.com>
---
AFAICT the previously exported asm/types.h seemed to include definitions
that changed the behaviour of <inttypes.h> (I could have misunderstood
though). I presume it wasn't intended to be exported in kernel headers?
The comment suggests that this patch would change / fix the behaviour of
userland code which includes the kernel headers and <inttypes.h>. I
don't know enough about it to be sure of that though.
---
 arch/arm/include/asm/types.h     | 2 +-
 arch/arm/include/uapi/asm/Kbuild | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/types.h b/arch/arm/include/asm/types.h
index a53cdb8f068c..d75f2d6b6fef 100644
--- a/arch/arm/include/asm/types.h
+++ b/arch/arm/include/asm/types.h
@@ -1,7 +1,7 @@
 #ifndef _ASM_TYPES_H
 #define _ASM_TYPES_H
 
-#include <asm-generic/int-ll64.h>
+#include <uapi/asm/types.h>
 
 /*
  * The C99 types uintXX_t that are usually defined in 'stdint.h' are not as
diff --git a/arch/arm/include/uapi/asm/Kbuild b/arch/arm/include/uapi/asm/Kbuild
index 70a1c9da30ca..4ffdc48cbf2c 100644
--- a/arch/arm/include/uapi/asm/Kbuild
+++ b/arch/arm/include/uapi/asm/Kbuild
@@ -17,3 +17,5 @@ header-y += stat.h
 header-y += statfs.h
 header-y += swab.h
 header-y += unistd.h
+
+generic-y += types.h
-- 
1.9.2
