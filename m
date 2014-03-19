From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 19 Mar 2014 21:46:32 +0000
Subject: PL310 errata workarounds
In-Reply-To: <CAL_JsqK6+gz6u=bSUFS7qjKANd2ZSQV5bWccw85KvAA7aP0FrA@mail.gmail.com>
References: <20140314144835.GP21483@n2100.arm.linux.org.uk>
 <20140314175701.GR21483@n2100.arm.linux.org.uk>
 <CAL_JsqL02dw7B+GEL4921f_7m=RRUokW0n64TxSJnMWN3MMfrQ@mail.gmail.com>
 <201403192222.30622.marex@denx.de>
 <CAL_JsqK6+gz6u=bSUFS7qjKANd2ZSQV5bWccw85KvAA7aP0FrA@mail.gmail.com>
Message-ID: <20140319214631.GL7528@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 19, 2014 at 04:35:58PM -0500, Rob Herring wrote:
> On Wed, Mar 19, 2014 at 4:22 PM, Marek Vasut <marex@denx.de> wrote:
> > On Friday, March 14, 2014 at 08:14:06 PM, Rob Herring wrote:
> >> On Fri, Mar 14, 2014 at 12:57 PM, Russell King - ARM Linux
> >>
> >> <linux@arm.linux.org.uk> wrote:
> >> > On Fri, Mar 14, 2014 at 11:02:17AM -0500, Rob Herring wrote:
> >> >> The obvious fix is to convert l2x0_flush_line to a function ptr which
> >> >> just further complicates the code.
> >> >
> >> > I currently regard this code as unmaintainable, so right now I'm in the
> >> > process of completely rewriting it, going back to the specs and checking
> >> > what is required.  Sharing code between the L210, L220 and L310 looks
> >> > good from the point of view of keeping the line count down, but actually
> >> > they're quite different and have various different requirements.
> >> >
> >> > Out of those, L220 is the odd one out: all operations are background
> >> > operations there, which means they have to be waited for.  Currently,
> >> > if you have one of these, and you build a multiplatform kernel which
> >> > includes PL310 support, you don't wait for any of these and you probably
> >> > see a lot of data corruption as a result.
> >>
> >> Oops. I guess there are not many users as the L220 was primarily used
> >> with the 1176 (and 11MP?) IIRC. I guess one of the primary 1176 based
> >> platforms currently used is RPi, but it appears the BCM2835 doesn't
> >> have an L2 (other than some custom L2 for the GPU).
> >
> > Won't Freescale i.MX35 help here ? It's 1136JF-S core and has some L2 cache.
> 
> No. 1136 uses L210. 1176 uses L220. There was the i.MX37 which had an
> 1176, but it was pretty short lived and never saw upstream support.

Don't worry too much about the L220 - the Realview boards have one, and
I have one Realview EB board:

Linux version 3.14.0-rc7+ (rmk at rmk-PC.arm.linux.org.uk) (gcc version 4.5.4 (GCC) ) #664 SMP Wed Mar 19 18:06:11 GMT 2014
CPU: ARMv6-compatible processor [410fb020] revision 0 (ARMv7), cr=00c5387d
CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
Machine: ARM-RealView EB
...
CPU0: thread -1, cpu 0, socket -1, mpidr 0
Setting up static identity map for 0x7036d130 - 0x7036d1a0
CPU1: Booted secondary processor
CPU1: thread -1, cpu 0, socket -1, mpidr 1
CPU2: Booted secondary processor
CPU2: thread -1, cpu 0, socket -1, mpidr 2
CPU3: Booted secondary processor
CPU3: thread -1, cpu 0, socket -1, mpidr 3
Brought up 4 CPUs
...
L2C: DT/platform modifies aux control register: 0x00020fff -> 0x00790fff
L2C-220 cache controller enabled, 8 ways, 1024 kB
L2C-220: CACHE_ID 0x41000081, AUX_CTRL 0x00790fff

These need to be configured by the board code for their cache size because
the register isn't correctly configured at reset.  Same goes for PL210.
Only with PL310 does the register contain appropriate sizing information
on reset.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
