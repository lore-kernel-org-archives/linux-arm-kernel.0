From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Wed, 3 Sep 2014 20:05:31 +0300
Subject: [PATCH v3 0/4] gpio: syscon: reuse for keystone 2 socs
Message-ID: <1409763935-5713-1-git-send-email-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series intended to integrate Keystone 2 DSP GPIO controller functionality
into gpio-syscon driver (drivers/gpio/gpio-syscon.c) as requested
by Linus Walleij in [1].

On Keystone SOCs, ARM host can send interrupts to DSP cores using the
DSP GPIO controller IP. Each DSP GPIO controller provides 28 IRQ signals for
each DSP core. This is one of the component used by the IPC mechanism used
on Keystone SOCs.

Keystone 2 DSP GPIO controller has specific features:
- each GPIO can be configured only as output pin;
- setting GPIO value to 1 causes IRQ generation on target DSP core;
- reading pin value returns 0 - if IRQ was handled or 1 - IRQ is still
  pending.

The gpio-syscon driver was need to be updated to satisfy Keystone 2 SoC
requirements:
1) special sequence of operations need to be used to assign output GPIO value.
   As result, first patch introduces SoC specific callback .set() to configure
   output GPIO value.

2) - eight (8) GPIO banks should be supported, but current gpio-syscon driver
   supports only one.
   - there can be more than on syscon devices per SoC and GPIO specific registers 
   can be placed any where. More over, number of syscon devices and their
   configuration can vary even between two versions of the same SoC. 
   As result, second patch introduces new DT property for gpio-syscon devices:
 	gpio,syscon-dev = <&syscon_dev data_reg_offset [direction_reg_offset]>;
   which allows to specify syscon node and data/direction registers offsets in DT.

Also, patch 4 is added to illustrate DSP GPIO configuration in DT used by Keystone 2.

Related discussions:
 [1] https://lkml.org/lkml/2014/7/16/170
 [2] https://lkml.org/lkml/2014/7/23/352

v1:
 https://www.mail-archive.com/devicetree at vger.kernel.org/msg37812.html
v2:
 https://www.mail-archive.com/devicetree at vger.kernel.org/msg38755.html

Grygorii Strashko (4):
  gpio: syscon: add soc specific callback to assign output value
  gpio: syscon: retrive syscon node and regs offsets from dt
  gpio: syscon: reuse for keystone 2 socs
  ARM: dts: keystone-k2hk: add dsp gpio controllers nodes

 .../devicetree/bindings/gpio/gpio-dsp-keystone.txt | 39 +++++++++
 arch/arm/boot/dts/k2hk.dtsi                        | 56 +++++++++++++
 drivers/gpio/gpio-syscon.c                         | 94 +++++++++++++++++++---
 3 files changed, 179 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-dsp-keystone.txt

-- 
1.9.1
