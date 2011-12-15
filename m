From: pawel.moll@arm.com (Pawel Moll)
Date: Thu, 15 Dec 2011 17:25:17 +0000
Subject: [PATCH v6 3/9] ARM: versatile: Map local timers using Device
 Tree when possible
In-Reply-To: <1323962751.18989.4.camel@hornet.cambridge.arm.com>
References: <1323957761-13553-1-git-send-email-pawel.moll@arm.com>
 <1323957761-13553-4-git-send-email-pawel.moll@arm.com>
 <4EEA09E8.3010807@gmail.com>
 <1323962751.18989.4.camel@hornet.cambridge.arm.com>
Message-ID: <1323969917.18989.8.camel@hornet.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-12-15 at 15:25 +0000, Pawel Moll wrote:
> > I think your previous version was more correct. This is going to find
> > the node and do ioremap N times where N is the number of cores. It does
> > work though because that is what I did initially too.
> 
> Right, how about that, then:
> 
> @@ -21,6 +23,22 @@
>   */
>  int __cpuinit local_timer_setup(struct clock_event_device *evt)
>  {
> +#if defined(CONFIG_OF)
> +       static int dt_node_probed;
> +
> +       if (!dt_node_probed) {
> +               struct device_node *node = of_find_compatible_node(NULL,
> +                               NULL, "arm,smp-twd");
> +
> +               if (node)
> +                       twd_base = of_iomap(node, 0);
> +
> +               dt_node_probed = 1;
> +       }
> +#endif
> +       if (!twd_base)
> +               return -ENXIO;
> +
>         evt->irq = IRQ_LOCALTIMER;
>         twd_timer_setup(evt);
>         return 0;

Ok, so I have updated the both vexpress-dt and
vexpress-dt-rmk-devel-stable branches like that.

Arnd, Russell, the new pull request below.

I'll see you all next year!

Cheers!

Pawe?

8<-------------------------------------------------------------------

The following changes since commit 55b02d2f4445ad625213817a1736bf2884d32547:

  Merge branch 'drm-fixes' of git://people.freedesktop.org/~airlied/linux (2011-12-14 19:45:40 -0800)

are available in the git repository at:

  git://git.linaro.org/people/pawelmoll/linux.git vexpress-dt

Pawel Moll (9):
      ARM: versatile: Add missing ENDPROC to headsmp.S
      ARM: vexpress: Get rid of MMIO_P2V
      ARM: versatile: Map local timers using Device Tree when possible
      ARM: vexpress: Use FDT data in platform SMP calls
      ARM: vexpress: Add Device Tree support
      ARM: vexpress: Motherboard RS1 memory map support
      ARM: vexpress: Add Device Tree for V2P-CA5s core tile
      ARM: vexpress: Add Device Tree for V2P-CA9 core tile
      ARM: vexpress: Add Device Tree for V2P-CA15 core tile (TC1 variant)

 Documentation/devicetree/bindings/arm/vexpress.txt |  144 ++++++++++
 arch/arm/Kconfig                                   |    2 +-
 arch/arm/boot/dts/vexpress-v2m-rs1.dtsi            |  201 ++++++++++++++
 arch/arm/boot/dts/vexpress-v2m.dtsi                |  200 ++++++++++++++
 arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts        |  155 +++++++++++
 arch/arm/boot/dts/vexpress-v2p-ca5s.dts            |  160 +++++++++++
 arch/arm/boot/dts/vexpress-v2p-ca9.dts             |  190 +++++++++++++
 arch/arm/include/asm/hardware/arm_timer.h          |    5 +
 arch/arm/mach-realview/platsmp.c                   |    3 +-
 arch/arm/mach-vexpress/Kconfig                     |   45 +++-
 arch/arm/mach-vexpress/Makefile.boot               |    6 +
 arch/arm/mach-vexpress/core.h                      |    9 +-
 arch/arm/mach-vexpress/ct-ca9x4.c                  |   48 +---
 arch/arm/mach-vexpress/include/mach/ct-ca9x4.h     |   13 +-
 arch/arm/mach-vexpress/include/mach/debug-macro.S  |   37 +++-
 arch/arm/mach-vexpress/include/mach/irqs.h         |    2 +-
 arch/arm/mach-vexpress/include/mach/motherboard.h  |   58 +++--
 arch/arm/mach-vexpress/include/mach/uncompress.h   |   13 +-
 arch/arm/mach-vexpress/platsmp.c                   |  153 ++++++++++-
 arch/arm/mach-vexpress/v2m.c                       |  282 ++++++++++++++++++--
 arch/arm/mm/Kconfig                                |    2 +-
 arch/arm/plat-versatile/headsmp.S                  |    1 +
 arch/arm/plat-versatile/localtimer.c               |   19 ++
 23 files changed, 1628 insertions(+), 120 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/vexpress.txt
 create mode 100644 arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
 create mode 100644 arch/arm/boot/dts/vexpress-v2m.dtsi
 create mode 100644 arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts
 create mode 100644 arch/arm/boot/dts/vexpress-v2p-ca5s.dts
 create mode 100644 arch/arm/boot/dts/vexpress-v2p-ca9.dts
