From: mst@redhat.com (Michael S. Tsirkin)
Date: Sun, 10 Jan 2016 21:30:38 +0200
Subject: [PATCH v3 1/3] checkpatch.pl: add missing memory barriers
In-Reply-To: <1452454200-8844-1-git-send-email-mst@redhat.com>
References: <1452454200-8844-1-git-send-email-mst@redhat.com>
Message-ID: <1452454200-8844-2-git-send-email-mst@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SMP-only barriers were missing in checkpatch.pl

Refactor code slightly to make adding more variants easier.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 scripts/checkpatch.pl | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 2b3c228..1c01b7d 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5116,7 +5116,27 @@ sub process {
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
+		my $smp_barrier_stems = qr{
+			mb__before_atomic|
+			mb__after_atomic|
+			store_release|
+			load_acquire|
+			store_mb|
+			(?:$barriers)
+		}x;
+		my $all_barriers = qr{
+			$barriers|
+			smp_(?:$smp_barrier_stems)
+		}x;
+
+		if ($line =~ /\b(?:$all_barriers)\s*\(/) {
 			if (!ctx_has_comment($first_line, $linenr)) {
 				WARN("MEMORY_BARRIER",
 				     "memory barrier without comment\n" . $herecurr);
-- 
MST
