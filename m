From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sat, 13 May 2017 14:28:01 +0200 (CEST)
Subject: usb: dwc2: NMI watchdog: BUG: soft lockup - CPU#0 stuck for 146s
In-Reply-To: <CAD=FV=VUaqtR2t04wodRJ33bqHo5DPke7zsvqBMYqZ5imX5+=A@mail.gmail.com>
References: <172093673.40121.1492427140661@email.1und1.de>
 <CAD=FV=WJBTUcMPw8OgQT_jhz0H8AsH=YqWMR7LtudUKrF5-XOA@mail.gmail.com>
 <79b9b35b-0600-771f-4cd2-9e03c5ba3a25@i2se.com>
 <186569458.91967.1492547106553@email.1und1.de>
 <CAD=FV=VHkJFrsJDmMytbUw=WjKQaGZ-8Ewfy5bPCA82AWS4O2Q@mail.gmail.com>
 <212870399.174480.1492633502649@email.1und1.de>
 <87mvbaykn1.fsf@eliezer.anholt.net>
 <1998517910.54108.1492894253010@email.1und1.de>
 <2127594073.298820.1493143869792@email.1und1.de>
 <316369012.317772.1494274928708@email.1und1.de>
 <20170510163150.GK30445@localhost>
 <CAD=FV=VUaqtR2t04wodRJ33bqHo5DPke7zsvqBMYqZ5imX5+=A@mail.gmail.com>
Message-ID: <446301756.220218.1494678481761@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Doug Anderson <dianders@chromium.org> hat am 11. Mai 2017 um 01:50 geschrieben:
> 
> 
> Hi,
> 
> On Wed, May 10, 2017 at 9:31 AM, Johan Hovold <johan@kernel.org> wrote:
> > On Mon, May 08, 2017 at 10:22:08PM +0200, Stefan Wahren wrote:
> >> @Doug, @John Y., @Johan: Any further ideas to narrow down the reason
> >> for this interrupt storm?
> >
> > No, sorry.
> >
> > I suggested earlier that you could try commenting out the interrupt-URB
> > submission in a naive attempt to narrow it down since that is an obvious
> > difference from the ftdi driver, but then again so are the frequent ftdi
> > status bulk messages (and any other timing differences).
> >
> > Seems like you need to dig into dwc2.
> 
> I haven't had a chance to dig and not sure when I'll have that time.
> I'll keep this around in my inbox for now on the off chance that I
> clean it out enough to get back to this.  Sorry!
> 

But thanks for all your feedback guys.

Btw i think i took a step forward. During the whole time i a took a Raspberry Pi B to reproduce this issue, which has a builtin USB hub and a SMSC USB to ethernet chip.

/:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=dwc2/1p, 480M
    |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/3p, 480M
        |__ Port 1: Dev 3, If 0, Class=Vendor Specific Class, Driver=smsc95xx, 480M
        |__ Port 2: Dev 4, If 0, Class=Vendor Specific Class, Driver=pl2303, 12M

I decide to switch to the Raspberry Pi Zero which neither have a builtin USB hub or a USB ethernet chip. If i connect the PL2303 directly to the RPi Zero the issue is not reproducible and usb_test behave as expected by opening the port and terminate after a few seconds (good case).

/:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=dwc2/1p, 480M
    |__ Port 1: Dev 5, If 0, Class=Vendor Specific Class, Driver=pl2303, 12M

After that i placed a USB 4 port hub between RPi Zero and PL2303. Now the issue (interrupt storm) occurs on the RPi Zero (bad case). After nearly 20 seconds i disconnected the PL2303 in order to make the system usable and stop the trace.

/:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=dwc2/1p, 480M
    |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/4p, 480M
        |__ Port 3: Dev 4, If 0, Class=Vendor Specific Class, Driver=pl2303, 12M

Additional i made usbmon traces of both cases. Maybe that's useful for somebody with more USB knowledge than me.

Stefan

good case:

