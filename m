From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Thu, 2 Apr 2015 11:38:12 +0200
Subject: [RFC PATCH 0/4] pinctrl: prototyping a per pin mux approach
Message-ID: <1427967496-22533-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Here is an implementation of what I need for the future at91 pin controller.
The pinctrl driver is a draft made for a sama5d4 in order to test it. 
It is not clean and many things are missing but I think it will be easier to
debate on code.

>From the discussion with Sascha, it seems that we agree that current pinctrl
doesn't fit the needs of controllers who have per pin muxing because the
concepts of groups is not real.
In my opinion, even if groups are not real it is quite convenient to use them
at least for debug sysfs.

The new at91 pin controller is close to Mediatek one. I am not totally happy
with their solution since a group is describing a pin. It is probably the
easiest way to do it but it doesn't fit my needs. I have two constraints:

- I want something readable in sysfs as:

device fc000000.mmc
state default
type MUX_GROUP (2)
controlling device ahb:apb:pinctrl at fc06a000
group mci1_0_4bit
function C

device fc000000.mmc
state default
type CONFIGS_PIN (3)
controlling device ahb:apb:pinctrl at fc06a000
pin PE19
config 00010003

I don't want to have a group named as a pin.

- I want to perform some verifications on user choices. A concept of ioset is
introduced. An ioset is a set of pins dedicated to a device. A device can have
several iosets. For example we can have i2c0 ioset1 with pins PA0 and PA1 and
i2c0 ioset2 with pins PE10 and PE11. The controller has no knowledge about
iosets. It means I could take the i2c data signal from ioset1 and the i2c
clock signal from ioset2 BUT validation has been done only per ioset. For
devices such as i2c it should not be a problem but it could be for other ones
such as mci, isi, etc.

- I don't want big tables describing pins in my driver. It represents a huge
amount of code mainly useless in the case of a multiplatform image.

- I would like to find a generic solution if possible by still using
pinconf_generic_dt_node_to_map_all() instead of having my own implementation
which will only call pinconf_generic_parse_dt_config().


Well, I let you having a look to the following patch, it should help you to
understand what I mean and what I need.

Regards

Ludovic


Ludovic Desroches (4):
  pinctrl: change function behavior for per pin muxing controllers
  pinctrl: introduce complex pin description
  pinctrl: rough draft for a future controller
  ARM: at91/dt: proto dt

 arch/arm/boot/dts/Makefile                 |   1 +
 arch/arm/boot/dts/at91-sama5d4ek_proto.dts | 243 ++++++++++
 arch/arm/boot/dts/sama5d4_proto-pinfunc.h  | 463 +++++++++++++++++++
 arch/arm/boot/dts/sama5d4_proto.dtsi       | 716 +++++++++++++++++++++++++++++
 drivers/pinctrl/Kconfig                    |  10 +
 drivers/pinctrl/Makefile                   |   1 +
 drivers/pinctrl/pinconf-generic.c          | 115 +++--
 drivers/pinctrl/pinctrl-at91-pio4.c        | 625 +++++++++++++++++++++++++
 drivers/pinctrl/pinmux.c                   |  58 +--
 include/linux/pinctrl/pinctrl.h            |   5 +
 include/linux/pinctrl/pinmux.h             |   3 +
 11 files changed, 2180 insertions(+), 60 deletions(-)
 create mode 100644 arch/arm/boot/dts/at91-sama5d4ek_proto.dts
 create mode 100644 arch/arm/boot/dts/sama5d4_proto-pinfunc.h
 create mode 100644 arch/arm/boot/dts/sama5d4_proto.dtsi
 create mode 100644 drivers/pinctrl/pinctrl-at91-pio4.c

-- 
2.2.0
