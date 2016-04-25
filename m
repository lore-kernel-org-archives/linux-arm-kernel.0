From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Apr 2016 17:35:30 +0200
Subject: [PATCH 4/5] gcov: disable tree-loop-im to reduce stack usage
In-Reply-To: <1461598531-2190169-1-git-send-email-arnd@arndb.de>
References: <1461598531-2190169-1-git-send-email-arnd@arndb.de>
Message-ID: <1461598531-2190169-5-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enabling CONFIG_GCOV_PROFILE_ALL produces us a lot of warnings like

lib/lz4/lz4hc_compress.c: In function 'lz4_compresshcctx':
lib/lz4/lz4hc_compress.c:514:1: warning: the frame size of 1504 bytes is larger than 1024 bytes [-Wframe-larger-than=]

After some investigation, I found that this behavior started with gcc-4.9,
and opened https://gcc.gnu.org/bugzilla/show_bug.cgi?id=69702.
A suggested workaround for it is to use the -fno-tree-loop-im
flag that turns off one of the optimization stages in gcc, so the
code runs a little slower but does not use excessive amounts
of stack.

We could make this conditional on the gcc version, but I could not
find an easy way to do this in Kbuild and the benefit would be
fairly small, given that most of the gcc version in production are
affected now.

I'm marking this for 'stable' backports because it addresses a bug
with code generation in gcc that exists in all kernel versions
with the affected gcc releases.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Peter Oberparleiter <oberpar@linux.vnet.ibm.com>
Cc: stable at vger.kernel.org
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index e595d1f626b8..d74b38e70d6f 100644
--- a/Makefile
+++ b/Makefile
@@ -364,7 +364,7 @@ AFLAGS_MODULE   =
 LDFLAGS_MODULE  =
 CFLAGS_KERNEL	=
 AFLAGS_KERNEL	=
-CFLAGS_GCOV	= -fprofile-arcs -ftest-coverage
+CFLAGS_GCOV	= -fprofile-arcs -ftest-coverage -fno-tree-loop-im
 CFLAGS_KCOV	= -fsanitize-coverage=trace-pc
 
 
-- 
2.7.0
