From: horms@verge.net.au (Simon Horman)
Date: Fri, 7 Aug 2015 10:28:47 +0900
Subject: [GIT PULL v2] Renesas ARM Based SoC Marzen Board Removal for v4.3
In-Reply-To: <20150806081000.GA16520@localhost>
References: <cover.1438581659.git.horms+renesas@verge.net.au>
 <20150806081000.GA16520@localhost>
Message-ID: <20150807012847.GF1145@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 06, 2015 at 10:10:00AM +0200, Olof Johansson wrote:
> On Mon, Aug 03, 2015 at 03:04:55PM +0900, Simon Horman wrote:
> > Hi Olof, Hi Kevin, Hi Arnd,
> > 
> > Please consider these Renesas ARM based SoC marzen board removal for v4.3.
> > 
> > 
> > This series removes legacy r8a7779 SoC and marzen board code.
> > It aims to do do so in a way that does not introduce feature regressions
> > when when booting the r8a7779/marzen board using shmobile_defconfig,
> > which provides for booting using multiplatform, a scenario which previously
> > used board code to provide some features including SMP.
> > 
> > Because of the above this series modifies SoC and DT files,
> > and then removes code. And because of that it was not entirely clear to
> > me which branch it should go into, so I have provided it in a stand-alone
> > branch.
> > 
> > Unfortunately this branch has a number of minor conflicts with the "Renesas
> > ARM Based SoC Cleanup for v4.3", tagged as renesas-cleanup-for-v4.3, which
> > you have previously pulled.
> > 
> > A resolution to those conflicts can be found in the
> > renesas-next-20150730-v4.2-rc1 tag of the renesas tree.
> > 
> > On a more positive note, I believe this to well over 8000 lines of legacy
> > code removed in this cycle :)
> > 
> > 
> > Changes between v1 and v2:
> > 
> > * As requested by Olof: Do not include defconfig updates;
> >   these will be handled separately
> > 
> > 
> > The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:
> > 
> >   Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-marzen-board-removal-for-v4.3
> 
> Merged, but it was a messy one and it's awkward to diff with your proposed
> resolution due to other differences.
> 
> Please double-check that I resolved things correctly. Thanks!

Sorry about that, it seems this has been rather messy.

Unfortunately I have noticed what appear to be two merge problems.

I am not sure what the best way to resolve them is,
but my corrections are below. If you need formal patches please
don't hesitate to ask.

* The arch/arm/mach-shmobile/Makefile problem seems to break builds where
  ARCH_SHMOBILE_LEGACY or ARCH_SHMOBILE_MULTI are enabled. In particular
  the following defconfigs: multi_v7, bockw, shmobile.

* The arch/arm/boot/dts/Makefile problem just causes some unnecessary
  dtb compilation. Which seems harmless though should be cleaned
  up at some point.


diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index dd2063ad194f..333e0e3466f1 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -517,9 +517,7 @@ dtb-$(CONFIG_ARCH_S5PV210) += \
 	s5pv210-torbreck.dtb
 dtb-$(CONFIG_ARCH_SHMOBILE_LEGACY) += \
 	r8a7778-bockw.dtb \
-	r8a7778-bockw-reference.dtb \
-	r8a7779-marzen.dtb \
-	sh73a0-kzm9g.dtb
+	r8a7778-bockw-reference.dtb
 dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += \
 	emev2-kzm9d.dtb \
 	r7s72100-genmai.dtb \
diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index 8d1e0b6ac2a2..476de30798d7 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -53,6 +53,7 @@ obj-$(CONFIG_ARCH_RCAR_GEN2)	+= pm-rcar-gen2.o
 ifndef CONFIG_ARCH_SHMOBILE_MULTI
 obj-$(CONFIG_MACH_BOCKW)	+= board-bockw.o
 obj-$(CONFIG_MACH_BOCKW_REFERENCE)	+= board-bockw-reference.o
+endif
 
 # Framework support
 obj-$(CONFIG_SMP)		+= $(smp-y)
