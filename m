From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Mon, 21 Jul 2014 15:47:19 +0100
Subject: [PATCH RFC 8/9] ARM: socfpga: Map the GIC CPU registers as
 MT_DEVICE_NS
In-Reply-To: <1405954040-30399-1-git-send-email-daniel.thompson@linaro.org>
References: <1405954040-30399-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1405954040-30399-9-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marek Vasut <marex@denx.de>

Statically map the SoCFPGA's memory space at PA 0xfff00000 +1MiB to 0xff000000
and set type of this VA to be MT_DEVICE_NS. This PA contains the SoCFPGA's GIC
CPU registers at offset +0xec100. This area is right past VMALLOC_END and well
below the optional start of per-CPU highmem entries. We can thus use this area
to place our mapping here and be sure it's not in anyone's way.

All accesses to VA 0xff000000 generate non-secure accesses on the bus and we
can leverage this property to generate non-secure read of the GIC INTACK (IAR)
register. This non-secure read will never return an FIQ interrupt number.

Signed-off-by: Marek Vasut <marex@denx.de>
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 arch/arm/mach-socfpga/socfpga.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
index adbf383..5b60f82 100644
--- a/arch/arm/mach-socfpga/socfpga.c
+++ b/arch/arm/mach-socfpga/socfpga.c
@@ -45,6 +45,13 @@ static struct map_desc uart_io_desc __initdata = {
 	.type		= MT_DEVICE,
 };
 
+static struct map_desc gic_cpu_io_desc __initdata = {
+		.virtual        = 0xff000000,
+		.pfn            = __phys_to_pfn(0xfff00000),
+		.length         = SZ_1M,
+		.type           = MT_DEVICE_NS,
+};
+
 static void __init socfpga_scu_map_io(void)
 {
 	unsigned long base;
@@ -60,6 +67,7 @@ static void __init socfpga_map_io(void)
 {
 	socfpga_scu_map_io();
 	iotable_init(&uart_io_desc, 1);
+	iotable_init(&gic_cpu_io_desc, 1);
 	early_printk("Early printk initialized\n");
 }
 
-- 
1.9.3
