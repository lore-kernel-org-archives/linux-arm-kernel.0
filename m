From: marek.vasut@gmail.com (Marek Vasut)
Date: Fri, 21 Jan 2011 19:11:35 +0100
Subject: [Openpxa-users] Linux udelay() is way off
In-Reply-To: <AANLkTi=cwRNCxS6qbR3Kp2Sf-ckx+wcUAgTc8LOYES9F@mail.gmail.com>
References: <AANLkTin_cCzNWhJnD=A2h1qiKpeUrnPrSZPs_Kmfjjd1@mail.gmail.com>
	<20110120193013.GL6335@n2100.arm.linux.org.uk>
	<AANLkTi=cwRNCxS6qbR3Kp2Sf-ckx+wcUAgTc8LOYES9F@mail.gmail.com>
Message-ID: <201101211911.35162.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 21 January 2011 18:46:48 Bj?rn Forsman wrote:
> 2011/1/20 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> > On Thu, Jan 20, 2011 at 08:18:10PM +0100, Bj?rn Forsman wrote:
> >> [   11.425363] cpufreq-core: saving 518144 as reference value for
> >> loops_per_jiffy; freq is 312000 kHz
> >> [   11.425523] cpufreq-core: scaling loops_per_jiffy to 1036288 for
> >> frequency 624000 kHz
> 
> [snip]
> 
> > Is it possible to boot at 624MHz and report the resulting lpj?
> > Alternatively, call calibrate_delay() after the cpufreq switch to
> > 624MHz, disabling the 'printed' stuff and see what it reports.
> 
> Now I have an extra calibrate_delay() after cpufreq changes the frequency.
> 
> First call:
> Calibrating delay loop... 103.62 BogoMIPS (lpj=518144)
> 
> Second call:
> Calibrating delay loop... 622.59 BogoMIPS (lpj=3112960)
> 
> (udelay() is correct when having that second call.)
> 
> It seems cpufreq thinks it transitions from 312 to 624 MHz, but in
> reality it may be transitioning from 104 to 624 MHz (because it now
> runs 6 times as fast according to lpj). This may explain the udelay()
> error ratio (~0.32):
> 
>   104 MHz / 312 MHz = 0.3333..
> 
> I think this means either the clock speed or the jiffies interval do
> not match what the kernel thinks.
> 
> I also did some tests changing the clock speed in the bootloader.

Hi,
how did you change the speed in the bootloader? Didn't you just adjust the 
apropriate registers? Don't forget, you need to issue CP15 (maybe CP14) 
coprocessor call.

Well, just my quick thought.

btw. Bjorn, I just dug out the pxa320 board, maybe I can also find the pxa310/300 
cards, mind IRC-ing ? ;-)
> It
> seems like the only thing that works for the kernel is booting with a
> 104 MHz clock. Any other frequency and cpufreq will do bad things to
> udelay().
> 
> Any thoughts?
> 
> BTW, I failed at locating the jiffies implementation for PXA310. Any
> pointers?
> 
> Best regards,
> Bj?rn Forsman
