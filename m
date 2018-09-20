From: romain.izard.pro@gmail.com (Romain Izard)
Date: Thu, 20 Sep 2018 16:17:20 +0200
Subject: Kernel memory leak on CDC-ACM device plug/unplug
In-Reply-To: <20180919203222.GA1492@kroah.com>
References: <CAGkQfmP6o+e_nanviTfRt7Ej9U+4BdqDYvMM83FjHhSCECcH3w@mail.gmail.com>
 <20180919203222.GA1492@kroah.com>
Message-ID: <CAGkQfmNEAeETcOqkX9Hh_RndT67VYTRs_sm4pCZkYy=VU+MzRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-09-19 22:32 GMT+02:00 Greg KH <gregkh@linuxfoundation.org>:
> On Wed, Sep 19, 2018 at 04:11:55PM +0200, Romain Izard wrote:
>> While trying to debug a memory leak problem, I encountered the following
>> problem:
>>
>> After plugging/unplugging an USB CDC-ACM device, kmemleak reports multiple
>> copies of the following leak. It is not necessary to open the port for the
>> leak to happen.
>>
>> unreferenced object 0xddbfd500 (size 128):
>>   comm "kworker/0:3", pid 675, jiffies 69734 (age 916.580s)
>>   hex dump (first 32 bytes):
>>     01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>     00 00 00 00 00 00 00 00 00 00 00 00 1c d5 bf dd  ................
>>   backtrace:
>>     [<da0194da>] acm_probe+0x868/0xc3c
>>     [<cc72c809>] usb_probe_interface+0x11c/0x274
>>     [<bbce212c>] driver_probe_device+0x22c/0x320
>>     [<544a5b43>] bus_for_each_drv+0x58/0xb8
>>     [<fe5944dc>] __device_attach+0xd0/0x138
>>     [<d807c1e5>] bus_probe_device+0x84/0x8c
>>     [<16645f2c>] device_add+0x3cc/0x5c0
>>     [<80c11c88>] usb_set_configuration+0x448/0x7b0
>>     [<76bdbcdf>] generic_probe+0x2c/0x78
>>     [<bbce212c>] driver_probe_device+0x22c/0x320
>>     [<544a5b43>] bus_for_each_drv+0x58/0xb8
>>     [<fe5944dc>] __device_attach+0xd0/0x138
>>     [<d807c1e5>] bus_probe_device+0x84/0x8c
>>     [<16645f2c>] device_add+0x3cc/0x5c0
>>     [<02a49898>] usb_new_device+0x264/0x424
>>     [<865a481b>] hub_event+0xa20/0x1154
>>
>> For each additional plug/unplug cycle, around 30 such new leaks are created.
>>
>> Tested on a SAMA5D2 Xplained demo board, with a v4.18.8 kernel.
>> The CDC-ACM device was another SAMA5D2 device, with a composite profile
>> including a CDC-ACM port implemented with configfs.
>
> Have you come up with any patches that might resolve this?  It's hard to
> see what exactly is "leaking" here.
>

I finally found that Linux v4.9 was not affected.
git-bisect gives the following output:

ba8c931ded8d96c8923662099416bc2096644eab is the first bad commit
commit ba8c931ded8d96c8923662099416bc2096644eab
Author: Ladislav Michl <ladis@linux-mips.org>
Date:   Fri Nov 18 19:07:08 2016 +0100

    cdc-acm: refactor killing urbs

    Move urb killing code into separate function and use it
    instead of copying that code pattern over.

    Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
    Acked-by: Oliver Neukum <oneukum@suse.com>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

:040000 040000 bb64a6003aa575fb459cd64cb63ff0189134db8f
68ad7dc597533eaff2d33c9ac2b23d49906f6551 M      drivers

I found a bug in that commit, I'm sending a fix for it.

Best regards
-- 
Romain Izard
