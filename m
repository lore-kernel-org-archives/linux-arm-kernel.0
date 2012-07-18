From: javier.martin@vista-silicon.com (javier Martin)
Date: Wed, 18 Jul 2012 15:03:41 +0200
Subject: i.MX27: gpio device tree problems.
Message-ID: <CACKLOr3TQXHekBM76LBL0AczUQrYTDxm6z5YWSdrbu5ug6EpTg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
we are trying to port our Visstrim SM10 [1] to device tree and we've
found some problems related to gpios in the process:

1.- IRQs don't work properly since the value of 'pdev->id' when using
device tree is -1, so 'irq_set_chained_handler()' never gets called
[2]
2.- When using device tree GPIO numbers are allocated dynamically
using gpiolib [3]. This leads to different GPIO numbers being used
compared to the version without device tree. Since GPIOs are exposed
to the user space by gpilib using sysfs this breaks compatibility with
current user applications.

Here is an example:

Version without device tree:
gpiochip_add: registered GPIOs 0 to 31 on device: imx21-gpio.0
gpiochip_add: registered GPIOs 32 to 63 on device: imx21-gpio.1
gpiochip_add: registered GPIOs 64 to 95 on device: imx21-gpio.2
gpiochip_add: registered GPIOs 96 to 127 on device: imx21-gpio.3
gpiochip_add: registered GPIOs 128 to 159 on device: imx21-gpio.4
gpiochip_add: registered GPIOs 160 to 191 on device: imx21-gpio.5

Version with device tree:
gpiochip_add: registered GPIOs 224 to 255 on device: 10015000.gpio
gpiochip_add: registered GPIOs 192 to 223 on device: 10015100.gpio
gpiochip_add: registered GPIOs 160 to 191 on device: 10015200.gpio
gpiochip_add: registered GPIOs 128 to 159 on device: 10015300.gpio
gpiochip_add: registered GPIOs 96 to 127 on device: 10015400.gpio
gpiochip_add: registered GPIOs 64 to 95 on device: 10015500.gpio


I'm sure that problem 1 is an bug that must be fixed but I'm not so
confident about 2. Can we allow a change in the base number of the
GPIOs?

Regards.

[1] http://lxr.linux.no/#linux+v3.4.5/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
[2] http://lxr.linux.no/#linux+v3.4.5/drivers/gpio/gpio-mxc.c#L400


-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
