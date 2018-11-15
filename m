From: akpm@linux-foundation.org (Andrew Morton)
Date: Thu, 15 Nov 2018 15:03:58 -0800
Subject: [PATCHv3 1/6] atomics: add common header generation files
In-Reply-To: <20180904104830.2975-2-mark.rutland@arm.com>
References: <20180904104830.2975-1-mark.rutland@arm.com>
 <20180904104830.2975-2-mark.rutland@arm.com>
Message-ID: <20181115150358.c5e816ded563af0643269c91@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue,  4 Sep 2018 11:48:25 +0100 Mark Rutland <mark.rutland@arm.com> wrote:

> To minimize repetition, to allow for future rework, and to ensure
> regularity of the various atomic APIs, we'd like to automatically
> generate (the bulk of) a number of headers related to atomics.
> 
> This patch adds the infrastructure to do so, leaving actual conversion
> of headers to subsequent patches. This infrastructure consists of:

My build broke.

scripts/atomic/check-atomics.sh: line 16: scripts/atomic/gen-atomic-instrumented.sh: Permission denied
scripts/atomic/check-atomics.sh: line 16: scripts/atomic/gen-atomic-long.sh: Permission denied
scripts/atomic/check-atomics.sh: line 16: scripts/atomic/gen-atomic-fallback.sh: Permission denied



From: Andrew Morton <akpm@linux-foundation.org>
Subject: scripts/atomic/check-atomics.sh: don't assume that scripts are executable

patch(1) doesn't set the x bit on files.  So if someone downloads and
applies patch-4.21.xz, their kernel won't build.  Fix that by executing
/bin/sh.

Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 scripts/atomic/check-atomics.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/scripts/atomic/check-atomics.sh~scripts-atomic-check-atomicssh-dont-assume-that-scripts-are-executable
+++ a/scripts/atomic/check-atomics.sh
@@ -13,7 +13,7 @@ gen-atomic-long.sh              asm-gene
 gen-atomic-fallback.sh          linux/atomic-fallback.h
 EOF
 while read script header; do
-	if ! (${ATOMICDIR}/${script} ${ATOMICTBL} | diff - ${LINUXDIR}/include/${header} > /dev/null); then
+	if ! (/bin/sh ${ATOMICDIR}/${script} ${ATOMICTBL} | diff - ${LINUXDIR}/include/${header} > /dev/null); then
 		printf "warning: include/${header} is out-of-date.\n"
 	fi
 done
_
