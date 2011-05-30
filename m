From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Tue, 31 May 2011 09:26:00 +1000
Subject: [RFC 2/2] ARM:Tegra: Device Tree Support: Initialize audio
	card gpio's from the device tree.
In-Reply-To: <20110530061155.GC23517@ponder.secretlab.ca>
References: <20110527205444.21000.90209.stgit@riker>
	<20110527205721.21000.78599.stgit@riker>
	<20110528012427.GB5971@opensource.wolfsonmicro.com>
	<BANLkTinKLcYmStvBEGDcN84BapJXe5Y5bg@mail.gmail.com>
	<20110530033826.GE4130@opensource.wolfsonmicro.com>
	<20110530061155.GC23517@ponder.secretlab.ca>
Message-ID: <1306797960.7481.640.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-05-30 at 00:11 -0600, Grant Likely wrote:

> > Interesting...  what was the reasoning behind this?  It's a definite
> > step backwards but it does explain my major concern with the new batch
> > of device tree patches.
>
> The binding for gpios was defined a few years ago and it is in fairly
> wide use within the powerpc sphere.  The design followed the pattern
> established for specifying irqs, and in that regard satisfied the
> principle of least surprise.
> 
> That said, it isn't a very large leap to go from a single 'gpios'
> property to allowing multiple named gpios properties with meaningful
> names, particularly if they are fully specified by the device
> binding, and they follow exactly the same binding semantics as the
> existing 'gpios' proprety (phandle + gpio specifier).
> 
> Personally, I'm /cautious/ about saying okay to extending the binding,
> simply because once the extension is in use it is really hard to go
> back on it, but I cannot think of any reason why this particular case
> wouldn't be a good idea.  Anyone have thoughts on this?  Ben?  Mitch?

So first, I wasn't involved in the definition of the GPIO binding much
if at all :-)

Second, I can see advantages in both the numbered and the named
approaches, it's not totally clear cut and it's definitely not a
"definite step backward" which explains "major concerns" since, Mark,
you just discovered it ;-) You -do- write like you just found the excuse
for your general hostility :-)

Now more seriously, referencing GPIOs as a list of phandle/number in an
array has the advantage of being compact. It works well for many setups,
and GPIOs in practice are -often- referenced by number within a GPIO
block. I think it's probably the right approach to "target" a given GPIO
-provider-.

The question is how do you relate the entries in that array with
basically wires on the "client" chip. This is the same problem faced by
the clock binding btw, tho there's usually a bit less clocks than GPIOs
(but still more than interrupts :-)

The approach apple uses is interesting, where they essentially use
device-specific properties that contain a GPIO binding. For example, a
reset-gpio property, that points to the GPIO doing the reset, etc...

We -could- do just that. For 'busses' such a property can easily contain
more than one entry.

Or we could keep a gpio "map" and have a parallel property to name the
entries like I was originally thinking for the clocks.

In any case, it's something that can reasonably easily be added on top
of the existing binding, and it would be much more productive Mark if
you actually proposed solutions rather than just opposing things :-) 

Cheers,
Ben.
