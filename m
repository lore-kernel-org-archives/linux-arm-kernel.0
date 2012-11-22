From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 22 Nov 2012 18:32:21 +0100
Subject: [PATCH 1/5] arm: mvebu: fix address decoding armada_cfg_base()
 function
In-Reply-To: <1353605545-7091-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353605545-7091-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353605545-7091-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The armada_cfg_base() function returns the base address of the
registers that allow to configure the decoding for a particular
address window. On Armada 370/XP, the lower windows have more
configuration registers (4 registers) than the higher windows (2
registers). This armada_cfg_base() takes this into account by doing a
different offset calculation depending on the window number, but this
offset calculation was wrong for the higher windows.

Even though we were not using high window numbers until now (only
window 0 is used to map the BootROM, needed for SMP), we use this
function at boot time to disable all windows to ensure that nothing
remains intialized from what the bootloader has done.

Unfortunately, the U-Boot on the OpenBlocks AX3-4 uses a window with a
high number (above 8) to remap the BootROM. And then when the kernel
boots, it remaps the BootROM in window 0. Normally, this is not a
problem, because all windows have previously been disabled. Except
that due to our wrong offset calculation, the windows with high
numbers were not properly disabled, leading to the BootROM being
mapped twice. The visible result of this bug was that the kernel was
unable to get the second CPU started on the OpenBlocks AX3-4
platform. With this fix, all windows are properly cleared at boot
time, the BootROM is remapped only once in window 0, and the second
CPU boots fine.

Thanks a lot to Lior Amsamlen <alior@marvell.com> for his help in
debugging this problem.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
Strictly speaking, this bug was introduced in 3.7, but since the only
platforms supported in 3.7 were Armada 370 and Armada XP, and there
was anyway no SMP support at this time, it isn't really worth the
effort to push this patch in 3.7.
---
 arch/arm/mach-mvebu/addr-map.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-mvebu/addr-map.c b/arch/arm/mach-mvebu/addr-map.c
index fe454a4..b20fc75 100644
--- a/arch/arm/mach-mvebu/addr-map.c
+++ b/arch/arm/mach-mvebu/addr-map.c
@@ -78,7 +78,7 @@ armada_cfg_base(const struct orion_addr_map_cfg *cfg, int win)
 	if (win < 8)
 		offset = (win << 4);
 	else
-		offset = ARMADA_WINDOW_8_PLUS_OFFSET + (win << 3);
+		offset = ARMADA_WINDOW_8_PLUS_OFFSET + ((win - 8) << 3);
 
 	return cfg->bridge_virt_base + offset;
 }
-- 
1.7.9.5
