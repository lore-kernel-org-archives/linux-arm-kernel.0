From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Tue, 6 Jul 2010 13:22:26 +0300
Subject: [PATCH 05/15] omap: hsmmc: add virtual card detect support
In-Reply-To: <alpine.LFD.2.00.1007052134460.6020@xanadu.home>
References: <1278376666-3509-1-git-send-email-ohad@wizery.com>
	<1278376666-3509-6-git-send-email-ohad@wizery.com>
	<alpine.LFD.2.00.1007052134460.6020@xanadu.home>
Message-ID: <AANLkTim4E4LlFERmfYA1M0HLBOoRAsQuvdW6QBNu6pC0@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

On Tue, Jul 6, 2010 at 4:45 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Tue, 6 Jul 2010, Ohad Ben-Cohen wrote:
>
>> From: Ohad Ben-Cohen <ohadb@ti.com>
>>
>> Add support for software emulation of card detect
>> events.
>>
>> This is required for specific controllers
>> that are hard wired with embedded SDIO devices
>> (such as TI's wl1271 WLAN device).
>
> Why?
>
> Many instances of hardwired SDIO based WLAN devices do exist already,
> and they don't need extra card detect events to be generated. ?The core
> MMC code already triggers a probe for cards whenever a new host
> controller is registered.

We prefer not to power up the chip as early as boot time; instead, we
would like to have it powered off until the wlan interface is brought
up, power it on when the interface is brought up,
and power it off again as soon as the interface is brought down again
(to minimize power consumption when the wlan is not in use).

For that we can't rely on the probing done when the controller is
registered, we want to have a mechanism to allow dynamic detection and
removal of the card.

Note: the wl1271 device does support standard card detection, but
AFAIK there's a limitation to use that with the specific omap
controller the device is hardwired to. I will try to get more info
about that, but probably Madhu can comment on that better.

>> Board-specific configuration is required to
>> enable this software card detect control.
>
> Could you elaborate please?

Please check out the last patch - that patch is doing that configuration.
In essence, this virtual card detect mechanism is enabled only for
specific controllers which we know there's an embedded sdio device
hardwired to. This knowledge is board-specific, and that's why we
enable this mechanism in the board files, per a specific mmc
controller.

Thanks,
Ohad.


>
>
> Nicolas
>
