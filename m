From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 01 Apr 2014 12:56:01 -0600
Subject: [PATCH 73/75] ARM: l2c: move L2 cache register saving to a more
 sensible location
In-Reply-To: <E1WTYaF-0007Hv-Nv@rmk-PC.arm.linux.org.uk>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
 <E1WTYaF-0007Hv-Nv@rmk-PC.arm.linux.org.uk>
Message-ID: <533B0BC1.6080608@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/28/2014 09:20 AM, Russell King wrote:
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

EXCEPT this one patch, the series,
Tested-by: Stephen Warren <swarren@nvidia.com>
(on Tegra20/Toshiba AC100 and Tegra30/Beaver)

And any part which touches Tegra code,
Acked-by: Stephen Warren <swarren@nvidia.com>

However, this one patch causes boot failures on the Toshiba AC100,
Springbank/Seaboard, and I would assume any Tegra20 system. I haven't
investigated what the problem is; do you need me to and/or have any clues?

Here's the boot spew re: caches:

> [    0.000000] L2C: platform modifies aux control register: 0x02080000 -> 0x3e480001
> [    0.000000] L2C: DT/platform modifies aux control register: 0x02080000 -> 0x3e480001
> [    0.000000] L2C-310 errata 727915 769419 enabled
> [    0.000000] L2C-310 enabling early BRESP for Cortex-A9
> [    0.000000] L2C-310: enabling full line of zeros but not enabled in Cortex-A9
> [    0.000000] L2C-310 ID prefetch enabled, offset 1 lines
> [    0.000000] L2C-310: dynamic clock gating disabled, standby mode disabled
> [    0.000000] L2C-310 cache controller enabled, 8 ways, 1024 kB
> [    0.000000] L2C-310: CACHE_ID 0x410000c4, AUX_CTRL 0x7e480001

The system simply hangs pretty late in the boot process from the AC100:

> [    1.640426] usbhid: USB HID core driver
> [    1.655176] nvec 7000c500.nvec: ec firmware version 01.20.00 / f9
> [    1.670832] input: nvec keyboard as /devices/soc0/7000c500.nvec/nvec-kbd.0/input/input1
> [    1.696465] tegra-alc5632 sound.7: alc5632-hifi <-> 70002800.i2s mapping ok
> [    1.886296] psmouse serio0: Failed to reset mouse on nvec
> [    1.908126] mmc0: new high speed SD card at address 0002
> [    1.914613] mmcblk0: mmc0:0002 00000 1.86 GiB 
> [    1.938532]  mmcblk0: p1
> [    1.982522] mmc1: new high speed MMC card at address 0001
> [    1.991327] mmcblk1: mmc1:0001 SEM08G 7.39 GiB 
> [    1.997179] mmcblk1boot0: mmc1:0001 SEM08G partition 1 1.00 MiB
> [    2.004356] mmcblk1boot1: mmc1:0001 SEM08G partition 2 1.00 MiB
> [    2.015144]  mmcblk1: unknown partition table
> [    2.026400]  mmcblk1boot1: unknown partition table
> [    2.037914]  mmcblk1boot0: unknown partition table
> [    2.224409] input: Compal PAZ00 Headset Jack as /devices/soc0/sound.7/sound/card0/input2
> [    2.236688] TCP: cubic registered
> [    2.241126] NET: Registered protocol family 10
> [    2.251831] mip6: Mobile IPv6
> [    2.254839] sit: IPv6 over IPv4 tunneling driver
> [    2.268383] NET: Registered protocol family 17
> [    2.272985] NET: Registered protocol family 15
> [    2.277800] Bluetooth: RFCOMM socket layer initialized
> [    2.283016] Bluetooth: RFCOMM ver 1.11
> [    2.287034] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
> [    2.292435] Bluetooth: BNEP socket layer initialized
> [    2.297472] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
> [    2.303474] Bluetooth: HIDP socket layer initialized
> [    2.313364] rfkill_gpio rfkill_gpio: wifi_rfkill device registered.
> [    2.319791] Registering SWP/SWPB emulation handler
> [    2.330586] +3VS,vdd_pnl: 3300 mV 
> [    2.335028] tegra-dc 54200000.dc: failed to probe RGB output: -517
> [    2.341413] platform 54200000.dc: Driver tegra-dc requests probe deferral
> [    2.352402] tegra-ehci c5000000.usb: EHCI Host Controller
> [    2.357982] tegra-ehci c5000000.usb: new USB bus registered, assigned bus number 1
> [    2.366221] tegra-ehci c5000000.usb: irq 52, io mem 0xc5000000
> [    2.386343] tegra-ehci c5000000.usb: USB 2.0 started, EHCI 1.00
> [    2.397034] hub 1-0:1.0: USB hub found
> [    2.400932] hub 1-0:1.0: 1 port detected
<<hang>>

... and from Seaboard/Springbank:

> [    2.715321] VFS: Mounted root (ext3 filesystem) on device 179:1.
> [    2.720970] devtmpfs: mounted
> [    2.721336] Freeing unused kernel memory: 264K (c07be000 - c0800000)
> [    2.775391] usb 2-1: new low-speed USB device number 2 using tegra-ehci
...
> [    9.515357] init: idmapd main process (525) terminated with status 1
> [    9.515572] init: idmapd respawning too fast, stopped
> [   11.978245] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
> [   12.097190] asix 3-1:1.0 eth0: link down
