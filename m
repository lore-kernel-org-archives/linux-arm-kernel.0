From: gsi@denx.de (Gerhard Sittig)
Date: Sat, 22 Feb 2014 19:44:14 +0100
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
Message-ID: <20140222184414.GG3327@book.gsilab.sittig.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 22, 2014 at 09:54 +0100, Dashie wrote:
> 
> On 02/21/2014 11:12 PM, Andrew Lunn wrote:
> > This suggests there is a different RTC on the board than the built in
> > one. It is probably on i2c. You can probably get the address using the
> > i2cdetect program. If you have boot logs from the vendor kernel it
> > will probably tell you what device it is.
> >
> >      Andrew
> I looked at my photos of the PCB and found a M41T80 "Serial access
> real-time clock with alarm", it seems to be at 0x0c, then added :
>         i2c at 11000 {
> [snip]
>                         rtc: rtc at 0c {
>                                 compatible = "stm,m41t80";
>                                 reg = <0x0c>;
>                         };
>         };

Aren't these M41T80 usually at I2C address 0x68 (fixed in the
chip, and not adjustable, not even partly)? 0x0c looks very
unexpected to me.

> And got:
> root at debian:~# dmesg|grep -i rtc
> rtc-mv f1010300.rtc: internal RTC not ticking
> rtc-m41t80 0-000c: chip found, driver version 0.05
> rtc-m41t80 0-000c: rtc core: registered m41t80 as rtc0
> rtc-m41t80 0-000c: hctosys: unable to read the hardware clock
> 
> The chip seems to register but nothing else.

Well, the driver blindly follows your input, and cannot detect
nor verify the chip's being present or being of the correct type.
So an address mismatch explains what you see.


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office at denx.de
