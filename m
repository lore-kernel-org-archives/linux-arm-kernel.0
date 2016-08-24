From: gmane@chmurka.net (Adam Wysocki)
Date: Wed, 24 Aug 2016 13:34:44 +0000 (UTC)
Subject: Linux 4.7 and Jornada 720 (SA-1100)
References: <4Tcq736lIfmjNv8%gof@news.chmurka.net>
 <20160819102945.GK1041@n2100.armlinux.org.uk>
 <7Tcq9hpfIfmjNv8%gof@news.chmurka.net>
 <20160819132650.GO1041@n2100.armlinux.org.uk>
 <8Tcq9pmbIfmjNv8%gof@news.chmurka.net>
 <20160819151852.GR1041@n2100.armlinux.org.uk>
Message-ID: <7Tcqmjs6I7ehNv8%gof@news.chmurka.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@armlinux.org.uk> wrote:

> $ cp .config config-mine
> $ make ARCH=arm jornada720_defconfig
> $ diff -u .config config-mine | less
> 
> As jornada720_defconfig is rather old, I don't guarantee that it will
> produce a working configuration file with current kernels as things
> have changed over the years, but it should get you close.

Thanks, I just used that. My .config is similar to the generated when it 
comes to the block layer and block devices, but it still fails to see any 
partitions...

Here's the diff: http://pastebin.com/raw/Mq8jPET9
Here's the console output: http://pastebin.com/raw/JkDvVV9A

Maybe some patches for the ide-gd driver are needed to support the CF 
card? Or even a different driver?

>> So it should use UART... strange that it doesn't do it. Or maybe it does, 
>> but on different baudrate than 115200 (but I would probably get garbage 
>> then)...
> 
> All it does is look for the first enabled serial port, and write the
> characters to the FIFO.  The idea is that the boot loader will have
> setup one of the ports at the correct baud rate, and we don't need to
> have device-specific hacks to select the correct port.

Hmm, maybe jlinexec.exe disables the serial port before passing control to 
the unpacker. Who knows.

> Consequently, without digging through the code each time, there's no
> easy way to determine the mapping of these ports.  In the case of
> jornada720, arch/arm/mach-sa1100/jornada720.c defines these as:
> 
>         sa1100_register_uart(0, 3);
>         sa1100_register_uart(1, 1);
> 
> which means ttySA0 -> serial 3, ttySA1 -> serial 1, ttySA2 is disabled.

I see. Thanks for explanation!

If you have some patches (mentioned in another email), I'm ready for 
testing.

-- 
http://www.chmurka.net/
