From: dashie@sigpipe.me (Dashie)
Date: Sat, 22 Feb 2014 19:50:20 +0100
Subject: Stuck getting DTS working for a new kirkwood board
In-Reply-To: <20140222184119.GF6667@lunn.ch>
References: <5306721B.7020403@sigpipe.me>
 <20140221013407.GX7862@titan.lakedaemon.net> <5307029C.20006@sigpipe.me>
 <20140221151530.GZ7862@titan.lakedaemon.net> <5307A727.9080508@sigpipe.me>
 <20140221200855.GM7862@titan.lakedaemon.net> <5307CCCD.5010505@sigpipe.me>
 <20140221221251.GH11878@lunn.ch> <530865C9.6000704@sigpipe.me>
 <20140222184119.GF6667@lunn.ch>
Message-ID: <5308F16C.1070207@sigpipe.me>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/22/2014 07:41 PM, Andrew Lunn wrote:
>>>> Kernel command line: mtdparts=orion_nand:0x000e0000 at 0x00000000(u-boot)ro,0x1d73c0 at 0x000e0000(uImage),0x86cb58 at 0x2b73c0(uInitrd),- at 0xb23f18(rootfs) console=ttyS0,115200n8 verbose mem=256M root=/dev/sda2 rootdelay=8 ip=off earlyprintk
>>> You seem to be missing nand in your DT. You should be able to work out
>>> the partition sizes from the information above.
>> Yes, I have manually removed nand partitions from my DTS, i don't use
>> the default ones (except u-boot part) and don't have the rights offsets
>> atm.
> It would be good to have them for the final version, using the
> standard defaults.
I've the nand offsets from original boot log available.
>>>> rtc-mv f1010300.rtc: internal RTC not ticking
>>> This suggests there is a different RTC on the board than the built in
>>> one. It is probably on i2c. You can probably get the address using the
>>> i2cdetect program. If you have boot logs from the vendor kernel it
>>> will probably tell you what device it is.
>> I looked at my photos of the PCB and found a M41T80 "Serial access
>> real-time clock with alarm", it seems to be at 0x0c, then added :
>>         i2c at 11000 {
>> [snip]
>>                         rtc: rtc at 0c {
>>                                 compatible = "stm,m41t80";
>>                                 reg = <0x0c>;
>>                         };
>>         };
>>
>> And got:
>> root at debian:~# dmesg|grep -i rtc
>> rtc-mv f1010300.rtc: internal RTC not ticking
>> rtc-m41t80 0-000c: chip found, driver version 0.05
>> rtc-m41t80 0-000c: rtc core: registered m41t80 as rtc0
>> rtc-m41t80 0-000c: hctosys: unable to read the hardware clock
>>
>> The chip seems to register but nothing else.
>> i2cdetect also shown the LM75 (working) and another i2c peripherial i
>> have no ideas what is it.
> I just had a look at the data sheet:
>
> http://www.st.com/web/en/resource/technical/document/datasheet/CD00003119.pdf
>
> It says:
>
>    Access is obtained by implementing a start condition followed by
>    the correct slave address (D0h).
>
> I2C addresses are a bit odd, so this might actually mean 0x68, because
> bit 0 is used to indicate Read/write. Does this address match to the
> one you have no idea about?
>
>     Andrew
i2c device currently are :

root at debian:~# i2cdetect 0
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0.
I will probe address range 0x03-0x77.
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- -- -- -- -- UU -- -- --
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
40: -- -- -- -- -- -- -- -- -- UU -- -- -- -- -- --
50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
60: -- -- -- -- 64 -- -- -- -- -- -- -- -- -- -- --
70: -- -- -- -- -- -- -- --

0x49 is a LM sensor, and 0x0c and 0x64 i don't know.
