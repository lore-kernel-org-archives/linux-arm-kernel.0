From: mw@semihalf.com (Marcin Wojtas)
Date: Wed, 21 Sep 2016 11:05:57 +0200
Subject: [PATCH v3 1/3] clk: mvebu: fix setting unwanted flags in CP110 gate
 clock
In-Reply-To: <1474448759-24482-1-git-send-email-mw@semihalf.com>
References: <1474448759-24482-1-git-send-email-mw@semihalf.com>
Message-ID: <1474448759-24482-2-git-send-email-mw@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Armada CP110 system controller comprises its own routine responsble
for registering gate clocks. Among others 'flags' field in
struct clk_init_data was not set, using a random values, which
may cause an unpredicted behavior.

This patch fixes the problem by resetting all fields of clk_init_data
before assigning values for all gated clocks of Armada 7k/8k SoCs family.

Fixes: d3da3eaef7f4 ("clk: mvebu: new driver for Armada CP110 system ...")
Signed-off-by: Marcin Wojtas <mw@semihalf.com>
CC: <stable@vger.kernel.org>
---
 drivers/clk/mvebu/cp110-system-controller.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/mvebu/cp110-system-controller.c b/drivers/clk/mvebu/cp110-system-controller.c
index 7fa42d6..59fe76e 100644
--- a/drivers/clk/mvebu/cp110-system-controller.c
+++ b/drivers/clk/mvebu/cp110-system-controller.c
@@ -142,6 +142,8 @@ static struct clk *cp110_register_gate(const char *name,
 	if (!gate)
 		return ERR_PTR(-ENOMEM);
 
+	memset(&init, 0, sizeof(init));
+
 	init.name = name;
 	init.ops = &cp110_gate_ops;
 	init.parent_names = &parent_name;
-- 
1.8.3.1
