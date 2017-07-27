From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 27 Jul 2017 12:12:59 +0200
Subject: [PATCH RESEND] ARM: davinci: don't mark vpif_input structures as
 'const'
Message-ID: <20170727101320.609258-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A change to the platform data definitions caused a warning in the board code:

arch/arm/mach-davinci/board-dm646x-evm.c:680:13: error: initialization discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
arch/arm/mach-davinci/board-dm646x-evm.c:690:13: error: initialization discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]

This is a bit unfortunate, since we generally like structure definitions to
be const, but as this is legacy code, the easiest way out is still to
remove the 'const' annotation here.

Fixes: 4a5f8ae50b66 ("[media] davinci: vpif_capture: get subdevs from DT when available")
Fixes: 231ce279e6e3 ("ARM: davinci: fix const warnings")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I originally sent my fix on Jun 9, but Kevin had already applied an
identical fix for two of the three affected files. This fixes the
third one that his patch missed.

I have a couple of other patches that I'm planning to apply directly
to the fixes branch now, and would do the same for this one unless
there are objections.
---
 arch/arm/mach-davinci/board-da850-evm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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
-- 
2.9.0
