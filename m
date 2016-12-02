From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Fri,  2 Dec 2016 15:05:18 +0000
Subject: [RFC v3 PATCH 00/25] Allow NOMMU for MULTIPLATFORM
Message-ID: <1480691143-19845-1-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

With transition to MULTIPLATFORM we lost capability to build NOMMU
configurations. Maybe not a big deal, but there is still interest in
building NOMMU configuration apart from M-class cores. Basically, I'm
talking about R-class cores which shares a lot with A-class except
MMU; there was little interest to run A-class with MMU disabled (or
1:1 MMU mapping) as well.  By now it is not even possible to build
such configurations without extra patches on top. Another aspect is
that some portion of NOMMU code have been (build) untested for a
while. All these makes it even harder to involve more people in using
NOMMU and build community around that.

This series is trying to make it possible to build NOMMU
configurations. It is done in PATCH 25/25 which allows to select
ARCH_MULTIPLATFORM even for NOMMU. This is controlled with EXPERT
config option. All patches prior 25/25 is an attempt to fix build
failures for NOMMU case. I don't claim they are 100% correct, so I'm
open to suggestion how they can be done in a better way.

It was build tested with allmodconfig and defconfigs [1] with
!MMU. Additionally, I've been running randconfig, so two more patches
have been added compared to RFC v2.
I had to keep following diff on top:

diff --git a/drivers/mtd/nand/orion_nand.c b/drivers/mtd/nand/orion_nand.c
index 40a7c4a..c737124 100644
--- a/drivers/mtd/nand/orion_nand.c
+++ b/drivers/mtd/nand/orion_nand.c
@@ -65,7 +65,7 @@ static void orion_nand_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
                 */
                register uint64_t x asm ("r2");
 
-               asm volatile ("ldrd\t%0, [%1]" : "=&r" (x) : "r" (io_base));
+//             asm volatile ("ldrd\t%0, [%1]" : "=&r" (x) : "r" (io_base));
                buf64[i++] = x;
        }
        i *= 8;

Not sure all cases are fixed yet, so keep running randconfig.

Patches can be pulled from Git tree:

git://linux-arm.org/linux-vm.git (branch: nommu-rfc-v3)

Cc: Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ryan Mallon <rmallon@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Alexander Shiyan <shc_work@mail.ru>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Russell King <linux@armlinux.org.uk>

Thanks!

Vladimir Murzin (25):
  ARM: NOMMU: define stubs for fixup
  ARM: NOMMU: define debug_ll_io_ini
  ARM: debug: allow debug_ll_addr for NOMMU
  ARM: NOMMU: define SECTION_xxx macros
  ARM: NOMMU: define dummy user structure for feroceon
  ARM: NOMMU: define __arm_ioremap_exec and pci_ioremap functions
  ARM: NOMMU: relax restriction on MPU existence
  ARM: NOMMU: fix head-nommu build for pre-ARMv7 CPUs
  ARM: NOMMU: fix load of CONFIG_VECTORS_BASE
  ARM: NOMMU: implement secondary_startup_arm
  ARM: move arm_heavy_mb to MMU/noMMU neutral place
  ARM: tlbflush: drop dependency on CONFIG_SMP
  ARM: sleep: allow it to be build for R-class
  ARM: setup: move call to erratum_a15_798181_init under CONFIG_MMU
  ARM: kexec: disallow kexec for NOMMU builds
  ARM: ep93xx: select ARM_PATCH_PHYS_VIRT for MMU builds only
  ARM: omap: do not select HIGHMEM explicitly
  ARM: sa1100: move CPU specific copy code under its own config
  ARM: sa11x0: assabet: add dependency on MMU
  ARM: i.MX: remove map_io callback
  PCI: tegra: limit to MMU build only
  IB: add dependency on MMU
  cnic: add dependency on MMU
  scsi: bnx2i: bnx2fc: add dependency on MMU
  ARM: Allow ARCH_MULTIPLATFORM to be selected for NOMMU

 arch/arm/Kconfig                      |   25 +++++++++++++++++++----
 arch/arm/include/asm/fixmap.h         |    6 ++++++
 arch/arm/include/asm/mach/map.h       |    3 +++
 arch/arm/include/asm/page.h           |    2 +-
 arch/arm/include/asm/pgtable-nommu.h  |    6 ++++++
 arch/arm/include/asm/tlbflush.h       |    2 +-
 arch/arm/kernel/Makefile              |    5 +++++
 arch/arm/kernel/debug.S               |    6 ++++--
 arch/arm/kernel/head-nommu.S          |   30 +++++++++++++++++++++++-----
 arch/arm/kernel/setup.c               |    4 ++--
 arch/arm/kernel/sleep.S               |    8 ++++----
 arch/arm/mach-imx/mach-imx1.c         |    1 -
 arch/arm/mach-omap2/Kconfig           |    1 -
 arch/arm/mach-sa1100/Kconfig          |    1 +
 arch/arm/mm/Kconfig                   |    4 ++++
 arch/arm/mm/Makefile                  |    2 +-
 arch/arm/mm/flush.c                   |   15 --------------
 arch/arm/mm/iomap.c                   |   17 ++++++++++++++++
 arch/arm/mm/nommu.c                   |   35 +++++++++++++++++++++++++++++++++
 drivers/infiniband/Kconfig            |    1 +
 drivers/net/ethernet/broadcom/Kconfig |    1 +
 drivers/pci/host/Kconfig              |    2 +-
 drivers/scsi/bnx2fc/Kconfig           |    1 +
 drivers/scsi/bnx2i/Kconfig            |    1 +
 24 files changed, 141 insertions(+), 38 deletions(-)

