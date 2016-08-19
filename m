From: gmane@chmurka.net (Adam Wysocki)
Date: Fri, 19 Aug 2016 14:33:34 +0000 (UTC)
Subject: Linux 4.7 and Jornada 720 (SA-1100)
References: <4Tcq736lIfmjNv8%gof@news.chmurka.net>
 <20160819102945.GK1041@n2100.armlinux.org.uk>
 <7Tcq9hpfIfmjNv8%gof@news.chmurka.net>
 <20160819132650.GO1041@n2100.armlinux.org.uk>
Message-ID: <8Tcq9pmbIfmjNv8%gof@news.chmurka.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@armlinux.org.uk> wrote:

> Looking at the board file, the jornada720 doesn't use sa11x0-fb at all.
> It uses an Epson s1d13xxx device.  The defconfig for jornada720 has:

Another bingo - enabling this:

> CONFIG_FB_S1D13XXX=y

Solved the issue with console. Thanks!

> so if your configuration is derived from that, you should have the
> driver already enabled.

Where is this board file and defconfig for Jornada? I wasn't aware of 
their existence, so I did my config from scratch. Maybe comparing my 
config to defconfig will solve the issue with CF card, too...

>> It seems that earlyprintk is ignored anyway, maybe there's no support for 
>> it on this platform?
> 
> No idea, sorry.

Well, now, as I have the console, it's not needed anymore :)

> I use my printascii() hack in printk() when I need early or lowlevel 
> debugging rather than early printk.

Where does it print to? Serial port?

>> > However, if you're not even getting the "Uncompressing Linux... done, 
>> > booting the kernel." line, that suggests the decompressor is not running, 
>> > or is trying to access the wrong serial port.  The decompressor tries to 
>> > find the first serial port out of serial 3, 1 and 2 which has been left 
>> > enabled.
>> 
>> In this order? Maybe it tries to send its messages to the built-in modem 
>> or IrDA port...
> 
> Yes, that order.

>From SA-1100 developers manual it seems that:

- serial 0 is the USB device controller
- serial 1 is the SDLC/UART
- serial 2 is the IrDA port
- serial 3 is the UART (probably this one is routed externally)
- serial 4 is the MCP / SSP (whatever it is)

So it should use UART... strange that it doesn't do it. Or maybe it does, 
but on different baudrate than 115200 (but I would probably get garbage 
then)...

Does it mean that if I enabled USB device and IrDA in the kernel, I would 
have external serial port on ttySA2 instead of 0?

Thanks again for your support.

-- 
http://www.chmurka.net/
