From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 11 Feb 2013 16:40:15 -0700
Subject: [PATCH V3 1/2] get_maintainer: allow keywords to match filenames
Message-ID: <1360626016-23332-1-git-send-email-swarren@wwwdotorg.org>
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

The value in $hash{$tvi} doesn't seem relevant, so I just assign 0.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
V3: New patch.

Joe, I'm not sure if you care where this gets merged; could it go through
arm-soc together with patch 2/2? A quick look at git history of the
script in linux-next indicates there won't be conflicts doing that.

 scripts/get_maintainer.pl |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index 18d4ab5..96cf92a 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -611,6 +611,10 @@ sub get_maintainers {
 				    $hash{$tvi} = $value_pd;
 				}
 			    }
+			} elsif ($type eq "K") {
+			    if ($file =~ m/$value/x) {
+				$hash{$tvi} = 0;
+			    }
 			}
 		    }
 		}
-- 
1.7.10.4