[1] List of errors/warnings from defconfigs:

acs5k_defconfig
arch/arm/mach-ks8695/cpu.c:37:24: warning: 'ks8695_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc ks8695_io_desc[] __initdata = {
                        ^
acs5k_tiny_defconfig
arch/arm/mach-ks8695/cpu.c:37:24: warning: 'ks8695_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc ks8695_io_desc[] __initdata = {
                        ^
am200epdkit_defconfig
aspeed_g4_defconfig
aspeed_g5_defconfig
assabet_defconfig
arch/arm/mach-sa1100/generic.c:350:24: warning: 'standard_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc standard_io_desc[] __initdata = {
                        ^
/work/tools/gcc-linaro-4.9-2014.11-x86_64_arm-linux-gnueabi/bin/arm-linux-gnueabi-ld: no machine record defined
make: *** [vmlinux] Error 1
at91_dt_defconfig
axm55xx_defconfig
arch/arm/kernel/smp.c:93:22: warning: 'get_arch_pgd' defined but not used [-Wunused-function]
 static unsigned long get_arch_pgd(pgd_t *pgd)
                      ^
badge4_defconfig
arch/arm/mach-sa1100/generic.c:350:24: warning: 'standard_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc standard_io_desc[] __initdata = {
                        ^
arch/arm/mach-sa1100/badge4.c:295:24: warning: 'badge4_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc badge4_io_desc[] __initdata = {
                        ^
bcm2835_defconfig
cerfcube_defconfig
arch/arm/mach-sa1100/generic.c:350:24: warning: 'standard_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc standard_io_desc[] __initdata = {
                        ^
arch/arm/mach-sa1100/cerf.c:137:24: warning: 'cerf_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc cerf_io_desc[] __initdata = {
                        ^
clps711x_defconfig
cm_x2xx_defconfig
cm_x300_defconfig
cns3420vb_defconfig
arch/arm/mach-cns3xxx/core.c:29:24: warning: 'cns3xxx_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc cns3xxx_io_desc[] __initdata = {
                        ^
arch/arm/mach-cns3xxx/cns3420vb.c:230:24: warning: 'cns3420_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc cns3420_io_desc[] __initdata = {
                        ^
colibri_pxa270_defconfig
colibri_pxa300_defconfig
collie_defconfig
arch/arm/mach-sa1100/generic.c:350:24: warning: 'standard_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc standard_io_desc[] __initdata = {
                        ^
