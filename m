From: loic.poulain@gmail.com (Loic Poulain)
Date: Wed, 22 Nov 2017 09:07:45 +0100
Subject: [GIT PULL 1/2] bcm2835-dt-fixes-2017-10-06
In-Reply-To: <CALeDE9NpTQCSC7AJ1NhkNuA-FgMQSme8LUJtyizXirthCh6chA@mail.gmail.com>
References: <20171006220504.7776-1-eric@anholt.net>
 <edb03edb-f2a6-549e-6060-eccfae554d92@gmail.com>
 <CAJsfgeU5Zq-2zSfto8WUZ5Xud1Ksedu9XdLG9pWR7YBZGVaHBA@mail.gmail.com>
 <CALeDE9NsjYHpaR6kyHgABGr2eE=EhpJstttK60WwRkAj0u1m7Q@mail.gmail.com>
 <910a98ca-57f6-baca-73ac-f6c8c1ff04db@i2se.com>
 <CALeDE9Oi+DvoJ6X22ButaQxHNyqBzg=H1-mb69_g-rp4RR_fqw@mail.gmail.com>
 <F3464528-76E5-4F11-BD58-DEB56410687B@holtmann.org>
 <CALeDE9OySr2LpcedpTHnz89aFYAk2CknKGHeVx+4ecFCemYZPw@mail.gmail.com>
 <CAM9fo8MktM-WX-AGFCLeCrcoRDR4XjR09BGcbNb5X4G4yVaU2A@mail.gmail.com>
 <CALeDE9NpTQCSC7AJ1NhkNuA-FgMQSme8LUJtyizXirthCh6chA@mail.gmail.com>
Message-ID: <CAM9fo8NMHvvMhhiBufj9Uz8wW5+a-YGJQja74CBwubwrqk4R5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

> So it seems it's actually working fine albeit the strange mac addr, no
> idea what I was trying before, although there's an error about loading
> firmware:
>
> [   31.035291] Bluetooth: hci0: BCM: chip id 94
> [   31.035801] Bluetooth: hci0: BCM: features 0x2e
> [   31.037483] Bluetooth: hci0: BCM43430A1
> [   31.037498] Bluetooth: hci0: BCM43430A1 (001.002.009) build 0000
> [   31.037694] bluetooth hci0: Direct firmware load for
> brcm/BCM43430A1.hcd failed with error -2
> [   31.037704] Bluetooth: hci0: BCM: Patch brcm/BCM43430A1.hcd not found

Ok, think that's why you have this kind of 'default' address, you should be able
to provision a valid address with btmgmt tool. The chip can work
without applying
patch file, original firmware is then executed, which is potentially
more or less buggy.


> By adding a firmware [1] to the location it actually now stops
> working, although shows up with a hciconfig, and had the following
> errors.
>
> [   26.078038] Bluetooth: hci0: BCM: chip id 94
> [   26.096797] Bluetooth: hci0: BCM: features 0x2e
> [   28.130753] Bluetooth: hci0 command 0x0c14 tx timeout
> [   36.322725] Bluetooth: hci0: BCM: Reading local name failed (-110)

Really weird, because these steps are prior firmware loading, moreover on HCI
command timeout, the HCI core is supposed to retry sending of the command,
here nothing happened between [28.13] and [36.32]....

Could you please try to load hci_uart.ko manually after boot to see if it could
be related to some init timings/concurrency.


Regards,
Loic
