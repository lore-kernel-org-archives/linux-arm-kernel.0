From: gmane@chmurka.net (Adam Wysocki)
Date: Wed, 24 Aug 2016 14:52:32 +0000 (UTC)
Subject: Linux 4.7 and Jornada 720 (SA-1100)
References: <4Tcq736lIfmjNv8%gof@news.chmurka.net>
 <20160819102945.GK1041@n2100.armlinux.org.uk>
 <7Tcq9hpfIfmjNv8%gof@news.chmurka.net>
 <20160819132650.GO1041@n2100.armlinux.org.uk>
 <8Tcq9pmbIfmjNv8%gof@news.chmurka.net>
 <20160819151852.GR1041@n2100.armlinux.org.uk>
 <7Tcqmjs6I7ehNv8%gof@news.chmurka.net>
Message-ID: <8Tcqmui6I7ehNv8%gof@news.chmurka.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adam Wysocki <gmane@chmurka.net> wrote:

> Here's the diff: http://pastebin.com/raw/Mq8jPET9
> Here's the console output: http://pastebin.com/raw/JkDvVV9A
> 
> Maybe some patches for the ide-gd driver are needed to support the CF 
> card? Or even a different driver?

I made some more investigation.

In the old kernel (2.6.25) ide_disk.c driver is used ("ide-disk version 
1.18"). Here's the boot console output: http://pastebin.com/raw/YqZBGHp9

We can see there:

Uniform Multi-Platform E-IDE driver
ide: Assuming 50MHz system bus speed for PIO modes; override with idebus=xx
[...]
Probing IDE interface ide0...
hda: SanDisk SDCFH-008G, CFA DISK drive

So it's okay.

In the new kernel, only ide_gd.c identifies itself:

Uniform Multi-Platform E-IDE driver
ide-gd driver 1.18

I made some diagnostic printks in ide_gd_probe(), ide_disk_check() and 
ide_disk_setup(): http://pastebin.com/raw/AeE4KD2H

But they are never printed. It seems something was broken in this driver 
between 2.6.25 and 4.7...

Maybe instead of trying to get the old and deprecated code ("IDE") to 
work, it would be better to make the new code ("ATA" or libata) work?

-- 
http://www.chmurka.net/
