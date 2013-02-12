From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 12 Feb 2013 12:39:34 -0700
Subject: [PATCH V5] get_maintainer: allow keywords to match filenames
Message-ID: <1360697974-23257-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Allow K: entries in MAINTAINERS to match directly against filenames;
either those extracted from patch +++ or --- lines, or those specified
on the command-line using the -f option.

This potentially allows fewer lines in a MAINTAINERS entry, if all the
relevant files are scattered throughout the whole kernel tree, yet
contain some common keyword. An example would be using an ARM SoC name
as the keyword to catch all related drivers.

I don't think setting exact_pattern_match_hash would be appropriate here;
at least for intended Tegra use case, this feature is to ensure that all
Tegra-related driver changes get Cc'd to the Tegra mailing list. Setting
exact_pattern_match_hash would prevent git history parsing for e.g. S-o-b
tags, which still seems like it would be useful. Hence, this flag isn't
set.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
V5: Add back "file content" into list of things affected by K: entries.
V4:
* Updated documentation at the start of MAINTAINERS to mention filename
  matching.
* s/"/'/ in if check for type 'K'.
---
 MAINTAINERS               |    9 +++++----
 scripts/get_maintainer.pl |    4 ++++
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1d0651e..ce35ee2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -97,12 +97,13 @@ Descriptions of section entries:
 	   X:	net/ipv6/
 	   matches all files in and below net excluding net/ipv6/
 	K: Keyword perl extended regex pattern to match content in a
-	   patch or file.  For instance:
+	   patch or file, or an affected filename.  For instance:
 	   K: of_get_profile
-	      matches patches or files that contain "of_get_profile"
+	      matches patch or file content, or filenames, that contain
+	      "of_get_profile"
 	   K: \b(printk|pr_(info|err))\b
-	      matches patches or files that contain one or more of the words
-	      printk, pr_info or pr_err
+	      matches patch or file content, or filenames, that contain one or
+	      more of the words printk, pr_info or pr_err
 	   One regex pattern per line.  Multiple K: lines acceptable.
 
 Note: For the hard of thinking, this list is meant to remain in alphabetical
diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index 18d4ab5..ce4cc83 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -611,6 +611,10 @@ sub get_maintainers {
 				    $hash{$tvi} = $value_pd;
 				}
 			    }
+			} elsif ($type eq 'K') {
+			    if ($file =~ m/$value/x) {
+				$hash{$tvi} = 0;
+			    }
 			}
 		    }
 		}
-- 
1.7.10.4