d9adfd00 1324940464 S Co:1:005:0 s 40 01 0008 0000 0000 0
d9adfd00 1324941739 C Co:1:005:0 0 0
d9adfd00 1324941792 S Co:1:005:0 s 40 01 0009 0000 0000 0
d9adfd00 1324941879 C Co:1:005:0 0 0
d9adfd00 1324941920 S Ci:1:005:0 s a1 21 0000 0000 0007 7 <
d9adfd00 1324942046 C Ci:1:005:0 0 7 = 80250000 000000
d9adfd00 1324942093 S Co:1:005:0 s 21 20 0000 0000 0007 7 = 80250000 000008
d9adfd00 1324942211 C Co:1:005:0 0 7 >
d9adfd00 1324942248 S Co:1:005:0 s 40 01 0000 0000 0000 0
d9adfd00 1324942335 C Co:1:005:0 0 0
da6ef600 1324942367 S Ii:1:005:1 -115:1 10 <
da6efd00 1324942412 S Bi:1:005:3 -115 256 <
da6ef800 1324942431 S Bi:1:005:3 -115 256 <
d9adfd00 1324942447 S Co:1:005:0 s 21 22 0003 0000 0000 0
d9adfd00 1324943310 C Co:1:005:0 0 0
da6ef600 1324944174 C Ii:1:005:1 0:1 10 = a1200000 00000200 8b06
da6ef600 1324944192 S Ii:1:005:1 -115:1 10 <
da6ef600 1324946152 C Ii:1:005:1 0:1 10 = a1200000 00000200 8b00
da6ef600 1324946161 S Ii:1:005:1 -115:1 10 <
da6ef600 1325451149 C Ii:1:005:1 -5:1 0
da6ef600 1325451177 S Ii:1:005:1 -115:1 10 <
d9adf400 1330210089 S Co:1:005:0 s 21 22 0000 0000 0000 0
d9adf400 1330211717 C Co:1:005:0 0 0
da6efd00 1330211855 C Bi:1:005:3 -2 0
da6ef800 1330211921 C Bi:1:005:3 -2 0
da6ef600 1330211969 C Ii:1:005:1 -2:1 0
d9adf400 1330211997 S Co:1:005:0 s 21 23 0000 0000 0000 0
d9adf400 1330212158 C Co:1:005:0 0 0

bad case:

