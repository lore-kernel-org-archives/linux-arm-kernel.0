From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 15 Dec 2011 14:36:13 -0700
Subject: [PATCH 1/9] ARM: OMAP2+: mux: add wakeup-capable hwmod mux entries to
 dynamic list
In-Reply-To: <20111215213358.26632.44165.stgit@dusk>
References: <20111215213358.26632.44165.stgit@dusk>
Message-ID: <20111215213609.26632.43406.stgit@dusk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

omap_hwmod_mux() currently only iterates through the dynamic pad list.
This list currently only consists of pads with the
OMAP_DEVICE_MUX_REMUX flag set.

Subsequent patches in this series will cause hwmod mux entries with
the OMAP_DEVICE_MUX_WAKEUP flag set to be changed dynamically, to
control hwmod I/O ring wakeup.  For this to work correctly, hwmod mux
entries with the OMAP_DEVICE_MUX_WAKEUP flag set must also be added to
the dynamic pad list.  So this patch modifies omap_hwmod_mux_init() to
do so.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Tero Kristo <t-kristo@ti.com>
Cc: Govindraj R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/mux.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 655e948..a474c81 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -306,7 +306,8 @@ omap_hwmod_mux_init(struct omap_device_pad *bpads, int nr_pads)
 		pad->idle = bpad->idle;
 		pad->off = bpad->off;
 
-		if (pad->flags & OMAP_DEVICE_PAD_REMUX)
+		if (pad->flags &
+		    (OMAP_DEVICE_PAD_REMUX | OMAP_DEVICE_PAD_WAKEUP))
 			nr_pads_dynamic++;
 
 		pr_debug("%s: Initialized %s\n", __func__, pad->name);
@@ -331,7 +332,8 @@ omap_hwmod_mux_init(struct omap_device_pad *bpads, int nr_pads)
 	for (i = 0; i < hmux->nr_pads; i++) {
 		struct omap_device_pad *pad = &hmux->pads[i];
 
-		if (pad->flags & OMAP_DEVICE_PAD_REMUX) {
+		if (pad->flags &
+		    (OMAP_DEVICE_PAD_REMUX | OMAP_DEVICE_PAD_WAKEUP)) {
 			pr_debug("%s: pad %s tagged dynamic\n",
 					__func__, pad->name);
 			hmux->pads_dynamic[nr_pads_dynamic] = pad;
