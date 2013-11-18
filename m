From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 18 Nov 2013 21:21:05 +0000
Subject: [RFC PATCH V3 1/2] scripts: dtc: build fdtget for extracting
 properties from dtbs
In-Reply-To: <cover.1384809305.git.jason@lakedaemon.net>
References: <1384201760-16785-1-git-send-email-jason@lakedaemon.net>
 <cover.1384809305.git.jason@lakedaemon.net>
Message-ID: <55bef0830d336fc1df24e4cbf96822acc70c8f7e.1384809305.git.jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order for 'make dtbs_install' to be maintainable, we need a reliable
way to determine the board compatible string for a given dtb.  fdtget
does that easily as written, but currently isn't built by the kernel.

Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
changes since v2:
 - switch from modifying dtc to building fdtget

changes since v1:
 - made patch against in-tree dtc code to facilitate testing
 - dtc prints compatible string to stdout now, instead of creating symlink
    - should be more flexible for end-users

 scripts/dtc/.gitignore |  2 +-
 scripts/dtc/Makefile   | 10 +++++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/scripts/dtc/.gitignore b/scripts/dtc/.gitignore
index 095acb49a374..80f6b50fdf77 100644
--- a/scripts/dtc/.gitignore
+++ b/scripts/dtc/.gitignore
@@ -2,4 +2,4 @@ dtc
 dtc-lexer.lex.c
 dtc-parser.tab.c
 dtc-parser.tab.h
-
+fdtget
diff --git a/scripts/dtc/Makefile b/scripts/dtc/Makefile
index 2a48022c41e7..021522cb76f2 100644
--- a/scripts/dtc/Makefile
+++ b/scripts/dtc/Makefile
@@ -1,12 +1,16 @@
 # scripts/dtc makefile
 
-hostprogs-y	:= dtc
+hostprogs-y	:= dtc fdtget
 always		:= $(hostprogs-y)
 
 dtc-objs	:= dtc.o flattree.o fstree.o data.o livetree.o treesource.o \
 		   srcpos.o checks.o util.o
 dtc-objs	+= dtc-lexer.lex.o dtc-parser.tab.o
 
+include $(src)/libfdt/Makefile.libfdt
+
+fdtget-objs	:= fdtget.o util.o $(patsubst %, libfdt/%, $(LIBFDT_OBJS))
+
 # Source files need to get at the userspace version of libfdt_env.h to compile
 
 HOSTCFLAGS_DTC := -I$(src) -I$(src)/libfdt
@@ -14,6 +18,7 @@ HOSTCFLAGS_DTC := -I$(src) -I$(src)/libfdt
 HOSTCFLAGS_checks.o := $(HOSTCFLAGS_DTC)
 HOSTCFLAGS_data.o := $(HOSTCFLAGS_DTC)
 HOSTCFLAGS_dtc.o := $(HOSTCFLAGS_DTC)
+HOSTCFLAGS_fdtget.o := $(HOSTCFLAGS_DTC)
 HOSTCFLAGS_flattree.o := $(HOSTCFLAGS_DTC)
 HOSTCFLAGS_fstree.o := $(HOSTCFLAGS_DTC)
 HOSTCFLAGS_livetree.o := $(HOSTCFLAGS_DTC)
@@ -21,6 +26,9 @@ HOSTCFLAGS_srcpos.o := $(HOSTCFLAGS_DTC)
 HOSTCFLAGS_treesource.o := $(HOSTCFLAGS_DTC)
 HOSTCFLAGS_util.o := $(HOSTCFLAGS_DTC)
 
+$(foreach file, $(LIBFDT_OBJS), \
+	$(eval HOSTCFLAGS_$(file) = -I$(src)/libfdt))
+
 HOSTCFLAGS_dtc-lexer.lex.o := $(HOSTCFLAGS_DTC)
 HOSTCFLAGS_dtc-parser.tab.o := $(HOSTCFLAGS_DTC)
 
-- 
1.8.4.3
