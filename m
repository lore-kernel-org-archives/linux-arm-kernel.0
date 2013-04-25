From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 25 Apr 2013 19:28:58 +0200
Subject: [PATCH 15/21] thermal: cooling: avoid uninitialied used gcc warning
In-Reply-To: <1366910944-3033663-1-git-send-email-arnd@arndb.de>
References: <1366910944-3033663-1-git-send-email-arnd@arndb.de>
Message-ID: <1366910944-3033663-16-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The newly rewritten get_property() function causes a bogus warning
from gcc-3.8, which cannot figure out that "level" is always
initialized at the point where it gets evaluated:

drivers/thermal/cpu_cooling.c: In function 'get_property':
drivers/thermal/cpu_cooling.c:189:37: warning: 'level' may be used uninitialized in this function [-Wmaybe-uninitialized]
   if (property == GET_FREQ && level == j) {
                                     ^

Slightly rearranging the code makes this more obvious and
avoids the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Amit Daniel kachhap <amit.daniel@samsung.com>
---
 drivers/thermal/cpu_cooling.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 768b508..34878e6 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -165,10 +165,6 @@ static int get_property(unsigned int cpu, unsigned long input,
 		return 0;
 	}
 
-	if (property == GET_FREQ)
-		level = descend ? input : (max_level - input -1);
-
-
 	for (i = 0, j = 0; table[i].frequency != CPUFREQ_TABLE_END; i++) {
 		/* ignore invalid entry */
 		if (table[i].frequency == CPUFREQ_ENTRY_INVALID)
@@ -186,10 +182,15 @@ static int get_property(unsigned int cpu, unsigned long input,
 			*output = descend ? j : (max_level - j - 1);
 			return 0;
 		}
-		if (property == GET_FREQ && level == j) {
-			/* get frequency by level */
-			*output = freq;
-			return 0;
+
+		if (property == GET_FREQ) {
+			level = descend ? input : (max_level - input -1);
+
+			if (level == j) {
+				/* get frequency by level */
+				*output = freq;
+				return 0;
+			}
 		}
 		j++;
 	}
-- 
1.8.1.2
