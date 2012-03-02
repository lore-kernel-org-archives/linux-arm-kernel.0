From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Fri, 2 Mar 2012 17:16:29 +0530
Subject: Randconfig module build error with OMAP4_ERRATA_I688
In-Reply-To: <20120301162556.GY18901@atomide.com>
References: <20120229173719.GN18901@atomide.com>
 <CAMQu2gxg_57AVW+MT_Sgi+gr2OUge-YPdSUxoG+z-zQth=4-UA@mail.gmail.com>
 <20120301162556.GY18901@atomide.com>
Message-ID: <CAMQu2gy9XksJ+8Q_Ygwtx7n2tVfd2KCu0o54SisuV8_QUX_rUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 1, 2012 at 9:55 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Shilimkar, Santosh <santosh.shilimkar@ti.com> [120301 00:38]:
>> On Wed, Feb 29, 2012 at 11:07 PM, Tony Lindgren <tony@atomide.com> wrote:
>> > Hi Santosh,
>> >
>> > Looks like OMAP4_ERRATA_I688 still has one more issue:
>> > Modules won't build at least with the attached randconfig
>> > generated file.
>> >
>> > Can you please take a look at how to deal with it?
>> >
>> > Maybe omap_bus_sync should be an inline function with some
>> > wrapper for the sleep44xx.S to call?
>> >
>> > I already posted a fix for the GPMC related error with the
>> > same .config file.
>> >
>> This one builds for me against 'Linux 3.3-rc5,
>> Ofocurse I got below error with the attached .config which
>> I bypassed to see the Errata build failure.
>>
>> arch/arm/mach-omap2/built-in.o: In function `n8x0_mmc_callback':
>> linux-2.6/arch/arm/mach-omap2/board-n8x0.c:374: undefined reference to
>> `omap_mmc_notify_cover_event'
>> make: *** [.tmp_vmlinux1] Error 1
>
> Yes a fix for that has been queued already.
>
>> I build this with below toolchain...
>> $arm-none-linux-gnueabi-gcc --version
>> arm-none-linux-gnueabi-gcc (Sourcery G++ Lite 2011.03-41) 4.5.2
>> Copyright (C) 2010 Free Software Foundation, Inc.
>>
>> Am I missing anything ?
>
> I think you're missing your commit 2ec1fc4e169acc0b8d6733ff028fd52e766773d9
> (ARM: OMAP4: Move the barrier memboclk_steal() as part of reserve callback)
> thats' queued up in fixes, and CONFIG_OMAP4_ERRATA_I688=y.
>
> Then with -rc5 + 2ec1fc4e when you build modules you'll get this:
>
> ERROR: "omap_bus_sync" [drivers/watchdog/sp805_wdt.ko] undefined!
> ERROR: "omap_bus_sync" [drivers/watchdog/dw_wdt.ko] undefined!
> ERROR: "omap_bus_sync" [drivers/virtio/virtio_ring.ko] undefined!
> ERROR: "omap_bus_sync" [drivers/video/sm501fb.ko] undefined!
> ERROR: "omap_bus_sync" [drivers/usb/mon/usbmon.ko] undefined!
> ERROR: "omap_bus_sync" [drivers/usb/host/sl811-hcd.ko] undefined!
> ERROR: "omap_bus_sync" [drivers/usb/host/ohci-hcd.ko] undefined!
> ERROR: "omap_bus_sync" [drivers/usb/host/isp1760.ko] undefined!
> ERROR: "omap_bus_sync" [drivers/usb/host/isp1362-hcd.ko] undefined!
> ERROR: "omap_bus_sync" [drivers/usb/host/isp116x-hcd.ko] undefined!
> ERROR: "omap_bus_sync" [drivers/usb/core/usbcore.ko] undefined!
> ERROR: "omap_bus_sync" [drivers/tty/serial/altera_uart.ko] undefined!
> ERROR: "omap_bus_sync" [drivers/tty/serial/altera_jtaguart.ko] undefined!
> ERROR: "omap_bus_sync" [drivers/tty/serial/8250/8250_dw.ko] undefined!
> ERROR: "omap_bus_sync" [drivers/ssb/ssb.ko] undefined!
> ERROR: "omap_bus_sync" [drivers/rtc/rtc-cmos.ko] undefined!
> ERROR: "omap_bus_sync" [drivers/rtc/rtc-bq4802.ko] undefined!
> ERROR: "omap_bus_sync" [drivers/mtd/nand/tmio_nand.ko] undefined!
> ERROR: "omap_bus_sync" [drivers/mtd/nand/omap2.ko] undefined!
>
Sricharan has posted a fix for it. [1]
The sleep code stuff is just dummy function for the cases when the errata
is not defined. When Errata is defined the generic barriers too get impacted
and hence the function needs to be exported.

Regards
Santosh
[1] http://www.spinics.net/lists/arm-kernel/msg162608.html
