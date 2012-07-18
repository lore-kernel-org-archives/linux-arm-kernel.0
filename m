From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 18 Jul 2012 16:00:22 +0200
Subject: i.MX27: gpio device tree problems.
In-Reply-To: <CACKLOr3TQXHekBM76LBL0AczUQrYTDxm6z5YWSdrbu5ug6EpTg@mail.gmail.com>
References: <CACKLOr3TQXHekBM76LBL0AczUQrYTDxm6z5YWSdrbu5ug6EpTg@mail.gmail.com>
Message-ID: <20120718140022.GI30009@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 18, 2012 at 03:03:41PM +0200, javier Martin wrote:
> Hi,
> we are trying to port our Visstrim SM10 [1] to device tree and we've
> found some problems related to gpios in the process:
> 
> 1.- IRQs don't work properly since the value of 'pdev->id' when using
> device tree is -1, so 'irq_set_chained_handler()' never gets called
> [2]

This should work since:

33a4e98 gpio/mxc: make irqs work for fsl,imx21-gpio devices

> 2.- When using device tree GPIO numbers are allocated dynamically
> using gpiolib [3]. This leads to different GPIO numbers being used
> compared to the version without device tree. Since GPIOs are exposed
> to the user space by gpilib using sysfs this breaks compatibility with
> current user applications.
> 
> Here is an example:
> 
> Version without device tree:
> gpiochip_add: registered GPIOs 0 to 31 on device: imx21-gpio.0
> gpiochip_add: registered GPIOs 32 to 63 on device: imx21-gpio.1
> gpiochip_add: registered GPIOs 64 to 95 on device: imx21-gpio.2
> gpiochip_add: registered GPIOs 96 to 127 on device: imx21-gpio.3
> gpiochip_add: registered GPIOs 128 to 159 on device: imx21-gpio.4
> gpiochip_add: registered GPIOs 160 to 191 on device: imx21-gpio.5
> 
> Version with device tree:
> gpiochip_add: registered GPIOs 224 to 255 on device: 10015000.gpio
> gpiochip_add: registered GPIOs 192 to 223 on device: 10015100.gpio
> gpiochip_add: registered GPIOs 160 to 191 on device: 10015200.gpio
> gpiochip_add: registered GPIOs 128 to 159 on device: 10015300.gpio
> gpiochip_add: registered GPIOs 96 to 127 on device: 10015400.gpio
> gpiochip_add: registered GPIOs 64 to 95 on device: 10015500.gpio

Known problem, I have no idea how to solve this.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
