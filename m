From: dimitrysh@google.com (Dmitry Shmidt)
Date: Thu, 23 Apr 2015 11:19:44 -0700
Subject: Broadcom 43340 module on iMX6DL
In-Reply-To: <CACUGKYMXr3ASbB9fCk+GBnpfMC1kf_+NxDsOF_FODBKRAN9YvQ@mail.gmail.com>
References: <CACUGKYMXr3ASbB9fCk+GBnpfMC1kf_+NxDsOF_FODBKRAN9YvQ@mail.gmail.com>
Message-ID: <CAH7ZN-ye6o3POi9xCPAPWDA0sZA4w9cDsdM-ZoGLR61gqT1D-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 23, 2015 at 11:10 AM, John Tobias <john.tobias.ph@gmail.com> wrote:
> Hello Guys,
>
> I am trying to use the bcmdhd wifi driver 43340 module on iMX6DL
> processor using kernel Freescale GA (3.10.53).
>
> I am having an issue with the sdio registration. I would like to know
> if anyone here had the same issue and how did you solve it?.

I would be careful with terminology - this error has nothing to do
with sdio registration. Moreover, you found wlan sdio device:

mmc0: new high speed SDIO card at address 0001

The problem is that after loading FW (you probably skipped
this line in log) it is not responding.
There are several reasons for this.
1) You didn't set up properly IRQ line. There are two ways:
OOB interrupt and SDIO interrupt. I don't know how it is set
in HW on your board. You may try to use polling as a test
Something like replace
  uint dhd_poll = FALSE;
  uint dhd_intr = TRUE;
to
  uint dhd_poll = TRUE;
  uint dhd_intr = FALSE;
But I am not sure about your source base and if it is working at all these days.

2) Your FW is wrong and it is not responding

3) Something else... :)

>
>
> Entry: wifi_add_dev
> Entry: wifi_add_dev
> Entry: wifi_probe
> wifi_probe: calling wifi_set_power on
> Entry: wifi_set_power
> wifi_set_power = 1
> wifi_set_carddetect = 1
> mmc0: queuing unknown CIS tuple 0x80 (7 bytes)
> mmc0: queuing unknown CIS tuple 0x80 (6 bytes)
> mmc0: queuing unknown CIS tuple 0x91 (3 bytes)
> mmc0: new high speed SDIO card at address 0001
>
> Dongle Host Driver, version 1.88.45 (r)
> Compiled in drivers/net/wireless/bcmdhd on Apr 23 2015 at 00:40:05
> F1 signature OK, socitype:0x1 chip:0xa94c rev:0x2 pkg:0x0
> DHD: dongle ram size is set to 524288(orig 524288) at 0x0
> wl_create_event_handler(): thread:wl_event_handler:3ba started
> CFG80211-ERROR) wl_event_handler : tsk Enter, tsk = 0x96741444
> dhd_attach(): thread:dhd_watchdog_thread:3bb started
> dhd_attach(): thread:dhd_dpc:3bc started
> dhd_attach(): thread:dhd_rxf:3bd started
> dhd_attach(): thread:dhd_sysioc:3be started
> wifi_get_mac_addr
> dhdsdio_write_vars: Download, Upload and compare of NVRAM succeeded.
>
>
> Times out here...
> dhd_module_init: sdio_register_driver timeout or error
>
> dhd_bus_init: enable 0x06, ready 0x02 (waited 3006383us)
> dhd_bus_start failed bus is not ready
> dhdsdio_probe: dhd_bus_start failed
> dhd_detach(): thread:dhd_sysioc:3be terminated OK
> dhd_detach(): thread:dhd_watchdog_thread:3bb terminated OK
> dhd_dpc_thread: Unexpected up_cnt 0
> dhd_detach(): thread:dhd_dpc:3bc terminated OK
> dhd_detach(): thread:dhd_rxf:3bd terminated OK
> CFG80211-ERROR) wl_event_handler : was terminated
> wl_destroy_event_handler(): thread:wl_event_handler:3ba terminated OK
> dhd_osl_detach: MEMORY LEAK 156 bytes
> ## wifi_remove
> Entry: wifi_set_power
> wifi_set_power = 0
> navdy_wifi_power: 0
> wifi_set_carddetect = 0
> insmod: init_module '/system/lib/modules/bcmdhd.ko' failed (No such device)
> # mmc0: card 0001 removed
>
>
> Note: I ran the command below to load the driver:
> insmod /system/lib/modules/bcmdhd.ko
> firmware_path=/system/vendor/firmware/brcmfmac43340-sdio.bin
> nvram_path=/system/vendor/firmware/bcmdhd.cal
>
>
> Regards,
>
> John
