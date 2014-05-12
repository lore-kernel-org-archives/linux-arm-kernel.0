From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 12 May 2014 16:11:39 +0200
Subject: [PATCH 1/2] ARM: mvebu: mvebu-soc-id: add missing clk_put() call
In-Reply-To: <1399903900-29977-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1399903900-29977-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1399903900-29977-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mvebu-soc-id code in mach-mvebu/ needs to enable a clock to read
the SoC device ID and revision number. To do so, it does a clk_get(),
then a clk_prepare_enable(), reads the value, and disables the clock
with clk_disable_unprepare(). However, it forgets to clk_put() the
clock. This commit fixes this issue.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: <stable@vger.kernel.org> # 3.14+
Fixes: af8d1c63afcbf36eea06789c92e22d4af118d2fb ('ARM: mvebu: Add support to get the ID and the revision of a SoC')
---
 arch/arm/mach-mvebu/mvebu-soc-id.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-mvebu/mvebu-soc-id.c b/arch/arm/mach-mvebu/mvebu-soc-id.c
index f3d4cf5..b52af6f 100644
--- a/arch/arm/mach-mvebu/mvebu-soc-id.c
+++ b/arch/arm/mach-mvebu/mvebu-soc-id.c
@@ -109,6 +109,7 @@ static int __init mvebu_soc_id_init(void)
 
 res_ioremap:
 	clk_disable_unprepare(clk);
+	clk_put(clk);
 
 clk_err:
 	of_node_put(child);
-- 
1.9.2
