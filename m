From: mst@redhat.com (Michael S. Tsirkin)
Date: Mon, 4 Jan 2016 13:37:08 +0200
Subject: [PATCH 3/3] checkpatch: add virt barriers
In-Reply-To: <1451907395-15978-1-git-send-email-mst@redhat.com>
References: <1451907395-15978-1-git-send-email-mst@redhat.com>
Message-ID: <1451907395-15978-4-git-send-email-mst@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add virt_ barriers to list of barriers to check for
presence of a comment.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 scripts/checkpatch.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index e3f9ad9..5fb6ef7 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5121,7 +5121,8 @@ sub process {
 		my @smp_barriers = ('smp_store_release', 'smp_load_acquire', 'smp_store_mb');
 
 		@smp_barriers = (@smp_barriers, map {"smp_" . $_} @barriers);
-		my $all_barriers = join('|', (@barriers, @smp_barriers));
+		my @virt_barriers = map {my $l = $_; $l =~ s/smp_/virt_/; $l} @smp_barriers;
+		my $all_barriers = join('|', (@barriers, @smp_barriers, @virt_barriers));
 
 		if ($line =~ /\b($all_barriers)\(/) {
 			if (!ctx_has_comment($first_line, $linenr)) {
-- 
MST
