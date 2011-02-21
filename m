From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 21 Feb 2011 15:48:36 +0100
Subject: [PATCH V4 3/4] ARM: Xilinx: base header files and assembly macros
In-Reply-To: <c3cdf33d-2163-4417-bc64-7637f5c211e0@VA3EHSMHS021.ehs.local>
References: <1298052881-14591-1-git-send-email-john.linn@xilinx.com>
	<201102210936.42098.arnd@arndb.de>
	<c3cdf33d-2163-4417-bc64-7637f5c211e0@VA3EHSMHS021.ehs.local>
Message-ID: <201102211548.36296.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 21 February 2011, John Linn wrote:
> > It would be better if you could avoid introducing new uses of
> > CLOCK_TICK_RATE, because that will have to be removed before we can
> > move to a real multi-platform kernel. For instance, you can put
> > PERIPHERAL_CLOCK_RATE in a hardware specific header and put a bogus
> > definition for CLOCK_TICK_RATE into timex.h
> 
> Hi Arnd,
> 
> I can remove the use of it from my timer code, but I still see
> CLOCK_TICK_RATE 
> being used in linux/jiffies.h.
> 
> I tried removing it and got build errors.  Am I missing something there?
> 

You still need to have some definition for CLOCK_TICK_RATE to make
the jiffies code compile, but the actual value no longer matters.

Traditionally, this was the i386-style PIT timer frequency of 11.93 MHz
for some things and the actual timer frequency for other things.
The timer code tries to correct the jiffies value based on difference
between the intended HZ frequency (100, 250 or 1000) and the actual
on (something very close to that, but not exact).

You can e.g. set it to (100 * HZ) to make something up that won't
hurt in that calculation.

	Arnd
