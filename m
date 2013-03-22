From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Fri, 22 Mar 2013 18:43:37 +0100
Subject: [PATCH v4 0/5] move s3c24xx-irq to drivers/irqchip and add dt support
Message-ID: <201303221843.37668.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As suggested by Rob Herring move back to get the parent releationship from dt
like in the first versions, but set the handler from the interrupt property
rather than from a specific list.

This version also implements (hopefully correctly) an idea from him and
Arnd Bergmann to have the parent relationship not described in the controller
node but the device nodes instead.

Therefore the main controller continues to use a two-cell descriptor to set
hwirq and trigger type but the sub-controller switches to a three-cell
descriptor where the third bit describes the hwirq of its parent irq in the
main controller.

As a result a serial node would then look like:
	serial at 50000000 {
		compatible = "samsung,s3c2410-uart";
		reg = <0x50000000 0x4000>;
		interrupt-parent = <&subintc>;
		interrupts = <0 4 28>, <1 4 28>;
	};

Tested on a s3c2416-based board.

As it depends on changes already pending for 3.10 it should probably go thru
the samsung tree.


Heiko Stuebner (5):
  ARM: S3C24XX: move irq driver to drivers/irqchip
  irqchip: s3c24xx: fix comments on some camera interrupts
  irqchip: s3c24xx: fix irqlist of second s3c2416 controller
  irqchip: s3c24xx: add irq_set_type callback for basic interrupt types
  irqchip: s3c24xx: add devicetree support

 .../interrupt-controller/samsung,s3c24xx-irq.txt   |   64 ++++++
 arch/arm/mach-s3c24xx/Makefile                     |    2 +-
 drivers/irqchip/Makefile                           |    1 +
 .../irq.c => drivers/irqchip/irq-s3c24xx.c         |  218 +++++++++++++++++++-
 4 files changed, 277 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/samsung,s3c24xx-irq.txt
 rename arch/arm/mach-s3c24xx/irq.c => drivers/irqchip/irq-s3c24xx.c (87%)

-- 
1.7.2.3
