From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 29 Jan 2013 22:59:58 +0100
Subject: [PATCH 1/5] dmaengine: dw_dmac: move to generic DMA binding
In-Reply-To: <201301292040.50143.arnd@arndb.de>
References: <1359395857-1235-1-git-send-email-arnd@arndb.de>
 <201301291636.38773.arnd@arndb.de>
 <20130129174546.GE23505@n2100.arm.linux.org.uk>
 <201301292040.50143.arnd@arndb.de>
Message-ID: <CACRpkdbC56TaCzxcYpLxz5WWdfbB7vQSmRtHd64TZsTXbLEy=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 29, 2013 at 9:40 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> the patches were certainly on the mailing list
> http://lists.infradead.org/pipermail/linux-arm-kernel/2010-June/017818.html
>
> Do you (or Linus) know what happened to the patch series?

Just stalled. My fault probably, and IIRC Russell sent a
modified version of this patch at one time.

> Based on your description, it sounds all doable, but the split
> between platform specific code and device driver code would be
> different: While the muxing that you describe all takes place
> in the get_signal/put_signal functions in platform code, doing
> a proper DT binding for the mux would imply moving that into the
> pl080 driver itself, at least as a compile-time option for the
> driver. Do you think that would be acceptable?

This is the pushing-to-driver paradigm, and for the legacy
support it will be troublesome as it needs to supply the
base address of the mux etc through the platform data,
and then with an ampersand reference to the syscon
in the dma node.

> While I guess we could still keep the get_signal/put_signal
> callbacks in mach-versatile but drop them for platforms
> without a mux, I'm not sure if that would make the overall
> driver better or worse.

I think that is not the big issue though.

I think the most important thing is to come up
with a OS-neutral description of channels vs
muxes and signals.

Basically all DMA hardware has a mux, but in
many cases it is fused with the DMA controller
itself, and sometimes even hidden from software,
i.e. it seems there is one channel per peripheral,
but if you try to use them all at the same time
something like round-robin bursts can be expected
(in best case).

For each channel, you need to be able to specify
a number of applicable request lines, with an
optional mux component inbetween. And I think
the bindings should be generic, because the problem
is generic.

I tried to express this in DT syntax but failed, I
just don't know how to do that, DT seems to be
very much not about muxes and things that take
optional paths, more about describing how static
electronics are set up.

The basic assumption of a 1:1 mapping between
a peripheral and a channel is bogus - this is true on
some hardware (like the COH901318), but certainly
not all, the Versatile and RealView being the most
problematic examples to date with the separate mux
and all.

Maybe stupid analogy:
http://en.wikipedia.org/wiki/File:JT_Switchboard_770x540.jpg
The actual channels are the cords.
The the sockets are the devices.
The telephonist is the mux.

So looking up a DMA channel for RX for the PL011
can be like trying to find a blue cord to put in the
PL011 socket when the red light goes on for RX
DMA. If no blue cord is available the telephonist can
plug in the handset and say "sorry, failed to find a
free line".

Conversely to TX DMA you may need a red
cord. Having a blue cord at hand will not help
you.

Coding it down in the device tree like in the
example is like plugging the cords in to some
holes at boot time and let the telephonist go
home.

Yours,
Linus Walleij
