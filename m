From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 18 Mar 2014 11:22:21 +0000
Subject: *READ THIS IF YOUR SOC HAS A L2 CACHE* PL310 auxctrl settings
In-Reply-To: <CAL_JsqLDun2VkCFK9Fec6n38bNz2w9mscPdXcGYeLiZtiXkVDg@mail.gmail.com>
References: <20140314144835.GP21483@n2100.arm.linux.org.uk>
 <20140316152953.GX21483@n2100.arm.linux.org.uk>
 <CAL_JsqLDun2VkCFK9Fec6n38bNz2w9mscPdXcGYeLiZtiXkVDg@mail.gmail.com>
Message-ID: <20140318112221.GV21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 17, 2014 at 09:00:03AM -0500, Rob Herring wrote:
> On Sun, Mar 16, 2014 at 10:29 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > static struct l2x0_aux prima2_l2x0_aux __initconst = {
> >         .val = 2 << L2X0_AUX_CTRL_WAY_SIZE_SHIFT,
> >         .mask = 0,
> > };
> >
> > static struct l2x0_aux marco_l2x0_aux __initconst = {
> >         .val = (2 << L2X0_AUX_CTRL_WAY_SIZE_SHIFT) |
> >                 (1 << L2X0_AUX_CTRL_ASSOCIATIVITY_SHIFT),
> >         .mask = L2X0_AUX_CTRL_MASK,
> 
> What I like about this is all the bits they are clearing and failing
> to set. Shared override, prefetch, etc.

It gets more fun when you see the full picture.  Here's a table of the
auxctrl settings that everyone uses.  The "good" ones which leave the
auxctrl register value alone are listed at the top.

                                                        DT val      mask
arch/arm/mach-bcm/board_bcm281xx.c:                     Y  00000000 ffffffff
arch/arm/mach-highbank/highbank.c:                      Y  00000000 ffffffff
arch/arm/mach-imx/mach-vf610.c:                         Y  00000000 ffffffff
arch/arm/mach-imx/system.c:                             Y  00000000 ffffffff
arch/arm/mach-mvebu/armada-370-xp.c:                    Y  00000000 ffffffff
arch/arm/mach-rockchip/rockchip.c:                      Y  00000000 ffffffff
arch/arm/mach-socfpga/socfpga.c:                        Y  00000000 ffffffff
arch/arm/mach-berlin/berlin.c:                          Y  70c00000 feffffff
arch/arm/mach-cns3xxx/core.c:                           N  00540000 fe000fff
arch/arm/mach-exynos/common.c:                          Y  7c470001 c200ffff
arch/arm/mach-imx/mm-imx3.c:                            N  00030024 00000000
arch/arm/mach-nomadik/cpu-8815.c:                       Y  00730249 fe000fff
arch/arm/mach-omap2/omap4-common.c:                     Y  aux_ctrl aux_mask
arch/arm/mach-omap2/omap4-common.c:                     N  aux_ctrl aux_mask
arch/arm/mach-prima2/l2x0.c:                            Y  aux->val aux->mask
arch/arm/mach-realview/realview_pbx.c:                  N  02520000 c0000fff
arch/arm/mach-realview/realview_pb1176.c:               N  00730000 fe000fff
arch/arm/mach-realview/realview_eb.c:                   N  00790000 fe000fff
arch/arm/mach-realview/realview_pb11mp.c:               N  00790000 fe000fff
arch/arm/mach-shmobile/setup-r8a7779.c:                 N  40470000 82000fff
arch/arm/mach-shmobile/board-kzm9g.c:                   N  40460000 82000fff
arch/arm/mach-shmobile/board-kzm9g-reference.c:         N  40460000 82000fff
arch/arm/mach-shmobile/board-armadillo800eva.c:         N  40440000 82000fff
arch/arm/mach-shmobile/board-armadillo800eva-reference.c:N 40440000 82000fff
arch/arm/mach-shmobile/setup-r8a7778.c:                 N  40470000 82000fff
arch/arm/mach-spear/spear13xx.c:                        N  70a60001 fe00ffff
arch/arm/mach-sti/board-dt.c:                           Y  30480000 c0000fff
arch/arm/mach-tegra/tegra.c:                            Y  aux_ctrl 8200c3fe
arch/arm/mach-ux500/cache-l2x0.c:                       Y  aux_val  c0000fff
arch/arm/mach-vexpress/v2m.c:                           Y  00400000 fe0fffff
arch/arm/mach-vexpress/ct-ca9x4.c:                      N  00400000 fe0fffff
arch/arm/mach-zynq/common.c:                            Y  02060000 f0f0ffff

Bits 19:17 are the way size, bit 16 (for the PL310) is the associativity
(8 or 16 ways.)  It seems many people have the impression that they have
to set these values according to the size of the cache and they can't
rely on the value already initialised by hardware from synthesis the
options.

tegra:
        cache_type = readl(p + L2X0_CACHE_TYPE);
        aux_ctrl = (cache_type & 0x700) << (17-8);
        aux_ctrl |= 0x7C400001;

Fun, since that's just reading the cache type to generate the auxctrl value
which should already be set to the values in the cache type register.

ux500:
        aux_val = 0x3e000000;
        if (cpu_is_ux540_family())
                aux_val |= L310_AUX_CTRL_WAY_SIZE(4);   /* 128KB way size */
        else
                aux_val |= L310_AUX_CTRL_WAY_SIZE(3);   /* 64KB way size */

omap4:
        if (omap_rev() == OMAP4430_REV_ES1_0) {
                aux_ctrl = L310_AUX_CTRL_ASSOCIATIVITY_16 |
                           L310_AUX_CTRL_CACHE_REPLACE_RR |
                           L310_AUX_CTRL_NS_LOCKDOWN |
                           L310_AUX_CTRL_NS_INT_CTRL |
                           L310_AUX_CTRL_WAY_SIZE(2);
                aux_mask = L2X0_AUX_CTRL_MASK;
        } else {
                aux_ctrl = L310_AUX_CTRL_CACHE_REPLACE_RR |
                           L310_AUX_CTRL_NS_LOCKDOWN |
                           L310_AUX_CTRL_NS_INT_CTRL |
                           L310_AUX_CTRL_SHARED_OVERRIDE |
                           L310_AUX_CTRL_DATA_PREFETCH |
                           L310_AUX_CTRL_INSTR_PREFETCH |
                           L310_AUX_CTRL_EARLY_BRESP;
                aux_mask = ~aux_ctrl;
        }
(I killed its setting of the cache sizing for ES2.)

So, the question is: how much of the messing with way size/associativity
can we kill off?  Can we kill all that off and ensure that aux_val always
has bits 19:16 clear and aux_mask always has them set?

-- 
FTTC broadband for 0.8mile line: now@9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
