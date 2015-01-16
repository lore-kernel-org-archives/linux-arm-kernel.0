From: will.deacon@arm.com (Will Deacon)
Date: Fri, 16 Jan 2015 13:52:14 +0000
Subject: [PATCH] arm64: uapi: expose our struct ucontext to the uapi headers
Message-ID: <1421416334-12588-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arm64 defines its own ucontext structure which is incompatible with the
struct defined (and exposed to userspace by) the asm-generic headers.

glibc carries its own struct definition that is compatible with the
arm64 definition, but we should expose our format in the uapi headers in
case other libraries want to make use of the ucontext pushed as part of
an arm64 sigframe.

This patch moves the arm64 asm/ucontext.h to the uapi headers, along
with the necessary #include of linux/types.h.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marcus Shawcroft <marcus.shawcroft@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---

I think we also need something similar for arch/arm/ unless we decide
that exposing the incorrect asm-generic header is harmless.

 arch/arm64/include/uapi/asm/Kbuild           | 1 +
 arch/arm64/include/{ => uapi}/asm/ucontext.h | 8 +++++---
 2 files changed, 6 insertions(+), 3 deletions(-)
 rename arch/arm64/include/{ => uapi}/asm/ucontext.h (88%)

diff --git a/arch/arm64/include/uapi/asm/Kbuild b/arch/arm64/include/uapi/asm/Kbuild
index 942376d37d22..825b0fe51c2b 100644
--- a/arch/arm64/include/uapi/asm/Kbuild
+++ b/arch/arm64/include/uapi/asm/Kbuild
@@ -18,4 +18,5 @@ header-y += siginfo.h
 header-y += signal.h
 header-y += stat.h
 header-y += statfs.h
+header-y += ucontext.h
 header-y += unistd.h
diff --git a/arch/arm64/include/asm/ucontext.h b/arch/arm64/include/uapi/asm/ucontext.h
similarity index 88%
rename from arch/arm64/include/asm/ucontext.h
rename to arch/arm64/include/uapi/asm/ucontext.h
index 42e04c877428..791de8e89e35 100644
--- a/arch/arm64/include/asm/ucontext.h
+++ b/arch/arm64/include/uapi/asm/ucontext.h
@@ -13,8 +13,10 @@
  * You should have received a copy of the GNU General Public License
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
-#ifndef __ASM_UCONTEXT_H
-#define __ASM_UCONTEXT_H
+#ifndef _UAPI__ASM_UCONTEXT_H
+#define _UAPI__ASM_UCONTEXT_H
+
+#include <linux/types.h>
 
 struct ucontext {
 	unsigned long	  uc_flags;
@@ -27,4 +29,4 @@ struct ucontext {
 	struct sigcontext uc_mcontext;
 };
 
-#endif /* __ASM_UCONTEXT_H */
+#endif /* _UAPI__ASM_UCONTEXT_H */
-- 
2.1.4
