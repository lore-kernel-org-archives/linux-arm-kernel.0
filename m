From: stefan@agner.ch (Stefan Agner)
Date: Wed, 12 Sep 2018 11:32:16 -0700
Subject: [PATCH v2 2/8] drm/pl111: simplify bridge timing support
In-Reply-To: <20180912183222.25414-1-stefan@agner.ch>
References: <20180912183222.25414-1-stefan@agner.ch>
Message-ID: <20180912183222.25414-3-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Simplify bridge timing support by only supporting pixel clock
polarity. This aligns pixel clock polarity handling for bridges
with displays.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/gpu/drm/pl111/pl111_display.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/pl111/pl111_display.c b/drivers/gpu/drm/pl111/pl111_display.c
index 754f6b25f265..31eb62e4476f 100644
--- a/drivers/gpu/drm/pl111/pl111_display.c
+++ b/drivers/gpu/drm/pl111/pl111_display.c
@@ -196,23 +196,13 @@ static void pl111_display_enable(struct drm_simple_display_pipe *pipe,
 		const struct drm_bridge_timings *btimings = bridge->timings;
 
 		/*
-		 * Here is when things get really fun. Sometimes the bridge
-		 * timings are such that the signal out from PL11x is not
-		 * stable before the receiving bridge (such as a dumb VGA DAC
-		 * or similar) samples it. If that happens, we compensate by
-		 * the only method we have: output the data on the opposite
-		 * edge of the clock so it is for sure stable when it gets
-		 * sampled.
-		 *
-		 * The PL111 manual does not contain proper timining diagrams
-		 * or data for these details, but we know from experiments
-		 * that the setup time is more than 3000 picoseconds (3 ns).
-		 * If we have a bridge that requires the signal to be stable
-		 * earlier than 3000 ps before the clock pulse, we have to
-		 * output the data on the opposite edge to avoid flicker.
+		 * Use LCD Timing 2 Register Invert Pixel Clock (IPC) bit
+		 * to make sure to drive data on falling edge if requested
+		 * by bridge.
 		 */
-		if (btimings && btimings->setup_time_ps >= 3000)
-			tim2 ^= TIM2_IPC;
+		if (btimings && btimings->input_bus_flags &
+		    DRM_BUS_FLAG_PIXDATA_NEGEDGE)
+			tim2 |= TIM2_IPC;
 	}
 
 	tim2 |= cpl << 16;
-- 
2.18.0