arch/arm/mach-sa1100/collie.c:403:24: warning: 'collie_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc collie_io_desc[] __initdata = {
                        ^
corgi_defconfig
davinci_all_defconfig
dove_defconfig
arch/arm/mach-dove/common.c:50:24: warning: 'dove_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc dove_io_desc[] __initdata = {
                        ^
ebsa110_defconfig
arch/arm/mach-ebsa110/core.c:72:24: warning: 'ebsa110_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc ebsa110_io_desc[] __initdata = {
                        ^
efm32_defconfig
em_x270_defconfig
ep93xx_defconfig
arch/arm/mach-ep93xx/core.c:56:24: warning: 'ep93xx_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc ep93xx_io_desc[] __initdata = {
                        ^
arch/arm/mach-ep93xx/ts72xx.c:32:24: warning: 'ts72xx_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc ts72xx_io_desc[] __initdata = {
                        ^
arch/arm/mach-ep93xx/vision_ep9307.c:51:24: warning: 'vision_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc vision_io_desc[] __initdata = {
                        ^
eseries_pxa_defconfig
exynos_defconfig
arch/arm/mach-exynos/exynos.c:31:24: warning: 'exynos4_iodesc' defined but not used [-Wunused-variable]
 static struct map_desc exynos4_iodesc[] __initdata = {
                        ^
arch/arm/kernel/smp.c:93:22: warning: 'get_arch_pgd' defined but not used [-Wunused-function]
 static unsigned long get_arch_pgd(pgd_t *pgd)
                      ^
ezx_defconfig
footbridge_defconfig
arch/arm/mach-footbridge/common.c:140:24: warning: 'fb_common_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc fb_common_io_desc[] __initdata = {
                        ^
arch/arm/mach-footbridge/common.c:153:24: warning: 'ebsa285_host_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc ebsa285_host_io_desc[] __initdata = {
                        ^
h3600_defconfig
arch/arm/mach-sa1100/generic.c:350:24: warning: 'standard_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc standard_io_desc[] __initdata = {
                        ^
arch/arm/mach-sa1100/h3xxx.c:274:24: warning: 'h3600_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc h3600_io_desc[] __initdata = {
                        ^
h5000_defconfig
hackkit_defconfig
arch/arm/mach-sa1100/generic.c:350:24: warning: 'standard_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc standard_io_desc[] __initdata = {
                        ^
arch/arm/mach-sa1100/hackkit.c:64:24: warning: 'hackkit_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc hackkit_io_desc[] __initdata = {
                        ^
hisi_defconfig
arch/arm/mach-hisi/hisilicon.c:31:24: warning: 'hi3620_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc hi3620_io_desc[] __initdata = {
                        ^
arch/arm/kernel/smp.c:93:22: warning: 'get_arch_pgd' defined but not used [-Wunused-function]
 static unsigned long get_arch_pgd(pgd_t *pgd)
                      ^
imote2_defconfig
imx_v4_v5_defconfig
arch/arm/mach-imx/mm-imx21.c:33:24: warning: 'imx21_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc imx21_io_desc[] __initdata = {
                        ^
arch/arm/mach-imx/mm-imx27.c:33:24: warning: 'imx27_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc imx27_io_desc[] __initdata = {
                        ^
arch/arm/mach-imx/mach-mx27ads.c:381:24: warning: 'mx27ads_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc mx27ads_io_desc[] __initdata = {
                        ^
imx_v6_v7_defconfig
arch/arm/mach-imx/mm-imx3.c:119:24: warning: 'mx31_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc mx31_io_desc[] __initdata = {
                        ^
arch/arm/mach-imx/mm-imx3.c:216:24: warning: 'mx35_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc mx35_io_desc[] __initdata = {
                        ^
arch/arm/kernel/smp.c:93:22: warning: 'get_arch_pgd' defined but not used [-Wunused-function]
 static unsigned long get_arch_pgd(pgd_t *pgd)
                      ^
arch/arm/mach-imx/mach-mx31ads.c:542:24: warning: 'mx31ads_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc mx31ads_io_desc[] __initdata = {
                        ^
arch/arm/mach-imx/mach-mx31lite.c:236:24: warning: 'mx31lite_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc mx31lite_io_desc[] __initdata = {
                        ^
arch/arm/mach-imx/mach-kzm_arm11_01.c:262:24: warning: 'kzm_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc kzm_io_desc[] __initdata = {
                        ^
integrator_defconfig
iop13xx_defconfig
iop32x_defconfig
iop33x_defconfig
ixp4xx_defconfig
jornada720_defconfig
arch/arm/mach-sa1100/generic.c:350:24: warning: 'standard_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc standard_io_desc[] __initdata = {
                        ^
arch/arm/mach-sa1100/jornada720.c:277:24: warning: 'jornada720_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc jornada720_io_desc[] __initdata = {
                        ^
keystone_defconfig
arch/arm/kernel/smp.c:93:22: warning: 'get_arch_pgd' defined but not used [-Wunused-function]
 static unsigned long get_arch_pgd(pgd_t *pgd)
                      ^
ks8695_defconfig
arch/arm/mach-ks8695/cpu.c:37:24: warning: 'ks8695_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc ks8695_io_desc[] __initdata = {
                        ^
lart_defconfig
arch/arm/mach-sa1100/generic.c:350:24: warning: 'standard_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc standard_io_desc[] __initdata = {
                        ^
arch/arm/mach-sa1100/lart.c:115:24: warning: 'lart_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc lart_io_desc[] __initdata = {
                        ^
lpc18xx_defconfig
lpc32xx_defconfig
arch/arm/mach-lpc32xx/common.c:70:24: warning: 'lpc32xx_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc lpc32xx_io_desc[] __initdata = {
                        ^
lpd270_defconfig
lubbock_defconfig
magician_defconfig
mainstone_defconfig
mini2440_defconfig
arch/arm/mach-s3c24xx/common.c:155:24: warning: 's3c_iodesc' defined but not used [-Wunused-variable]
 static struct map_desc s3c_iodesc[] __initdata = {
                        ^
arch/arm/mach-s3c24xx/s3c244x.c:49:24: warning: 's3c244x_iodesc' defined but not used [-Wunused-variable]
 static struct map_desc s3c244x_iodesc[] __initdata = {
                        ^
mmp2_defconfig
arch/arm/mach-mmp/common.c:28:24: warning: 'standard_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc standard_io_desc[] __initdata = {
                        ^
moxart_defconfig
mps2_defconfig
multi_v4t_defconfig
arch/arm/mach-clps711x/board-dt.c:33:24: warning: 'clps711x_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc clps711x_io_desc __initdata = {
                        ^
multi_v5_defconfig
arch/arm/mach-imx/mm-imx21.c:33:24: warning: 'imx21_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc imx21_io_desc[] __initdata = {
                        ^
arch/arm/mach-imx/mm-imx27.c:33:24: warning: 'imx27_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc imx27_io_desc[] __initdata = {
                        ^
arch/arm/mach-imx/mach-mx27ads.c:381:24: warning: 'mx27ads_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc mx27ads_io_desc[] __initdata = {
                        ^
multi_v7_defconfig
arch/arm/kernel/smp.c:93:22: warning: 'get_arch_pgd' defined but not used [-Wunused-function]
 static unsigned long get_arch_pgd(pgd_t *pgd)
                      ^
arch/arm/mach-exynos/exynos.c:31:24: warning: 'exynos4_iodesc' defined but not used [-Wunused-variable]
 static struct map_desc exynos4_iodesc[] __initdata = {
                        ^
arch/arm/mach-hisi/hisilicon.c:31:24: warning: 'hi3620_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc hi3620_io_desc[] __initdata = {
                        ^
arch/arm/mach-omap2/io.c:141:24: warning: 'omap34xx_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc omap34xx_io_desc[] __initdata = {
                        ^
arch/arm/mach-omap2/io.c:188:24: warning: 'omapti81xx_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc omapti81xx_io_desc[] __initdata = {
                        ^
arch/arm/mach-omap2/io.c:199:24: warning: 'omapam33xx_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc omapam33xx_io_desc[] __initdata = {
                        ^
arch/arm/mach-omap2/io.c:216:24: warning: 'omap44xx_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc omap44xx_io_desc[] __initdata = {
                        ^
arch/arm/mach-omap2/io.c:239:24: warning: 'omap54xx_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc omap54xx_io_desc[] __initdata = {
                        ^
arch/arm/mach-omap2/io.c:268:24: warning: 'dra7xx_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc dra7xx_io_desc[] __initdata = {
                        ^
arch/arm/mach-tegra/io.c:33:24: warning: 'tegra_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc tegra_io_desc[] __initdata = {
                        ^
arch/arm/mach-vt8500/vt8500.c:52:24: warning: 'vt8500_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc vt8500_io_desc[] __initdata = {
                        ^
arch/arm/mach-spear/spear13xx.c:60:24: warning: 'spear13xx_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc spear13xx_io_desc[] __initdata = {
                        ^
arch/arm/mach-spear/spear1310.c:43:24: warning: 'spear1310_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc spear1310_io_desc[] __initdata = {
                        ^
mv78xx0_defconfig
mvebu_v5_defconfig
mvebu_v7_defconfig
arch/arm/kernel/smp.c:93:22: warning: 'get_arch_pgd' defined but not used [-Wunused-function]
 static unsigned long get_arch_pgd(pgd_t *pgd)
                      ^
mxs_defconfig
neponset_defconfig
arch/arm/mach-sa1100/generic.c:350:24: warning: 'standard_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc standard_io_desc[] __initdata = {
                        ^
/work/tools/gcc-linaro-4.9-2014.11-x86_64_arm-linux-gnueabi/bin/arm-linux-gnueabi-ld: no machine record defined
make: *** [vmlinux] Error 1
netwinder_defconfig
arch/arm/mach-footbridge/common.c:140:24: warning: 'fb_common_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc fb_common_io_desc[] __initdata = {
                        ^
arch/arm/mach-footbridge/common.c:153:24: warning: 'ebsa285_host_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc ebsa285_host_io_desc[] __initdata = {
                        ^
In file included from sound/oss/os.h:20:0,
                 from sound/oss/sound_config.h:20,
                 from sound/oss/midibuf.c:21:
sound/oss/midibuf.c: In function 'MIDIbuf_read':
./arch/arm/include/asm/uaccess.h:530:38: warning: 'tmp_data' may be used uninitialized in this function [-Wmaybe-uninitialized]
 #define __copy_to_user(to, from, n) (memcpy((void __force *)to, from, n), 0)
                                      ^
sound/oss/midibuf.c:316:16: note: 'tmp_data' was declared here
  unsigned char tmp_data;
                ^
netx_defconfig
arch/arm/mach-netx/generic.c:33:24: warning: 'netx_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc netx_io_desc[] __initdata = {
                        ^
nhk8815_defconfig
arch/arm/mach-nomadik/cpu-8815.c:86:24: warning: 'cpu8815_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc cpu8815_io_desc[] __initdata = {
                        ^
nuc910_defconfig
arch/arm/mach-w90x900/cpu.c:45:24: warning: 'nuc900_iodesc' defined but not used [-Wunused-variable]
 static struct map_desc nuc900_iodesc[] __initdata = {
                        ^
nuc950_defconfig
arch/arm/mach-w90x900/cpu.c:45:24: warning: 'nuc900_iodesc' defined but not used [-Wunused-variable]
 static struct map_desc nuc900_iodesc[] __initdata = {
                        ^
nuc960_defconfig
arch/arm/mach-w90x900/cpu.c:45:24: warning: 'nuc900_iodesc' defined but not used [-Wunused-variable]
 static struct map_desc nuc900_iodesc[] __initdata = {
                        ^
omap1_defconfig
omap2plus_defconfig
arch/arm/mach-omap2/io.c:71:24: warning: 'omap24xx_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc omap24xx_io_desc[] __initdata = {
                        ^
arch/arm/mach-omap2/io.c:87:24: warning: 'omap242x_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc omap242x_io_desc[] __initdata = {
                        ^
arch/arm/mach-omap2/io.c:111:24: warning: 'omap243x_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc omap243x_io_desc[] __initdata = {
                        ^
arch/arm/mach-omap2/io.c:141:24: warning: 'omap34xx_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc omap34xx_io_desc[] __initdata = {
                        ^
arch/arm/mach-omap2/io.c:188:24: warning: 'omapti81xx_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc omapti81xx_io_desc[] __initdata = {
                        ^
arch/arm/mach-omap2/io.c:199:24: warning: 'omapam33xx_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc omapam33xx_io_desc[] __initdata = {
                        ^
arch/arm/mach-omap2/io.c:216:24: warning: 'omap44xx_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc omap44xx_io_desc[] __initdata = {
                        ^
arch/arm/mach-omap2/io.c:239:24: warning: 'omap54xx_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc omap54xx_io_desc[] __initdata = {
                        ^
arch/arm/mach-omap2/io.c:268:24: warning: 'dra7xx_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc dra7xx_io_desc[] __initdata = {
                        ^
arch/arm/kernel/smp.c:93:22: warning: 'get_arch_pgd' defined but not used [-Wunused-function]
 static unsigned long get_arch_pgd(pgd_t *pgd)
                      ^
orion5x_defconfig
palmz72_defconfig
pcm027_defconfig
pleb_defconfig
arch/arm/mach-sa1100/generic.c:350:24: warning: 'standard_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc standard_io_desc[] __initdata = {
                        ^
prima2_defconfig
arch/arm/kernel/smp.c:93:22: warning: 'get_arch_pgd' defined but not used [-Wunused-function]
 static unsigned long get_arch_pgd(pgd_t *pgd)
                      ^
pxa168_defconfig
arch/arm/mach-mmp/common.c:28:24: warning: 'standard_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc standard_io_desc[] __initdata = {
                        ^
pxa255-idp_defconfig
pxa3xx_defconfig
pxa910_defconfig
arch/arm/mach-mmp/common.c:28:24: warning: 'standard_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc standard_io_desc[] __initdata = {
                        ^
pxa_defconfig
qcom_defconfig
arch/arm/kernel/smp.c:93:22: warning: 'get_arch_pgd' defined but not used [-Wunused-function]
 static unsigned long get_arch_pgd(pgd_t *pgd)
                      ^
raumfeld_defconfig
realview_defconfig
arch/arm/kernel/smp.c:93:22: warning: 'get_arch_pgd' defined but not used [-Wunused-function]
 static unsigned long get_arch_pgd(pgd_t *pgd)
                      ^
rpc_defconfig
s3c2410_defconfig
arch/arm/mach-s3c24xx/common.c:155:24: warning: 's3c_iodesc' defined but not used [-Wunused-variable]
 static struct map_desc s3c_iodesc[] __initdata = {
                        ^
arch/arm/mach-s3c24xx/s3c2410.c:54:24: warning: 's3c2410_iodesc' defined but not used [-Wunused-variable]
 static struct map_desc s3c2410_iodesc[] __initdata = {
                        ^
arch/arm/mach-s3c24xx/s3c2412.c:64:24: warning: 's3c2412_iodesc' defined but not used [-Wunused-variable]
 static struct map_desc s3c2412_iodesc[] __initdata = {
                        ^
arch/arm/mach-s3c24xx/s3c2416.c:69:24: warning: 's3c2416_iodesc' defined but not used [-Wunused-variable]
 static struct map_desc s3c2416_iodesc[] __initdata = {
                        ^
arch/arm/mach-s3c24xx/s3c244x.c:49:24: warning: 's3c244x_iodesc' defined but not used [-Wunused-variable]
 static struct map_desc s3c244x_iodesc[] __initdata = {
                        ^
arch/arm/mach-s3c24xx/s3c2443.c:50:24: warning: 's3c2443_iodesc' defined but not used [-Wunused-variable]
 static struct map_desc s3c2443_iodesc[] __initdata = {
                        ^
s3c6400_defconfig
arch/arm/mach-s3c64xx/common.c:106:24: warning: 's3c_iodesc' defined but not used [-Wunused-variable]
 static struct map_desc s3c_iodesc[] __initdata = {
                        ^
s5pv210_defconfig
sama5_defconfig
shannon_defconfig
arch/arm/mach-sa1100/generic.c:350:24: warning: 'standard_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc standard_io_desc[] __initdata = {
                        ^
shmobile_defconfig
arch/arm/kernel/smp.c:93:22: warning: 'get_arch_pgd' defined but not used [-Wunused-function]
 static unsigned long get_arch_pgd(pgd_t *pgd)
                      ^
simpad_defconfig
arch/arm/mach-sa1100/generic.c:350:24: warning: 'standard_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc standard_io_desc[] __initdata = {
                        ^
arch/arm/mach-sa1100/simpad.c:121:24: warning: 'simpad_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc simpad_io_desc[] __initdata = {
                        ^
socfpga_defconfig
arch/arm/kernel/smp.c:93:22: warning: 'get_arch_pgd' defined but not used [-Wunused-function]
 static unsigned long get_arch_pgd(pgd_t *pgd)
                      ^
spear13xx_defconfig
arch/arm/mach-spear/spear13xx.c:60:24: warning: 'spear13xx_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc spear13xx_io_desc[] __initdata = {
                        ^
arch/arm/mach-spear/spear1310.c:43:24: warning: 'spear1310_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc spear1310_io_desc[] __initdata = {
                        ^
arch/arm/kernel/smp.c:93:22: warning: 'get_arch_pgd' defined but not used [-Wunused-function]
 static unsigned long get_arch_pgd(pgd_t *pgd)
                      ^
spear3xx_defconfig
spear6xx_defconfig
spitz_defconfig
stm32_defconfig
sunxi_defconfig
arch/arm/kernel/smp.c:93:22: warning: 'get_arch_pgd' defined but not used [-Wunused-function]
 static unsigned long get_arch_pgd(pgd_t *pgd)
                      ^
tct_hammer_defconfig
arch/arm/mach-s3c24xx/common.c:155:24: warning: 's3c_iodesc' defined but not used [-Wunused-variable]
 static struct map_desc s3c_iodesc[] __initdata = {
                        ^
arch/arm/mach-s3c24xx/s3c2410.c:54:24: warning: 's3c2410_iodesc' defined but not used [-Wunused-variable]
 static struct map_desc s3c2410_iodesc[] __initdata = {
                        ^
tegra_defconfig
arch/arm/mach-tegra/io.c:33:24: warning: 'tegra_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc tegra_io_desc[] __initdata = {
                        ^
arch/arm/kernel/smp.c:93:22: warning: 'get_arch_pgd' defined but not used [-Wunused-function]
 static unsigned long get_arch_pgd(pgd_t *pgd)
                      ^
trizeps4_defconfig
u300_defconfig
u8500_defconfig
arch/arm/kernel/smp.c:93:22: warning: 'get_arch_pgd' defined but not used [-Wunused-function]
 static unsigned long get_arch_pgd(pgd_t *pgd)
                      ^
versatile_defconfig
vexpress_defconfig
arch/arm/kernel/smp.c:93:22: warning: 'get_arch_pgd' defined but not used [-Wunused-function]
 static unsigned long get_arch_pgd(pgd_t *pgd)
                      ^
vf610m4_defconfig
viper_defconfig
vt8500_v6_v7_defconfig
arch/arm/mach-vt8500/vt8500.c:52:24: warning: 'vt8500_io_desc' defined but not used [-Wunused-variable]
 static struct map_desc vt8500_io_desc[] __initdata = {
                        ^
xcep_defconfig
zeus_defconfig
zx_defconfig
arch/arm/kernel/smp.c:93:22: warning: 'get_arch_pgd' defined but not used [-Wunused-function]
 static unsigned long get_arch_pgd(pgd_t *pgd)


-- 
1.7.9.5
