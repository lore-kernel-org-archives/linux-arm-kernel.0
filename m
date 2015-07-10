From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 10 Jul 2015 23:07:26 +0200
Subject: [PATCH] soc/rockchip: add handler for usb-uart functionality
In-Reply-To: <1574322.mYky5df1dK@diego>
References: <1574322.mYky5df1dK@diego>
Message-ID: <1748257.PI6hyOPu9L@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 8. Juli 2015, 21:00:06 schrieb Heiko St?bner:
> Most newer Rockchip SoCs provide the possibility to use a usb-phy
> as passthrough for the debug uart (uart2), making it possible to
> get console output without needing to open the device.
> 
> This patch adds an early_initcall to enable this functionality
> conditionally via the commandline and also disables the corresponding
> usb controller in the devicetree.
> 
> Currently only data for the rk3288 is provided, but at least the
> rk3188 and arm64 rk3368 also provide this functionality and will be
> enabled later.
> 
> On a spliced usb cable the signals are tx on white wire(D+) and
> rx on green wire(D-).
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

dumping some thoughts that stem from comments in my g+ post about this:


Arnd Bergmann, yesterday 19:40:
Would it help to move this code into the console init section of the UART 
driver to avoid losing the initial output??


Heiko St?bner, yesterday 20:08
I don't think so. The functionality has nothing to do with the uart itself - 
in fact for the system everything stays the same - only the routing becomes 
different. It should even work with earlyprintk/earlycon.

The only output you loose is up to the point when the early_initcall is 
executed - which is around the smp bringup time. And I guess if somebody is 
doing kernel changes for this early stage, they will probably use a board with 
a real uart or modify their uboot to already also set this option.?


Arnd Bergmann, yesterday 20:52
Isn't early_initcall /much/ later than console_init, or even earlycon?
The console output gets buffered until the first console gets found and is then 
flushed to that. If you switch the MUX just before registering the console, you 
should not lose anything, and also put this code in a more natural location.?


Heiko St?bner, today 23:03
Yep as I said, twi switch currently runs around the time of the smp bringup . 
I'm probably just daft, but also still not sure how this should fit into the 
uart driver/console stuff. Especially as it is not even a property of the 
(designware) uart ips, but instead it might even be more a property of the usb 
phy. In terms of natural location, the usbphy driver might then be a more 
suitable position?

In terms of when to run, it also looks like early_initcall is one of the 
earliest times to run, as the code needs syscons, devicetree matching and also 
devicetree updates.

If just the regular console is included, nothing is lost and I guess when 
somebody needs to touch (and debug) such low-low-level parts like before the 
smp bringup they won't do it on a board without a real serial port I guess.

I guess we should also move this to a mailing list ... I guess I'll just copy 
our thread here into a reply to my patch ;-) .?
