From: tony@atomide.com (Tony Lindgren)
Date: Fri, 01 Oct 2010 16:34:02 -0700
Subject: [PATCH 1/8] omap: Fix omap_mux_init_signal not to trash muxname
In-Reply-To: <20101001233315.31894.49599.stgit@baageli.muru.com>
References: <20101001233315.31894.49599.stgit@baageli.muru.com>
Message-ID: <20101001233402.31894.59103.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Otherwise the muxname passed to the function will get truncated.

Based on an earlier patch by rockefeller.lin at innocomm.com.

Reported-by: rockefeller.lin at innocomm.com
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/mux.c |   13 +++++++------
 arch/arm/mach-omap2/mux.h |    2 +-
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 6c2f8f0..e33740c 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -127,17 +127,16 @@ int __init omap_mux_init_gpio(int gpio, int val)
 	return 0;
 }
 
-int __init omap_mux_init_signal(char *muxname, int val)
+int __init omap_mux_init_signal(const char *muxname, int val)
 {
 	struct omap_mux_entry *e;
-	char *m0_name = NULL, *mode_name = NULL;
-	int found = 0;
+	const char *mode_name;
+	int found = 0, mode0_len = 0;
 
 	mode_name = strchr(muxname, '.');
 	if (mode_name) {
-		*mode_name = '\0';
+		mode0_len = strlen(muxname) - strlen(mode_name);
 		mode_name++;
-		m0_name = muxname;
 	} else {
 		mode_name = muxname;
 	}
@@ -147,9 +146,11 @@ int __init omap_mux_init_signal(char *muxname, int val)
 		char *m0_entry = m->muxnames[0];
 		int i;
 
-		if (m0_name && strcmp(m0_name, m0_entry))
+		/* First check for full name in mode0.muxmode format */
+		if (mode0_len && strncmp(muxname, m0_entry, mode0_len))
 			continue;
 
+		/* Then check for muxmode only */
 		for (i = 0; i < OMAP_MUX_NR_MODES; i++) {
 			char *mode_cur = m->muxnames[i];
 
diff --git a/arch/arm/mach-omap2/mux.h b/arch/arm/mach-omap2/mux.h
index a8e040c..350c04f 100644
--- a/arch/arm/mach-omap2/mux.h
+++ b/arch/arm/mach-omap2/mux.h
@@ -120,7 +120,7 @@ int omap_mux_init_gpio(int gpio, int val);
  * @muxname:		Mux name in mode0_name.signal_name format
  * @val:		Options for the mux register value
  */
-int omap_mux_init_signal(char *muxname, int val);
+int omap_mux_init_signal(const char *muxname, int val);
 
 #else
 
