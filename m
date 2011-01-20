From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 20 Jan 2011 17:55:51 +0000
Subject: [Openpxa-users] Linux udelay() is way off
In-Reply-To: <201101201800.04289.marek.vasut@gmail.com>
References: <AANLkTin_cCzNWhJnD=A2h1qiKpeUrnPrSZPs_Kmfjjd1@mail.gmail.com>
	<201101201800.04289.marek.vasut@gmail.com>
Message-ID: <20110120175551.GG6335@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 20, 2011 at 06:00:04PM +0100, Marek Vasut wrote:
> On Thursday 20 January 2011 17:09:00 Bj?rn Forsman wrote:
> > Hi,
> > 
> > On my Colibri PXA310, I see that Linux udelay() is only 30 % of the
> > length it's supposed to. This is way off and cause problems (e.g.
> > 1-Wire device driver breaks). I'm running OpenPXA bootloaders (OBM2 +
> > U-Boot) and mainline Linux 2.6.36.
> > 
> > Any ideas how to fix this?
> > 
> > Could it be that U-Boot sets up the system clock to something
> > different than what Linux "expects" so that loops_per_jiffy becomes
> > wrong? I see some clock setup in <u-boot-pxa>/arch/arm/cpu/pxa/start.S
> > but I'm not sure what to do with it (yet). I'd like to try out
> > different clock speeds to see if it helps. Any pointers?
> > 
> > I also have a workaround in mind: Try out different lpj= settings on
> > the kernel command line until a udelay(1000) actually is 1000 us. Is
> > this a sane thing to do?
> 
> CCing relevant people.
> 
> And no, linux kernel should derive it's timing properly so it's a kernel bug.

I recently looked into the udelay() timing accuracy, and I saw it only
being reduced by .7% at boot time - due to the cycles stolen by the timer
IRQ handler.

The delay calibration algorithm shouldn't produce big errors due to the
way it works.  It first tries to find a delay longer than the timer tick.
It then uses a successive approximation technique over about 9 bits of
loops_per_jiffy value.

So, I wouldn't expect the boot time lpj value to be significantly out.

However, what might be happening is you boot at X MHz.  You then use cpufreq
and drop the frequency to Y MHz.  You then suspend and resume.  On resume,
the boot loader starts the processor again at X MHz, but the kernel still
assumes that you're running at Y MHz and has not adjusted the delay loop
accordingly.

This will result in a much shorter than expected delay.

So, the first thing that needs doing is to ascertain when the delay
becomes wrong.

The other thing to check is whether you're suffering from rounding errors
in the us-to-loops calculation - 56949d4 (ARM: udelay: prevent math
rounding resulting in short udelays) which aren't calibrated away.
(The lpj delay testing bypasses the calculation as its dealing with
number of loops, not us.)
