From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue,  3 Nov 2009 14:42:12 +0000
Subject: [PATCH 9/9] S3C64XX: Redo voltage ranges for cpufreq
In-Reply-To: <1257259332-7867-8-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1257259332-7867-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1257259332-7867-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1257259332-7867-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1257259332-7867-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1257259332-7867-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1257259332-7867-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1257259332-7867-7-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1257259332-7867-8-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <1257259332-7867-9-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The documentation for the S3C6410 CPU voltage scaling is rather
unclear, with omitted values for several speed settings. Originally
the code was using only quoted values, resulting in some fairly odd
settings. The S3C6410 is also unusual in that the both the maximum
and minimum voltages quoted scale as the frequency rises, rather
than just the minimum voltage.

Clean this up a bit by always using the specified typical settings
as the minimum voltage (ignoring any specified minimum voltage) in
order to avoid running near the edge of the processor capabilities.
Also use the next quoted maximum voltages rather than the typical
voltages where no maximum voltage is quoted, allowing operation on
a greater range of systems.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/plat-s3c64xx/cpufreq.c |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/arm/plat-s3c64xx/cpufreq.c b/arch/arm/plat-s3c64xx/cpufreq.c
index 61276bf..74c0e83 100644
--- a/arch/arm/plat-s3c64xx/cpufreq.c
+++ b/arch/arm/plat-s3c64xx/cpufreq.c
@@ -28,11 +28,10 @@ struct s3c64xx_dvfs {
 };
 
 static struct s3c64xx_dvfs s3c64xx_dvfs_table[] = {
-	[0] = { 1000000, 1000000 },
-	[1] = { 1000000, 1050000 },
-	[2] = { 1050000, 1100000 },
-	[3] = { 1050000, 1150000 },
-	[4] = { 1250000, 1350000 },
+	[0] = { 1000000, 1150000 },
+	[1] = { 1050000, 1150000 },
+	[2] = { 1100000, 1150000 },
+	[3] = { 1200000, 1350000 },
 };
 
 static struct cpufreq_frequency_table s3c64xx_freq_table[] = {
@@ -42,9 +41,9 @@ static struct cpufreq_frequency_table s3c64xx_freq_table[] = {
 	{ 1, 266000 },
 	{ 2, 333000 },
 	{ 2, 400000 },
-	{ 3, 532000 },
-	{ 3, 533000 },
-	{ 4, 667000 },
+	{ 2, 532000 },
+	{ 2, 533000 },
+	{ 3, 667000 },
 	{ 0, CPUFREQ_TABLE_END },
 };
 #endif
-- 
1.6.5.2
