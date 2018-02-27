From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 27 Feb 2018 19:51:19 +0100 (CET)
Subject: [PATCH 3/4] ARM: dts: bcm2835-rpi-zero-w: Add bcm43438 serial
 slave
In-Reply-To: <9D6209F2-5389-4F4E-844D-6A8683044F88@holtmann.org>
References: <1519567855-26105-1-git-send-email-stefan.wahren@i2se.com>
 <1519567855-26105-4-git-send-email-stefan.wahren@i2se.com>
 <84F7E645-59B4-4618-8C91-A5CD654E16A6@holtmann.org>
 <648118289.71086.1519593373795@email.1und1.de>
 <9D6209F2-5389-4F4E-844D-6A8683044F88@holtmann.org>
Message-ID: <879698373.164009.1519757479655@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marcel,

> Marcel Holtmann <marcel@holtmann.org> hat am 25. Februar 2018 um 22:38 geschrieben:
> 
> 
> Hi Stefan,
> 
> >>> Add BCM43438 (bluetooth) as a serdev slave device of uart0 (pl011/ttyAMA0).
> >>> This allows to automatically insert the bcm43438 to the bluetooth
> >>> subsystem instead of relying on patched userspace helpers (hciattach).
> >>> 
> >>> In order to keep a debug UART we need to switch to uart1.
> >>> 
> >>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> >>> ---
> >>> arch/arm/boot/dts/bcm2835-rpi-zero-w.dts | 14 +++++++++++++-
> >>> 1 file changed, 13 insertions(+), 1 deletion(-)
> >>> 
> >>> diff --git a/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts b/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts
> >>> index cf53436..b7f79f1 100644
> >>> --- a/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts
> >>> +++ b/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts
> >>> @@ -131,6 +131,18 @@
> >>> 
> >>> &uart0 {
> >>> 	pinctrl-names = "default";
> >>> -	pinctrl-0 = <&uart0_gpio14>;
> >>> +	pinctrl-0 = <&uart0_gpio32 &uart0_ctsrts_gpio30>;
> >>> +	status = "okay";
> >>> +
> >>> +	bluetooth {
> >>> +		compatible = "brcm,bcm43438-bt";
> >>> +		max-speed = <2000000>;
> >>> +		shutdown-gpios = <&gpio 45 GPIO_ACTIVE_HIGH>;
> >>> +	};
> >>> +};
> >> 
> >> is the shutdown GPIO working as expected with this hardware. So even module unload and reload works fine?
> > 
> > Yes, unload and reload works fine. 
> > 
> >> Meaning we are getting back to the 115200 default baud rate on the UART?
> > 
> > I assume that, because reload works as expected. 
> 
> awesome. That is good news.
> 
> Since you said that the GPIO expander driver for the RPi 3 has been accepted, did you test it there as well?

Currently not 

> If so, then it would be good to get a patch that also provides shutdown-gpios for RPi 3.

Sure, but not before this weekend.

> 
> Regards
> 
> Marcel
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
