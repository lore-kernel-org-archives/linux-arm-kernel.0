From: Matthias.Thomae@de.bosch.com (Thomae Matthias (CM-AI/PJ-CF31))
Date: Mon, 30 Jul 2012 09:28:21 +0200
Subject: [PATCH 2/2] ARM: dts: imx6q: Invert the GPIO controller order
In-Reply-To: <20120728134114.GH2128@S2101-09.ap.freescale.net>
References: <1343219864-3040-1-git-send-email-dirk.behme@de.bosch.com>
 <1343219864-3040-2-git-send-email-dirk.behme@de.bosch.com>
 <20120728134114.GH2128@S2101-09.ap.freescale.net>
Message-ID: <8E7BE7398BB9294F8B826ADE09B18EBE6CC2FF7EE1@SI-MBX20.de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Shawn Guo [mailto:shawn.guo at linaro.org]
> On Wed, Jul 25, 2012 at 02:37:44PM +0200, Dirk Behme wrote:
> > From: Matthias Thomae <matthias.thomae@de.bosch.com>
> >
> > The GPIO controllers in the device tree are registered dynamically
> > via gpiochip_add and gpiochip_find_base in descending order (from
> > ARCH_NR_GPIO to 0). This change reorders the controllers in the
> > device tree (from gpio7 to gpio1) so that they finally appear in
> > ascending order after registration.
> >
> First of all, the device nodes in device tree are sorted in address
> order, and should be independent with Linux implementation.
>
> Secondly, I'm wondering why you care about the global gpio number,
> as gpio and associated interrupt should be addressed by port + offset.
>
> Regards,
> Shawn

Shawn,

I care about the global number because it is used to access GPIOs
from userspace via the Sysfs interface (see Documentation/gpio.txt).
Without the 2 patches, the GPIOs are mapped this way:

gpiochip_add: registered GPIOs 224 to 255 on device: 209c000.gpio
gpiochip_add: registered GPIOs 192 to 223 on device: 20a0000.gpio
gpiochip_add: registered GPIOs 160 to 191 on device: 20a4000.gpio
gpiochip_add: registered GPIOs 128 to 159 on device: 20a8000.gpio
gpiochip_add: registered GPIOs 96 to 127 on device: 20ac000.gpio
gpiochip_add: registered GPIOs 64 to 95 on device: 20b0000.gpio
gpiochip_add: registered GPIOs 32 to 63 on device: 20b4000.gpio

With the patches, the mapping looks like this:

gpiochip_add: registered GPIOs 192 to 223 on device: 20b4000.gpio
gpiochip_add: registered GPIOs 160 to 191 on device: 20b0000.gpio
gpiochip_add: registered GPIOs 128 to 159 on device: 20ac000.gpio
gpiochip_add: registered GPIOs 96 to 127 on device: 20a8000.gpio
gpiochip_add: registered GPIOs 64 to 95 on device: 20a4000.gpio
gpiochip_add: registered GPIOs 32 to 63 on device: 20a0000.gpio
gpiochip_add: registered GPIOs 0 to 31 on device: 209c000.gpio

I.e. pin 0 on gpio1 is now accessed via /sys/class/gpio/gpio0
instead of /sys/class/gpio/gpio224.

BR
Matthias
