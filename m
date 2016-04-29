From: chunkeey@googlemail.com (Christian Lamparter)
Date: Fri, 29 Apr 2016 02:53:13 +0200
Subject: [RFC v5 0/4] gpio: add DT support for generic memory-mapped GPIOs
Message-ID: <cover.1461888822.git.chunkeey@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds device tree support for generic memory-mapped GPIOs.
The GPIO library already allows drivers and architecture support code to
reuse generic code for managing a GPIO chip. Currently, a developer has
to create a platform device "basic-mmio-gpio" and attach a bgpio_pdata
platform data structure to make use of it. However, for architectures
which rely on the device tree to enumerate devices, creating custom
platform devices is another extra step that can be avoided by having
direct support via a device tree binding.

I initially came across this patch [0] from ?lvaro Fern?ndez Rojas,
while looking for an easy way to add support for the GPIO of my
WD MyBook Live [1] (APM82181 - ppc464). This generic approach patch
allowed me to easily get the GPIO (and the connected LEDs,
buttons, gpiohogs, etc.) up and running. Even tought, Mr. Fernandez
initially developed it for his work on the brcm63xx [2].

The device tree parses for the integrated drivers:
gpio-clps711x, gpio-ge, gpio-moxart and gpio-ts4800 are now part
of the gpio-generic.c driver file. The old driver files have been
removed and the Kconfig, Makefile entries have been updated
accordingly. If no complaints are filed (MODULE_ALIASES?), I'll
go ahead and post the PATCH series beginning of next week.

And finally, the most important stat about the series:
	>>> 312 insertions(+), 412 deletions(-) <<<
	It removes more lines than it adds!

Thanks! (Please keep me in the CC)

[0] <https://patchwork.ozlabs.org/patch/422121/>
[1] <https://github.com/chunkeey/MBL-openwrt>
[2] <https://wiki.openwrt.org/doc/hardware/soc/soc.broadcom.bcm63xx>

changelog:

v4 -> v5:
	- reverted rename of gpio-mmio.c back to gpio-generic.c
	- fixed Andy Shevchenko's comments
	- consolidated changes from clps711x, gpio-ge, gpio-moxart and
	  gpio-ts4800 into one patch.

v3 -> v4:
	- renamed gpio-generic.c to gpio-mmio.c
	- changed compat. string to "linux,gpio-mmio"
	- integrated Cirrus clps711x driver
	- integrated GE FGPA gpio-ge driver
	- integrated MOXA ART GPIO driver
	- integrated TS4800 gpio driver
	- reshuffled patches, reworded commits, fixed spelling errors, etc.

Christian Lamparter (2):
  gpio: generic: fix GPIO_GENERIC_PLATFORM is set to module case
  gpio: move clps711x, moxart, ts4800 and gpio-ge into gpio-generic

?lvaro Fern?ndez Rojas (2):
  gpio: generic: add DT support for generic memory-mapped GPIOs
  gpio: dt-bindings: add gpio-mmio bindings

 .../devicetree/bindings/gpio/gpio-mmio.txt         |  73 +++++++
 drivers/gpio/Kconfig                               |  43 +---
 drivers/gpio/Makefile                              |   4 -
 drivers/gpio/gpio-clps711x.c                       |  91 --------
 drivers/gpio/gpio-ge.c                             | 114 ----------
 drivers/gpio/gpio-generic.c                        | 234 ++++++++++++++++++++-
 drivers/gpio/gpio-moxart.c                         |  84 --------
 drivers/gpio/gpio-ts4800.c                         |  81 -------
 8 files changed, 312 insertions(+), 412 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-mmio.txt
 delete mode 100644 drivers/gpio/gpio-clps711x.c
 delete mode 100644 drivers/gpio/gpio-ge.c
 delete mode 100644 drivers/gpio/gpio-moxart.c
 delete mode 100644 drivers/gpio/gpio-ts4800.c

-- 
2.8.1
