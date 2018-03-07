From: marcel@holtmann.org (Marcel Holtmann)
Date: Wed, 7 Mar 2018 13:12:03 +0100
Subject: [PATCH 3/4] ARM: dts: bcm2835-rpi-zero-w: Add bcm43438 serial
 slave
In-Reply-To: <438185389.274708.1520422108782@email.1und1.de>
References: <1519567855-26105-1-git-send-email-stefan.wahren@i2se.com>
 <1519567855-26105-4-git-send-email-stefan.wahren@i2se.com>
 <84F7E645-59B4-4618-8C91-A5CD654E16A6@holtmann.org>
 <648118289.71086.1519593373795@email.1und1.de>
 <9D6209F2-5389-4F4E-844D-6A8683044F88@holtmann.org>
 <438185389.274708.1520422108782@email.1und1.de>
Message-ID: <03B9ACBE-3ACA-40C4-9DA2-6A57D1AD96E0@holtmann.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

>>>>> Add BCM43438 (bluetooth) as a serdev slave device of uart0 (pl011/ttyAMA0).
>>>>> This allows to automatically insert the bcm43438 to the bluetooth
>>>>> subsystem instead of relying on patched userspace helpers (hciattach).
>>>>> 
>>>>> In order to keep a debug UART we need to switch to uart1.
>>>>> 
>>>>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
>>>>> ---
>>>>> arch/arm/boot/dts/bcm2835-rpi-zero-w.dts | 14 +++++++++++++-
>>>>> 1 file changed, 13 insertions(+), 1 deletion(-)
>>>>> 
>>>>> diff --git a/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts b/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts
>>>>> index cf53436..b7f79f1 100644
>>>>> --- a/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts
>>>>> +++ b/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts
>>>>> @@ -131,6 +131,18 @@
>>>>> 
>>>>> &uart0 {
>>>>> 	pinctrl-names = "default";
>>>>> -	pinctrl-0 = <&uart0_gpio14>;
>>>>> +	pinctrl-0 = <&uart0_gpio32 &uart0_ctsrts_gpio30>;
>>>>> +	status = "okay";
>>>>> +
>>>>> +	bluetooth {
>>>>> +		compatible = "brcm,bcm43438-bt";
>>>>> +		max-speed = <2000000>;
>>>>> +		shutdown-gpios = <&gpio 45 GPIO_ACTIVE_HIGH>;
>>>>> +	};
>>>>> +};
>>>> 
>>>> is the shutdown GPIO working as expected with this hardware. So even module unload and reload works fine?
>>> 
>>> Yes, unload and reload works fine. 
>>> 
>>>> Meaning we are getting back to the 115200 default baud rate on the UART?
>>> 
>>> I assume that, because reload works as expected. 
>> 
>> awesome. That is good news.
>> 
>> Since you said that the GPIO expander driver for the RPi 3 has been accepted, did you test it there as well? If so, then it would be good to get a patch that also provides shutdown-gpios for RPi 3.
> 
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

maybe it needs some time after switching the hardware on. Have you tried to sleep for a bit at the end of bcm_gpio_set_power?

Can you also dump where the Frame reassembly fails. Or correlate that with the btmon trace of which packets make its through. The 0x0c14 is Read Local Name and maybe we actually have bit errors here.

In theory we could also run this hardware in 3-wire protocol mode. I just do not know how to get that one started, but maybe that would be an option if there is some sort of packet loss. However maybe this is really just some timing issue for the hardware to settle its baud rate. However I assume that the firmware loading itself succeeds here.

Regards

Marcel