da6efb00 316377734 S Co:1:004:0 s 40 01 0008 0000 0000 0
da6efb00 316378587 C Co:1:004:0 0 0
da6efb00 316378837 S Co:1:004:0 s 40 01 0009 0000 0000 0
da6efb00 316379201 C Co:1:004:0 0 0
da6efb00 316379397 S Ci:1:004:0 s a1 21 0000 0000 0007 7 <
da6efb00 316379697 C Ci:1:004:0 0 7 = 80250000 000000
da6efb00 316379890 S Co:1:004:0 s 21 20 0000 0000 0007 7 = 80250000 000008
da6efb00 316380350 C Co:1:004:0 0 7 >
da6efb00 316380580 S Co:1:004:0 s 40 01 0000 0000 0000 0
da6efb00 316380932 C Co:1:004:0 0 0
d9a14b00 316381132 S Ii:1:004:1 -115:1 10 <
da780600 316381325 S Bi:1:004:3 -115 256 <
da780100 316381488 S Bi:1:004:3 -115 256 <
d9a14b00 316389933 C Ii:1:004:1 0:1 10 = a1200000 00000200 8b06
d9a14b00 316390820 S Ii:1:004:1 -115:1 10 <
d9a14b00 316398308 C Ii:1:004:1 0:1 10 = a1200000 00000200 8b00
d9a14b00 316399936 S Ii:1:004:1 -115:1 10 <
da6efb00 316419808 S Co:1:004:0 s 21 22 0003 0000 0000 0
da6efb00 316438433 C Co:1:004:0 0 0
da780600 339316684 C Bi:1:004:3 -32 0
da780100 339316772 C Bi:1:004:3 -32 0
d9a14b00 339317035 C Ii:1:004:1 -32:1 0
d9a14b00 339317049 S Ii:1:004:1 -115:1 10 <
d9a14b00 339318040 C Ii:1:004:1 -32:1 0
d9a14b00 339318057 S Ii:1:004:1 -115:1 10 <
d9a14b00 339319042 C Ii:1:004:1 -32:1 0
d9a14b00 339319056 S Ii:1:004:1 -115:1 10 <
d9a14b00 339329551 C Ii:1:004:1 -32:1 0
d9a14b00 339329571 S Ii:1:004:1 -115:1 10 <
d9a14b00 339330586 C Ii:1:004:1 -32:1 0
d9a14b00 339330601 S Ii:1:004:1 -115:1 10 <
d9a14b00 339331035 C Ii:1:004:1 -32:1 0
d9a14b00 339331046 S Ii:1:004:1 -115:1 10 <
d9a14b00 339332037 C Ii:1:004:1 -32:1 0
d9a14b00 339332049 S Ii:1:004:1 -115:1 10 <
d9a14b00 339333054 C Ii:1:004:1 -32:1 0
d9a14b00 339333068 S Ii:1:004:1 -115:1 10 <
d9a14b00 339334037 C Ii:1:004:1 -32:1 0
d9a14b00 339334050 S Ii:1:004:1 -115:1 10 <
d9a14b00 339335036 C Ii:1:004:1 -32:1 0
d9a14b00 339335050 S Ii:1:004:1 -115:1 10 <
d9a14b00 339336036 C Ii:1:004:1 -32:1 0
d9a14b00 339336049 S Ii:1:004:1 -115:1 10 <
d9a14b00 339337037 C Ii:1:004:1 -32:1 0
d9a14b00 339337050 S Ii:1:004:1 -115:1 10 <
d9a14b00 339338039 C Ii:1:004:1 -32:1 0
d9a14b00 339338074 S Ii:1:004:1 -115:1 10 <
d9a14b00 339339038 C Ii:1:004:1 -32:1 0
d9a14b00 339339052 S Ii:1:004:1 -115:1 10 <
d9a14b00 339340130 C Ii:1:004:1 -32:1 0
d9a14b00 339340143 S Ii:1:004:1 -115:1 10 <
d9a14b00 339341035 C Ii:1:004:1 -32:1 0
d9a14b00 339341048 S Ii:1:004:1 -115:1 10 <
d9a14b00 339342039 C Ii:1:004:1 -32:1 0
d9a14b00 339342051 S Ii:1:004:1 -115:1 10 <
d9a14b00 339343038 C Ii:1:004:1 -32:1 0
d9a14b00 339343051 S Ii:1:004:1 -115:1 10 <
d9a14b00 339344038 C Ii:1:004:1 -32:1 0
d9a14b00 339344050 S Ii:1:004:1 -115:1 10 <
d9a14b00 339345037 C Ii:1:004:1 -32:1 0
d9a14b00 339345050 S Ii:1:004:1 -115:1 10 <
d9a14b00 339346038 C Ii:1:004:1 -32:1 0
d9a14b00 339346049 S Ii:1:004:1 -115:1 10 <
d9a14b00 339347030 C Ii:1:004:1 -32:1 0
d9a14b00 339347041 S Ii:1:004:1 -115:1 10 <
d9a14b00 339348039 C Ii:1:004:1 -32:1 0
d9a14b00 339348052 S Ii:1:004:1 -115:1 10 <
d9a14b00 339349039 C Ii:1:004:1 -32:1 0
d9a14b00 339349053 S Ii:1:004:1 -115:1 10 <
d9a14b00 339350105 C Ii:1:004:1 -32:1 0
d9a14b00 339350119 S Ii:1:004:1 -115:1 10 <
d9a14b00 339351032 C Ii:1:004:1 -32:1 0
d9a14b00 339351044 S Ii:1:004:1 -115:1 10 <
d9a14b00 339352030 C Ii:1:004:1 -32:1 0
d9a14b00 339352042 S Ii:1:004:1 -115:1 10 <
d9a14b00 339353037 C Ii:1:004:1 -32:1 0
d9a14b00 339353051 S Ii:1:004:1 -115:1 10 <
d9a14b00 339354068 C Ii:1:004:1 -32:1 0
d9a14b00 339354083 S Ii:1:004:1 -115:1 10 <
d9a14b00 339355018 C Ii:1:004:1 -32:1 0
d9a14b00 339355026 S Ii:1:004:1 -115:1 10 <
d9a14b00 339356017 C Ii:1:004:1 -32:1 0
d9a14b00 339356025 S Ii:1:004:1 -115:1 10 <
d9a14b00 339357018 C Ii:1:004:1 -32:1 0
d9a14b00 339357026 S Ii:1:004:1 -115:1 10 <
d9a14b00 339358017 C Ii:1:004:1 -32:1 0
d9a14b00 339358025 S Ii:1:004:1 -115:1 10 <
d9a14b00 339359018 C Ii:1:004:1 -32:1 0
d9a14b00 339359026 S Ii:1:004:1 -115:1 10 <
d9a14b00 339360016 C Ii:1:004:1 -32:1 0
d9a14b00 339360024 S Ii:1:004:1 -115:1 10 <
d9a14b00 339361018 C Ii:1:004:1 -32:1 0
d9a14b00 339361026 S Ii:1:004:1 -115:1 10 <
d9a14b00 339362016 C Ii:1:004:1 -32:1 0
d9a14b00 339362024 S Ii:1:004:1 -115:1 10 <
d9a14b00 339363017 C Ii:1:004:1 -32:1 0
d9a14b00 339363049 S Ii:1:004:1 -115:1 10 <
d9a14b00 339364017 C Ii:1:004:1 -32:1 0
d9a14b00 339364025 S Ii:1:004:1 -115:1 10 <
d9a14b00 339365017 C Ii:1:004:1 -32:1 0
d9a14b00 339365025 S Ii:1:004:1 -115:1 10 <
d9a14b00 339366016 C Ii:1:004:1 -32:1 0
d9a14b00 339366024 S Ii:1:004:1 -115:1 10 <
d9a14b00 339367017 C Ii:1:004:1 -32:1 0
d9a14b00 339367025 S Ii:1:004:1 -115:1 10 <
d9a14b00 339368017 C Ii:1:004:1 -32:1 0
d9a14b00 339368024 S Ii:1:004:1 -115:1 10 <
d9a14b00 339369017 C Ii:1:004:1 -32:1 0
d9a14b00 339369025 S Ii:1:004:1 -115:1 10 <
d9a14b00 339370017 C Ii:1:004:1 -32:1 0
d9a14b00 339370024 S Ii:1:004:1 -115:1 10 <
d9a14b00 339371017 C Ii:1:004:1 -32:1 0
d9a14b00 339371026 S Ii:1:004:1 -115:1 10 <
d9a14b00 339372017 C Ii:1:004:1 -32:1 0
d9a14b00 339372024 S Ii:1:004:1 -115:1 10 <
d9a14b00 339373017 C Ii:1:004:1 -32:1 0
d9a14b00 339373025 S Ii:1:004:1 -115:1 10 <
d9a14b00 339374018 C Ii:1:004:1 -32:1 0
d9a14b00 339374025 S Ii:1:004:1 -115:1 10 <
d9a14b00 339375017 C Ii:1:004:1 -32:1 0
d9a14b00 339375025 S Ii:1:004:1 -115:1 10 <
d9a14b00 339376018 C Ii:1:004:1 -32:1 0
d9a14b00 339376026 S Ii:1:004:1 -115:1 10 <
d9a14b00 339377017 C Ii:1:004:1 -32:1 0
d9a14b00 339377024 S Ii:1:004:1 -115:1 10 <
d9930180 339605934 S Ci:1:002:0 s a3 00 0000 0003 0004 4 <
d9930180 339606101 C Ci:1:002:0 0 4 = 00010000
d9930380 339650171 S Ci:1:002:0 s a3 00 0000 0003 0004 4 <
d9930380 339650346 C Ci:1:002:0 0 4 = 00010000
d9842c80 339700165 S Ci:1:002:0 s a3 00 0000 0003 0004 4 <
d9842c80 339700346 C Ci:1:002:0 0 4 = 00010000
da780000 339751063 S Ci:1:002:0 s a3 00 0000 0003 0004 4 <
da780000 339751221 C Ci:1:002:0 0 4 = 00010000
d9a15380 339800833 S Ci:1:002:0 s a3 00 0000 0003 0004 4 <
d9a15380 339800974 C Ci:1:002:0 0 4 = 00010000
da737080 339801535 C Ii:1:002:1 -2:2048 0
d9a15380 339802157 S Co:1:002:0 s 00 03 0001 0000 0000 0
d9a15380 339802265 C Co:1:002:0 0 0
d9a15380 339802291 S Co:1:001:0 s 23 03 0002 0001 0000 0
d9a15380 339802352 C Co:1:001:0 0 0
da6ba280 339830247 C Ii:1:001:1 -2:2048 0
