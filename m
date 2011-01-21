From: bjorn.forsman@gmail.com (=?UTF-8?Q?Bj=C3=B8rn_Forsman?=)
Date: Fri, 21 Jan 2011 18:46:48 +0100
Subject: [Openpxa-users] Linux udelay() is way off
In-Reply-To: <20110120193013.GL6335@n2100.arm.linux.org.uk>
References: <AANLkTin_cCzNWhJnD=A2h1qiKpeUrnPrSZPs_Kmfjjd1@mail.gmail.com>
	<201101201800.04289.marek.vasut@gmail.com>
	<20110120175551.GG6335@n2100.arm.linux.org.uk>
	<AANLkTin8UR_1kU=+Dw-O9zHahquGJvBC560nByO=F6YV@mail.gmail.com>
	<20110120193013.GL6335@n2100.arm.linux.org.uk>
Message-ID: <AANLkTi=cwRNCxS6qbR3Kp2Sf-ckx+wcUAgTc8LOYES9F@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/1/20 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Thu, Jan 20, 2011 at 08:18:10PM +0100, Bj?rn Forsman wrote:
>> [ ? 11.425363] cpufreq-core: saving 518144 as reference value for
>> loops_per_jiffy; freq is 312000 kHz
>> [ ? 11.425523] cpufreq-core: scaling loops_per_jiffy to 1036288 for
>> frequency 624000 kHz

[snip]

> Is it possible to boot at 624MHz and report the resulting lpj?
> Alternatively, call calibrate_delay() after the cpufreq switch to
> 624MHz, disabling the 'printed' stuff and see what it reports.

Now I have an extra calibrate_delay() after cpufreq changes the frequency.

First call:
Calibrating delay loop... 103.62 BogoMIPS (lpj=518144)

Second call:
Calibrating delay loop... 622.59 BogoMIPS (lpj=3112960)

(udelay() is correct when having that second call.)

It seems cpufreq thinks it transitions from 312 to 624 MHz, but in
reality it may be transitioning from 104 to 624 MHz (because it now
runs 6 times as fast according to lpj). This may explain the udelay()
error ratio (~0.32):

  104 MHz / 312 MHz = 0.3333..

I think this means either the clock speed or the jiffies interval do
not match what the kernel thinks.

I also did some tests changing the clock speed in the bootloader. It
seems like the only thing that works for the kernel is booting with a
104 MHz clock. Any other frequency and cpufreq will do bad things to
udelay().

Any thoughts?

BTW, I failed at locating the jiffies implementation for PXA310. Any pointers?

Best regards,
Bj?rn Forsman
