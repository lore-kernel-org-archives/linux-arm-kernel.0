From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 6 Apr 2011 01:19:34 +0200
Subject: [GIT PULL] omap changes for v2.6.39 merge window
In-Reply-To: <AANLkTikfBhCH5wrpYzKbws0F_UVaskhtN_SUGQ+hU8Ab@mail.gmail.com>
References: <alpine.LFD.2.00.1103310145390.28032@xanadu.home>
	<201104011554.07924.arnd@arndb.de>
	<1301671655.28467.52.camel@e102144-lin.cambridge.arm.com>
	<201104011755.57412.arnd@arndb.de>
	<AANLkTikfBhCH5wrpYzKbws0F_UVaskhtN_SUGQ+hU8Ab@mail.gmail.com>
Message-ID: <BANLkTinDgAwu7jg+rciMUU19fj+TKPRwmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/4/1 Linus Torvalds <torvalds@linux-foundation.org>:

> If you have discoverable hardware, use it.
>
> But by "discoverable hardware" I mean something like PCI config
> cycles. IOW, real hardware features.

The ARM AMBA architecture actually has such a thing, or a
little of it, found in drivers/amba/bus.c.

Basically it requires you to get the physical address and size of
each peripheral, then at offset -0x10 from the end address (usually
at even 4K pages), if you find the magic number 0xB105F00D
(ARM has a sense of humour, obviously) you can find something
alike the PCI IDs at offset -0x20, manufacturer ID, version number
and revision of the hardware.

It isn't very hard to imagine that mechanism providing IRQ
numbers or DMA channel allocation and other such data
so it becomes more plug'n'play-ish. If the hardware had a
list of device physical whereabouts in a specific location too,
the system would be quite self-describing.

Not as sexy as the separate PCI configuration space
though, it's just hardcoded in along with the device I/O pages.

Apparently ARM pushed this in their few initial cells
and manufacturers are free to reuse this system for their
silicon. ST Microelectronics for example actually use it to
a larger extent. But since it was not mandatory and there
was no clear way on how to register magic numbers with
this system (like the PCI-SIG), it simply failed. Silicon
foundries didn't care or even know about it, neglecting to put
this 0xB105F00D in place.

IMO the world would have been much better off if
ARM mandated that all vendors *must* use this scheme
for their hardware blocks if they are to license the AMBA
bus incarnations, but they don't.

Maybe the ARM guys on the list has some background on
this?

Yours,
Linus Walleij
