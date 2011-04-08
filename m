From: ratbert.chuang@gmail.com (Po-Yu Chuang)
Date: Fri,  8 Apr 2011 17:35:53 +0800
Subject: [PATCH RFC] util-linux: readprofile: don't stop parsing at __init_end
Message-ID: <1302255353-1622-1-git-send-email-ratbert.chuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Po-Yu Chuang <ratbert@faraday-tech.com>

Some architectures like ARM place __init_end before .text section.
If any function in .init section is hit while profiling, readprofile
stops at __init_end.  That means if we enable profiling at boot time,
the profiler probably hits init functions and readprofile does not
work well unless we reset profiling buffer with -r option.

Signed-off-by: Po-Yu Chuang <ratbert@faraday-tech.com>
---
 sys-utils/readprofile.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/sys-utils/readprofile.c b/sys-utils/readprofile.c
index 91ff329..174f9aa 100644
--- a/sys-utils/readprofile.c
+++ b/sys-utils/readprofile.c
@@ -323,8 +323,10 @@ main(int argc, char **argv) {
 			done = 1;
 		else {
 			/* ignore any LEADING (before a '[tT]' symbol is found)
-			   Absolute symbols */
-			if ((*mode == 'A' || *mode == '?') && total == 0)
+			   Absolute symbols and __init_end because some
+			   architectures place it before .text section */
+			if ((*mode == 'A' || *mode == '?')
+			    && (total == 0 || !strcmp(next_name, "__init_end")))
 				continue;
 			if (*mode != 'T' && *mode != 't' &&
 			    *mode != 'W' && *mode != 'w')
-- 
1.6.3.3
