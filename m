From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 12 Dec 2012 09:15:52 +1100
Subject: linux-next: some merging notes
Message-ID: <20121212091552.02c72c8926f9f9147b080d68@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Just some notes about the current state of some of the merges in
linux-next.

The powerpc tree
(git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git#next)
contains a commit that breaks the building of
lib/pSeries-reconfig-notifier-error-inject.c.  I applied a patch to
linux-next to disable CONFIG_PSERIES_RECONFIG_NOTIFIER_ERROR_INJECT.

The virtio tree
(git://git.kernel.org/pub/scm/linux/kernel/git/rusty/linux.git#virtio-next)
has a conflict with the net-next tree
(git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git#master)
that requires the following extra fix up patch:

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 33d6f6f..8afe32d 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -147,7 +147,7 @@ struct padded_vnet_hdr {
  */
 static int vq2txq(struct virtqueue *vq)
 {
-	return (virtqueue_get_queue_index(vq) - 1) / 2;
+	return (vq->index - 1) / 2;
 }
 
 static int txq2vq(int txq)
@@ -157,7 +157,7 @@ static int txq2vq(int txq)
 
 static int vq2rxq(struct virtqueue *vq)
 {
-	return virtqueue_get_queue_index(vq) / 2;
+	return vq->index / 2;
 }
 
 static int rxq2vq(int rxq)

The tty tree
(git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git#tty-next)
contains a new driver (SystemBase Multi-2/PCI) that fails to build for
(at least) the powerpc architecture.  I have applied a patch that
disables the driver (I made CONFIG_SB105X in
drivers/staging/sb105x/Kconfig depend on BROKEN).

The arm-soc tree
(git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git#for-next)
(which you will get in pieces) has a merge conflict against the omap_dss2
tree (git://gitorious.org/linux-omap-dss2/linux.git#for-next) that
requires the followin fix up patch:

diff --git a/arch/arm/mach-omap2/common.c b/arch/arm/mach-omap2/common.c
index 5c2fd48..2dabb9e 100644
--- a/arch/arm/mach-omap2/common.c
+++ b/arch/arm/mach-omap2/common.c
@@ -16,8 +16,6 @@
 #include <linux/init.h>
 #include <linux/platform_data/dsp-omap.h>
 
-#include <plat/vram.h>
-
 #include "common.h"
 #include "omap-secure.h"
 
@@ -32,7 +30,6 @@ int __weak omap_secure_ram_reserve_memblock(void)
 
 void __init omap_reserve(void)
 {
-	omap_vram_reserve_sdram_memblock();
 	omap_dsp_reserve_sdram_memblock();
 	omap_secure_ram_reserve_memblock();
 	omap_barrier_reserve_memblock();

Part of the arm-soc tree also requires the following fixup patch due to a
conflict with the powerpc tree (patch from N, Mugunthan V
<mugunthanvnm@ti.com>):

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 099e406..5fd5e23 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -192,7 +192,7 @@ static struct device_node * __init omap_get_timer_dt
(struct of_device_id *match, continue;
 		}
 
-		prom_add_property(np, &device_disabled);
+		of_add_property(np, &device_disabled);
 		return np;
 	}
 
There are also lots of conflicts due to the __dev* annotation removals -
a lot of which are in the driver-core tree
(git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git#driver-core-next).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121212/65d101f8/attachment.sig>
