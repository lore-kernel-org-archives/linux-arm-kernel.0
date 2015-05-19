From: stefan@agner.ch (Stefan Agner)
Date: Tue, 19 May 2015 13:23:22 +0200
Subject: [PATCH v7 08/13] ARM: unify MMU/!MMU addruart calls
In-Reply-To: <20150519101615.GA2067@n2100.arm.linux.org.uk>
References: <1431769465-26867-1-git-send-email-stefan@agner.ch>
 <1431769465-26867-9-git-send-email-stefan@agner.ch>
 <20150516205103.GO2067@n2100.arm.linux.org.uk>
 <alpine.DEB.2.11.1505170952060.4225@nanos>
 <alpine.DEB.2.11.1505181735230.4225@nanos> <20150519053503.GP1071@dragon>
 <20150519101615.GA2067@n2100.arm.linux.org.uk>
Message-ID: <bb773210f5f7068a8cba2c283422676c@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-05-19 12:16, Russell King - ARM Linux wrote:
> On Tue, May 19, 2015 at 01:35:03PM +0800, Shawn Guo wrote:
>> On Mon, May 18, 2015 at 05:36:43PM +0200, Thomas Gleixner wrote:
>> > On Sun, 17 May 2015, Thomas Gleixner wrote:
>> > > On Sat, 16 May 2015, Russell King - ARM Linux wrote:
>> > > > On Sat, May 16, 2015 at 11:44:20AM +0200, Stefan Agner wrote:
>> > > > > Remove the needless differences between MMU/!MMU addruart calls.
>> > > > > This allows to use the same addruart macro on SoC level. Useful
>> > > > > for SoC consisting of multiple CPUs with and without MMU such as
>> > > > > Freescale Vybrid.
>> > > > >
>> > > > > Signed-off-by: Stefan Agner <stefan@agner.ch>
>> > > >
>> > > > Depending on the merge plan for the remainder (has tglx reviewed the IRQ
>> > > > changes yet?  I think he needs to before this can be merged)... if it's
>> > > > not going to go in for the next merge window, this should find its way
>> > > > into the patch system so it can be applied anyway.
>> > >
>> > > I'm going to apply the irq core and chip driver modifications to a
>> > > separate branch later today, so you or ARM-SOC folks can pull that
>> > > in. Will send you a mail where it can be found.
>> >
>> >   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/for-arm
>> >
>> > That contains the first 5 patches which touch kernel/irq/ and
>> > drivers/irqchip/
>>
>> Russell, Arnd,
>>
>> I guess the easiest way to merge rest of the series is to have them go
>> via i.MX tree with your nods?
> 
> I don't know, I've not looked at the remainder of the patches.  Having
> looked briefly at them, it looks like they touch EFM32 as well, so I'm
> not sure having them all go through iMX is the right approach either.
> 
> Looking at the EFM32 patch, it looks like we've adopted my suggestion
> (discussed with Arnd in the previous month) wrt noMMU, so I'll post a
> couple of patches in a moment which fix Integrator for this as well.
> Integrator is independent of this series, and it fixes real problems
> caused by the single zImage stuff for noMMU there.
> 
> It makes sense for these to all go through arm-soc - but the question
> is how do we get them all into arm-soc...

Sorry for the mess, I see, I should have tried split it in pieces which
match the subsystems.

Patch 06 defines a smaller vector table size, which is by default too
large. Hence this patch is quite independent, the rest of the patch set
works flawless without that patch. However, that patch relies on 8340/1
being applied ("ARM: ARMv7-M: Enlarge vector table up to 256 entries").
If this is ok for you Russel, I would submit that to your patch system.

Patch 07 defines dependencies a bit more explicitly, however, with the
current Kconfig symbol setup, both should be selected by other config
symbols (CLKSRC_OF by ARM_SINGLE_ARMV7M and CLKSRC_MMIO by ARCH_MXC).
Hence this can go independently through clocksource trees
(Daniel/Thomas?)

Not sure how we can deal with the EFM32 vs. IMX changes... Patches 08-10
has no dependencies on the clock changes which Thomas merged. They could
go through whatever EFM32 is merged normally (last time Arnd directly
merged from Uwe), and then Shawn could base the rest of the changes on
that too?

--
Stefan
