From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Thu, 21 Aug 2014 19:23:20 +0300
Subject: [PATCH v2 0/3] gpio: syscon: reuse for keystone 2 socs
In-Reply-To: <53ECE9B1.4060303@ti.com>
References: <53ECE9B1.4060303@ti.com>
Message-ID: <1408638203-8246-1-git-send-email-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

Alexander,

I've updated gpio-syscon as requested in [3].
I still don't like it, but any way I did it :(

Linus,

I'd very appreciated if you can comment on these series.
Personally, I like v1 [3], because this v2 is not elegant and will
require constant code patching in case of adding new SoCs or new SoC's versions.

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
- special sequence of operations need to be used to assign output GPIO value.
   As result, first patch introduces SoC specific callback .set() to configure
   output GPIO value.

Also, patch 3 was added to illustrate DSP GPIO configuration in DT used by Keystone 2.

Related sicussions:
 [1] https://lkml.org/lkml/2014/7/16/170
 [2] https://lkml.org/lkml/2014/7/23/352
 [3] https://www.mail-archive.com/devicetree at vger.kernel.org/msg37863.html

Grygorii Strashko (3):
  gpio: syscon: add soc specific callback to assign output value
  gpio: syscon: reuse for keystone 2 socs
  ARM: dts: keystone-k2hk: add dsp gpio controllers nodes

 .../bindings/gpio/gpio-mctrl-keystone.txt          |   42 ++++++
 arch/arm/boot/dts/k2hk.dtsi                        |   48 +++++++
 drivers/gpio/gpio-syscon.c                         |  140 ++++++++++++++++++++
 3 files changed, 230 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-mctrl-keystone.txt

-- 
1.7.9.5
