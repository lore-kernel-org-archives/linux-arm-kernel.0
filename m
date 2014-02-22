From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 22 Feb 2014 19:41:19 +0100
Subject: Stuck getting DTS working for a new kirkwood board
In-Reply-To: <530865C9.6000704@sigpipe.me>
References: <5306721B.7020403@sigpipe.me>
 <20140221013407.GX7862@titan.lakedaemon.net>
 <5307029C.20006@sigpipe.me>
 <20140221151530.GZ7862@titan.lakedaemon.net>
 <5307A727.9080508@sigpipe.me>
 <20140221200855.GM7862@titan.lakedaemon.net>
 <5307CCCD.5010505@sigpipe.me> <20140221221251.GH11878@lunn.ch>
 <530865C9.6000704@sigpipe.me>
Message-ID: <20140222184119.GF6667@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 22, 2014 at 09:54:33AM +0100, Dashie wrote:
> On 02/21/2014 11:12 PM, Andrew Lunn wrote:
> > Hi Dashie
> >
> > A few more tips for you
> Hi, thanks.
> >> Kernel command line: mtdparts=orion_nand:0x000e0000 at 0x00000000(u-boot)ro,0x1d73c0 at 0x000e0000(uImage),0x86cb58 at 0x2b73c0(uInitrd),- at 0xb23f18(rootfs) console=ttyS0,115200n8 verbose mem=256M root=/dev/sda2 rootdelay=8 ip=off earlyprintk
> > You seem to be missing nand in your DT. You should be able to work out
> > the partition sizes from the information above.
> Yes, I have manually removed nand partitions from my DTS, i don't use
> the default ones (except u-boot part) and don't have the rights offsets
> atm.

It would be good to have them for the final version, using the
standard defaults.

> >> rtc-mv f1010300.rtc: internal RTC not ticking
> > This suggests there is a different RTC on the board than the built in
> > one. It is probably on i2c. You can probably get the address using the
> > i2cdetect program. If you have boot logs from the vendor kernel it
> > will probably tell you what device it is.

> I looked at my photos of the PCB and found a M41T80 "Serial access
> real-time clock with alarm", it seems to be at 0x0c, then added :
>         i2c at 11000 {
> [snip]
>                         rtc: rtc at 0c {
>                                 compatible = "stm,m41t80";
>                                 reg = <0x0c>;
>                         };
>         };
> 
> And got:
> root at debian:~# dmesg|grep -i rtc
> rtc-mv f1010300.rtc: internal RTC not ticking
> rtc-m41t80 0-000c: chip found, driver version 0.05
> rtc-m41t80 0-000c: rtc core: registered m41t80 as rtc0
> rtc-m41t80 0-000c: hctosys: unable to read the hardware clock
> 
> The chip seems to register but nothing else.
> i2cdetect also shown the LM75 (working) and another i2c peripherial i
> have no ideas what is it.

I just had a look at the data sheet:

http://www.st.com/web/en/resource/technical/document/datasheet/CD00003119.pdf

It says:

   Access is obtained by implementing a start condition followed by
   the correct slave address (D0h).

I2C addresses are a bit odd, so this might actually mean 0x68, because
bit 0 is used to indicate Read/write. Does this address match to the
one you have no idea about?

    Andrew
