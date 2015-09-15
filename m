From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Tue, 15 Sep 2015 18:53:34 +0200
Subject: I.MX6 HDMI support in v4.2
In-Reply-To: <20150915142913.GV21084@n2100.arm.linux.org.uk> (Russell King's
 message of "Tue, 15 Sep 2015 15:29:13 +0100")
References: <m3bnde5whx.fsf@t19.piap.pl>
 <20150907112555.GS21084@n2100.arm.linux.org.uk>
 <m337yp5gvv.fsf@t19.piap.pl> <1441709778.13536.8.camel@pengutronix.de>
 <m3bnd52y4s.fsf@t19.piap.pl> <m337yg2ip4.fsf@t19.piap.pl>
 <20150915101220.GQ21084@n2100.arm.linux.org.uk>
 <m3wpvs0wvu.fsf@t19.piap.pl>
 <20150915142913.GV21084@n2100.arm.linux.org.uk>
Message-ID: <m3a8sn39pt.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

>> Interestingly, i.MX6 seems to achive about 3.2 ms, which is much faster.
>> If not for the missing color planes (and scaling), it would be perfect.
>> (and I only need 30 FPS).
>
> That means iMX6 isn't synchronising to the vertical sync, so would be
> subject to tearing.

Right. However the bigger problem ATM is the lack of color, or actually
wrong colors (such as solid green or magenta etc). I'm looking if the
support can be added easily, this whole IPU stuff is a bit complicated.

> It's interesting that iMX6 takes longer - without analysing what's going
> on, I'd guess that will be because the GC320's memory bandwidth is
> throttled compared to Dove.

Well, one would think the bandwidths should be an order of magnitude
larger than needed here. The boards I have here (Ventana GW5xxx) are
using e.g. 4 * MT41K128M16JT-125 DDR3 chips, for a total of (if
configured correctly) 12 GB/s. Now, a single burst read (or write) at
1024x768 32 bit requires 3 MB, for 30 FPS it means 90 MB/s.
I realize the buffers may be copied many times, and the timeslots you
describe don't make it easier. 66 ms for a frame is rather long, though.

I guess, in this case, it would be better to convert YUV420 planar ->
YUV422 packed (perhaps with NEON - the packed mode(s) work correctly),
and use the more traditional overlay instead of the textured adapter.
Or maybe I will make this YUV420 mode work.
-- 
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
