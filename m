From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 16 Jul 2014 19:39:04 +0100
Subject: BUG: i.MX6-FEC: broken TCP tx checksumming
In-Reply-To: <CAOpc7mGrZXbr-cytzSHLUjgoYz88ZFeuv2g0kJ2kzOnbF7Uz5g@mail.gmail.com>
References: <CAOpc7mFpW=ZDdF3g-MK4TaNje5KBWimUwUgxoebg-wmb+OQ8zA@mail.gmail.com>
 <20140716095850.GO21766@n2100.arm.linux.org.uk>
 <CAOpc7mGrZXbr-cytzSHLUjgoYz88ZFeuv2g0kJ2kzOnbF7Uz5g@mail.gmail.com>
Message-ID: <20140716183904.GQ21766@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 16, 2014 at 04:03:21PM +0200, Holger Schurig wrote:
> >> So I tried "ethtool -K eth0 tx off" (on the i.MX6 board) and suddenly
> >> ssh worked.
> >
> > That sounds like the hardware IP header checksumming isn't working.  Is
> > there anything specific to your setup?  VLAN maybe?
> 
> No, no games, I just did a normal "ifconfig eth0 192.168.200.199".
> 
> > Which gcc version are you using?
> 
> Currently http://releases.linaro.org/14.04/components/toolchain/binaries/gcc-linaro-arm-linux-gnueabihf-4.8-2014.04_linux.tar.xz
>  But I could try a different one.

I'd consider asking whether you'd send me fec_main.o with and without the
wmb() in it, but I'm not sure if I have the time to look at it right now.

> > That's a little heavy-weight, but let's use the sledge hammer first...
> 
> The sledge hammer worked!
> 
> Do you want to to find out which of the for wmb() is actually needed?

It may be worth checking whether it needs to be wmb(), or whether
barrier() will do - in other words, is it the compiler re-ordering the
stores, or is it the hardware re-ordering them.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
