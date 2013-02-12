From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 12 Feb 2013 15:50:07 -0200
Subject: Building DRM for i.MX fails with linux-next 20130212
Message-ID: <CAOMZO5CzFbSKe1dKjCgmFtzbPCjMsHu1mGzphae3jmhByCPBqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Building imx_v6_v7_defconfig on linux-next 20130212 gives me the
following build error:

  CC      drivers/gpu/drm/drm_pci.o
drivers/gpu/drm/drm_pci.c: In function ?drm_pcie_get_speed_cap_mask?:
drivers/gpu/drm/drm_pci.c:485:2: error: implicit declaration of
function ?pcie_capability_read_dword?
[-Werror=implicit-function-declaration]

Then I tried to fix it as follows:

diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 6f58c81..6a08165 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -8,7 +8,7 @@ drm-y       :=  drm_auth.o drm_buffer.o drm_bufs.o drm_cache.o \
                drm_context.o drm_dma.o \
                drm_drv.o drm_fops.o drm_gem.o drm_ioctl.o drm_irq.o \
                drm_lock.o drm_memory.o drm_proc.o drm_stub.o drm_vm.o \
-               drm_agpsupport.o drm_scatter.o drm_pci.o \
+               drm_agpsupport.o drm_scatter.o  \
                drm_platform.o drm_sysfs.o drm_hashtab.o drm_mm.o \
                drm_crtc.o drm_modes.o drm_edid.o \
                drm_info.o drm_debugfs.o drm_encoder_slave.o \
@@ -16,7 +16,7 @@ drm-y       :=        drm_auth.o drm_buffer.o
drm_bufs.o drm_cache.o \

 drm-$(CONFIG_COMPAT) += drm_ioc32.o
 drm-$(CONFIG_DRM_GEM_CMA_HELPER) += drm_gem_cma_helper.o
-drm-$(CONFIG_PCI) += ati_pcigart.o
+drm-$(CONFIG_PCI) += ati_pcigart.o drm_pci.o

 drm-usb-y   := drm_usb.o

,which caused another issue:

  GEN     .version
  CHK     include/generated/compile.h
  UPD     include/generated/compile.h
  CC      init/version.o
  LD      init/built-in.o
drivers/built-in.o: In function `drm_rmmap_locked':
clk-vexpress-osc.c:(.text+0x4f370): undefined reference to `__drm_pci_free'
drivers/built-in.o: In function `drm_addmap_core':
clk-vexpress-osc.c:(.text+0x4f4f4): undefined reference to `drm_pci_alloc'
drivers/built-in.o: In function `drm_cleanup_buf_error':
clk-vexpress-osc.c:(.text+0x4f920): undefined reference to `drm_pci_free'
drivers/built-in.o: In function `drm_addbufs_pci':
clk-vexpress-osc.c:(.text+0x4fc00): undefined reference to `drm_pci_alloc'
drivers/built-in.o: In function `drm_dma_takedown':
clk-vexpress-osc.c:(.text+0x51c84): undefined reference to `drm_pci_free'
drivers/built-in.o: In function `drm_vm_shm_close':
clk-vexpress-osc.c:(.text+0x57d60): undefined reference to `__drm_pci_free'
make: *** [vmlinux] Error 1

Any ideas or suggestions?

Thanks,

Fabio Estevam
