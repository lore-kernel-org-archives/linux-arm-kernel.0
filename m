From: loic.poulain@linaro.org (Loic Poulain)
Date: Wed, 7 Mar 2018 13:08:21 +0100
Subject: [PATCH 3/4] ARM: dts: bcm2835-rpi-zero-w: Add bcm43438 serial
 slave
In-Reply-To: <438185389.274708.1520422108782@email.1und1.de>
References: <1519567855-26105-1-git-send-email-stefan.wahren@i2se.com>
 <1519567855-26105-4-git-send-email-stefan.wahren@i2se.com>
 <84F7E645-59B4-4618-8C91-A5CD654E16A6@holtmann.org>
 <648118289.71086.1519593373795@email.1und1.de>
 <9D6209F2-5389-4F4E-844D-6A8683044F88@holtmann.org>
 <438185389.274708.1520422108782@email.1und1.de>
Message-ID: <CAMZdPi97EnK+W42AgiO2BZ=S33Vh=WkY02T7umdFF5VKXhmTSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

> after applying Loic's patch and the necessary patch for the RPi 3 dts file (see below), i will get this output:
>
> [    4.873246] Bluetooth: HCI UART driver ver 2.3
> [    4.873260] Bluetooth: HCI UART protocol H4 registered
> [    4.873265] Bluetooth: HCI UART protocol Three-wire (H5) registered
> [    4.873751] Bluetooth: HCI UART protocol Broadcom registered
> [    4.877279] uart-pl011 3f201000.serial: no DMA platform data
> [    6.952382] Bluetooth: hci0: command 0xfc18 tx timeout
> [   15.192298] Bluetooth: hci0: BCM: failed to write update baudrate (-110)
> [   15.192312] Bluetooth: hci0: Failed to set baudrate
> [   15.316415] Bluetooth: hci0: BCM: chip id 94
> [   15.318567] Bluetooth: hci0: BCM: features 0x2e
> [   15.341538] Bluetooth: hci0: BCM43430A1
> [   15.341560] Bluetooth: hci0: BCM43430A1 (001.002.009) build 0000
> [   19.112670] Bluetooth: hci0: BCM (001.002.009) build 0360
> [  274.713732] Bluetooth: hci0: command 0x0c14 tx timeout
> [  274.714085] Bluetooth: hci0: Frame reassembly failed (-84)
> [  317.275941] Bluetooth: hci0: last event is not cmd complete (0x0f)
>
> I don't see these errors on RPi Zero W. Maybe the reason for this is the lack of hardware flowcontrol on RPi 3. Or some of the downstream patches on BlueZ must be adapted for the kernel [1].
>
> Btw the bcm43438 is detected even after unloading and reloading the driver. But the timeout occurs also on driver reload. Reducing the baudrate to 115200 doesn't help here.
>
> Sorry in case this patch gets corrupted by my webmailer.

I assume the controller requests a certain time to be ready, so the
controller probably misses the first command (update baudrate).
And yes the reason it's not reproducible on RPi Zero W is seems
related to hardware flow control, the device most likely asserts RTS
only when ready.

Could you try adding a msleep in the bcm_gpio_set_power method after
toggling the shutdown gpio, I don't know about the BCM controller boot
time but 50ms should be enough.

I'm not sure why it's related to my patch, maybe just a timing question.

Regards,
Loic
