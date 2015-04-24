From: nschichan@freebox.fr (Nicolas Schichan)
Date: Fri, 24 Apr 2015 16:44:31 +0200
Subject: [RFC PATCH] bus: mvebu-mbus: do not set WIN_CTRL_SYNCBARRIER on non
 io-coherent platforms.
In-Reply-To: <20150417132350.329bcace@free-electrons.com>
References: <20150417132350.329bcace@free-electrons.com>
Message-ID: <1429886671-14415-1-git-send-email-nschichan@freebox.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On those platforms (orion5x, kirkwood and dove AFAICS) the
WIN_CTRL_SYNCBARRIER bit in the window control register is either
reserved (all windows except 6 and 7) or enables read-only protection
(windows 6 and 7).

Signed-off-by: Nicolas Schichan <nschichan@freebox.fr>
---

Hello Thomas,

Please find here my attempt at fixing this. I have been relying on the
hw_io_coherency field of the struct mvebu_mbus_state which is always
false for the platforms without the WIN_CTRL_SYNCBARRIER bit available
(orion5x, kirkwood, and dove).

I was going to add a field to mvebu_soc_data documenting the
availability of the WIN_CTRL_SYNCBARRIER bit for each platform but for
that purpose, the mvebu_mbus_state struct hw_io_coherency field looks
to be enough.

This has been tested on mv88f6282 (kirkwood).

Regards,

 drivers/bus/mvebu-mbus.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
index fb9ec62..019a033 100644
--- a/drivers/bus/mvebu-mbus.c
+++ b/drivers/bus/mvebu-mbus.c
@@ -323,8 +323,9 @@ static int mvebu_mbus_setup_window(struct mvebu_mbus_state *mbus,
 	ctrl = ((size - 1) & WIN_CTRL_SIZE_MASK) |
 		(attr << WIN_CTRL_ATTR_SHIFT)    |
 		(target << WIN_CTRL_TGT_SHIFT)   |
-		WIN_CTRL_SYNCBARRIER             |
 		WIN_CTRL_ENABLE;
+	if (mbus->hw_io_coherency)
+		ctrl |= WIN_CTRL_SYNCBARRIER;
 
 	writel(base & WIN_BASE_LOW, addr + WIN_BASE_OFF);
 	writel(ctrl, addr + WIN_CTRL_OFF);
-- 
1.9.1
