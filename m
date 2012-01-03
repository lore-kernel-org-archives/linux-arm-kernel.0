From: swarren@nvidia.com (Stephen Warren)
Date: Tue,  3 Jan 2012 15:25:19 -0700
Subject: [PATCH 3/4] ARM: tegra: uncompress.h: Choose a UART at runtime
In-Reply-To: <1325629520-23018-1-git-send-email-swarren@nvidia.com>
References: <1325629520-23018-1-git-send-email-swarren@nvidia.com>
Message-ID: <1325629520-23018-4-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With this change we automatically detect which UART to use for
for printing during decompression. The detection involves coordination
with the bootloader: it's expected that the bootloader will leave a
'D' (for [D]ebug) in the UART scratchpad register for whichever UART we
should use for debugging.

If we don't find any such UART, we fall back to the UART that was
specified during config time: CONFIG_TEGRA_DEBUG_UART_XXX.

As a side effect of this change, uncompress debug messages will work
if you've specified CONFIG_TEGRA_DEBUG_UART_NONE, provided the
bootloader obeys the protocol.

This change is in line with what is documented in
Documentation/arm/Booting.

Other approaches considered:
* Hardcode based on machine ID (as many other ARM boards do).
  OK, but nice to not have yet another place to add per-board
  code. Better to have bootloader parse device tree and pass us
  this info.
* Check for TXE bit (like SA1110). Nice (and doesn't require
  a bootloader change), but a little less explicit. Also: if
  bootloader (for some reason) uses another UART, it needs to
  remember to turn it off before jumping to the kernel or we may
  print to it. NOTE: adapting this patch to check TXE too would
  be easy if desired.

Signed-off-by: Doug Anderson <dianders@chromium.org>
[swarren: Added clock/reset condition checks]
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/include/mach/uncompress.h |   74 ++++++++++++++++++++++++-
 1 files changed, 73 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-tegra/include/mach/uncompress.h b/arch/arm/mach-tegra/include/mach/uncompress.h
index bb3fd35..4d8e1b7 100644
--- a/arch/arm/mach-tegra/include/mach/uncompress.h
+++ b/arch/arm/mach-tegra/include/mach/uncompress.h
@@ -3,11 +3,13 @@
  *
  * Copyright (C) 2010 Google, Inc.
  * Copyright (C) 2011 Google, Inc.
+ * Copyright (C) 2011 NVIDIA CORPORATION. All Rights Reserved.
  *
  * Author:
  *	Colin Cross <ccross@google.com>
  *	Erik Gilling <konkers@google.com>
  *	Doug Anderson <dianders@chromium.org>
+ *	Stephen Warren <swarren@nvidia.com>
  *
  * This software is licensed under the terms of the GNU General Public
  * License version 2, as published by the Free Software Foundation, and
@@ -46,12 +48,82 @@ static inline void flush(void)
 {
 }
 
+/*
+ * Setup before decompression.  This is where we do UART selection for
+ * earlyprintk and init the uart_base register.
+ */
 static inline void arch_decomp_setup(void)
 {
+	static const struct {
+		u32 base;
+		u32 reset_reg;
+		u32 clock_reg;
+		u32 bit;
+	} uarts[] = {
+		{
+			TEGRA_UARTA_BASE,
+			TEGRA_CLK_RESET_BASE + 0x04,
+			TEGRA_CLK_RESET_BASE + 0x10,
+			6,
+		},
+		{
+			TEGRA_UARTB_BASE,
+			TEGRA_CLK_RESET_BASE + 0x04,
+			TEGRA_CLK_RESET_BASE + 0x10,
+			7,
+		},
+		{
+			TEGRA_UARTC_BASE,
+			TEGRA_CLK_RESET_BASE + 0x08,
+			TEGRA_CLK_RESET_BASE + 0x14,
+			23,
+		},
+		{
+			TEGRA_UARTD_BASE,
+			TEGRA_CLK_RESET_BASE + 0x0c,
+			TEGRA_CLK_RESET_BASE + 0x18,
+			1,
+		},
+		{
+			TEGRA_UARTE_BASE,
+			TEGRA_CLK_RESET_BASE + 0x0c,
+			TEGRA_CLK_RESET_BASE + 0x18,
+			2,
+		},
+	};
+	int i;
 	volatile u32 *apb_misc = (volatile u32 *)TEGRA_APB_MISC_BASE;
 	u32 chip, div;
 
-	uart = (volatile u8 *)TEGRA_DEBUG_UART_BASE;
+	/*
+	 * Look for the first UART that:
+	 * a) Is not in reset.
+	 * b) Is clocked.
+	 * c) Has a 'D' in the scratchpad register.
+	 *
+	 * Note that on Tegra30, the first two conditions are required, since
+	 * if not true, accesses to the UART scratch register will hang.
+	 * Tegra20 doesn't have this issue.
+	 *
+	 * The intent is that the bootloader will tell the kernel which UART
+	 * to use by setting up those conditions. If nothing found, we'll fall
+	 * back to what's specified in TEGRA_DEBUG_UART_BASE.
+	 */
+	for (i = 0; i < ARRAY_SIZE(uarts); i++) {
+		if (*(u8 *)uarts[i].reset_reg & BIT(uarts[i].bit))
+			continue;
+
+		if (!(*(u8 *)uarts[i].clock_reg & BIT(uarts[i].bit)))
+			continue;
+
+		uart = (volatile u8 *)uarts[i].base;
+		if (uart[UART_SCR << DEBUG_UART_SHIFT] != 'D')
+			continue;
+
+		break;
+	}
+	if (i == ARRAY_SIZE(uarts))
+		uart = (volatile u8 *)TEGRA_DEBUG_UART_BASE;
 	if (uart == NULL)
 		return;
 
-- 
1.7.0.4
