From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 10 Dec 2014 18:02:42 +0100
Subject: BCM2048 bluetooth connected over OMAP serial
In-Reply-To: <20141210164333.GA3154@amd>
References: <20141210164333.GA3154@amd>
Message-ID: <11367725.nphhSzdtpK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 10 December 2014 17:43:33 Pavel Machek wrote:
> 
> So, there's bluetooth chip that's connected to the SoC by UART and some
> GPIOs. What would be right representation in the device tree?
> Something like this?
> 
>         bluetooth {
>                   compatible = "broadcom,bcm2048";
>                   uart = <&uart2>;
>                   reset-gpios = <&gpio3 27 GPIO_ACTIVE_HIGH>; /* want 91 */
>                   host-wakeup-gpios = <&gpio4 5 GPIO_ACTIVE_HIGH>; /* want 101 */
>                   bluetooth-wakeup-gpios = <&gpio2 5 GPIO_ACTIVE_HIGH>; /* want 37 */
>                   chip-type = >;
>                   bt-sysclk = <2>;
>                   reset-gpio-shared = <0>;
>         };
> 
> Is there some way to prevent OMAP tty driver from binding to the
> device and exporting the device to userspace?

I think from the driver perspective, you want this to be a tty line
discipline rather than a driver that attaches to the physical
uart.

For the DT representation, I fear we haven't got a precedent. A uart
phandle sounds reasonable, but there might be other ways to do it
and we should consider if there are better alternatives. It could
possibly be a child node of the uart, but that would require other
infrastructure in the kernel because we don't currently create
devices for those.

	Arnd
