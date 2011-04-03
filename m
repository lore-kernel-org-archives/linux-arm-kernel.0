From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Mon, 04 Apr 2011 08:26:13 +1000
Subject: [GIT PULL] omap changes for v2.6.39 merge window
In-Reply-To: <AANLkTikfBhCH5wrpYzKbws0F_UVaskhtN_SUGQ+hU8Ab@mail.gmail.com>
References: <alpine.LFD.2.00.1103310145390.28032@xanadu.home>
	<201104011554.07924.arnd@arndb.de>
	<1301671655.28467.52.camel@e102144-lin.cambridge.arm.com>
	<201104011755.57412.arnd@arndb.de>
	<AANLkTikfBhCH5wrpYzKbws0F_UVaskhtN_SUGQ+hU8Ab@mail.gmail.com>
Message-ID: <1301869573.2549.44.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-04-01 at 09:39 -0700, Linus Torvalds wrote:
> that just maps some _other_ hardware knowledge (reading a SoC ID or
> something) into an unrelated thing ("I know this SoC has these bits of
> hardware").
> 
> So devicetree should never override actual "hardware tells me it
> exists here". But you might well have a mapping from SoC ID's to a
> compiled-in devicetree thing (this is largely what POWER does, iirc).

Not quite :-)

On the most common non-embedded platforms the device-tree comes from the
firmware which generates it (ie, pSeries, macs, ...)

On most embedded platforms, the device-tree is either flashed separately
in a separate flash partition (and thus comes from u-boot) or is wrapped
with the kernel zImage at install time.

We have almost no case of detecting the board via some magic ID and
using that to slap a device-tree at runtime, mostly because the old
embedded platforms before most bootloaders grew the ability to pass us
the DT blob from flash, simply didn't even have such a board ID...

They did pass -some- informations but to some extent we were in a worst
position than ARM which does have them.

However, what I've observed (sadly) in practice is that many
manufacturers just ship products with bogus board IDs as well, they make
them up, often non-registered or registered to other vendors, duplicate
between products etc..., I've seen that with my Marvell based D-Link NAS
box for example.

But yes, I agree with pretty much everything you said :-) There is -one-
advantage in -one- specific case to also provide device node
representation for devices that are otherwise discoverable (PCI etc..),
which is when the device-tree can carry useful auxiliary informations
that the devices themselves don't provide. The typical example is that
growing tendency in ARM world to stick USB ethernet controllers on board
without a MAC address SEEPROM .... As long as the device is soldered
(and thus can be addressed via a stable "path" of ports/hubs), it can be
useful to stick a device-node for it (and for its parent controller,
potentially PCI, etc...).


Cheers,
Ben.
