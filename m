From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 30 May 2011 15:10:33 +0800
Subject: [RFC 2/2] ARM:Tegra: Device Tree Support: Initialize audio card
	gpio's from the device tree.
In-Reply-To: <20110530061155.GC23517@ponder.secretlab.ca>
References: <20110527205444.21000.90209.stgit@riker>
	<20110527205721.21000.78599.stgit@riker>
	<20110528012427.GB5971@opensource.wolfsonmicro.com>
	<BANLkTinKLcYmStvBEGDcN84BapJXe5Y5bg@mail.gmail.com>
	<20110530033826.GE4130@opensource.wolfsonmicro.com>
	<20110530061155.GC23517@ponder.secretlab.ca>
Message-ID: <20110530071008.GA5055@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 30, 2011 at 12:11:55AM -0600, Grant Likely wrote:
> On Mon, May 30, 2011 at 11:38:27AM +0800, Mark Brown wrote:

> > Interesting...  what was the reasoning behind this?  It's a definite
> > step backwards but it does explain my major concern with the new batch
> > of device tree patches.

> The binding for gpios was defined a few years ago and it is in fairly
> wide use within the powerpc sphere.  The design followed the pattern
> established for specifying irqs, and in that regard satisfied the
> principle of least surprise.

GPIOs are rather different to IRQs in that one tends to have rather more
of them, the typical case is that you only have a very small number of
IRQs (usually only one).

> That said, it isn't a very large leap to go from a single 'gpios'
> property to allowing multiple named gpios properties with meaningful
> names, particularly if they are fully specified by the device
> binding, and they follow exactly the same binding semantics as the
> existing 'gpios' proprety (phandle + gpio specifier).

This should definitely be specified, yes.

> Personally, I'm /cautious/ about saying okay to extending the binding,
> simply because once the extension is in use it is really hard to go
> back on it, but I cannot think of any reason why this particular case
> wouldn't be a good idea.  Anyone have thoughts on this?  Ben?  Mitch?

I just can't see how it's sustainable to use an array here - for devices
with many possible functions that could be connected to a GPIO on the
CPU, most of which won't be in use on any given system (a typical part
that I work with might have 20 or so GPIO functions but only be able to
use a fraction of those at once), a flat array with magic indexes is
just going to be error prone and illegible.  Speaking as someone who'll
have to support users using affected drivers I'm entirely unenthusiastic
about the idea.
