From: fu.wei@linaro.org (fu.wei at linaro.org)
Date: Wed, 18 Jan 2017 21:25:39 +0800
Subject: [PATCH v20 15/17] acpi/arm64: Add memory-mapped timer support in GTDT
 driver
In-Reply-To: <20170118132541.8989-1-fu.wei@linaro.org>
References: <20170118132541.8989-1-fu.wei@linaro.org>
Message-ID: <20170118132541.8989-16-fu.wei@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fu Wei <fu.wei@linaro.org>

On platforms booting with ACPI, architected memory-mapped timers'
configuration data is provided by firmware through the ACPI GTDT
static table.

The clocksource architected timer kernel driver requires a firmware
interface to collect timer configuration and configure its driver.
this infrastructure is present for device tree systems, but it is
missing on systems booting with ACPI.

Implement the kernel infrastructure required to parse the static
ACPI GTDT table so that the architected timer clocksource driver can
make use of it on systems booting with ACPI, therefore enabling
the corresponding timers configuration.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/arm64/gtdt.c | 124 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/acpi.h      |   1 +
 2 files changed, 125 insertions(+)

diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
index d93a790..91ea6cb 100644
--- a/drivers/acpi/arm64/gtdt.c
+++ b/drivers/acpi/arm64/gtdt.c
@@ -37,6 +37,28 @@ struct acpi_gtdt_descriptor {
 
 static struct acpi_gtdt_descriptor acpi_gtdt_desc __initdata;
 
+static inline void *next_platform_timer(void *platform_timer)
+{
+	struct acpi_gtdt_header *gh = platform_timer;
+
+	platform_timer += gh->length;
+	if (platform_timer < acpi_gtdt_desc.gtdt_end)
+		return platform_timer;
+
+	return NULL;
+}
+
+#define for_each_platform_timer(_g)				\
+	for (_g = acpi_gtdt_desc.platform_timer; _g;	\
+	     _g = next_platform_timer(_g))
+
+static inline bool is_timer_block(void *platform_timer)
+{
+	struct acpi_gtdt_header *gh = platform_timer;
+
+	return gh->type == ACPI_GTDT_TYPE_TIMER_BLOCK;
+}
+
 static int __init map_gt_gsi(u32 interrupt, u32 flags)
 {
 	int trigger, polarity;
@@ -155,3 +177,105 @@ int __init acpi_gtdt_init(struct acpi_table_header *table,
 
 	return ret;
 }
+
+static int __init gtdt_parse_timer_block(struct acpi_gtdt_timer_block *block,
+					 struct arch_timer_mem *data)
+{
+	int i;
+	struct acpi_gtdt_timer_entry *frame;
+
+	if (!block->timer_count) {
+		pr_err(FW_BUG "GT block present, but frame count is zero.");
+		return -ENODEV;
+	}
+
+	if (block->timer_count > ARCH_TIMER_MEM_MAX_FRAMES) {
+		pr_err(FW_BUG "GT block lists %d frames, ACPI spec only allows 8\n",
+		       block->timer_count);
+		return -EINVAL;
+	}
+
+	data->cntctlbase = (phys_addr_t)block->block_address;
+	/*
+	 * According to "Table * CNTCTLBase memory map" of
+	 * <ARM Architecture Reference Manual> for ARMv8,
+	 * The size of the CNTCTLBase frame is 4KB(Offset 0x000 ? 0xFFC).
+	 */
+	data->size = SZ_4K;
+	data->num_frames = block->timer_count;
+
+	frame = (void *)block + block->timer_offset;
+	if (frame + block->timer_count != (void *)block + block->header.length)
+		return -EINVAL;
+
+	/*
+	 * Get the GT timer Frame data for every GT Block Timer
+	 */
+	for (i = 0; i < block->timer_count; i++, frame++) {
+		if (!frame->base_address || !frame->timer_interrupt)
+			return -EINVAL;
+
+		data->frame[i].phys_irq = map_gt_gsi(frame->timer_interrupt,
+						     frame->timer_flags);
+		if (data->frame[i].phys_irq <= 0) {
+			pr_warn("failed to map physical timer irq in frame %d.\n",
+				i);
+			return -EINVAL;
+		}
+
+		data->frame[i].virt_irq =
+			map_gt_gsi(frame->virtual_timer_interrupt,
+				   frame->virtual_timer_flags);
+		if (data->frame[i].virt_irq <= 0) {
+			pr_warn("failed to map virtual timer irq in frame %d.\n",
+				i);
+			acpi_unregister_gsi(frame->timer_interrupt);
+			return -EINVAL;
+		}
+
+		data->frame[i].frame_nr = frame->frame_number;
+		data->frame[i].cntbase = frame->base_address;
+		/*
+		 * According to "Table * CNTBaseN memory map" of
+		 * <ARM Architecture Reference Manual> for ARMv8,
+		 * The size of the CNTBaseN frame is 4KB(Offset 0x000 ? 0xFFC).
+		 */
+		data->frame[i].size = SZ_4K;
+	}
+
+	return 0;
+}
+
+/**
+ * acpi_arch_timer_mem_init() - Get the info of all GT blocks in GTDT table.
+ * @data:	the pointer to the array of struct arch_timer_mem for returning
+ *		the result of parsing. The element number of this array should
+ *		be platform_timer_count(the total number of platform timers).
+ * @count:	The pointer of int variate for returning the number of GT
+ *		blocks we have parsed.
+ *
+ * Return: 0 if success, -EINVAL/-ENODEV if error.
+ */
+int __init acpi_arch_timer_mem_init(struct arch_timer_mem *data,
+				    int *timer_count)
+{
+	int ret;
+	void *platform_timer;
+
+	*timer_count = 0;
+	for_each_platform_timer(platform_timer) {
+		if (is_timer_block(platform_timer)) {
+			ret = gtdt_parse_timer_block(platform_timer, data);
+			if (ret)
+				return ret;
+			data++;
+			(*timer_count)++;
+		}
+	}
+
+	if (*timer_count)
+		pr_info("found %d memory-mapped timer block(s).\n",
+			*timer_count);
+
+	return 0;
+}
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index d0b271e..51e85b9 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -601,6 +601,7 @@ int acpi_reconfig_notifier_unregister(struct notifier_block *nb);
 int acpi_gtdt_init(struct acpi_table_header *table, int *platform_timer_count);
 int acpi_gtdt_map_ppi(int type);
 bool acpi_gtdt_c3stop(int type);
+int acpi_arch_timer_mem_init(struct arch_timer_mem *data, int *timer_count);
 #endif
 
 #else	/* !CONFIG_ACPI */
-- 
2.9.3
