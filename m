From: joe@perches.com (Joe Perches)
Date: Wed, 28 Oct 2015 09:41:46 -0700
Subject: [PATCH] get_maintainer: Add subsystem to reviewer output
In-Reply-To: <5630CA06.7050503@samsung.com>
References: <1445960557-24328-1-git-send-email-lee.jones@linaro.org>
 <20151027172428.GB21070@earth> <20151027181555.GE5828@x1>
 <1445971482.2757.27.camel@perches.com>
 <CAJKOXPc_w2Dc8LvkCu_d+kjZZmYScXboQrpNWdicT2yfL_5D7Q@mail.gmail.com>
 <20151028082446.GF5828@x1> <56309419.4060908@samsung.com>
 <20151028093907.GP4931@pengutronix.de> <20151028095524.GP5828@x1>
 <5630CA06.7050503@samsung.com>
Message-ID: <1446050506.2757.109.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reviewer output currently does not include the subsystem
that matched.  Add it.

Miscellanea:

o Add a get_subsystem_name routine to centralize this

Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/get_maintainer.pl | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index 98bae86..d641541 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -970,20 +970,29 @@ sub find_ending_index {
     return $index;
 }
 
-sub get_maintainer_role {
+sub get_subsystem_name {
     my ($index) = @_;
 
-    my $i;
     my $start = find_starting_index($index);
-    my $end = find_ending_index($index);
 
-    my $role = "unknown";
     my $subsystem = $typevalue[$start];
     if ($output_section_maxlen && length($subsystem) > $output_section_maxlen) {
 	$subsystem = substr($subsystem, 0, $output_section_maxlen - 3);
 	$subsystem =~ s/\s*$//;
 	$subsystem = $subsystem . "...";
     }
+    return $subsystem;
+}
+
+sub get_maintainer_role {
+    my ($index) = @_;
+
+    my $i;
+    my $start = find_starting_index($index);
+    my $end = find_ending_index($index);
+
+    my $role = "unknown";
+    my $subsystem = get_subsystem_name($index);
 
     for ($i = $start + 1; $i < $end; $i++) {
 	my $tv = $typevalue[$i];
@@ -1017,16 +1026,7 @@ sub get_maintainer_role {
 sub get_list_role {
     my ($index) = @_;
 
-    my $i;
-    my $start = find_starting_index($index);
-    my $end = find_ending_index($index);
-
-    my $subsystem = $typevalue[$start];
-    if ($output_section_maxlen && length($subsystem) > $output_section_maxlen) {
-	$subsystem = substr($subsystem, 0, $output_section_maxlen - 3);
-	$subsystem =~ s/\s*$//;
-	$subsystem = $subsystem . "...";
-    }
+    my $subsystem = get_subsystem_name($index);
 
     if ($subsystem eq "THE REST") {
 	$subsystem = "";
@@ -1114,7 +1114,8 @@ sub add_categories {
 		    }
 		}
 		if ($email_reviewer) {
-		    push_email_addresses($pvalue, 'reviewer');
+		    my $subsystem = get_subsystem_name($i);
+		    push_email_addresses($pvalue, "reviewer:$subsystem");
 		}
 	    } elsif ($ptype eq "T") {
 		push(@scm, $pvalue);
