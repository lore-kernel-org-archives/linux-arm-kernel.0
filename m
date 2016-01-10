From: mst@redhat.com (Michael S. Tsirkin)
Date: Sun, 10 Jan 2016 21:30:49 +0200
Subject: [PATCH v3 2/3] checkpatch: check for __smp outside barrier.h
In-Reply-To: <1452454200-8844-1-git-send-email-mst@redhat.com>
References: <1452454200-8844-1-git-send-email-mst@redhat.com>
Message-ID: <1452454200-8844-3-git-send-email-mst@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduction of __smp barriers cleans up a bunch of duplicate code, but
it gives people an additional handle onto a "new" set of barriers - just
because they're prefixed with __* unfortunately doesn't stop anyone from
using it (as happened with other arch stuff before.)

Add a checkpatch test so it will trigger a warning.

Reported-by: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 scripts/checkpatch.pl | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 1c01b7d..15cfca4 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5143,6 +5143,16 @@ sub process {
 			}
 		}
 
+		my $underscore_smp_barriers = qr{__smp_(?:$smp_barrier_stems)}x;
+
+		if ($realfile !~ m@^include/asm-generic/@ &&
+		    $realfile !~ m@/barrier\.h$@ &&
+		    $line =~ m/\b(?:$underscore_smp_barriers)\s*\(/ &&
+		    $line !~ m/^.\s*\#\s*define\s+(?:$underscore_smp_barriers)\s*\(/) {
+			WARN("MEMORY_BARRIER",
+			     "__smp memory barriers shouldn't be used outside barrier.h and asm-generic\n" . $herecurr);
+		}
+
 # check for waitqueue_active without a comment.
 		if ($line =~ /\bwaitqueue_active\s*\(/) {
 			if (!ctx_has_comment($first_line, $linenr)) {
-- 
MST
