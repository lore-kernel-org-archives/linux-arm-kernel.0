From: ykk@rock-chips.com (Yakir Yang)
Date: Mon, 21 Mar 2016 17:40:06 +0800
Subject: [RFC PATCH v1 2/4] drm: rockchip: add RGA driver support
In-Reply-To: <1458552518-25527-1-git-send-email-ykk@rock-chips.com>
References: <1458552518-25527-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1458553206-26880-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rockchip RGA is a separate 2D raster graphic acceleration unit. It
accelerates 2D graphics operations, such as point/line drawing, image
scaling, rotation, BitBLT, alpha blending and image blur/sharpness.

The RGA driver is based on Exynos G2D driver, it is performed by two
tasks simply.
1. Configures the rendering parameters, such as foreground color and
   coordinates data by setting the drawing context registers.
2. Start the rendering process by calling rga_exec() ioctl.

The RGA supports DMA mode as host interface. User can make command list
to reduce HOST(ARM) loads. The contents of The command list is setted to
relevant registers of RGA by DMA.

The command list is composed Header and command sets and Tail.
- Header: The number of command set(4Bytes)
- Command set: Register offset(4Bytes) + Register data(4Bytes)
- Tail: Pointer of base address of the other command list(4Bytes)

By Tail field, the G2D can process many command lists without halt at
one go.

The G2D has following the rendering pipeline.
               --->     Color Fill     --->
               |                          |
--> DMA (read) ---> Src Bitmap Process ----> Alpha/ROP ---> Format convert ---> DMA (Write)
               |                          |
               ---> Dst Bitmap Process --->

And supports various operations from the rendering pipeline.
- copy
- fast solid color fill
- rotation
- flip
- 4 operand raster operation(ROP4)
- alpha blending
- color key
- dithering
- etc

User should make the command list to data and registers needed by
operation to use. The Rockchip RGA driver only manages the command lists
received from user. Some registers needs memory base address(physical
address) of image. User doesn't know its physical address, so fills the
gem handle of that memory than address to command sets, then RGA driver
converts it to memory base address.

We adds three ioctls for Rockchip RGA.

- ioctls
DRM_ROCKCHIP_RGA_GET_VER: get the RGA hardware version
DRM_ROCKCHIP_RGA_SET_CMDLIST: set the command list from user to driver
DRM_ROCKCHIP_RGA_EXEC: execute the command lists setted to driver

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
 .../bindings/display/rockchip/rockchip-rga.txt     |  36 +
 drivers/gpu/drm/rockchip/Kconfig                   |   9 +
 drivers/gpu/drm/rockchip/Makefile                  |   1 +
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c        |  35 +-
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h        |   4 +
 drivers/gpu/drm/rockchip/rockchip_drm_rga.c        | 977 +++++++++++++++++++++
 drivers/gpu/drm/rockchip/rockchip_drm_rga.h        | 108 +++
 include/uapi/drm/rockchip_drm.h                    |  63 ++
 8 files changed, 1232 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip-rga.txt
 create mode 100644 drivers/gpu/drm/rockchip/rockchip_drm_rga.c
 create mode 100644 drivers/gpu/drm/rockchip/rockchip_drm_rga.h
 create mode 100644 include/uapi/drm/rockchip_drm.h

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip-rga.txt b/Documentation/devicetree/bindings/display/rockchip/rockchip-rga.txt
new file mode 100644
index 0000000..0c606cb
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip-rga.txt
@@ -0,0 +1,36 @@
+device-tree bindings for rockchip 2D raster graphic acceleration controller (RGA)
+
+RGA is a separate 2D raster graphic acceleration unit. It accelerates 2D
+graphics operations, such as point/line drawing, image scaling, rotation,
+BitBLT, alpha blending and image blur/sharpness.
+
+Required properties:
+- compatible: value should be one of the following
+		"rockchip,rk3228-rga";
+		"rockchip,rk3288-rga";
+		"rockchip,rk3399-rga";
+
+- interrupts: RGA interrupt number.
+
+- clocks: phandle to RGA sclk/hclk/aclk clocks
+
+- clock-names: should be "aclk" "hclk" and "sclk"
+
+- resets: Must contain an entry for each entry in reset-names.
+  See ../reset/reset.txt for details.
+- reset-names: should be "aclk" "hclk" and "sclk"
+
+Example:
+SoC specific DT entry:
+	rga: rga at ff680000 {
+		compatible = "rockchip,rk3399-rga";
+		reg = <0xff680000 0x10000>;
+		interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "rga";
+		clocks = <&cru ACLK_RGA>, <&cru HCLK_RGA>, <&cru SCLK_RGA>;
+		clock-names = "aclk", "hclk", "sclk";
+
+		resets = <&cru SRST_A_RGA>, <&cru SRST_H_RGA>, <&cru SRST_RGA_CORE>;
+		reset-names = "aclk", "hclk", "sclk";
+		status = "disabled";
+	};
diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/Kconfig
index 76b3362..220221b 100644
--- a/drivers/gpu/drm/rockchip/Kconfig
+++ b/drivers/gpu/drm/rockchip/Kconfig
@@ -16,6 +16,15 @@ config DRM_ROCKCHIP
 	  2D or 3D acceleration; acceleration is performed by other
 	  IP found on the SoC.
 
+config ROCKCHIP_DRM_RGA
+	tristate "Rockchip RGA support"
+	depends on DRM_ROCKCHIP
+	help
+	  Choose this option to enable support for Rockchip RGA.
+	  Rockchip RGA is a kind of hardware 2D accelerator, and it support
+	  solid roration, scaling, color format transform, say Y to enable its
+	  driver
+
 config ROCKCHIP_DW_HDMI
         tristate "Rockchip specific extensions for Synopsys DW HDMI"
         depends on DRM_ROCKCHIP
diff --git a/drivers/gpu/drm/rockchip/Makefile b/drivers/gpu/drm/rockchip/Makefile
index df8fbef..7de547c 100644
--- a/drivers/gpu/drm/rockchip/Makefile
+++ b/drivers/gpu/drm/rockchip/Makefile
@@ -9,5 +9,6 @@ rockchipdrm-$(CONFIG_DRM_FBDEV_EMULATION) += rockchip_drm_fbdev.o
 obj-$(CONFIG_ROCKCHIP_DW_HDMI) += dw_hdmi-rockchip.o
 obj-$(CONFIG_ROCKCHIP_DW_MIPI_DSI) += dw-mipi-dsi.o
 obj-$(CONFIG_ROCKCHIP_INNO_HDMI) += inno_hdmi.o
