From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 05 Dec 2011 20:11:03 +0100
Subject: [PATCH 2/2] [CPUFREQ] s3c64xx: Add VDDINT voltage scaling
In-Reply-To: <20111205185758.GC7467@opensource.wolfsonmicro.com>
References: <1323109322-24130-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <2739091.DkZC0oOhCv@flatron>
 <20111205185758.GC7467@opensource.wolfsonmicro.com>
Message-ID: <11611639.9NBo3p2F8o@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 05 of December 2011 18:57:58 Mark Brown wrote:
> On Mon, Dec 05, 2011 at 07:45:43PM +0100, Tomasz Figa wrote:
> 
> Please fix your mailer to word wrap at less than 80 columns, I've
> reflowed your text for legibility.

Interesting, I had it set to wrap at 78 characters and this seems to match 
with what I have in my Sent mailbox. Anyway, I have switched it to 75 
characters.

> > I would oppose here. According to my information, VDDint depends on
> > peripheral clock frequencies not ARM frequency and it should be 1.25V
> 
> That's quite frankly what my electrical engineering knowledge would
> suggest but looking at both the extant drivers implementing this (Google
> should turn some up) and the documentation I have that doesn't seem to
> be the case.  The 1.25V number certainly looks off.
>
> > (min 1.15, max 1.3) for HCLK at 133 MHz and 1.05V (min 0.95, max 1.3)
> > for HCLK running at 66 MHz.
> 
> I've certainly got documentation that contradicts this, and for some
> reason synchronous clocks seem to require a higher VDDINT supply which
> baffles me rather.

I'm basing my statements on S3C6410 power design guide and source code of 
original kernel for Samsung Galaxy GT-i5700 released by Samsung on their 
open source portal.
 
> > Anyway, the behavior will probably vary from board to board, so I
> > would rather think about extending s3c64xx-cpufreq driver to allow
> > per board frequency/voltage configuration., which would also include
> > settings optimized for your boards in their board-specific code.
> 
> That seems quite tasteless frankly - the behaviour of the silicon is
> not board specific, and we do already have a facility in the regulator
> API to compensate for voltage drops in the board if that's an issue.
> Anything beyond that is policy and is in the domain of the governors.

Well, you are mostly right, but there is one aspect that varies between 
boards, configuration. Boards can have different PLL settings, run in 
synchronous or asynchronous mode and might have power regulators of 
different qualities which will vary in voltage ripple.

For example, in case of your boards, the regulator is nice and allow 
reduction of VDDint voltage to minimal value (1.15V), but in general Power 
Design Guide it is recommended to use the typical value (1.25V).

As far as I know, there are also different revisions of S3C6410, capable of 
running at different maximal frequencies, at least 667 MHz and 800 MHz 
versions.
 
> The ideal thing would be to be able to scale the HCLK independently of
> the ARM clock based on bus loading (taking into account the restrictions
> on the relationship between the two clocks) that's very much a long term
> goal at this point.
> 
> > This would also solve a major problem of current s3c64xx-cpufreq
> > implementation, namely crashing boards running in synchronous mode,
> > because of odd frequencies specified, like 200 MHz (achievable with
> > PLL set to 800 MHz), while the requirement is to keep the ARM
> > frequency a multiple of HCLK when running synchronously.
> > 
> > I have two boards running in synchronous mode (Samsung Galaxy
> > GT-i5700 phone and FriendlyARM Tiny6410 board), I might be able to
> > test things related to synchronous mode.
> 
> The clock code should just be adjusted to refuse to set invalid ARM
> clock ratios.

This might be some solution as well. I'm not yet sure if it solves all the 
problems, but I will think about it.
