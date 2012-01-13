From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 13 Jan 2012 21:45:40 +0000
Subject: [RFC PATCH 01/10] rtc: sa1100: include mach/irqs.h instead of
 asm/irq.h
In-Reply-To: <alpine.LFD.2.02.1201131536040.2722@xanadu.home>
References: <1326472451-9002-1-git-send-email-robherring2@gmail.com>
 <1326472451-9002-2-git-send-email-robherring2@gmail.com>
 <20120113164336.GA1068@n2100.arm.linux.org.uk> <4F106299.8050306@gmail.com>
 <alpine.LFD.2.02.1201131536040.2722@xanadu.home>
Message-ID: <20120113214540.GF1068@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 13, 2012 at 03:46:03PM -0500, Nicolas Pitre wrote:
> Another problem that resources solve (and your original patch didn't 
> make it any better nor worse) has to do with include file search paths.  
> Once we start building more than one SOC in the kernel, we won't be able 
> to support the inclusion of <mach/whatever.h> from driver code anymore 
> since this could refer to more than one instances of 
> arch/arm/mach-*/include/mach/whatever.h.

As a general principle, yes.  We're going to run into some big horrible
problem cases with it though.  The biggest few areas I think will be the
USB host drivers, ALSA ASoC board specifics and PCMCIA board specifics.

I don't particularly see the SA-11x0 code having that sorted out in short
time - we have too many cases where we share registers throughout the code
in all sorts of places.  Eg, things like the peripheral controller registers
and the watchdog stuff accesses the OS timer registers directly.

Things will gradually get better over time - the StrongARM code still has
at least two interested parties on it (one being for Simpad, the other
being me.)

I've been toying with a DMA engine driver for the SA11x0 recently (because
I wanted a platform to chase up my idea of providing a generic virtual DMA
channel library to the DMA engine code).  This includes converting the IrDA
driver to use it and resurecting the audio on the Assabet via the UDA1341.

We're going to need this library - if we're going to see people moving
their private DMA engine APIs over to the established one, we'll see
multiple reimplementations of this all over the place (just like we have
in amba-pl08x and others.)

Why put so much work into a mostly dead platform?  Well, it's one of the
few decent platforms which I have, which actually has working DMA hardware.
Why audio?  It's one of those which provides a significant stress test on
DMA stuff being correct.  Why IrDA?  It can reconfigure a DMA channel (eg,
burst size) on the fly when it switches between SIR/FIR mode.

It may be 12 years old but it's still a very useful platform to develop
non-hardware specific features on!

I've also been adding GPIO support to PCMCIA soc-common.  That helps to
remove some open-coded platform specifics from drivers/pcmcia, but doesn't
entirely eliminate them.  If this progresses sufficiently, we may be able
to get rid of a fair number of platform files in there.

Obviously, patches haven't been posted yet... I'll probably push some of
the patch sets shortly after -rc1 hits.
