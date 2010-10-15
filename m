From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 14 Oct 2010 23:42:04 -0400 (EDT)
Subject: [PATCH 0/3] Allow late mdesc detection, v4
In-Reply-To: <20100901073913.GF8142@n2100.arm.linux.org.uk>
References: <1282553423.737985.983362819420.0.gpush@pororo>
	<20100901073913.GF8142@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1010142331220.2764@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 1 Sep 2010, Russell King - ARM Linux wrote:

> On Mon, Aug 23, 2010 at 04:50:23PM +0800, Jeremy Kerr wrote:
> > Currently, we probe for a mdesc early in boot. At this early stage, the
> > only thing we use the mdesc for is to determine the debug page mapping.
> > 
> > However, the debug addresses (phys and virt) need to be coded into the
> > addruart macro anyway; the dynamic probing is only going to tell us what
> > we already know.
> > 
> > These changes allow us to use the addruart macros to find the debug
> > mapping addresses, rather than pulling them out of the mdesc. This means
> > that the addresses are only kept in the one place, and that we don't
> > need the mdesc nearly as early.
> 
> I fear that to merge them into my tree now will invite merge conflicts
> and/or code breakage when something gets merged without regard to these
> changes.  As I said last time around, the point to merge these (as newly
> updated patches) is once we freeze new platform support just before the
> next merge window.
> 
> So I'm not merging them until the potential last week prior to the merge
> window opening - please keep an eye on Linus' -rc announcements and
> send updated patches (against my -devel tree - this is one case where
> we're going to have to do it this way) to the patch system at when Linus
> indicates that he's released the final -rc.

I think that time has come, or is very close.  And since Jeremy is away 
on vacation he asked me to handle the submission for those patches on 
his behalf.

So... could you pull the following:

	git://git.linaro.org/people/nico/linux debug_cleanup

It is currently based on your devel branch at commit f7de6b55ea4. If 
you'd prefer another base just tell me.

Jeremy Kerr (3):
      arm/debug: consolidate addruart macros for CONFIG_DEBUG_ICEDCC
      arm: return both physical and virtual addresses from addruart
      arm: use addruart macro to establish debug mappings

Nicolas Pitre (2):
      ARM: make struct machine_desc definition coherent with its comment
      arm: remove machine_desc.io_pg_offst and .phys_io

 arch/arm/include/asm/mach/arch.h                   |    9 +-
 arch/arm/kernel/asm-offsets.c                      |    2 -
 arch/arm/kernel/debug.S                            |   35 +++--
 arch/arm/kernel/head.S                             |   23 ++-
 arch/arm/mach-aaec2000/aaed2000.c                  |    2 -
 arch/arm/mach-aaec2000/include/mach/debug-macro.S  |   10 +-
 arch/arm/mach-at91/board-1arm.c                    |    2 -
 arch/arm/mach-at91/board-afeb-9260v1.c             |    2 -
 arch/arm/mach-at91/board-at572d940hf_ek.c          |    2 -
 arch/arm/mach-at91/board-cam60.c                   |    2 -
 arch/arm/mach-at91/board-cap9adk.c                 |    2 -
 arch/arm/mach-at91/board-carmeva.c                 |    2 -
 arch/arm/mach-at91/board-cpu9krea.c                |    2 -
 arch/arm/mach-at91/board-cpuat91.c                 |    2 -
 arch/arm/mach-at91/board-csb337.c                  |    2 -
 arch/arm/mach-at91/board-csb637.c                  |    2 -
 arch/arm/mach-at91/board-dk.c                      |    2 -
 arch/arm/mach-at91/board-eb9200.c                  |    2 -
 arch/arm/mach-at91/board-ecbat91.c                 |    2 -
 arch/arm/mach-at91/board-eco920.c                  |    2 -
 arch/arm/mach-at91/board-ek.c                      |    2 -
 arch/arm/mach-at91/board-flexibity.c               |    2 -
 arch/arm/mach-at91/board-kafa.c                    |    2 -
 arch/arm/mach-at91/board-kb9202.c                  |    2 -
 arch/arm/mach-at91/board-neocore926.c              |    2 -
 arch/arm/mach-at91/board-picotux200.c              |    2 -
 arch/arm/mach-at91/board-qil-a9260.c               |    2 -
 arch/arm/mach-at91/board-sam9-l9260.c              |    2 -
 arch/arm/mach-at91/board-sam9260ek.c               |    2 -
 arch/arm/mach-at91/board-sam9261ek.c               |    2 -
 arch/arm/mach-at91/board-sam9263ek.c               |    2 -
 arch/arm/mach-at91/board-sam9g20ek.c               |    4 -
 arch/arm/mach-at91/board-sam9m10g45ek.c            |    2 -
 arch/arm/mach-at91/board-sam9rlek.c                |    2 -
 arch/arm/mach-at91/board-snapper9260.c             |    2 -
 arch/arm/mach-at91/board-stamp9g20.c               |    4 -
 arch/arm/mach-at91/board-usb-a9260.c               |    2 -
 arch/arm/mach-at91/board-usb-a9263.c               |    2 -
 arch/arm/mach-at91/board-yl-9200.c                 |    2 -
 arch/arm/mach-at91/include/mach/debug-macro.S      |    8 +-
 arch/arm/mach-bcmring/arch.c                       |    2 -
 arch/arm/mach-clps711x/autcpu12.c                  |    2 -
 arch/arm/mach-clps711x/cdb89712.c                  |    2 -
 arch/arm/mach-clps711x/ceiva.c                     |    2 -
 arch/arm/mach-clps711x/clep7312.c                  |    2 -
 arch/arm/mach-clps711x/edb7211-arch.c              |    2 -
 arch/arm/mach-clps711x/fortunet.c                  |    2 -
 arch/arm/mach-clps711x/include/mach/debug-macro.S  |   12 +-
 arch/arm/mach-clps711x/p720t.c                     |    2 -
 arch/arm/mach-cns3xxx/cns3420vb.c                  |    2 -
 arch/arm/mach-cns3xxx/include/mach/debug-macro.S   |   10 +-
 arch/arm/mach-davinci/board-da830-evm.c            |    2 -
 arch/arm/mach-davinci/board-da850-evm.c            |    2 -
 arch/arm/mach-davinci/board-dm355-evm.c            |    2 -
 arch/arm/mach-davinci/board-dm355-leopard.c        |    2 -
 arch/arm/mach-davinci/board-dm365-evm.c            |    2 -
 arch/arm/mach-davinci/board-dm644x-evm.c           |    2 -
 arch/arm/mach-davinci/board-dm646x-evm.c           |    4 -
 arch/arm/mach-davinci/board-neuros-osd2.c          |    2 -
 arch/arm/mach-davinci/board-sffsdr.c               |    2 -
 arch/arm/mach-davinci/board-tnetv107x-evm.c        |    2 -
 arch/arm/mach-davinci/include/mach/debug-macro.S   |   46 +++---
 arch/arm/mach-dove/dove-db-setup.c                 |    2 -
 arch/arm/mach-dove/include/mach/debug-macro.S      |   11 +-
 arch/arm/mach-ebsa110/core.c                       |    2 -
 arch/arm/mach-ebsa110/include/mach/debug-macro.S   |    7 +-
 arch/arm/mach-ep93xx/adssphere.c                   |    2 -
 arch/arm/mach-ep93xx/edb93xx.c                     |   16 --
 arch/arm/mach-ep93xx/gesbc9312.c                   |    2 -
 arch/arm/mach-ep93xx/include/mach/debug-macro.S    |   11 +-
 arch/arm/mach-ep93xx/micro9.c                      |    8 -
 arch/arm/mach-ep93xx/simone.c                      |    2 -
 arch/arm/mach-ep93xx/snappercl15.c                 |    2 -
 arch/arm/mach-ep93xx/ts72xx.c                      |    2 -
 arch/arm/mach-footbridge/cats-hw.c                 |    2 -
 arch/arm/mach-footbridge/ebsa285.c                 |    2 -
 .../arm/mach-footbridge/include/mach/debug-macro.S |   22 +--
 arch/arm/mach-footbridge/netwinder-hw.c            |    2 -
 arch/arm/mach-footbridge/personal.c                |    2 -
 arch/arm/mach-gemini/board-nas4220b.c              |    2 -
 arch/arm/mach-gemini/board-rut1xx.c                |    2 -
 arch/arm/mach-gemini/board-wbd111.c                |    2 -
 arch/arm/mach-gemini/board-wbd222.c                |    2 -
 arch/arm/mach-gemini/include/mach/debug-macro.S    |    8 +-
 arch/arm/mach-h720x/h7201-eval.c                   |    2 -
 arch/arm/mach-h720x/h7202-eval.c                   |    2 -
 arch/arm/mach-h720x/include/mach/debug-macro.S     |   10 +-
 arch/arm/mach-imx/mach-cpuimx27.c                  |    2 -
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c        |    2 -
 arch/arm/mach-imx/mach-imx27lite.c                 |    2 -
 arch/arm/mach-imx/mach-mx1ads.c                    |    4 -
 arch/arm/mach-imx/mach-mx21ads.c                   |    2 -
 arch/arm/mach-imx/mach-mx27_3ds.c                  |    2 -
 arch/arm/mach-imx/mach-mx27ads.c                   |    2 -
 arch/arm/mach-imx/mach-mxt_td60.c                  |    2 -
 arch/arm/mach-imx/mach-pca100.c                    |    2 -
 arch/arm/mach-imx/mach-pcm038.c                    |    2 -
 arch/arm/mach-imx/mach-scb9328.c                   |    2 -
 .../arm/mach-integrator/include/mach/debug-macro.S |   10 +-
 arch/arm/mach-integrator/integrator_ap.c           |    2 -
 arch/arm/mach-integrator/integrator_cp.c           |    2 -
 arch/arm/mach-iop13xx/include/mach/debug-macro.S   |   16 +-
 arch/arm/mach-iop13xx/iq81340mc.c                  |    2 -
 arch/arm/mach-iop13xx/iq81340sc.c                  |    2 -
 arch/arm/mach-iop32x/em7210.c                      |    2 -
 arch/arm/mach-iop32x/glantank.c                    |    2 -
 arch/arm/mach-iop32x/include/mach/debug-macro.S    |    7 +-
 arch/arm/mach-iop32x/iq31244.c                     |    4 -
 arch/arm/mach-iop32x/iq80321.c                     |    2 -
 arch/arm/mach-iop32x/n2100.c                       |    2 -
 arch/arm/mach-iop33x/include/mach/debug-macro.S    |   12 +-
 arch/arm/mach-iop33x/iq80331.c                     |    2 -
 arch/arm/mach-iop33x/iq80332.c                     |    2 -
 arch/arm/mach-ixp2000/enp2611.c                    |    2 -
 arch/arm/mach-ixp2000/include/mach/debug-macro.S   |   14 +-
 arch/arm/mach-ixp2000/ixdp2400.c                   |    2 -
 arch/arm/mach-ixp2000/ixdp2800.c                   |    2 -
 arch/arm/mach-ixp2000/ixdp2x01.c                   |    6 -
 arch/arm/mach-ixp23xx/espresso.c                   |    2 -
 arch/arm/mach-ixp23xx/include/mach/debug-macro.S   |   11 +-
 arch/arm/mach-ixp23xx/ixdp2351.c                   |    2 -
 arch/arm/mach-ixp23xx/roadrunner.c                 |    2 -
 arch/arm/mach-ixp4xx/avila-setup.c                 |    4 -
 arch/arm/mach-ixp4xx/coyote-setup.c                |    4 -
 arch/arm/mach-ixp4xx/dsmg600-setup.c               |    2 -
 arch/arm/mach-ixp4xx/fsg-setup.c                   |    2 -
 arch/arm/mach-ixp4xx/gateway7001-setup.c           |    2 -
 arch/arm/mach-ixp4xx/goramo_mlr.c                  |    2 -
 arch/arm/mach-ixp4xx/gtwx5715-setup.c              |    2 -
 arch/arm/mach-ixp4xx/include/mach/debug-macro.S    |   16 +-
 arch/arm/mach-ixp4xx/ixdp425-setup.c               |    8 -
 arch/arm/mach-ixp4xx/nas100d-setup.c               |    2 -
 arch/arm/mach-ixp4xx/nslu2-setup.c                 |    2 -
 arch/arm/mach-ixp4xx/vulcan-setup.c                |    2 -
 arch/arm/mach-ixp4xx/wg302v2-setup.c               |    2 -
 arch/arm/mach-kirkwood/d2net_v2-setup.c            |    2 -
 arch/arm/mach-kirkwood/db88f6281-bp-setup.c        |    2 -
 arch/arm/mach-kirkwood/dockstar-setup.c            |    2 -
 arch/arm/mach-kirkwood/guruplug-setup.c            |    2 -
 arch/arm/mach-kirkwood/include/mach/debug-macro.S  |   11 +-
 arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c     |    2 -
 arch/arm/mach-kirkwood/netspace_v2-setup.c         |    6 -
 arch/arm/mach-kirkwood/netxbig_v2-setup.c          |    4 -
 arch/arm/mach-kirkwood/openrd-setup.c              |    6 -
 arch/arm/mach-kirkwood/rd88f6192-nas-setup.c       |    2 -
 arch/arm/mach-kirkwood/rd88f6281-setup.c           |    2 -
 arch/arm/mach-kirkwood/sheevaplug-setup.c          |    4 -
 arch/arm/mach-kirkwood/t5325-setup.c               |    2 -
 arch/arm/mach-kirkwood/ts219-setup.c               |    2 -
 arch/arm/mach-kirkwood/ts41x-setup.c               |    2 -
 arch/arm/mach-ks8695/board-acs5k.c                 |    2 -
 arch/arm/mach-ks8695/board-dsm320.c                |    2 -
 arch/arm/mach-ks8695/board-micrel.c                |    2 -
 arch/arm/mach-ks8695/include/mach/debug-macro.S    |    8 +-
 arch/arm/mach-l7200/include/mach/debug-macro.S     |   38 ++++
 arch/arm/mach-lh7a40x/arch-kev7a400.c              |    2 -
 arch/arm/mach-lh7a40x/arch-lpd7a40x.c              |    4 -
 arch/arm/mach-lh7a40x/include/mach/debug-macro.S   |   10 +-
 arch/arm/mach-loki/include/mach/debug-macro.S      |   11 +-
 arch/arm/mach-loki/lb88rc8480-setup.c              |    2 -
 arch/arm/mach-lpc32xx/include/mach/debug-macro.S   |    8 +-
 arch/arm/mach-lpc32xx/phy3250.c                    |    2 -
 arch/arm/mach-mmp/aspenite.c                       |    4 -
 arch/arm/mach-mmp/avengers_lite.c                  |    2 -
 arch/arm/mach-mmp/flint.c                          |    2 -
 arch/arm/mach-mmp/include/mach/debug-macro.S       |   11 +-
 arch/arm/mach-mmp/jasper.c                         |    2 -
 arch/arm/mach-mmp/tavorevb.c                       |    2 -
 arch/arm/mach-mmp/ttc_dkb.c                        |    2 -
 arch/arm/mach-msm/board-halibut.c                  |    2 -
 arch/arm/mach-msm/board-mahimahi.c                 |    2 -
 arch/arm/mach-msm/board-msm7x27.c                  |    8 -
 arch/arm/mach-msm/board-msm7x30.c                  |    6 -
 arch/arm/mach-msm/board-qsd8x50.c                  |    4 -
 arch/arm/mach-msm/board-sapphire.c                 |    2 -
 arch/arm/mach-msm/board-trout.c                    |    2 -
 arch/arm/mach-msm/include/mach/debug-macro.S       |   10 +-
 arch/arm/mach-mv78xx0/buffalo-wxl-setup.c          |    2 -
 arch/arm/mach-mv78xx0/db78x00-bp-setup.c           |    2 -
 arch/arm/mach-mv78xx0/include/mach/debug-macro.S   |   11 +-
 arch/arm/mach-mv78xx0/rd78x00-masa-setup.c         |    2 -
 arch/arm/mach-mx25/mach-cpuimx25.c                 |    2 -
 arch/arm/mach-mx25/mach-mx25_3ds.c                 |    2 -
 arch/arm/mach-mx3/mach-armadillo5x0.c              |    2 -
 arch/arm/mach-mx3/mach-cpuimx35.c                  |    2 -
 arch/arm/mach-mx3/mach-kzm_arm11_01.c              |    2 -
 arch/arm/mach-mx3/mach-mx31_3ds.c                  |    2 -
 arch/arm/mach-mx3/mach-mx31ads.c                   |    2 -
 arch/arm/mach-mx3/mach-mx31lilly.c                 |    2 -
 arch/arm/mach-mx3/mach-mx31lite.c                  |    2 -
 arch/arm/mach-mx3/mach-mx31moboard.c               |    2 -
 arch/arm/mach-mx3/mach-mx35_3ds.c                  |    2 -
 arch/arm/mach-mx3/mach-pcm037.c                    |    2 -
 arch/arm/mach-mx3/mach-pcm043.c                    |    2 -
 arch/arm/mach-mx3/mach-qong.c                      |    2 -
 arch/arm/mach-mx5/board-cpuimx51.c                 |    2 -
 arch/arm/mach-mx5/board-mx51_3ds.c                 |    2 -
 arch/arm/mach-mx5/board-mx51_babbage.c             |    2 -
 arch/arm/mach-mx5/board-mx51_efikamx.c             |    2 -
 arch/arm/mach-mxc91231/magx-zn5.c                  |    2 -
 arch/arm/mach-netx/include/mach/debug-macro.S      |   10 +-
 arch/arm/mach-netx/nxdb500.c                       |    2 -
 arch/arm/mach-netx/nxdkn.c                         |    2 -
 arch/arm/mach-netx/nxeb500hmi.c                    |    2 -
 arch/arm/mach-nomadik/board-nhk8815.c              |    2 -
 arch/arm/mach-nomadik/include/mach/debug-macro.S   |   12 +-
 arch/arm/mach-ns9xxx/include/mach/debug-macro.S    |    8 +-
 arch/arm/mach-nuc93x/mach-nuc932evb.c              |    2 -
 arch/arm/mach-omap1/board-ams-delta.c              |    2 -
 arch/arm/mach-omap1/board-fsample.c                |    2 -
 arch/arm/mach-omap1/board-generic.c                |    2 -
 arch/arm/mach-omap1/board-h2.c                     |    2 -
 arch/arm/mach-omap1/board-h3.c                     |    2 -
 arch/arm/mach-omap1/board-htcherald.c              |    2 -
 arch/arm/mach-omap1/board-innovator.c              |    2 -
 arch/arm/mach-omap1/board-nokia770.c               |    2 -
 arch/arm/mach-omap1/board-osk.c                    |    2 -
 arch/arm/mach-omap1/board-palmte.c                 |    2 -
 arch/arm/mach-omap1/board-palmtt.c                 |    2 -
 arch/arm/mach-omap1/board-palmz71.c                |    2 -
 arch/arm/mach-omap1/board-perseus2.c               |    2 -
 arch/arm/mach-omap1/board-sx1.c                    |    2 -
 arch/arm/mach-omap1/board-voiceblue.c              |    2 -
 arch/arm/mach-omap1/include/mach/debug-macro.S     |   68 ++++----
 arch/arm/mach-omap2/board-2430sdp.c                |    2 -
 arch/arm/mach-omap2/board-3430sdp.c                |    2 -
 arch/arm/mach-omap2/board-3630sdp.c                |    2 -
 arch/arm/mach-omap2/board-4430sdp.c                |    2 -
 arch/arm/mach-omap2/board-am3517evm.c              |    2 -
 arch/arm/mach-omap2/board-apollon.c                |    2 -
 arch/arm/mach-omap2/board-cm-t35.c                 |    2 -
 arch/arm/mach-omap2/board-devkit8000.c             |    2 -
 arch/arm/mach-omap2/board-generic.c                |    2 -
 arch/arm/mach-omap2/board-h4.c                     |    2 -
 arch/arm/mach-omap2/board-igep0020.c               |    2 -
 arch/arm/mach-omap2/board-ldp.c                    |    2 -
 arch/arm/mach-omap2/board-n8x0.c                   |    6 -
 arch/arm/mach-omap2/board-omap3beagle.c            |    2 -
 arch/arm/mach-omap2/board-omap3evm.c               |    2 -
 arch/arm/mach-omap2/board-omap3pandora.c           |    2 -
 arch/arm/mach-omap2/board-omap3stalker.c           |    2 -
 arch/arm/mach-omap2/board-omap3touchbook.c         |    2 -
 arch/arm/mach-omap2/board-omap4panda.c             |    2 -
 arch/arm/mach-omap2/board-overo.c                  |    2 -
 arch/arm/mach-omap2/board-rx51.c                   |    2 -
 arch/arm/mach-omap2/board-zoom2.c                  |    2 -
 arch/arm/mach-omap2/board-zoom3.c                  |    2 -
 arch/arm/mach-omap2/include/mach/debug-macro.S     |  127 +++++++-------
 arch/arm/mach-orion5x/d2net-setup.c                |    4 -
 arch/arm/mach-orion5x/db88f5281-setup.c            |    2 -
 arch/arm/mach-orion5x/dns323-setup.c               |    2 -
 arch/arm/mach-orion5x/edmini_v2-setup.c            |    2 -
 arch/arm/mach-orion5x/include/mach/debug-macro.S   |   11 +-
 arch/arm/mach-orion5x/kurobox_pro-setup.c          |    4 -
 arch/arm/mach-orion5x/ls_hgl-setup.c               |    2 -
 arch/arm/mach-orion5x/lsmini-setup.c               |    2 -
 arch/arm/mach-orion5x/mss2-setup.c                 |    2 -
 arch/arm/mach-orion5x/mv2120-setup.c               |    2 -
 arch/arm/mach-orion5x/net2big-setup.c              |    2 -
 arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c       |    2 -
 arch/arm/mach-orion5x/rd88f5181l-ge-setup.c        |    2 -
 arch/arm/mach-orion5x/rd88f5182-setup.c            |    2 -
 arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c       |    2 -
 arch/arm/mach-orion5x/terastation_pro2-setup.c     |    2 -
 arch/arm/mach-orion5x/ts209-setup.c                |    2 -
 arch/arm/mach-orion5x/ts409-setup.c                |    2 -
 arch/arm/mach-orion5x/ts78xx-setup.c               |    2 -
 arch/arm/mach-orion5x/wnr854t-setup.c              |    2 -
 arch/arm/mach-orion5x/wrt350n-v2-setup.c           |    2 -
 arch/arm/mach-pnx4008/core.c                       |    2 -
 arch/arm/mach-pnx4008/include/mach/debug-macro.S   |   10 +-
 arch/arm/mach-pxa/balloon3.c                       |    2 -
 arch/arm/mach-pxa/capc7117.c                       |    2 -
 arch/arm/mach-pxa/cm-x2xx.c                        |    2 -
 arch/arm/mach-pxa/cm-x300.c                        |    2 -
 arch/arm/mach-pxa/colibri-pxa270.c                 |    4 -
 arch/arm/mach-pxa/colibri-pxa300.c                 |    2 -
 arch/arm/mach-pxa/colibri-pxa320.c                 |    2 -
 arch/arm/mach-pxa/corgi.c                          |    6 -
 arch/arm/mach-pxa/csb726.c                         |    2 -
 arch/arm/mach-pxa/em-x270.c                        |    4 -
 arch/arm/mach-pxa/eseries.c                        |   12 --
 arch/arm/mach-pxa/ezx.c                            |   12 --
 arch/arm/mach-pxa/gumstix.c                        |    2 -
 arch/arm/mach-pxa/h5000.c                          |    2 -
 arch/arm/mach-pxa/himalaya.c                       |    2 -
 arch/arm/mach-pxa/hx4700.c                         |    2 -
 arch/arm/mach-pxa/icontrol.c                       |    2 -
 arch/arm/mach-pxa/idp.c                            |    2 -
 arch/arm/mach-pxa/include/mach/debug-macro.S       |   10 +-
 arch/arm/mach-pxa/littleton.c                      |    2 -
 arch/arm/mach-pxa/lpd270.c                         |    2 -
 arch/arm/mach-pxa/lubbock.c                        |    2 -
 arch/arm/mach-pxa/magician.c                       |    2 -
 arch/arm/mach-pxa/mainstone.c                      |    2 -
 arch/arm/mach-pxa/mioa701.c                        |    2 -
 arch/arm/mach-pxa/mp900.c                          |    2 -
 arch/arm/mach-pxa/palmld.c                         |    2 -
 arch/arm/mach-pxa/palmt5.c                         |    2 -
 arch/arm/mach-pxa/palmtc.c                         |    2 -
 arch/arm/mach-pxa/palmte2.c                        |    2 -
 arch/arm/mach-pxa/palmtreo.c                       |    4 -
 arch/arm/mach-pxa/palmtx.c                         |    2 -
 arch/arm/mach-pxa/palmz72.c                        |    2 -
 arch/arm/mach-pxa/pcm027.c                         |    2 -
 arch/arm/mach-pxa/poodle.c                         |    2 -
 arch/arm/mach-pxa/raumfeld.c                       |    6 -
 arch/arm/mach-pxa/saar.c                           |    2 -
 arch/arm/mach-pxa/spitz.c                          |    6 -
 arch/arm/mach-pxa/stargate2.c                      |    4 -
 arch/arm/mach-pxa/tavorevb.c                       |    2 -
 arch/arm/mach-pxa/tosa.c                           |    2 -
 arch/arm/mach-pxa/trizeps4.c                       |    4 -
 arch/arm/mach-pxa/viper.c                          |    2 -
 arch/arm/mach-pxa/vpac270.c                        |    2 -
 arch/arm/mach-pxa/xcep.c                           |    2 -
 arch/arm/mach-pxa/z2.c                             |    2 -
 arch/arm/mach-pxa/zeus.c                           |    2 -
 arch/arm/mach-pxa/zylonite.c                       |    2 -
 arch/arm/mach-realview/include/mach/debug-macro.S  |   10 +-
 arch/arm/mach-realview/realview_eb.c               |    2 -
 arch/arm/mach-realview/realview_pb1176.c           |    2 -
 arch/arm/mach-realview/realview_pb11mp.c           |    2 -
 arch/arm/mach-realview/realview_pba8.c             |    2 -
 arch/arm/mach-realview/realview_pbx.c              |    2 -
 arch/arm/mach-rpc/include/mach/debug-macro.S       |   12 +-
 arch/arm/mach-rpc/riscpc.c                         |    2 -
 arch/arm/mach-s3c2410/include/mach/debug-macro.S   |   11 +-
 arch/arm/mach-s3c2410/mach-amlm5900.c              |    2 -
 arch/arm/mach-s3c2410/mach-bast.c                  |    2 -
 arch/arm/mach-s3c2410/mach-h1940.c                 |    2 -
 arch/arm/mach-s3c2410/mach-n30.c                   |    4 -
 arch/arm/mach-s3c2410/mach-otom.c                  |    2 -
 arch/arm/mach-s3c2410/mach-qt2410.c                |    2 -
 arch/arm/mach-s3c2410/mach-smdk2410.c              |    2 -
 arch/arm/mach-s3c2410/mach-tct_hammer.c            |    2 -
 arch/arm/mach-s3c2410/mach-vr1000.c                |    2 -
 arch/arm/mach-s3c2412/mach-jive.c                  |    2 -
 arch/arm/mach-s3c2412/mach-smdk2413.c              |    6 -
 arch/arm/mach-s3c2412/mach-vstms.c                 |    2 -
 arch/arm/mach-s3c2416/mach-smdk2416.c              |    2 -
 arch/arm/mach-s3c2440/mach-anubis.c                |    2 -
 arch/arm/mach-s3c2440/mach-at2440evb.c             |    2 -
 arch/arm/mach-s3c2440/mach-gta02.c                 |    2 -
 arch/arm/mach-s3c2440/mach-mini2440.c              |    2 -
 arch/arm/mach-s3c2440/mach-nexcoder.c              |    2 -
 arch/arm/mach-s3c2440/mach-osiris.c                |    2 -
 arch/arm/mach-s3c2440/mach-rx1950.c                |    2 -
 arch/arm/mach-s3c2440/mach-rx3715.c                |    2 -
 arch/arm/mach-s3c2440/mach-smdk2440.c              |    2 -
 arch/arm/mach-s3c2443/mach-smdk2443.c              |    2 -
 arch/arm/mach-s3c24a0/include/mach/debug-macro.S   |   11 +-
 arch/arm/mach-s3c64xx/include/mach/debug-macro.S   |   11 +-
 arch/arm/mach-s3c64xx/mach-anw6410.c               |    2 -
 arch/arm/mach-s3c64xx/mach-hmt.c                   |    2 -
 arch/arm/mach-s3c64xx/mach-ncp.c                   |    2 -
 arch/arm/mach-s3c64xx/mach-real6410.c              |    2 -
 arch/arm/mach-s3c64xx/mach-smartq5.c               |    2 -
 arch/arm/mach-s3c64xx/mach-smartq7.c               |    2 -
 arch/arm/mach-s3c64xx/mach-smdk6400.c              |    2 -
 arch/arm/mach-s3c64xx/mach-smdk6410.c              |    2 -
 arch/arm/mach-s5p6440/include/mach/debug-macro.S   |   11 +-
 arch/arm/mach-s5p6440/mach-smdk6440.c              |    2 -
 arch/arm/mach-s5p6442/include/mach/debug-macro.S   |   11 +-
 arch/arm/mach-s5p6442/mach-smdk6442.c              |    2 -
 arch/arm/mach-s5pc100/include/mach/debug-macro.S   |   11 +-
 arch/arm/mach-s5pc100/mach-smdkc100.c              |    2 -
 arch/arm/mach-s5pv210/include/mach/debug-macro.S   |   11 +-
 arch/arm/mach-s5pv210/mach-aquila.c                |    2 -
 arch/arm/mach-s5pv210/mach-goni.c                  |    2 -
 arch/arm/mach-s5pv210/mach-smdkc110.c              |    2 -
 arch/arm/mach-s5pv210/mach-smdkv210.c              |    2 -
 arch/arm/mach-s5pv310/include/mach/debug-macro.S   |   11 +-
 arch/arm/mach-s5pv310/mach-smdkv310.c              |    2 -
 arch/arm/mach-s5pv310/mach-universal_c210.c        |    2 -
 arch/arm/mach-sa1100/assabet.c                     |    2 -
 arch/arm/mach-sa1100/badge4.c                      |    2 -
 arch/arm/mach-sa1100/cerf.c                        |    2 -
 arch/arm/mach-sa1100/collie.c                      |    2 -
 arch/arm/mach-sa1100/h3100.c                       |    2 -
 arch/arm/mach-sa1100/h3600.c                       |    2 -
 arch/arm/mach-sa1100/hackkit.c                     |    2 -
 arch/arm/mach-sa1100/include/mach/debug-macro.S    |   36 ++--
 arch/arm/mach-sa1100/jornada720.c                  |    2 -
 arch/arm/mach-sa1100/lart.c                        |    2 -
 arch/arm/mach-sa1100/pleb.c                        |    2 -
 arch/arm/mach-sa1100/shannon.c                     |    2 -
 arch/arm/mach-sa1100/simpad.c                      |    2 -
 arch/arm/mach-shark/core.c                         |    2 -
 arch/arm/mach-shark/include/mach/debug-macro.S     |    7 +-
 arch/arm/mach-shmobile/board-ap4evb.c              |    2 -
 arch/arm/mach-shmobile/board-g3evm.c               |    2 -
 arch/arm/mach-shmobile/board-g4evm.c               |    2 -
 arch/arm/mach-stmp378x/stmp378x_devb.c             |    2 -
 arch/arm/mach-stmp37xx/stmp37xx_devb.c             |    2 -
 arch/arm/mach-tcc8k/board-tcc8000-sdk.c            |    2 -
 arch/arm/mach-tegra/board-harmony.c                |    2 -
 arch/arm/mach-tegra/include/mach/debug-macro.S     |   26 ++--
 arch/arm/mach-u300/include/mach/debug-macro.S      |   11 +-
 arch/arm/mach-u300/u300.c                          |    2 -
 arch/arm/mach-ux500/board-mop500.c                 |    2 -
 arch/arm/mach-ux500/board-u5500.c                  |    2 -
 arch/arm/mach-ux500/include/mach/debug-macro.S     |    8 +-
 arch/arm/mach-versatile/include/mach/debug-macro.S |   12 +-
 arch/arm/mach-versatile/versatile_ab.c             |    2 -
 arch/arm/mach-versatile/versatile_pb.c             |    2 -
 arch/arm/mach-vexpress/ct-ca9x4.c                  |    2 -
 arch/arm/mach-vexpress/include/mach/debug-macro.S  |   10 +-
 arch/arm/mach-w90x900/mach-nuc910evb.c             |    2 -
 arch/arm/mach-w90x900/mach-nuc950evb.c             |    2 -
 arch/arm/mach-w90x900/mach-nuc960evb.c             |    2 -
 arch/arm/plat-mxc/include/mach/debug-macro.S       |    8 +-
 arch/arm/plat-spear/include/plat/debug-macro.S     |    8 +-
 arch/arm/plat-stmp3xxx/include/mach/debug-macro.S  |   11 +-
 arch/arm/plat-tcc/include/mach/debug-macro.S       |   11 +-
 415 files changed, 469 insertions(+), 1311 deletions(-)






> 
> Thanks.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
