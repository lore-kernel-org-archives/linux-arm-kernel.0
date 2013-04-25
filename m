From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 25 Apr 2013 19:28:57 +0200
Subject: [PATCH 14/21] cpufreq: pxa2xx: initialize variables
In-Reply-To: <1366910944-3033663-1-git-send-email-arnd@arndb.de>
References: <1366910944-3033663-1-git-send-email-arnd@arndb.de>
Message-ID: <1366910944-3033663-15-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gcc-3.8 correctly found that the variables set by find_freq_tables()
are not initialized if this function is called on something other
than a pxa2xx or pxa3xx:

pxa2xx-cpufreq.c: In function 'pxa_verify_policy':
pxa2xx-cpufreq.c:272:6: warning: 'pxa_freqs_table' may be used uninitialized in this function [-Wmaybe-uninitialized]
pxa2xx-cpufreq.c: In function 'pxa_set_target':
pxa2xx-cpufreq.c:345:23: warning: 'pxa_freq_settings' may be used uninitialized in this function [-Wmaybe-uninitialized]

Rather than adding a bogus initialization that would let us
get a little further before crashing, add an explicit BUG().
We know that this code is designed to run on only these cpus,
so this will fix the build warning and give a more helpful
diagnostic if the code ever changes to run on other machines.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/pxa2xx-cpufreq.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/pxa2xx-cpufreq.c b/drivers/cpufreq/pxa2xx-cpufreq.c
index fe4c55b..9e5bc8e 100644
--- a/drivers/cpufreq/pxa2xx-cpufreq.c
+++ b/drivers/cpufreq/pxa2xx-cpufreq.c
@@ -221,10 +221,11 @@ static void find_freq_tables(struct cpufreq_frequency_table **freq_table,
 			*pxa_freqs = pxa255_turbo_freqs;
 			*freq_table = pxa255_turbo_freq_table;
 		}
-	}
-	if (cpu_is_pxa27x()) {
+	} else if (cpu_is_pxa27x()) {
 		*pxa_freqs = pxa27x_freqs;
 		*freq_table = pxa27x_freq_table;
+	} else {
+		BUG();
 	}
 }
 
-- 
1.8.1.2
