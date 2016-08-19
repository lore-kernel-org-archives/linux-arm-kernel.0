From: gmane@chmurka.net (Adam Wysocki)
Date: Fri, 19 Aug 2016 13:11:13 +0000 (UTC)
Subject: Linux 4.7 and Jornada 720 (SA-1100)
References: <4Tcq736lIfmjNv8%gof@news.chmurka.net>
 <20160819102945.GK1041@n2100.armlinux.org.uk>
Message-ID: <7Tcq9hpfIfmjNv8%gof@news.chmurka.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@armlinux.org.uk> wrote:

> Make sure you have "console=ttySA0,38400n8" or similar to get serial
> console output - it needs to be a "ttySA" port, not "ttyS".

Hmm... I changed to:

root=0x302 mem=32m console=ttySA0,115200n8

and success - it helped! The screen is still blank, but I least I have 
some messages on the serial port, finished with kernel panic because of 
failing to mount root. It looks like I didn't enable some drivers for 
the CF controller, but I look and it seems everything that should be 
enabled is enabled... maybe this kernel doesn't support CF on Jornada 
without a patch?

http://pastebin.com/J2ATKxQM

And I'm just wondering why the screen is blank while I definitely enabled 
the SA-1100 framebuffer support and console on framebuffer... I'm not sure 
if it should be blank when I specified console=ttySA0, but I don't think 
it should be blank without any console= setting...

> Same probably goes for "earlyprintk=serial,ttyS0,115200", although I've
> no experience of earlyprintk myself.

It seems that earlyprintk is ignored anyway, maybe there's no support for 
it on this platform?

> However, if you're not even getting the "Uncompressing Linux... done, 
> booting the kernel." line, that suggests the decompressor is not running, 
> or is trying to access the wrong serial port.  The decompressor tries to 
> find the first serial port out of serial 3, 1 and 2 which has been left 
> enabled.

In this order? Maybe it tries to send its messages to the built-in modem 
or IrDA port...

Anyway, now I know that kernel boots, so it's definitely helpful. I'll try 
to find out what's wrong with this console and CF controller...

-- 
http://www.chmurka.net/
