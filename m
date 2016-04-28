From: chunkeey@googlemail.com (Christian Lamparter)
Date: Thu, 28 Apr 2016 11:05:10 +0200
Subject: [RFC v4 0/8] gpio: add DT support for generic memory-mapped GPIOs
Message-ID: <cover.1461806071.git.chunkeey@googlemail.com>
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

[0] <https://patchwork.ozlabs.org/patch/422121/>
[1] <https://github.com/chunkeey/MBL-openwrt>
[2] <https://wiki.openwrt.org/doc/hardware/soc/soc.broadcom.bcm63xx>

Currently, the device tree parses for the integrated drivers
(gpio-clps711x, gpio-ge, gpio-moxart and gpio-ts4800) are still
residing in their original driver .c file. This way, these
drivers don't clutter the gpio-generic.c with their own hardware
definitions and MODULE_* statements. I hoped this would make the
transition from the _probe to the parser less painless but the diff
is retty much unreadable. So the next series will consolidate them
into gpio-generic.c and then I can drop the gpio-generic -> gpio-mmio
change. I think this is now mostly a matter of how to organize things
and why not try it just once just so it was tested.

changelog:

v3 -> v4:
	- renamed gpio-generic.c to gpio-mmio.c
	  (The gpio-generic only contains a generic mmio driver,
	  this confuses and angers people!)
	- changed compat. string to "linux,gpio-mmio"
	- integrated Cirrus clps711x driver
	- integrated GE FGPA gpio-ge driver
	- integrated MOXA ART GPIO driver
	- integrated TS4800 gpio driver
	- reshuffled patches, reworded commits, fixed spelling errors, etc.

Thanks! (Please keep me in the CC)
---
Christian Lamparter (6):
  gpio: generic: fix GPIO_GENERIC_PLATFORM is set to module case
  gpio: rename gpio-generic.c into gpio-mmio.c
  gpio: clps711x: integrate cirrus clps711x into gpio-mmio
  gpio: ge: integrate GE's FPGA GPIO into gpio-mmio
  gpio: moxart: integrate MOXA ART GPIO driver into gpio-mmio
  gpio: ts4800: integrate TS4800 into gpio-mmio

?lvaro Fern?ndez Rojas (2):
  gpio: generic: add DT support for generic memory-mapped GPIOs
  gpio: dt-bindings: add gpio-mmio bindings

 .../devicetree/bindings/gpio/gpio-mmio.txt         |  73 +++++++++++++++
 drivers/gpio/Kconfig                               |  57 ++++++------
 drivers/gpio/Makefile                              |  11 ++-
 drivers/gpio/gpio-clps711x.c                       |  84 ++++++-----------
 drivers/gpio/gpio-ge.c                             | 101 ++++++---------------
 drivers/gpio/gpio-mmio-compat.h                    |  65 +++++++++++++
 drivers/gpio/{gpio-generic.c => gpio-mmio.c}       | 101 ++++++++++++++++++++-
 drivers/gpio/gpio-moxart.c                         |  81 +++++------------
 drivers/gpio/gpio-ts4800.c                         |  76 +++++-----------
 9 files changed, 376 insertions(+), 273 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-mmio.txt
 create mode 100644 drivers/gpio/gpio-mmio-compat.h
 rename drivers/gpio/{gpio-generic.c => gpio-mmio.c} (86%)

-- 
2.8.1
