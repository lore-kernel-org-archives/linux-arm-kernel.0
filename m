From: mst@redhat.com (Michael S. Tsirkin)
Date: Sun, 10 Jan 2016 13:56:59 +0200
Subject: [PATCH v2 1/3] checkpatch.pl: add missing memory barriers
In-Reply-To: <1452427000-4520-1-git-send-email-mst@redhat.com>
References: <1452427000-4520-1-git-send-email-mst@redhat.com>
Message-ID: <1452427000-4520-2-git-send-email-mst@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SMP-only barriers were missing in checkpatch.pl

Refactor code slightly to make adding more variants easier.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 scripts/checkpatch.pl | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 2b3c228..97b8b62 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5116,7 +5116,25 @@ sub process {
 			}
 		}
 # check for memory barriers without a comment.
-		if ($line =~ /\b(mb|rmb|wmb|read_barrier_depends|smp_mb|smp_rmb|smp_wmb|smp_read_barrier_depends)\(/) {
+
+		my $barriers = qr{
+			mb|
+			rmb|
+			wmb|
+			read_barrier_depends
+		}x;
+		my $smp_barriers = qr{
+			store_release|
+			load_acquire|
+			store_mb|
+			($barriers)
+		}x;
+		my $all_barriers = qr{
+			$barriers|
+			smp_($smp_barriers)
+		}x;
+
+		if ($line =~ /\b($all_barriers)\s*\(/) {
 			if (!ctx_has_comment($first_line, $linenr)) {
 				WARN("MEMORY_BARRIER",
 				     "memory barrier without comment\n" . $herecurr);
-- 
MST
