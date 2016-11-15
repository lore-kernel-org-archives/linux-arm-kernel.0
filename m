From: fu.wei@linaro.org (fu.wei at linaro.org)
Date: Tue, 15 Nov 2016 21:13:33 +0800
Subject: [PATCH v15 11/13] acpi/arm64: Add memory-mapped timer support in GTDT
 driver
In-Reply-To: <1479215615-26950-1-git-send-email-fu.wei@linaro.org>
References: <1479215615-26950-1-git-send-email-fu.wei@linaro.org>
Message-ID: <1479215615-26950-12-git-send-email-fu.wei@linaro.org>
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
 drivers/acpi/arm64/gtdt.c | 95 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/acpi.h      |  1 +
 2 files changed, 96 insertions(+)

diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
index 2de79aa..08d9506 100644
--- a/drivers/acpi/arm64/gtdt.c
+++ b/drivers/acpi/arm64/gtdt.c
@@ -51,6 +51,14 @@ static inline bool is_timer_block(void *platform_timer)
 	return gh->type == ACPI_GTDT_TYPE_TIMER_BLOCK;
 }
 
+static inline struct acpi_gtdt_timer_block *get_timer_block(unsigned int index)
+{
+	if (index >= acpi_gtdt_desc.timer_block_count || !timer_block)
+		return NULL;
+
+	return timer_block[index];
+}
+
 static inline bool is_watchdog(void *platform_timer)
 {
 	struct acpi_gtdt_header *gh = platform_timer;
@@ -214,3 +222,90 @@ int __init acpi_gtdt_init(struct acpi_table_header *table)
 	acpi_gtdt_release();
 	return -EINVAL;
 }
+
+/*
+ * Get ONE GT block info for memory-mapped timer from GTDT table.
+ * @data: the GT block data (parsing result)
+ * @index: the index number of GT block
+ * Note: we already verify @data in caller, it can't be NULL here.
+ * Returns 0 if success, -EINVAL/-ENODEV if error.
+ */
+int __init gtdt_arch_timer_mem_init(struct arch_timer_mem *data,
+				    unsigned int index)
+{
+	struct acpi_gtdt_timer_block *block;
+	struct acpi_gtdt_timer_entry *frame;
+	int i;
+
+	block = get_timer_block(index);
+	if (!block)
+		return -ENODEV;
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
+	 * We can NOT get the size info from GTDT table,
+	 * but according to "Table * CNTCTLBase memory map" of
+	 * <ARM Architecture Reference Manual> for ARMv8,
+	 * it should be 4KB(Offset 0x000 ? 0xFFC).
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
+		if (frame->virtual_timer_interrupt) {
+			data->frame[i].virt_irq =
+				map_gt_gsi(frame->virtual_timer_interrupt,
+					   frame->virtual_timer_flags);
+			if (data->frame[i].virt_irq <= 0) {
+				pr_warn("failed to map virtual timer irq in frame %d.\n",
+					i);
+				return -EINVAL;
+			}
+		}
+
+		data->frame[i].frame_nr = frame->frame_number;
+		data->frame[i].cntbase = frame->base_address;
+		/*
+		 * We can NOT get the size info from GTDT table,
+		 * but according to "Table * CNTBaseN memory map" of
+		 * <ARM Architecture Reference Manual> for ARMv8,
+		 * it should be 4KB(Offset 0x000 ? 0xFFC).
+		 */
+		data->frame[i].size = SZ_4K;
+	}
+
+	if (acpi_gtdt_desc.timer_block_count)
+		pr_info("parsed No.%d of %d memory-mapped timer block(s).\n",
+			index, acpi_gtdt_desc.timer_block_count);
+
+	return 0;
+}
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index a1611d1..44b8c1b 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -582,6 +582,7 @@ int acpi_gtdt_init(struct acpi_table_header *table);
 int acpi_gtdt_map_ppi(int type);
 bool acpi_gtdt_c3stop(int type);
 void acpi_gtdt_release(void);
+int gtdt_arch_timer_mem_init(struct arch_timer_mem *data, unsigned int index);
 #endif
 
 #else	/* !CONFIG_ACPI */
-- 
2.7.4
