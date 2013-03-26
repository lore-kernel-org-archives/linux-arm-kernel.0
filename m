From: mfuzzey@parkeon.com (Martin Fuzzey)
Date: Tue, 26 Mar 2013 10:54:44 +0100
Subject: [PATCH V2] Sound: sgtl5000 Allow codec clock frequency to be set.
In-Reply-To: <CAKGA1bnFiwECxr=2aja-WQVp+Qbr8ULzUmbZsEgSFOQV+nt7wg@mail.gmail.com>
References: <20130322093344.20605.49509.stgit@localhost>
 <CAKGA1bnFiwECxr=2aja-WQVp+Qbr8ULzUmbZsEgSFOQV+nt7wg@mail.gmail.com>
Message-ID: <51517064.4090404@parkeon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matt,

On 25/03/13 21:22, Matt Sealey wrote:
> I'm a little confused why there need to be 3 different alternative bindings.
>
> The first is valid (phandle only), the second is redundant
> (clock-frequency only) - why not just REQUIRE a clock phandle? There
> is not a single use case where you supply a valid clock on the PCB but
> cannot write it's frequency into a 3-line DT node, except in allowing
> non-internally-consistent device trees (which I frown at :)
Yes this is true, however the current code already has this method 
(which was actually the first to be implemented).
Removing it would break compatibility with existing DTs.

I'm not sure what the policy on DT backwards compatibility is on the 
scale "never break backwards compatibility" (like userspace) to 
"anything goes if you fix the in tree damage" (internal kernel APIs). 
But clearly over time it is going to have to be more on the "never break 
backwards compatibility" side, especially If we are talking about 
hosting the DTs elsewhere than in the kernel sources.

> I can think of several reasons I don't like the 3rd way (dynamic
> clock, phandle+frequency) because it implies lack of trust in the
> bootloader and/or early platform init code... that said since you need
> the frequency value to configure the codec, you either get it from the
> clock (but it may not be valid) or you force a value upon it from
> clock-frequency.. I would like a little warning, maybe, that the
> expected clock-frequency was not available at the time it read the
> value from the phandle, since this would allow sgtl5000-using hardware
> designers and linux implementers to know immediately that they have
> missed something important (bootloader setup of the codec clock).
I don't agree here.
In my opinion the bootloader should only need to set up the hardware 
that is essential to boot
(RAM timings and any hardware necessary to access the boot media)

The rest can, and I believe should, be left to the kernel.
Since:
* there is only one kernel whereas there are multiple bootloaders.
* on many platforms, updating the bootloader is more complicated and/or 
risky than updating the kernel.

> It's rare that any real hardware design house would leave a clock like
> that unconfigured as being able to test the frequency from whatever
> source and how clean it is and what the levels are for debugging is
> easier done in the bootloader than with an operating system running
> (re power management etc.) but for the cases where we, for want of a
> better way of describing it, forgot to actually set it up.. it should
> still really, really be in the bootloader and bitching about it.
Yes it may well be easier in some cases to do hardware design / board 
bringup from the bootloader but that doesn't mean that the bootloader 
code used by the hardware engineers to do it will or even should be the 
same as the production bootloader. So I still think the kernel should 
make the minimum assumptions on what the bootloader has done.

> I wholeheartedly support the third method (clock+freq) in the hope
> that it forces bootloader developers to properly configure fixed
> clocks (such as the codec clock which is very hard to change at
> runtime) at boot, before the OS has any need for it (and to relieve it
> of the task of setting the clock frequency), but on the basis that
> eventually people would get a clue or get their task list in order for
> bootloader support and make it redundant (at which point it could be
> removed..).
Sorry not following you here regarding the third (clock + freq) method - 
first you say "I can think of several reasons I don't like the 3rd way" 
then here "I wholeheartedly support the third method"

Regards,

Martin
