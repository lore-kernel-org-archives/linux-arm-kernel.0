From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 19 Feb 2016 10:03:51 +0100
Subject: [PATCH 8/9] ARM: do not use optimized do_div for ARMv3
In-Reply-To: <alpine.LFD.2.20.1602181215310.13632@knanqh.ubzr>
References: <1455804123-2526139-1-git-send-email-arnd@arndb.de>
 <1455804123-2526139-9-git-send-email-arnd@arndb.de>
 <alpine.LFD.2.20.1602181215310.13632@knanqh.ubzr>
Message-ID: <13253932.bg5yHHtIOq@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 18 February 2016 12:20:51 Nicolas Pitre wrote:
> On Thu, 18 Feb 2016, Arnd Bergmann wrote:
> 
> > The gcc-4.9 optimization goes wrong while building target_core_iblock.c
> > for ARMv3 and leaves a bogus reference to __aeabi_uldivmod in the
> > output:
> > 
> > ERROR: "__aeabi_uldivmod" [drivers/target/target_core_iblock.ko] undefined!
> > 
> > I could not find anyone who is interested in fixing it in gcc,
> > so as a workaround this disables the do_div magic, just like
> > we do for old compilers and for OABI.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> I suppose this is good enough for the purpose of keeping RiscPC 
> buildable. Whether or not it is still used is another question.  If it 
> is then its user probably expects it to be slow already.
> 
> Acked-by: Nicolas Pitre <nico@linaro.org>

Thanks.

> Still unfortunate having to use a big hammer such as -march=armv3 just 
> to avoid halfword memory accesses.

I brought this up with the gcc developers before. They would really want
to deprecated ARMv3 support, but nobody seems interested in implementing
halfword memory access as a replacement.

FWIW, I am currently still allowing ARMv3 in randconfig builds, but
have run into 12 internal compiler errors with that, on gcc-4.9 or higher.
It's probably all the same bug, but I don't see this getting fixed
unless the RiscOS people update to a newer toolchain and run into the
same problem.

The patch below disables optimization so I am able to build this, but
I see no way to fix this upstream.

	Arnd

 arch/arm/boot/compressed/Makefile            |    3 +++
 drivers/block/aoe/Makefile                   |    3 +++
 drivers/block/paride/Makefile                |    3 +++
 drivers/net/Makefile                         |    7 +++++++
 drivers/net/ethernet/apm/xgene/Makefile      |    4 ++++
 drivers/staging/lustre/lustre/llite/Makefile |    4 ++++
 fs/fat/Makefile                              |    4 ++++
 kernel/Makefile                              |    3 +++
 lib/zlib_inflate/Makefile                    |    4 ++++
 net/decnet/Makefile                          |    4 ++++
 net/irda/Makefile                            |    4 ++++
 11 files changed, 43 insertions(+)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index b5db4c868640..f000efa55003 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -9,6 +9,9 @@ OBJS		=
 AFLAGS_head.o += -DTEXT_OFFSET=$(TEXT_OFFSET)
 HEAD	= head.o
 OBJS	+= misc.o decompress.o
+ifdef CONFIG_CPU_32v3
+CFLAGS_decompress.o += -O0
+endif
 ifeq ($(CONFIG_DEBUG_UNCOMPRESS),y)
 OBJS	+= debug.o
 endif
diff --git a/drivers/block/aoe/Makefile b/drivers/block/aoe/Makefile
index 06ea82cdf27d..7007fe7a14ce 100644
--- a/drivers/block/aoe/Makefile
+++ b/drivers/block/aoe/Makefile
@@ -4,3 +4,6 @@
 
 obj-$(CONFIG_ATA_OVER_ETH)	+= aoe.o
 aoe-y := aoeblk.o aoechr.o aoecmd.o aoedev.o aoemain.o aoenet.o
+ifdef CONFIG_CPU_32v3
+CFLAGS_aoechr.o += -O0
+endif
diff --git a/drivers/block/paride/Makefile b/drivers/block/paride/Makefile
index a539e004bb7a..26ac7c329e4b 100644
--- a/drivers/block/paride/Makefile
+++ b/drivers/block/paride/Makefile
@@ -11,6 +11,9 @@ obj-$(CONFIG_PARIDE_BPCK)	+= bpck.o
 obj-$(CONFIG_PARIDE_COMM)	+= comm.o
 obj-$(CONFIG_PARIDE_DSTR)	+= dstr.o
 obj-$(CONFIG_PARIDE_KBIC)	+= kbic.o
+ifdef CONFIG_CPU_32v3
+CFLAGS_kbic.o += -O0
+endif
 obj-$(CONFIG_PARIDE_EPAT)	+= epat.o
 obj-$(CONFIG_PARIDE_EPIA)	+= epia.o
 obj-$(CONFIG_PARIDE_FRPW)	+= frpw.o
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index 900b0c5320bb..a249ae2a5c9b 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -12,6 +12,10 @@ obj-$(CONFIG_EQUALIZER) += eql.o
 obj-$(CONFIG_IFB) += ifb.o
 obj-$(CONFIG_MACVLAN) += macvlan.o
 obj-$(CONFIG_MACVTAP) += macvtap.o
