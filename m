From: mst@redhat.com (Michael S. Tsirkin)
Date: Mon, 4 Jan 2016 13:36:53 +0200
Subject: [PATCH 1/3] checkpatch.pl: add missing memory barriers
In-Reply-To: <1451907395-15978-1-git-send-email-mst@redhat.com>
References: <1451907395-15978-1-git-send-email-mst@redhat.com>
Message-ID: <1451907395-15978-2-git-send-email-mst@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SMP-only barriers were missing in checkpatch.pl

Refactor code slightly to make adding more variants easier.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 scripts/checkpatch.pl | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 2b3c228..0245bbe 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5116,7 +5116,14 @@ sub process {
 			}
 		}
 # check for memory barriers without a comment.
-		if ($line =~ /\b(mb|rmb|wmb|read_barrier_depends|smp_mb|smp_rmb|smp_wmb|smp_read_barrier_depends)\(/) {
+
+		my @barriers = ('mb', 'rmb', 'wmb', 'read_barrier_depends');
+		my @smp_barriers = ('smp_store_release', 'smp_load_acquire', 'smp_store_mb');
+
+		@smp_barriers = (@smp_barriers, map {"smp_" . $_} @barriers);
+		my $all_barriers = join('|', (@barriers, @smp_barriers));
+
+		if ($line =~ /\b($all_barriers)\(/) {
 			if (!ctx_has_comment($first_line, $linenr)) {
 				WARN("MEMORY_BARRIER",
 				     "memory barrier without comment\n" . $herecurr);
-- 
MST
