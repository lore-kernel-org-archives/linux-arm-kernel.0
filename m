From: marcel@holtmann.org (Marcel Holtmann)
Date: Thu, 8 Mar 2018 13:08:35 +0100
Subject: [PATCH 3/4] ARM: dts: bcm2835-rpi-zero-w: Add bcm43438 serial
 slave
In-Reply-To: <20180308105624.GA2316@wunner.de>
References: <84F7E645-59B4-4618-8C91-A5CD654E16A6@holtmann.org>
 <648118289.71086.1519593373795@email.1und1.de>
 <9D6209F2-5389-4F4E-844D-6A8683044F88@holtmann.org>
 <438185389.274708.1520422108782@email.1und1.de>
 <03B9ACBE-3ACA-40C4-9DA2-6A57D1AD96E0@holtmann.org>
 <2071508922.276811.1520426568577@email.1und1.de> <87sh9bvh3r.fsf@anholt.net>
 <D48AB207-F7F4-46D8-AC65-EC5CF76A6084@holtmann.org>
 <87muzjfr8l.fsf@anholt.net> <698451580.263856.1520467358497@email.1und1.de>
 <20180308105624.GA2316@wunner.de>
Message-ID: <1AD61B17-8B07-42A4-9B82-5515C9850C28@holtmann.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lukas,

>>>>>>>> after applying Loic's patch and the necessary patch for the
>>>>>>>> RPi 3 dts file (see below), i will get this output:
>>>>>>>> 
>>>>>>>> [    4.873246] Bluetooth: HCI UART driver ver 2.3
>>>>>>>> [    4.873260] Bluetooth: HCI UART protocol H4 registered
>>>>>>>> [    4.873265] Bluetooth: HCI UART protocol Three-wire (H5) registered
>>>>>>>> [    4.873751] Bluetooth: HCI UART protocol Broadcom registered
>>>>>>>> [    4.877279] uart-pl011 3f201000.serial: no DMA platform data
>>>>>>>> [    6.952382] Bluetooth: hci0: command 0xfc18 tx timeout
>>>>>>>> [   15.192298] Bluetooth: hci0: BCM: failed to write update baudrate (-110)
>>>>>>>> [   15.192312] Bluetooth: hci0: Failed to set baudrate
>>>>>>>> [   15.316415] Bluetooth: hci0: BCM: chip id 94
>>>>>>>> [   15.318567] Bluetooth: hci0: BCM: features 0x2e
>>>>>>>> [   15.341538] Bluetooth: hci0: BCM43430A1
>>>>>>>> [   15.341560] Bluetooth: hci0: BCM43430A1 (001.002.009) build 0000
>>>>>>>> [   19.112670] Bluetooth: hci0: BCM (001.002.009) build 0360
>>>>>>>> [  274.713732] Bluetooth: hci0: command 0x0c14 tx timeout
>>>>>>>> [  274.714085] Bluetooth: hci0: Frame reassembly failed (-84)
>>>>>>>> [  317.275941] Bluetooth: hci0: last event is not cmd complete (0x0f)
>>>>>>>> 
>>>>>>>> I don't see these errors on RPi Zero W. Maybe the reason for
>>>>>>>> this is the lack of hardware flowcontrol on RPi 3.
>>>>>>> 
>>>>>>> maybe it needs some time after switching the hardware on. Have
>>>>>>> you tried to sleep for a bit at the end of bcm_gpio_set_power?
>> 
>> after applying this patch [1] the RPi 3 specific probing errors disappear.
>> 
>> But this is only a quick hack. The proper solution would be to extend
>> hci_h5 in order to support the BCM43438.
>> 
>> [1] - https://github.com/lategoodbye/rpi-zero/commit/ed5900296dfb7aec7f467477440751e7367a1881
> 
> Users of the MacBookPro13,1 and MacBookPro14,1 are reporting similar
> timeouts when the Bluetooth controller is reset on ->setup.
> 
> These are the models without touchbar.  The models with touchbar
> (MBP13,2, MBP13,3, MBP14,2, MBP14,3) as well as the 12" MacBooks
> (MB8,1, MB9,1, MB10,1) do not suffer from this issue.
> 
> Christoph Gysin (+cc) reports that applying your patch on 4.16-rc4 gets
> Bluetooth working on his MBP13,1:
> https://github.com/Dunedan/mbp-2016-linux/issues/29#issuecomment-371434970
> 
> For some reason, not toggling the device_wake pin in bcm_gpio_set_power()
> also fixed the issue for those users.  They did complain about stuttering
> audio though.
> 
> Users of the touchbar models reported that stuttering audio only occurs
> when the GNOME Bluetooth control panel is open. Closing it made the
> stuttering audio go away.  But apparently on the non-touchbar models,
> the stuttering persisted regardless.  Both the stuttering audio as well as
> the timeouts on ->setup might be explained by a lack of hardware flow
> control on those models.  The chipset (and thus the UART) is identical
> on the touchbar versus non-touchbar models.  It would seem odd if Apple
> did not wire CTS consistently on all models.

do you know if Apple is actually running H:4 or if they run H:5 (3-Wire) within macOS. I think the Broadcom chips will auto-detect the transport protocol. At least on the RPi3 it seems like that.

Regards

Marcel
