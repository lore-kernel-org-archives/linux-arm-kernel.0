From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 2 Sep 2018 19:13:35 +0200 (CEST)
Subject: [PATCH RFC 0/2] hwmon: Add RPi PoE HAT fan driver
In-Reply-To: <e8d4e69c-2668-2794-6474-79749bf8b577@roeck-us.net>
References: <1535887251-29515-1-git-send-email-stefan.wahren@i2se.com>
 <99ca4f6d-d2b2-36e7-9f27-189df379cfaf@roeck-us.net>
 <67224834.51159.1535905604770@email.1und1.de>
 <e8d4e69c-2668-2794-6474-79749bf8b577@roeck-us.net>
Message-ID: <829194253.51526.1535908415057@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guenter,

> Guenter Roeck <linux@roeck-us.net> hat am 2. September 2018 um 18:49 geschrieben:
> 
> 
> On 09/02/2018 09:26 AM, Stefan Wahren wrote:
> > Hi Guenter,
> > 
> >> Guenter Roeck <linux@roeck-us.net> hat am 2. September 2018 um 16:23 geschrieben:
> >>
> >>
> >> On 09/02/2018 04:20 AM, Stefan Wahren wrote:
> >>> This series is an early stage of the hwmon driver for the fan on the
> >>> Raspberry Pi Power over Ethernet HAT [1]. At the end this should use a
> >>> Device Tree Overlay.
> >>>
> >>> Changes by Stefan based on [2]:
> >>> - reformat the downstream patches for submission
> >>> - drop reboot notification
> >>> - fix remaining checkpatch issues
> >>> - add COMPILE_TEST to Kconfig
> >>>
> >>> The driver is mostly copy & paste from pwm-fan, which isn't good. Personally
> >>> i see two options:
> >>>
> >>> 1) integrate the driver function into the pwm-fan driver (new compatible)
> >>> 2) implement the core function as a PWM driver and use the pwm-fan driver on top
> >>>
> >>
> >> I don't really see the point of thise driver. Why not implement either of those ?
> > 
> > i'm not sure about your question. Since the fan is placed over the SoC, the fan should takes care of the SoC temperature. AFAIK the firmware should have exclusive access to the I2C. So why we need this mailbox interface instead of a I2C driver.
> > 
> 
> The driver sets pwm values. The pwm-fan driver sets pwm values. A pwm driver
> sets pwm values. The pwm-fan driver uses a pwm driver to set pwm values.
> You appear to be arguing that the pwm-fan driver for Rpi is different than
> a pwm-fan driver for all other hardware and should _not_ use a pwm driver
> to set pwm values.

thanks for your explanation. Now i think i understand and sorry for the confusion. We need a driver which translate the pwm values into the mailbox properties. "My" RFC series is only a starting point (not intended for merge and not an option) for a discussion and i'm perfectly fine with 2).
Both options would be feasible in general. I only wanted to know your opinion before i start to implement one of them.

Stefan

> 
> As you don't understand my question, I don't understand your rationale either.
> I will require detailed explanations why 2) is not feasible, and why 1) is not
> feasible either. Until then, NACK.
> 
> Guenter
> 
> >> 2) sounds like a perfect fit to me.
> >>
> >> Guenter
> >>
> >>> [1] - https://www.raspberrypi.org/products/poe-hat/
> >>> [2] - https://github.com/raspberrypi/linux/commit/0f937c8dc3201ebffa6c617c616fd7c65db65959
> >>>
> >>> Serge Schneider (2):
> >>>     dt-bindings: hwmon: Add RPi PoE HAT documentation
> >>>     hwmon: Add RPi PoE HAT fan driver
> >>>
> >>>    .../devicetree/bindings/hwmon/rpi-poe-fan.txt      |  55 +++
> >>>    Documentation/hwmon/rpi-poe-fan                    |  15 +
> >>>    drivers/hwmon/Kconfig                              |  11 +
> >>>    drivers/hwmon/Makefile                             |   1 +
> >>>    drivers/hwmon/rpi-poe-fan.c                        | 414 +++++++++++++++++++++
> >>>    include/soc/bcm2835/raspberrypi-firmware.h         |   2 +
> >>>    6 files changed, 498 insertions(+)
> >>>    create mode 100644 Documentation/devicetree/bindings/hwmon/rpi-poe-fan.txt
> >>>    create mode 100644 Documentation/hwmon/rpi-poe-fan
> >>>    create mode 100644 drivers/hwmon/rpi-poe-fan.c
> >>>
> >>
> > 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
