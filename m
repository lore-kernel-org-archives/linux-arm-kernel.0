From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 17 Feb 2017 12:32:49 +0000
Subject: [BOOTWRAPPER PATCH 1/3] FDT.pm: add helper to get untranslated reg
In-Reply-To: <1487334771-25789-1-git-send-email-mark.rutland@arm.com>
References: <1487334771-25789-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1487334771-25789-2-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In some cases, we'll want to parse a reg property that cannot be
translated, e.g. for cpu nodes. Add a helper to extract the reg without
attempting translation, factoring this logic out of
Node::get_translated_reg().

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 FDT.pm | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/FDT.pm b/FDT.pm
index b814ef8..f498f09 100755
--- a/FDT.pm
+++ b/FDT.pm
@@ -348,7 +348,7 @@ sub translate_address
 	return undef;
 }
 
-sub get_translated_reg
+sub get_untranslated_reg
 {
 	my $self = shift;
 	my $idx = shift;
@@ -361,7 +361,18 @@ sub get_translated_reg
 
 	return undef if ($off + $ac + $sc > $reg->num_cells());
 
-	my ($addr, $size) = $reg->read_cell_list($off, [$ac, $sc]);
+	return $reg->read_cell_list($off, [$ac, $sc]);
+}
+
+sub get_translated_reg
+{
+	my $self = shift;
+	my $idx = shift;
+	my $parent = $self->{parent};
+
+	my ($addr, $size) = $self->get_untranslated_reg($idx);
+
+	return undef if (not defined($addr) && defined($size));
 
 	for (my $parent = $self->{parent}; $parent; $parent = $parent->{parent}) {
 		last if (not defined($addr));
-- 
1.9.1
