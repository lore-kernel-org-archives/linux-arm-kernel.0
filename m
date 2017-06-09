From: arnd@arndb.de (Arnd Bergmann)
Date: Fri,  9 Jun 2017 12:20:27 +0200
Subject: [PATCH] ARM: davinci: don't mark vpif_input structures as 'const'
Message-ID: <20170609102131.2836298-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A change to the platform data definitions caused a warning in the board code:

arch/arm/mach-davinci/board-dm646x-evm.c:680:13: error: initialization discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
arch/arm/mach-davinci/board-dm646x-evm.c:690:13: error: initialization discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]

This is a bit unfortunate, since we generally like structure definitions to
be const, but as this is legacy code, the easiest way out is still to
remove the 'const' annotation here.

Fixes: 4a5f8ae50b66 ("[media] davinci: vpif_capture: get subdevs from DT when available")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-davinci/board-da850-evm.c  | 4 ++--
 arch/arm/mach-davinci/board-dm646x-evm.c | 4 ++--
 arch/arm/mach-davinci/pdata-quirks.c     | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index b5625d009288..e568c8c6f69c 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -1166,7 +1166,7 @@ static struct tvp514x_platform_data tvp5146_pdata = {
 
 #define TVP514X_STD_ALL (V4L2_STD_NTSC | V4L2_STD_PAL)
 
-static const struct vpif_input da850_ch0_inputs[] = {
+static struct vpif_input da850_ch0_inputs[] = {
 	{
 		.input = {
 			.index = 0,
@@ -1181,7 +1181,7 @@ static const struct vpif_input da850_ch0_inputs[] = {
 	},
 };
 
-static const struct vpif_input da850_ch1_inputs[] = {
+static struct vpif_input da850_ch1_inputs[] = {
 	{
 		.input = {
 			.index = 0,
diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index ca69d0b96a4f..1d76e7480a42 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -641,7 +641,7 @@ static struct vpif_subdev_info vpif_capture_sdev_info[] = {
 	},
 };
 
-static const struct vpif_input dm6467_ch0_inputs[] = {
+static struct vpif_input dm6467_ch0_inputs[] = {
 	{
 		.input = {
 			.index = 0,
@@ -656,7 +656,7 @@ static const struct vpif_input dm6467_ch0_inputs[] = {
 	},
 };
 
-static const struct vpif_input dm6467_ch1_inputs[] = {
+static struct vpif_input dm6467_ch1_inputs[] = {
        {
 		.input = {
 			.index = 0,
diff --git a/arch/arm/mach-davinci/pdata-quirks.c b/arch/arm/mach-davinci/pdata-quirks.c
index 329f5402ad1d..4858b1cdf31b 100644
--- a/arch/arm/mach-davinci/pdata-quirks.c
+++ b/arch/arm/mach-davinci/pdata-quirks.c
@@ -33,7 +33,7 @@ static struct tvp514x_platform_data tvp5146_pdata = {
 
 #define TVP514X_STD_ALL (V4L2_STD_NTSC | V4L2_STD_PAL)
 
-static const struct vpif_input da850_ch0_inputs[] = {
+static struct vpif_input da850_ch0_inputs[] = {
 	{
 		.input = {
 			.index = 0,
@@ -48,7 +48,7 @@ static const struct vpif_input da850_ch0_inputs[] = {
 	},
 };
 
-static const struct vpif_input da850_ch1_inputs[] = {
+static struct vpif_input da850_ch1_inputs[] = {
 	{
 		.input = {
 			.index = 0,
-- 
2.9.0
