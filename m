From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 22 Nov 2012 14:06:14 +0000
Subject: [PATCH 0/10] Kirkwood ASoC drivers fixes and improvements
In-Reply-To: <20121120122051.GA12063@n2100.arm.linux.org.uk>
References: <20121120121726.GN3290@n2100.arm.linux.org.uk>
 <20121120122051.GA12063@n2100.arm.linux.org.uk>
Message-ID: <20121122140614.GA26930@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All,

I'm opening this to a wider audience in the hope of getting a solution.

There are classes of hardware out there where the DMA support is tightly
integrated along side the rest of the I2S interface.

One such example of this is the hardware found on Marvell Kirkwood
platforms and their derivatives.   Not only are the registers interleaved
between the I2S interface part and the DMA part, and the DMA can only be
used for I2S, but the current Kirkwood ASoC implementation in
sound/soc/kirkwood shares a common data structure created by the "cpu dai"
to provide register access and other data.  This data structure is
"struct kirkwood_dma_data".

This means that in software, as things stand today, kirkwood-dma.c has
intimate knowledge of kirkwood-i2s.c despite being two separate platform
drivers.  This also means that the split between kirkwood-dma.c and
kirkwood-i2s.c is entirely artificial, brought about by the insistance
of ASoC that these things shall be separate.

How does ASoC insist that these be separate?  It only provides the
necessary callbacks for DMA related stuff to what it calls the "platform"
driver.  The interface part is called a "cpu dai" and one of those must
always be provided.  Each of these must be a separate platform device,
because they're each named drivers, and the name comes from the
device/driver.

This is fine in the pre-DT world, where we have board files in arch/arm
which can create whatever platform devices are needed to bring ASoC up,
but we're moving to a DT-only solution - that means no board files.
DT is a hardware description; it does not describe whatever random ideas
some software implementation has come up with; a DT description of audio
on Kirkwood will not make any distinction between the artificial
"platform" part and the "cpu dai" part.

Instead, a DT description will just declare there to be one I2S device
with its relevant resources.

Such a description is _inherently_ incompatible with ASoC as long as
ASoC insists that there is this artificial distinction.

What Mark is telling me is that he requires yet more board files to
spring up under sound/soc/ which create these artificial platform
devices.  Not only does that go against the direction which we're heading
on ARM (at Linus' insistance) to get rid of board files, but it perpetuates
this silly idea that every audio interface should be split up whether
there's a distinction there or not.

It also makes the handling of -EPROBE_DEFER yet more complex; using this
driver on the Dove Cubox platform with built as a set of modules revealed
that where a platform device was being registered by code in
sound/soc/kirkwood, and would be immediately unregistered on -EPROBE_DEFER
never to be re-registered.

It is my belief that Mark's position is not the right solution for where
things are heading.

We need to have solutions which do not require artificial breakup of
drivers; we need solutions where hardware can be described by DT and
that DT description be used by the kernel with the minimum of code.
What we don't need are yet more board files appearing in some other
random part of the kernel tree.

Your thoughts please.