+obj-$(CONFIG_ROCKCHIP_DRM_RGA) += rockchip_drm_rga.o
 
 obj-$(CONFIG_DRM_ROCKCHIP) += rockchipdrm.o rockchip_vop_reg.o
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index 4e0feb2..1638bc9 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -25,10 +25,13 @@
 #include <linux/of_graph.h>
 #include <linux/component.h>
 
+#include <drm/rockchip_drm.h>
+
 #include "rockchip_drm_drv.h"
 #include "rockchip_drm_fb.h"
 #include "rockchip_drm_fbdev.h"
 #include "rockchip_drm_gem.h"
+#include "rockchip_drm_rga.h"
 
 #define DRIVER_NAME	"rockchip"
 #define DRIVER_DESC	"RockChip Soc DRM"
@@ -277,16 +280,28 @@ EXPORT_SYMBOL_GPL(rockchip_unregister_subdrv);
 
 static int rockchip_drm_open(struct drm_device *dev, struct drm_file *file)
 {
+	struct rockchip_drm_file_private *file_priv;
 	struct drm_rockchip_subdrv *subdrv;
 	int ret = 0;
 
+	file_priv = kzalloc(sizeof(*file_priv), GFP_KERNEL);
+	if (!file_priv)
+		return -ENOMEM;
+
+	file->driver_priv = file_priv;
+
 	list_for_each_entry(subdrv, &rockchip_drm_subdrv_list, list) {
 		ret = subdrv->open(dev, subdrv->dev, file);
 		if (ret)
-			return ret;
+			goto err_file_priv_free;
 	}
 
 	return 0;
+
+err_file_priv_free:
+	kfree(file_priv);
+	file->driver_priv = NULL;
+	return ret;
 }
 
 static void rockchip_drm_preclose(struct drm_device *dev,
@@ -298,6 +313,12 @@ static void rockchip_drm_preclose(struct drm_device *dev,
 		subdrv->close(dev, subdrv->dev, file);
 }
 
+static void rockchip_drm_postclose(struct drm_device *dev,
+				   struct drm_file *file)
+{
+	kfree(file->driver_priv);
+}
+
 void rockchip_drm_lastclose(struct drm_device *dev)
 {
 	struct rockchip_drm_private *priv = dev->dev_private;
@@ -305,6 +326,15 @@ void rockchip_drm_lastclose(struct drm_device *dev)
 	drm_fb_helper_restore_fbdev_mode_unlocked(&priv->fbdev_helper);
 }
 
+static const struct drm_ioctl_desc rockchip_ioctls[] = {
+	DRM_IOCTL_DEF_DRV(ROCKCHIP_RGA_GET_VER, rockchip_rga_get_ver_ioctl,
+			  DRM_AUTH | DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(ROCKCHIP_RGA_SET_CMDLIST, rockchip_rga_set_cmdlist_ioctl,
+			  DRM_AUTH | DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(ROCKCHIP_RGA_EXEC, rockchip_rga_exec_ioctl,
+			  DRM_AUTH | DRM_RENDER_ALLOW),
+};
+
 static const struct file_operations rockchip_drm_driver_fops = {
 	.owner = THIS_MODULE,
 	.open = drm_open,
@@ -330,6 +360,7 @@ static struct drm_driver rockchip_drm_driver = {
 	.unload			= rockchip_drm_unload,
 	.open			= rockchip_drm_open,
 	.preclose		= rockchip_drm_preclose,
+	.postclose		= rockchip_drm_postclose,
 	.lastclose		= rockchip_drm_lastclose,
 	.get_vblank_counter	= drm_vblank_no_hw_counter,
 	.enable_vblank		= rockchip_drm_crtc_enable_vblank,
@@ -347,6 +378,8 @@ static struct drm_driver rockchip_drm_driver = {
 	.gem_prime_vmap		= rockchip_gem_prime_vmap,
 	.gem_prime_vunmap	= rockchip_gem_prime_vunmap,
 	.gem_prime_mmap		= rockchip_gem_mmap_buf,
+	.ioctls			= rockchip_ioctls,
+	.num_ioctls		= ARRAY_SIZE(rockchip_ioctls),
 	.fops			= &rockchip_drm_driver_fops,
 	.name	= DRIVER_NAME,
 	.desc	= DRIVER_DESC,
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
index 5ea5fcb..ea30ba6 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
@@ -53,6 +53,10 @@ struct drm_rockchip_subdrv {
 		      struct drm_file *file);
 };
 
+struct rockchip_drm_file_private {
+	struct rockchip_drm_rga_private *rga_priv;
+};
+
 struct rockchip_atomic_commit {
 	struct work_struct	work;
 	struct drm_atomic_state *state;
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_rga.c b/drivers/gpu/drm/rockchip/rockchip_drm_rga.c
new file mode 100644
index 0000000..4202121
--- /dev/null
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_rga.c
@@ -0,0 +1,977 @@
+/*
+ * Copyright (C) Fuzhou Rockchip Electronics Co.Ltd
+ * Author: Yakir Yang <ykk@rock-chips.com>
+ *
+ * based on exynos_drm_g2d.c
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/clk.h>
+#include <linux/debugfs.h>
+#include <linux/delay.h>
+#include <linux/dma-buf.h>
+#include <linux/dma-mapping.h>
+#include <linux/interrupt.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/reset.h>
+#include <linux/seq_file.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+
+#include <asm/cacheflush.h>
+#include <drm/drmP.h>
+#include <drm/rockchip_drm.h>
+
+#include "rockchip_drm_drv.h"
+#include "rockchip_drm_rga.h"
+
+#define RGA_MODE_BASE_REG		0x0100
+#define RGA_MODE_MAX_REG		0x017C
+
+#define RGA_SYS_CTRL			0x0000
+#define RGA_CMD_CTRL			0x0004
+#define RGA_CMD_BASE			0x0008
+#define RGA_INT				0x0010
+#define RGA_MMU_CTRL0			0x0014
+#define RGA_VERSION_INFO		0x0028
+
+#define RGA_SRC_Y_RGB_BASE_ADDR		0x0108
+#define RGA_SRC_CB_BASE_ADDR		0x010C
+#define RGA_SRC_CR_BASE_ADDR		0x0110
+#define RGA_SRC1_RGB_BASE_ADDR		0x0114
+#define RGA_DST_Y_RGB_BASE_ADDR		0x013C
+#define RGA_DST_CB_BASE_ADDR		0x0140
+#define RGA_DST_CR_BASE_ADDR		0x014C
+#define RGA_MMU_CTRL1			0x016C
+#define RGA_MMU_SRC_BASE		0x0170
+#define RGA_MMU_SRC1_BASE		0x0174
+#define RGA_MMU_DST_BASE		0x0178
+
+static void rga_dma_flush_range(void *ptr, int size)
+{
+#ifdef CONFIG_ARM
+	dmac_flush_range(ptr, ptr + size);
+	outer_flush_range(virt_to_phys(ptr), virt_to_phys(ptr + size));
+#elif CONFIG_ARM64
+	__dma_flush_range(ptr, ptr + size);
+#endif
+}
+
+static inline void rga_write(struct rockchip_rga *rga, u32 reg, u32 value)
+{
+	writel(value, rga->regs + reg);
+}
+
+static inline u32 rga_read(struct rockchip_rga *rga, u32 reg)
+{
+	return readl(rga->regs + reg);
+}
+
+static inline void rga_mod(struct rockchip_rga *rga, u32 reg, u32 val, u32 mask)
+{
+	u32 temp = rga_read(rga, reg) & ~(mask);
+
+	temp |= val & mask;
+	rga_write(rga, reg, temp);
+}
+
+static int rga_enable_clocks(struct rockchip_rga *rga)
+{
+	int ret;
+
+	ret = clk_prepare_enable(rga->sclk);
+	if (ret) {
+		dev_err(rga->dev, "Cannot enable rga sclk: %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_prepare_enable(rga->aclk);
+	if (ret) {
+		dev_err(rga->dev, "Cannot enable rga aclk: %d\n", ret);
+		goto err_disable_sclk;
+	}
+
+	ret = clk_prepare_enable(rga->hclk);
+	if (ret) {
+		dev_err(rga->dev, "Cannot enable rga hclk: %d\n", ret);
+		goto err_disable_aclk;
+	}
+
+	return 0;
+
+err_disable_sclk:
+	clk_disable_unprepare(rga->sclk);
+err_disable_aclk:
+	clk_disable_unprepare(rga->aclk);
+
+	return ret;
+}
+
+static void rga_disable_clocks(struct rockchip_rga *rga)
+{
+	clk_disable_unprepare(rga->sclk);
+	clk_disable_unprepare(rga->hclk);
+	clk_disable_unprepare(rga->aclk);
+}
+
+static void rga_init_cmdlist(struct rockchip_rga *rga)
+{
+	struct rga_cmdlist_node *node;
+	int nr;
+
+	node = rga->cmdlist_node;
+
+	for (nr = 0; nr < ARRAY_SIZE(rga->cmdlist_node); nr++)
+		list_add_tail(&node[nr].list, &rga->free_cmdlist);
+}
+
+static int rga_alloc_dma_buf_for_cmdlist(struct rga_runqueue_node *runqueue)
+{
+	struct list_head *run_cmdlist = &runqueue->run_cmdlist;
+	struct device *dev = runqueue->dev;
+	struct dma_attrs cmdlist_dma_attrs;
+	struct rga_cmdlist_node *node;
+	void *cmdlist_pool_virt;
+	dma_addr_t cmdlist_pool;
+	int cmdlist_cnt = 0;
+	int count = 0;
+
+	list_for_each_entry(node, run_cmdlist, list)
+		cmdlist_cnt++;
+
+	init_dma_attrs(&cmdlist_dma_attrs);
+	dma_set_attr(DMA_ATTR_WRITE_COMBINE, &runqueue->cmdlist_dma_attrs);
+
+	cmdlist_pool_virt = dma_alloc_attrs(dev, cmdlist_cnt * RGA_CMDLIST_SIZE,
+					    &cmdlist_pool, GFP_KERNEL,
+					    &cmdlist_dma_attrs);
+	if (!cmdlist_pool_virt) {
+		dev_err(dev, "failed to allocate cmdlist dma memory\n");
+		return -ENOMEM;
+	}
+
+	/*
+	 * Fill in the RGA operation registers from cmdlist command buffer,
+	 * and also filled in the MMU TLB base information.
+	 */
+	list_for_each_entry(node, run_cmdlist, list) {
+		struct rga_cmdlist *cmdlist = &node->cmdlist;
+		unsigned int mmu_ctrl = 0;
+		unsigned int *dest;
+		unsigned int reg;
+		int i;
+
+		dest = cmdlist_pool_virt + RGA_CMDLIST_SIZE * 4 * count++;
+
+		for (i = 0; i < cmdlist->last / 2; i++) {
+			reg = (node->cmdlist.data[2 * i] - RGA_MODE_BASE_REG);
+			if (reg > RGA_MODE_BASE_REG)
+				continue;
+			dest[reg << 2] = cmdlist->data[2 * i + 1];
+		}
+
+		if (cmdlist->src_mmu_pages) {
+			reg = RGA_MMU_SRC_BASE - RGA_MODE_BASE_REG;
+			dest[reg << 2] = virt_to_phys(cmdlist->src_mmu_pages) >> 4;
+			mmu_ctrl |= 0x7;
+		}
+
+		if (cmdlist->dst_mmu_pages) {
+			reg = RGA_MMU_DST_BASE - RGA_MODE_BASE_REG;
+			dest[reg << 2] = virt_to_phys(cmdlist->dst_mmu_pages) >> 4;
+			mmu_ctrl |= 0x7 << 8;
+		}
+
+		if (cmdlist->src1_mmu_pages) {
+			reg = RGA_MMU_SRC1_BASE - RGA_MODE_BASE_REG;
+			dest[reg << 2] = virt_to_phys(cmdlist->src1_mmu_pages) >> 4;
+			mmu_ctrl |= 0x7 << 4;
+		}
+
+		reg = RGA_MMU_CTRL1 - RGA_MODE_BASE_REG;
+		dest[reg << 2] = mmu_ctrl;
+	}
+
+	rga_dma_flush_range(cmdlist_pool_virt, cmdlist_cnt * RGA_CMDLIST_SIZE);
+
+	runqueue->cmdlist_dma_attrs = cmdlist_dma_attrs;
+	runqueue->cmdlist_pool_virt = cmdlist_pool_virt;
+	runqueue->cmdlist_pool = cmdlist_pool;
+	runqueue->cmdlist_cnt = cmdlist_cnt;
+
+	return 0;
+}
+
+static int rga_check_reg_offset(struct device *dev,
+				struct rga_cmdlist_node *node)
+{
+	struct rga_cmdlist *cmdlist = &node->cmdlist;
+	int index;
+	int reg;
+	int i;
+
+	for (i = 0; i < cmdlist->last / 2; i++) {
+		index = cmdlist->last - 2 * (i + 1);
+		reg = cmdlist->data[index];
+
+		switch (reg) {
+		case RGA_BUF_TYPE_GEMFD | RGA_DST_Y_RGB_BASE_ADDR:
+		case RGA_BUF_TYPE_GEMFD | RGA_SRC_Y_RGB_BASE_ADDR:
+			break;
+
+		case RGA_BUF_TYPE_USERPTR | RGA_DST_Y_RGB_BASE_ADDR:
+		case RGA_BUF_TYPE_USERPTR | RGA_SRC_Y_RGB_BASE_ADDR:
+			goto err;
+
+		default:
+			if (reg < RGA_MODE_BASE_REG || reg > RGA_MODE_MAX_REG)
+				goto err;
+
+			if (reg % 4)
+				goto err;
+		}
+	}
+
+	return 0;
+
+err:
+	dev_err(dev, "Bad register offset: 0x%lx\n", cmdlist->data[index]);
+	return -EINVAL;
+}
+
+static struct dma_buf_attachment *
+rga_gem_buf_to_pages(struct rockchip_rga *rga, void **mmu_pages, int fd)
+{
+	struct dma_buf_attachment *attach;
+	struct dma_buf *dmabuf;
+	struct sg_table *sgt;
+	struct scatterlist *sgl;
+	unsigned int mapped_size = 0;
+	unsigned int address;
+	unsigned int len;
+	unsigned int i, p;
+	unsigned int *pages;
+	int ret;
+
+	dmabuf = dma_buf_get(fd);
+	if (IS_ERR(dmabuf)) {
+		dev_err(rga->dev, "Failed to get dma_buf with fd %d\n", fd);
+		return ERR_PTR(-EINVAL);
+	}
+
+	attach = dma_buf_attach(dmabuf, rga->dev);
+	if (IS_ERR(attach)) {
+		dev_err(rga->dev, "Failed to attach dma_buf\n");
+		ret = PTR_ERR(attach);
+		goto failed_attach;
+	}
+
+	sgt = dma_buf_map_attachment(attach, DMA_BIDIRECTIONAL);
+	if (IS_ERR(sgt)) {
+		dev_err(rga->dev, "Failed to map dma_buf attachment\n");
+		ret = PTR_ERR(sgt);
+		goto failed_detach;
+	}
+
+	/*
+	 * Alloc (2^3 * 4K) = 32K byte for storing pages, those space could
+	 * cover 32K * 4K = 128M ram address.
+	 */
+	pages = (unsigned int *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, 3);
+
+	for_each_sg(sgt->sgl, sgl, sgt->nents, i) {
+		len = sg_dma_len(sgl) >> PAGE_SHIFT;
+		address = sg_phys(sgl);
+
+		for (p = 0; p < len; p++) {
+			dma_addr_t phys = address + (p << PAGE_SHIFT);
+			void *virt = phys_to_virt(phys);
+
+			rga_dma_flush_range(virt, 4 * 1024);
+			pages[mapped_size + p] = phys;
+		}
+
+		mapped_size += len;
+	}
+
+	rga_dma_flush_range(pages, 32 * 1024);
+
+	*mmu_pages = pages;
+
+	dma_buf_unmap_attachment(attach, sgt, DMA_BIDIRECTIONAL);
+
+	return attach;
+
+failed_detach:
+	dma_buf_detach(dmabuf, attach);
+failed_attach:
+	dma_buf_put(dmabuf);
+
+	return ERR_PTR(ret);
+}
+
+static int rga_map_cmdlist_gem(struct rockchip_rga *rga,
+			       struct rga_cmdlist_node *node,
+			       struct drm_device *drm_dev,
+			       struct drm_file *file)
+{
+	struct rga_cmdlist *cmdlist = &node->cmdlist;
+	struct dma_buf_attachment *attach;
+	void *mmu_pages;
+	int fd;
+	int i;
+
+	for (i = 0; i < cmdlist->last / 2; i++) {
+		int index = cmdlist->last - 2 * (i + 1);
+
+		switch (cmdlist->data[index]) {
+		case RGA_SRC_Y_RGB_BASE_ADDR | RGA_BUF_TYPE_GEMFD:
+			fd = cmdlist->data[index + 1];
+			attach = rga_gem_buf_to_pages(rga, &mmu_pages, fd);
+
+			cmdlist->src_attach = attach;
+			cmdlist->src_mmu_pages = mmu_pages;
+			break;
+
+		case RGA_DST_Y_RGB_BASE_ADDR | RGA_BUF_TYPE_GEMFD:
+			fd = cmdlist->data[index + 1];
+			attach = rga_gem_buf_to_pages(rga, &mmu_pages, fd);
+
+			cmdlist->dst_attach = attach;
+			cmdlist->dst_mmu_pages = mmu_pages;
+			break;
+		}
+	}
+
+	return 0;
+}
+
+static void rga_unmap_cmdlist_gem(struct rockchip_rga *rga,
+				  struct rga_cmdlist_node *node)
+{
+	struct dma_buf_attachment *attach;
+	struct dma_buf *dma_buf;
+
+	attach = node->cmdlist.src_attach;
+	if (attach) {
+		dma_buf = attach->dmabuf;
+		dma_buf_detach(dma_buf, attach);
+		dma_buf_put(dma_buf);
+	}
+	node->cmdlist.src_attach = NULL;
+
+	attach = node->cmdlist.dst_attach;
+	if (attach) {
+		dma_buf = attach->dmabuf;
+		dma_buf_detach(dma_buf, attach);
+		dma_buf_put(dma_buf);
+	}
+	node->cmdlist.dst_attach = NULL;
+
+	if (node->cmdlist.src_mmu_pages)
+		free_pages((unsigned long)node->cmdlist.src_mmu_pages, 3);
+	node->cmdlist.src_mmu_pages = NULL;
+
+	if (node->cmdlist.src1_mmu_pages)
+		free_pages((unsigned long)node->cmdlist.src1_mmu_pages, 3);
+	node->cmdlist.src1_mmu_pages = NULL;
+
+	if (node->cmdlist.dst_mmu_pages)
+		free_pages((unsigned long)node->cmdlist.dst_mmu_pages, 3);
+	node->cmdlist.dst_mmu_pages = NULL;
+}
+
+static void rga_cmd_start(struct rockchip_rga *rga,
+			  struct rga_runqueue_node *runqueue)
+{
+	int ret;
+
+	ret = pm_runtime_get_sync(rga->dev);
+	if (ret < 0)
+		return;
+
+	rga_write(rga, RGA_SYS_CTRL, 0x00);
+
+	rga_write(rga, RGA_CMD_BASE, runqueue->cmdlist_pool);
+
+	rga_write(rga, RGA_SYS_CTRL, 0x22);
+
+	rga_write(rga, RGA_INT, 0x600);
+
+	rga_write(rga, RGA_CMD_CTRL, ((runqueue->cmdlist_cnt - 1) << 3) | 0x1);
+}
+
+static void rga_free_runqueue_node(struct rockchip_rga *rga,
+				   struct rga_runqueue_node *runqueue)
+{
+	struct rga_cmdlist_node *node;
+
+	if (!runqueue)
+		return;
+
+	if (runqueue->cmdlist_pool_virt && runqueue->cmdlist_pool)
+		dma_free_attrs(rga->dev, runqueue->cmdlist_cnt * RGA_CMDLIST_SIZE,
+			       runqueue->cmdlist_pool_virt,
+			       runqueue->cmdlist_pool,
+			       &runqueue->cmdlist_dma_attrs);
+
+	mutex_lock(&rga->cmdlist_mutex);
+	/*
+	 * commands in run_cmdlist have been completed so unmap all gem
+	 * objects in each command node so that they are unreferenced.
+	 */
+	list_for_each_entry(node, &runqueue->run_cmdlist, list)
+		rga_unmap_cmdlist_gem(rga, node);
+	list_splice_tail_init(&runqueue->run_cmdlist, &rga->free_cmdlist);
+	mutex_unlock(&rga->cmdlist_mutex);
+
+	kmem_cache_free(rga->runqueue_slab, runqueue);
+}
+
+static struct rga_runqueue_node *rga_get_runqueue(struct rockchip_rga *rga)
+{
+	struct rga_runqueue_node *runqueue;
+
+	if (list_empty(&rga->runqueue_list))
+		return NULL;
+
+	runqueue = list_first_entry(&rga->runqueue_list,
+				    struct rga_runqueue_node, list);
+	list_del_init(&runqueue->list);
+
+	return runqueue;
+}
+
+static void rga_exec_runqueue(struct rockchip_rga *rga)
+{
+	rga->runqueue_node = rga_get_runqueue(rga);
+	if (rga->runqueue_node)
+		rga_cmd_start(rga, rga->runqueue_node);
+}
+
+static struct rga_cmdlist_node *rga_get_cmdlist(struct rockchip_rga *rga)
+{
+	struct rga_cmdlist_node *node;
+	struct device *dev = rga->dev;
+
+	mutex_lock(&rga->cmdlist_mutex);
+	if (list_empty(&rga->free_cmdlist)) {
+		dev_err(dev, "there is no free cmdlist\n");
+		mutex_unlock(&rga->cmdlist_mutex);
+		return NULL;
+	}
+
+	node = list_first_entry(&rga->free_cmdlist,
+				struct rga_cmdlist_node, list);
+	list_del_init(&node->list);
+	mutex_unlock(&rga->cmdlist_mutex);
+
+	return node;
+}
+
+static void rga_add_cmdlist_to_inuse(struct rockchip_drm_rga_private *rga_priv,
+				     struct rga_cmdlist_node *node)
+{
+	struct rga_cmdlist_node *lnode;
+
+	if (list_empty(&rga_priv->inuse_cmdlist))
+		goto add_to_list;
+
+	/* this links to base address of new cmdlist */
+	lnode = list_entry(rga_priv->inuse_cmdlist.prev,
+			   struct rga_cmdlist_node, list);
+
+add_to_list:
+	list_add_tail(&node->list, &rga_priv->inuse_cmdlist);
+}
+
+/*
+ * IOCRL functions for userspace to get RGA version.
+ */
+int rockchip_rga_get_ver_ioctl(struct drm_device *drm_dev, void *data,
+			       struct drm_file *file)
+{
+	struct rockchip_drm_file_private *file_priv = file->driver_priv;
+	struct rockchip_drm_rga_private *rga_priv = file_priv->rga_priv;
+	struct drm_rockchip_rga_get_ver *ver = data;
+	struct rockchip_rga *rga;
+	struct device *dev;
+
+	if (!rga_priv)
+		return -ENODEV;
+
+	dev = rga_priv->dev;
+	if (!dev)
+		return -ENODEV;
+
+	rga = dev_get_drvdata(dev);
+	if (!rga)
+		return -EFAULT;
+
+	ver->major = rga->version.major;
+	ver->minor = rga->version.minor;
+
+	return 0;
+}
+
+/*
+ * IOCRL functions for userspace to send an RGA request.
+ */
+int rockchip_rga_set_cmdlist_ioctl(struct drm_device *drm_dev, void *data,
+				   struct drm_file *file)
+{
+	struct rockchip_drm_file_private *file_priv = file->driver_priv;
+	struct rockchip_drm_rga_private *rga_priv = file_priv->rga_priv;
+	struct drm_rockchip_rga_set_cmdlist *req = data;
+	struct rga_cmdlist_node *node;
+	struct rga_cmdlist *cmdlist;
+	struct rockchip_rga *rga;
+	int ret;
+
+	if (!rga_priv)
+		return -ENODEV;
+
+	if (!rga_priv->dev)
+		return -ENODEV;
+
+	rga = dev_get_drvdata(rga_priv->dev);
+	if (!rga)
+		return -EFAULT;
+
+	node = rga_get_cmdlist(rga);
+	if (!node)
+		return -ENOMEM;
+
+	cmdlist = &node->cmdlist;
+	cmdlist->last = 0;
+
+	if (req->cmd_nr > RGA_CMDLIST_SIZE || req->cmd_buf_nr > RGA_CMDBUF_SIZE) {
+		dev_err(rga->dev, "cmdlist size is too big\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Copy the command / buffer registers setting from userspace, each
+	 * command have two integer, one for register offset, another for
+	 * register value.
+	 */
+	if (copy_from_user((void *)cmdlist->data, (const void __user *)req->cmd,
+			   sizeof(struct drm_rockchip_rga_cmd) * req->cmd_nr))
+		return -EFAULT;
+	cmdlist->last += req->cmd_nr * 2;
+
+	if (copy_from_user((void *)cmdlist->data + cmdlist->last,
+			   (const void __user *)req->cmd_buf,
+			   sizeof(struct drm_rockchip_rga_cmd) * req->cmd_buf_nr))
+		return -EFAULT;
+	cmdlist->last += req->cmd_buf_nr * 2;
+
+	/*
+	 * Check the userspace command registers, and mapping the framebuffer,
+	 * create the RGA mmu pages or get the framebuffer dma address.
+	 */
+	ret = rga_check_reg_offset(rga->dev, node);
+	if (ret < 0)
+		return ret;
+
+	ret = rga_map_cmdlist_gem(rga, node, drm_dev, file);
+	if (ret < 0)
+		return ret;
+
+	rga_add_cmdlist_to_inuse(rga_priv, node);
+
+	return 0;
+}
+
+/*
+ * IOCRL functions for userspace to start RGA transform.
+ */
+int rockchip_rga_exec_ioctl(struct drm_device *drm_dev, void *data,
+			    struct drm_file *file)
+{
+	struct rockchip_drm_file_private *file_priv = file->driver_priv;
+	struct rockchip_drm_rga_private *rga_priv = file_priv->rga_priv;
+	struct rga_runqueue_node *runqueue;
+	struct rockchip_rga *rga;
+	struct device *dev;
+	int ret;
+
+	if (!rga_priv)
+		return -ENODEV;
+
+	dev = rga_priv->dev;
+	if (!dev)
+		return -ENODEV;
+
+	rga = dev_get_drvdata(dev);
+	if (!rga)
+		return -EFAULT;
+
+	runqueue = kmem_cache_alloc(rga->runqueue_slab, GFP_KERNEL);
+	if (!runqueue) {
+		dev_err(rga->dev, "failed to allocate memory\n");
+		return -ENOMEM;
+	}
+
+	runqueue->dev = rga->dev;
+
+	init_completion(&runqueue->complete);
+
+	INIT_LIST_HEAD(&runqueue->run_cmdlist);
+
+	list_splice_init(&rga_priv->inuse_cmdlist, &runqueue->run_cmdlist);
+
+	if (list_empty(&runqueue->run_cmdlist)) {
+		dev_err(rga->dev, "there is no inuse cmdlist\n");
+		kmem_cache_free(rga->runqueue_slab, runqueue);
+		return -EPERM;
+	}
+
+	ret = rga_alloc_dma_buf_for_cmdlist(runqueue);
+	if (ret < 0) {
+		dev_err(rga->dev, "cmdlist init failed\n");
+		return ret;
+	}
+
+	mutex_lock(&rga->runqueue_mutex);
+	runqueue->pid = current->pid;
+	runqueue->file = file;
+	list_add_tail(&runqueue->list, &rga->runqueue_list);
+	if (!rga->runqueue_node)
+		rga_exec_runqueue(rga);
+	mutex_unlock(&rga->runqueue_mutex);
+
+	wait_for_completion(&runqueue->complete);
+	rga_free_runqueue_node(rga, runqueue);
+
+	return 0;
+}
+
+static int rockchip_rga_open(struct drm_device *drm_dev, struct device *dev,
+			     struct drm_file *file)
+{
+	struct rockchip_drm_file_private *file_priv = file->driver_priv;
+	struct rockchip_drm_rga_private *rga_priv;
+
+	rga_priv = kzalloc(sizeof(*rga_priv), GFP_KERNEL);
+	if (!rga_priv)
+		return -ENOMEM;
+
+	rga_priv->dev = dev;
+	file_priv->rga_priv = rga_priv;
+
+	INIT_LIST_HEAD(&rga_priv->inuse_cmdlist);
+
+	return 0;
+}
+
+static void rockchip_rga_close(struct drm_device *drm_dev, struct device *dev,
+			       struct drm_file *file)
+{
+	struct rockchip_drm_file_private *file_priv = file->driver_priv;
+	struct rockchip_drm_rga_private *rga_priv = file_priv->rga_priv;
+	struct rga_cmdlist_node *node, *n;
+	struct rockchip_rga *rga;
+
+	if (!dev)
+		return;
+
+	rga = dev_get_drvdata(dev);
+	if (!rga)
+		return;
+
+	mutex_lock(&rga->cmdlist_mutex);
+	list_for_each_entry_safe(node, n, &rga_priv->inuse_cmdlist, list) {
+		/*
+		 * unmap all gem objects not completed.
+		 *
+		 * P.S. if current process was terminated forcely then
+		 * there may be some commands in inuse_cmdlist so unmap
+		 * them.
+		 */
+		rga_unmap_cmdlist_gem(rga, node);
+		list_move_tail(&node->list, &rga->free_cmdlist);
+	}
+	mutex_unlock(&rga->cmdlist_mutex);
+
+	kfree(file_priv->rga_priv);
+}
+
+static void rga_runqueue_worker(struct work_struct *work)
+{
+	struct rockchip_rga *rga = container_of(work, struct rockchip_rga,
+					    runqueue_work);
+
+	mutex_lock(&rga->runqueue_mutex);
+	pm_runtime_put_sync(rga->dev);
+
+	complete(&rga->runqueue_node->complete);
+
+	if (rga->suspended)
+		rga->runqueue_node = NULL;
+	else
+		rga_exec_runqueue(rga);
+
+	mutex_unlock(&rga->runqueue_mutex);
+}
+
+static irqreturn_t rga_irq_handler(int irq, void *dev_id)
+{
+	struct rockchip_rga *rga = dev_id;
+	int intr;
+
+	intr = rga_read(rga, RGA_INT) & 0xf;
+
+	rga_mod(rga, RGA_INT, intr << 4, 0xf << 4);
+
+	if (intr & 0x04)
+		queue_work(rga->rga_workq, &rga->runqueue_work);
+
+	return IRQ_HANDLED;
+}
+
+static int rga_parse_dt(struct rockchip_rga *rga)
+{
+	struct reset_control *sclk_rst, *aclk_rst, *hclk_rst;
+
+	sclk_rst = devm_reset_control_get(rga->dev, "sclk");
+	if (IS_ERR(sclk_rst)) {
+		dev_err(rga->dev, "failed to get sclk reset controller\n");
+		return PTR_ERR(sclk_rst);
+	}
+
+	aclk_rst = devm_reset_control_get(rga->dev, "aclk");
+	if (IS_ERR(aclk_rst)) {
+		dev_err(rga->dev, "failed to get aclk reset controller\n");
+		return PTR_ERR(aclk_rst);
+	}
+
+	hclk_rst = devm_reset_control_get(rga->dev, "hclk");
+	if (IS_ERR(hclk_rst)) {
+		dev_err(rga->dev, "failed to get hclk reset controller\n");
+		return PTR_ERR(hclk_rst);
+	}
+
+	reset_control_assert(sclk_rst);
+	usleep_range(10, 20);
+	reset_control_deassert(sclk_rst);
+
+	reset_control_assert(aclk_rst);
+	usleep_range(10, 20);
+	reset_control_deassert(aclk_rst);
+
+	reset_control_assert(hclk_rst);
+	usleep_range(10, 20);
+	reset_control_deassert(hclk_rst);
+
+	rga->sclk = devm_clk_get(rga->dev, "sclk");
+	if (IS_ERR(rga->sclk)) {
+		dev_err(rga->dev, "failed to get sclk clock\n");
+		return PTR_ERR(rga->sclk);
+	}
+
+	rga->aclk = devm_clk_get(rga->dev, "aclk");
+	if (IS_ERR(rga->aclk)) {
+		dev_err(rga->dev, "failed to get aclk clock\n");
+		return PTR_ERR(rga->aclk);
+	}
+
+	rga->hclk = devm_clk_get(rga->dev, "hclk");
+	if (IS_ERR(rga->hclk)) {
+		dev_err(rga->dev, "failed to get hclk clock\n");
+		return PTR_ERR(rga->hclk);
+	}
+
+	return rga_enable_clocks(rga);
+}
+
+static const struct of_device_id rockchip_rga_dt_ids[] = {
+	{ .compatible = "rockchip,rk3288-rga", },
+	{ .compatible = "rockchip,rk3228-rga", },
+	{ .compatible = "rockchip,rk3399-rga", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, rockchip_rga_dt_ids);
+
+static int rga_probe(struct platform_device *pdev)
+{
+	struct drm_rockchip_subdrv *subdrv;
+	struct rockchip_rga *rga;
+	struct resource *iores;
+	int irq;
+	int ret;
+
+	if (!pdev->dev.of_node)
+		return -ENODEV;
+
+	rga = devm_kzalloc(&pdev->dev, sizeof(*rga), GFP_KERNEL);
+	if (!rga)
+		return -ENOMEM;
+
+	rga->dev = &pdev->dev;
+
+	rga->runqueue_slab = kmem_cache_create("rga_runqueue_slab",
+					       sizeof(struct rga_runqueue_node),
+					       0, 0, NULL);
+	if (!rga->runqueue_slab)
+		return -ENOMEM;
+
+	rga->rga_workq = create_singlethread_workqueue("rga");
+	if (!rga->rga_workq) {
+		dev_err(rga->dev, "failed to create workqueue\n");
+		goto err_destroy_slab;
+	}
+
+	INIT_WORK(&rga->runqueue_work, rga_runqueue_worker);
+	INIT_LIST_HEAD(&rga->runqueue_list);
+	mutex_init(&rga->runqueue_mutex);
+
+	INIT_LIST_HEAD(&rga->free_cmdlist);
+	mutex_init(&rga->cmdlist_mutex);
+
+	rga_init_cmdlist(rga);
+
+	ret = rga_parse_dt(rga);
+	if (ret) {
+		dev_err(rga->dev, "Unable to parse OF data\n");
+		goto err_destroy_workqueue;
+	}
+
+	pm_runtime_enable(rga->dev);
+
+	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	rga->regs = devm_ioremap_resource(rga->dev, iores);
+	if (IS_ERR(rga->regs)) {
+		ret = PTR_ERR(rga->regs);
+		goto err_put_clk;
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(rga->dev, "failed to get irq\n");
+		ret = irq;
+		goto err_put_clk;
+	}
+
+	ret = devm_request_irq(rga->dev, irq, rga_irq_handler, 0,
+			       dev_name(rga->dev), rga);
+	if (ret < 0) {
+		dev_err(rga->dev, "failed to request irq\n");
+		goto err_put_clk;
+	}
+
+	platform_set_drvdata(pdev, rga);
+
+	rga->version.major = (rga_read(rga, RGA_VERSION_INFO) >> 24) & 0xFF;
+	rga->version.minor = (rga_read(rga, RGA_VERSION_INFO) >> 20) & 0x0F;
+
+	subdrv = &rga->subdrv;
+	subdrv->dev = rga->dev;
+	subdrv->open = rockchip_rga_open;
+	subdrv->close = rockchip_rga_close;
+
+	rockchip_register_subdrv(subdrv);
+
+	return 0;
+
+err_put_clk:
+	pm_runtime_disable(rga->dev);
+err_destroy_workqueue:
+	destroy_workqueue(rga->rga_workq);
+err_destroy_slab:
+	kmem_cache_destroy(rga->runqueue_slab);
+
+	return ret;
+}
+
+static int rga_remove(struct platform_device *pdev)
+{
+	struct rockchip_rga *rga = platform_get_drvdata(pdev);
+
+	cancel_work_sync(&rga->runqueue_work);
+
+	while (rga->runqueue_node) {
+		rga_free_runqueue_node(rga, rga->runqueue_node);
+		rga->runqueue_node = rga_get_runqueue(rga);
+	}
+
+	rockchip_unregister_subdrv(&rga->subdrv);
+
+	return 0;
+}
+
+static int rga_suspend(struct device *dev)
+{
+	struct rockchip_rga *rga = dev_get_drvdata(dev);
+
+	mutex_lock(&rga->runqueue_mutex);
+	rga->suspended = true;
+	mutex_unlock(&rga->runqueue_mutex);
+
+	flush_work(&rga->runqueue_work);
+
+	return 0;
+}
+
+static int rga_resume(struct device *dev)
+{
+	struct rockchip_rga *rga = dev_get_drvdata(dev);
+
+	rga->suspended = false;
+	rga_exec_runqueue(rga);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int rga_runtime_suspend(struct device *dev)
+{
+	struct rockchip_rga *rga = dev_get_drvdata(dev);
+
+	rga_disable_clocks(rga);
+
+	return 0;
+}
+
+static int rga_runtime_resume(struct device *dev)
+{
+	struct rockchip_rga *rga = dev_get_drvdata(dev);
+
+	return rga_enable_clocks(rga);
+}
+#endif
+
+static const struct dev_pm_ops rga_pm = {
+	SET_SYSTEM_SLEEP_PM_OPS(rga_suspend, rga_resume)
+	SET_RUNTIME_PM_OPS(rga_runtime_suspend,
+			   rga_runtime_resume, NULL)
+};
+
+static struct platform_driver rga_pltfm_driver = {
+	.probe  = rga_probe,
+	.remove = rga_remove,
+	.driver = {
+		.name = "rockchip-rga",
+		.pm = &rga_pm,
+		.of_match_table = rockchip_rga_dt_ids,
+	},
+};
+
+module_platform_driver(rga_pltfm_driver);
+
+MODULE_AUTHOR("Yakir Yang <ykk@rock-chips.com>");
+MODULE_DESCRIPTION("Rockchip RGA Driver Extension");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:rockchip-rga");
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_rga.h b/drivers/gpu/drm/rockchip/rockchip_drm_rga.h
new file mode 100644
index 0000000..4a8839a
--- /dev/null
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_rga.h
@@ -0,0 +1,108 @@
+#ifndef __ROCKCHIP_DRM_RGA__
+#define __ROCKCHIP_DRM_RGA__
+
+#define RGA_CMDBUF_SIZE			14
+#define RGA_CMDLIST_SIZE		0x20
+#define RGA_CMDLIST_NUM			64
+
+/* cmdlist data structure */
+struct rga_cmdlist {
+	u32		head;
+	unsigned long	data[RGA_CMDLIST_SIZE * 2];
+	u32		last;	/* last data offset */
+	void		*src_mmu_pages;
+	void		*dst_mmu_pages;
+	void		*src1_mmu_pages;
+	struct dma_buf_attachment *src_attach;
+	struct dma_buf_attachment *dst_attach;
+};
+
+struct rga_cmdlist_node {
+	struct list_head	list;
+	struct rga_cmdlist	cmdlist;
+};
+
+struct rga_runqueue_node {
+	struct list_head	list;
+
+	struct device		*dev;
+	pid_t			pid;
+	struct drm_file		*file;
+	struct completion	complete;
+
+	struct list_head	run_cmdlist;
+
+	int			cmdlist_cnt;
+	void			*cmdlist_pool_virt;
+	dma_addr_t		cmdlist_pool;
+	struct dma_attrs	cmdlist_dma_attrs;
+};
+
+struct rockchip_rga_version {
+	__u32			major;
+	__u32			minor;
+};
+
+struct rockchip_rga {
+	struct drm_device	*drm_dev;
+	struct device		*dev;
+	struct regmap		*grf;
+	void __iomem		*regs;
+	struct clk		*sclk;
+	struct clk		*aclk;
+	struct clk		*hclk;
+
+	bool				suspended;
+	struct rockchip_rga_version	version;
+	struct drm_rockchip_subdrv	subdrv;
+	struct workqueue_struct		*rga_workq;
+	struct work_struct		runqueue_work;
+
+	/* rga command list pool */
+	struct rga_cmdlist_node		cmdlist_node[RGA_CMDLIST_NUM];
+	struct mutex			cmdlist_mutex;
+
+	struct list_head		free_cmdlist;
+
+	/* rga runqueue */
+	struct rga_runqueue_node	*runqueue_node;
+	struct list_head		runqueue_list;
+	struct mutex			runqueue_mutex;
+	struct kmem_cache		*runqueue_slab;
+};
+
+struct rockchip_drm_rga_private {
+	struct device		*dev;
+	struct list_head	inuse_cmdlist;
+	struct list_head	userptr_list;
+};
+
+#ifdef CONFIG_ROCKCHIP_DRM_RGA
+int rockchip_rga_get_ver_ioctl(struct drm_device *dev, void *data,
+			       struct drm_file *file_priv);
+int rockchip_rga_set_cmdlist_ioctl(struct drm_device *dev, void *data,
+				   struct drm_file *file_priv);
+int rockchip_rga_exec_ioctl(struct drm_device *dev, void *data,
+			    struct drm_file *file_priv);
+#else
+static inline int rockchip_rga_get_ver_ioctl(struct drm_device *dev, void *data,
+					     struct drm_file *file_priv)
+{
+	return -ENODEV;
+}
+
+static inline int rockchip_rga_set_cmdlist_ioctl(struct drm_device *dev,
+						 void *data,
+						 struct drm_file *file_priv)
+{
+	return -ENODEV;
+}
+
+static inline int rockchip_rga_exec_ioctl(struct drm_device *dev, void *data,
+					  struct drm_file *file_priv)
+{
+	return -ENODEV;
+}
+#endif
+
+#endif /* __ROCKCHIP_DRM_RGA__ */
diff --git a/include/uapi/drm/rockchip_drm.h b/include/uapi/drm/rockchip_drm.h
new file mode 100644
index 0000000..2e3e240
--- /dev/null
+++ b/include/uapi/drm/rockchip_drm.h
@@ -0,0 +1,63 @@
+/* rockchip_drm.h
+ *
+ * Copyright (c) 2016 Fuzhou Rockchip Electronics Co., Ltd.
+ * Authors:
+ *	Yakir Yang <ykk@rock-chips.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifndef _UAPI_ROCKCHIP_DRM_H_
+#define _UAPI_ROCKCHIP_DRM_H_
+
+#include <drm/drm.h>
+
+struct drm_rockchip_rga_get_ver {
+	__u32   major;
+	__u32   minor;
+};
+
+struct drm_rockchip_rga_cmd {
+	__u32   offset;
+	__u32   data;
+};
+
+enum drm_rockchip_rga_buf_type {
+	RGA_BUF_TYPE_USERPTR = 1 << 31,
+	RGA_BUF_TYPE_GEMFD   = 1 << 30,
+};
+
+struct drm_rockchip_rga_userptr {
+	unsigned long userptr;
+	unsigned long size;
+};
+
+struct drm_rockchip_rga_set_cmdlist {
+	__u64		cmd;
+	__u64		cmd_buf;
+	__u32		cmd_nr;
+	__u32		cmd_buf_nr;
+	__u64		user_data;
+};
+
+struct drm_rockchip_rga_exec {
+	__u64		async;
+};
+
+#define DRM_ROCKCHIP_RGA_GET_VER		0x20
+#define DRM_ROCKCHIP_RGA_SET_CMDLIST		0x21
+#define DRM_ROCKCHIP_RGA_EXEC			0x22
+
+#define DRM_IOCTL_ROCKCHIP_RGA_GET_VER		DRM_IOWR(DRM_COMMAND_BASE + \
+	DRM_ROCKCHIP_RGA_GET_VER, struct drm_rockchip_rga_get_ver)
+
+#define DRM_IOCTL_ROCKCHIP_RGA_SET_CMDLIST	DRM_IOWR(DRM_COMMAND_BASE + \
+	DRM_ROCKCHIP_RGA_SET_CMDLIST, struct drm_rockchip_rga_set_cmdlist)
+
+#define DRM_IOCTL_ROCKCHIP_RGA_EXEC		DRM_IOWR(DRM_COMMAND_BASE + \
+	DRM_ROCKCHIP_RGA_EXEC, struct drm_rockchip_rga_exec)
+
+#endif /* _UAPI_ROCKCHIP_DRM_H */
-- 
1.9.1
