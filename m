From: tony@atomide.com (Tony Lindgren)
Date: Tue, 02 Feb 2010 18:26:14 -0800
Subject: [PATCH 7/9] omap: Fix arch/arm/mach-omap2/mux.c: Off by one error
In-Reply-To: <20100203022318.26347.34734.stgit@baageli.muru.com>
References: <20100203022318.26347.34734.stgit@baageli.muru.com>
Message-ID: <20100203022614.26347.38121.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

David Binderman ran the sourceforge tool cppcheck over the source code of the
new Linux kernel 2.6.33-rc6:

[./arm/mach-omap2/mux.c:492]: (error) Buffer access out-of-bounds

13 characters + 1 digit + 1 zero byte is more than 14 characters.

Also add a comment on mode0 name length in case new omaps
start using longer names.

Reported-by: David Binderman <dcb314@hotmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/mux.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 19001dd..5fedc50 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -486,7 +486,7 @@ int __init omap_mux_init_signal(char *muxname, int val)
 static inline void omap_mux_decode(struct seq_file *s, u16 val)
 {
 	char *flags[OMAP_MUX_MAX_NR_FLAGS];
-	char mode[14];
+	char mode[sizeof("OMAP_MUX_MODE") + 1];
 	int i = -1;
 
 	sprintf(mode, "OMAP_MUX_MODE%d", val & 0x7);
@@ -553,6 +553,7 @@ static int omap_mux_dbg_board_show(struct seq_file *s, void *unused)
 		if (!m0_name)
 			continue;
 
+		/* REVISIT: Needs to be updated if mode0 names get longer */
 		for (i = 0; i < OMAP_MUX_DEFNAME_LEN; i++) {
 			if (m0_name[i] == '\0') {
 				m0_def[i] = m0_name[i];
