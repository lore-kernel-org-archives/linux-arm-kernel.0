From: 21cnbao@gmail.com (Barry Song)
Date: Fri, 16 Sep 2011 11:24:36 +0800
Subject: [PATCH v2 1/2] ARM: cache-l2x0: remove __init annotation from
	initialization functions
In-Reply-To: <20110915083248.GG6267@n2100.arm.linux.org.uk>
References: <1315288107-14689-1-git-send-email-shawn.guo@linaro.org>
	<1315288107-14689-2-git-send-email-shawn.guo@linaro.org>
	<20110914084237.GC6267@n2100.arm.linux.org.uk>
	<20110915013937.GE1488@S2100-06.ap.freescale.net>
	<20110915083248.GG6267@n2100.arm.linux.org.uk>
Message-ID: <CAGsJ_4xpc-8zzGkZ9LThqP7in27n6uX4LRGAf+AtoWTM4p=82w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/9/15 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Thu, Sep 15, 2011 at 09:39:39AM +0800, Shawn Guo wrote:
>> On Wed, Sep 14, 2011 at 09:42:38AM +0100, Russell King - ARM Linux wrote:
>> > I'm unconvinced about the wise-ness of this. ?We read-modify-write the
>> > auxillary control register, which means some bits are preserved from
>> > the initial boot. ?If the boot loader sets the L2 cache up for normal
>> > boot and not for resume, we'll end up with different L2 cache settings.
>> >
>> > We've historically seen this kind of thing with boot loaders over the
>> > years, to the point where systems boot at one CPU clock rate but resume
>> > at some other CPU clock rate.
>> >
>> I would think this is a problem in the kernel. ?Kernel initialization
>> code should put all these stuff into a known state to ensure boot and
>> resume of the kernel do not result in a different state, shouldn't it?
>
> grep the kernel for l2x0_init() and look at the mask and value registers.
> Note that any bit set in the mask is preserved from boot time.

if we have a save/restore interface, it looks it will be very
complicated. different l2 need to save different registers.

pl310:
tag-latency(not all pl310 has TAG_LATENCY_CTRL ctrl setting)
arm,data-latency(not all pl310 has L2X0_DATA_LATENCY_CTRL ctrl setting)
arm,filter-ranges(not all pl310 has filter range setting)
L2X0_AUX_CTRL
L2X0_CTRL
So the save interface needs to know what should be saved. but who can
tell them those if the save interface is not in SoC-specific file but
in arch/arm/mm/cache-l2x0.c?

when we resume, we must disable l2 if bootloader has enabled it and
restore all registers.

so it looks like making l2 resume specific to chip is also the right
choice even for chips which will lose l2 in suspend cycles.

-barry