+ifdef CONFIG_CPU_32v3
+CFLAGS_macvtap.o += -O1
+endif
+
 obj-$(CONFIG_MII) += mii.o
 obj-$(CONFIG_MDIO) += mdio.o
 obj-$(CONFIG_NET) += Space.o loopback.o
@@ -70,3 +74,6 @@ obj-$(CONFIG_HYPERV_NET) += hyperv/
 obj-$(CONFIG_NTB_NETDEV) += ntb_netdev.o
 
 obj-$(CONFIG_FUJITSU_ES) += fjes/
+ifdef CONFIG_CPU_32v3
+CFLAGS_tun.o += -O1
+endif
diff --git a/drivers/net/ethernet/apm/xgene/Makefile b/drivers/net/ethernet/apm/xgene/Makefile
index 700b5abe5de5..b357127e77ed 100644
--- a/drivers/net/ethernet/apm/xgene/Makefile
+++ b/drivers/net/ethernet/apm/xgene/Makefile
@@ -5,3 +5,7 @@
 xgene-enet-objs := xgene_enet_hw.o xgene_enet_sgmac.o xgene_enet_xgmac.o \
 		   xgene_enet_main.o xgene_enet_ring2.o xgene_enet_ethtool.o
 obj-$(CONFIG_NET_XGENE) += xgene-enet.o
+
+ifdef CONFIG_CPU_32v3
+CFLAGS_xgene_enet_main.o += -O1
+endif
diff --git a/drivers/staging/lustre/lustre/llite/Makefile b/drivers/staging/lustre/lustre/llite/Makefile
index 9ac29e718da3..7ebe6c751448 100644
--- a/drivers/staging/lustre/lustre/llite/Makefile
+++ b/drivers/staging/lustre/lustre/llite/Makefile
@@ -8,3 +8,7 @@ lustre-y := dcache.o dir.o file.o llite_close.o llite_lib.o llite_nfs.o \
 	    vvp_dev.o vvp_page.o vvp_lock.o vvp_io.o vvp_object.o lproc_llite.o
 
 llite_lloop-y := lloop.o
+
+ifdef CONFIG_CPU_32v3
+CFLAGS_file.o += -O1
+endif
diff --git a/fs/fat/Makefile b/fs/fat/Makefile
index 964b634f6667..b33feac5df36 100644
--- a/fs/fat/Makefile
+++ b/fs/fat/Makefile
@@ -9,3 +9,7 @@ obj-$(CONFIG_MSDOS_FS) += msdos.o
 fat-y := cache.o dir.o fatent.o file.o inode.o misc.o nfs.o
 vfat-y := namei_vfat.o
 msdos-y := namei_msdos.o
+
+ifdef CONFIG_CPU_32v3
+CFLAGS_dir.o += -O0
+endif
diff --git a/kernel/Makefile b/kernel/Makefile
index f0c40bf49d9f..d0c818182fd8 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -55,6 +55,9 @@ ifneq ($(CONFIG_SMP),y)
 obj-y += up.o
 endif
 obj-$(CONFIG_UID16) += uid16.o
+ifdef CONFIG_CPU_32v3
+CFLAGS_uid16.o += -O0
+endif
 obj-$(CONFIG_MODULES) += module.o
 obj-$(CONFIG_MODULE_SIG) += module_signing.o
 obj-$(CONFIG_KALLSYMS) += kallsyms.o
diff --git a/lib/zlib_inflate/Makefile b/lib/zlib_inflate/Makefile
index 49f8ce5774d2..d99fd57d0d34 100644
--- a/lib/zlib_inflate/Makefile
+++ b/lib/zlib_inflate/Makefile
@@ -17,3 +17,7 @@ obj-$(CONFIG_ZLIB_INFLATE) += zlib_inflate.o
 
 zlib_inflate-objs := inffast.o inflate.o infutil.o \
 		     inftrees.o inflate_syms.o
+
+ifdef CONFIG_CPU_32v3
+CFLAGS_inffast.o += -O0
+endif
diff --git a/net/decnet/Makefile b/net/decnet/Makefile
index e44003af71f6..a99608c9bd93 100644
--- a/net/decnet/Makefile
+++ b/net/decnet/Makefile
@@ -8,3 +8,7 @@ decnet-y += sysctl_net_decnet.o
 
 obj-$(CONFIG_NETFILTER) += netfilter/
 
+ifdef CONFIG_CPU_32v3
+CFLAGS_dn_table.o += -O1
+endif
+
diff --git a/net/irda/Makefile b/net/irda/Makefile
index 187f6c563a4b..d1801fda7865 100644
--- a/net/irda/Makefile
+++ b/net/irda/Makefile
@@ -13,3 +13,7 @@ irda-y := iriap.o iriap_event.o irlmp.o irlmp_event.o irlmp_frame.o \
 	  discovery.o parameters.o irnetlink.o irmod.o
 irda-$(CONFIG_PROC_FS) += irproc.o
 irda-$(CONFIG_SYSCTL) += irsysctl.o
+
+ifdef CONFIG_CPU_32v3
+CFLAGS_wrapper.o += -O0
+endif
