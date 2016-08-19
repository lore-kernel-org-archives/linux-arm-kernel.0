From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 19 Aug 2016 14:26:50 +0100
Subject: Linux 4.7 and Jornada 720 (SA-1100)
In-Reply-To: <7Tcq9hpfIfmjNv8%gof@news.chmurka.net>
References: <4Tcq736lIfmjNv8%gof@news.chmurka.net>
 <20160819102945.GK1041@n2100.armlinux.org.uk>
 <7Tcq9hpfIfmjNv8%gof@news.chmurka.net>
Message-ID: <20160819132650.GO1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 19, 2016 at 01:11:13PM +0000, Adam Wysocki wrote:
> Russell King - ARM Linux <linux@armlinux.org.uk> wrote:
> 
> > Make sure you have "console=ttySA0,38400n8" or similar to get serial
> > console output - it needs to be a "ttySA" port, not "ttyS".
> 
> Hmm... I changed to:
> 
> root=0x302 mem=32m console=ttySA0,115200n8
> 
> and success - it helped! The screen is still blank, but I least I have 
> some messages on the serial port, finished with kernel panic because of 
> failing to mount root. It looks like I didn't enable some drivers for 
> the CF controller, but I look and it seems everything that should be 
> enabled is enabled... maybe this kernel doesn't support CF on Jornada 
> without a patch?
> 
> http://pastebin.com/J2ATKxQM
> 
> And I'm just wondering why the screen is blank while I definitely enabled 
> the SA-1100 framebuffer support and console on framebuffer... I'm not sure 
> if it should be blank when I specified console=ttySA0, but I don't think 
> it should be blank without any console= setting...

Looking at the board file, the jornada720 doesn't use sa11x0-fb at all.
It uses an Epson s1d13xxx device.  The defconfig for jornada720 has:

CONFIG_FB_S1D13XXX=y

so if your configuration is derived from that, you should have the
driver already enabled.

> > Same probably goes for "earlyprintk=serial,ttyS0,115200", although I've
> > no experience of earlyprintk myself.
> 
> It seems that earlyprintk is ignored anyway, maybe there's no support for 
> it on this platform?

No idea, sorry.  I use my printascii() hack in printk() when I need early
or lowlevel debugging rather than early printk.

> > However, if you're not even getting the "Uncompressing Linux... done, 
> > booting the kernel." line, that suggests the decompressor is not running, 
> > or is trying to access the wrong serial port.  The decompressor tries to 
> > find the first serial port out of serial 3, 1 and 2 which has been left 
> > enabled.
> 
> In this order? Maybe it tries to send its messages to the built-in modem 
> or IrDA port...

Yes, that order.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
