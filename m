From: romain.izard.pro@gmail.com (Romain Izard)
Date: Wed, 19 Sep 2018 16:11:55 +0200
Subject: Kernel memory leak on CDC-ACM device plug/unplug
Message-ID: <CAGkQfmP6o+e_nanviTfRt7Ej9U+4BdqDYvMM83FjHhSCECcH3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While trying to debug a memory leak problem, I encountered the following
problem:

After plugging/unplugging an USB CDC-ACM device, kmemleak reports multiple
copies of the following leak. It is not necessary to open the port for the
leak to happen.

unreferenced object 0xddbfd500 (size 128):
  comm "kworker/0:3", pid 675, jiffies 69734 (age 916.580s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 1c d5 bf dd  ................
  backtrace:
    [<da0194da>] acm_probe+0x868/0xc3c
    [<cc72c809>] usb_probe_interface+0x11c/0x274
    [<bbce212c>] driver_probe_device+0x22c/0x320
    [<544a5b43>] bus_for_each_drv+0x58/0xb8
    [<fe5944dc>] __device_attach+0xd0/0x138
    [<d807c1e5>] bus_probe_device+0x84/0x8c
    [<16645f2c>] device_add+0x3cc/0x5c0
    [<80c11c88>] usb_set_configuration+0x448/0x7b0
    [<76bdbcdf>] generic_probe+0x2c/0x78
    [<bbce212c>] driver_probe_device+0x22c/0x320
    [<544a5b43>] bus_for_each_drv+0x58/0xb8
    [<fe5944dc>] __device_attach+0xd0/0x138
    [<d807c1e5>] bus_probe_device+0x84/0x8c
    [<16645f2c>] device_add+0x3cc/0x5c0
    [<02a49898>] usb_new_device+0x264/0x424
    [<865a481b>] hub_event+0xa20/0x1154

For each additional plug/unplug cycle, around 30 such new leaks are created.

Tested on a SAMA5D2 Xplained demo board, with a v4.18.8 kernel.
The CDC-ACM device was another SAMA5D2 device, with a composite profile
including a CDC-ACM port implemented with configfs.

-- 
Romain Izard
