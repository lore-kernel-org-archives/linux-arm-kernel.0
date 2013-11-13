From: tom.leiming@gmail.com (Ming Lei)
Date: Wed, 13 Nov 2013 19:15:51 +0800
Subject: [PATCH 2/2] scripts/link-vmlinux.sh: only filter kernel symbols for
 arm
In-Reply-To: <1384341351-4110-1-git-send-email-tom.leiming@gmail.com>
References: <1384341351-4110-1-git-send-email-tom.leiming@gmail.com>
Message-ID: <1384341351-4110-3-git-send-email-tom.leiming@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Actually CONFIG_PAGE_OFFSET isn't same with PAGE_OFFSET, so
it isn't easy to figue out PAGE_OFFSET defined in header
file from scripts.

Because CONFIG_PAGE_OFFSET may not be defined in some ARCHs(
64bit ARCH), or defined as bogus value in !MMU case, so
this patch only applys the filter on ARM when CONFIG_PAGE_OFFSET
is defined as the original problem is only on ARM.

Cc: <stable@vger.kernel.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Singed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 scripts/link-vmlinux.sh |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 32b10f5..2dcb377 100644
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -82,7 +82,9 @@ kallsyms()
 		kallsymopt="${kallsymopt} --all-symbols"
 	fi
 
-	kallsymopt="${kallsymopt} --page-offset=$CONFIG_PAGE_OFFSET"
+	if [ -n "${CONFIG_ARM}" ] && [ -n "${CONFIG_PAGE_OFFSET}" ]; then
+		kallsymopt="${kallsymopt} --page-offset=$CONFIG_PAGE_OFFSET"
+	fi
 
 	local aflags="${KBUILD_AFLAGS} ${KBUILD_AFLAGS_KERNEL}               \
 		      ${NOSTDINC_FLAGS} ${LINUXINCLUDE} ${KBUILD_CPPFLAGS}"
-- 
1.7.9.5
