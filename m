From: tony@atomide.com (Tony Lindgren)
Date: Tue, 13 Jan 2015 15:13:52 -0800
Subject: [PATCH 2/7] ARM: OMAP2+: Fix error handling for
 omap2_clk_enable_init_clocks
In-Reply-To: <1421190837-4692-1-git-send-email-tony@atomide.com>
References: <1421190837-4692-1-git-send-email-tony@atomide.com>
Message-ID: <1421190837-4692-3-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need to check if we got the clock before trying to do anything
with it. Otherwise we will get something like this:

Unable to handle kernel paging request at virtual address fffffffe
...
[<c04bef78>] (clk_prepare) from [<c00338a4>] (omap2_clk_enable_init_clocks+0x50/0x8)
[<c00338a4>] (omap2_clk_enable_init_clocks) from [<c0876838>] (dm816x_dt_clk_init+0)
...

Let's add check for the clock and WARN if the init clock was not
found.

Cc: Brian Hutchinson <b.hutchman@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/clock.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 6ad5b4d..89a0732 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -620,6 +620,11 @@ void omap2_clk_enable_init_clocks(const char **clk_names, u8 num_clocks)
 
 	for (i = 0; i < num_clocks; i++) {
 		init_clk = clk_get(NULL, clk_names[i]);
+		if (IS_ERR(init_clk)) {
+			WARN(1, "omap clock: could not find init clock %s\n",
+			     clk_names[i]);
+			continue;
+		}
 		clk_prepare_enable(init_clk);
 	}
 }
-- 
2.1.4
