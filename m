From: broonie@kernel.org (Mark Brown)
Date: Wed, 30 Oct 2013 18:28:30 -0700
Subject: [PATCHv7][ 2/5] ASoC: eukrea-tlv320: Add DT support.
In-Reply-To: <CAHCPf3s46E=s85ohfqajr-VbavAM+gernXkkYeSwd4NYN8AEHw@mail.gmail.com>
References: <1382616832-23593-1-git-send-email-denis@eukrea.com>
 <1382616832-23593-2-git-send-email-denis@eukrea.com>
 <20131025191513.5345BC4042C@trevor.secretlab.ca>
 <20131026114840.GX2443@sirena.org.uk>
 <CAHCPf3vHWt5XJCwvGDMfX9rTPKqHU43SHORqpxLtLaDL6RGb8A@mail.gmail.com>
 <20131029174445.GB20251@sirena.org.uk>
 <CAHCPf3sm9BawgCKrPH_mbD-Mhb-uXzSyZTjxhJf1W25pG3wZUA@mail.gmail.com>
 <20131030212927.GM2493@sirena.org.uk>
 <CAHCPf3s46E=s85ohfqajr-VbavAM+gernXkkYeSwd4NYN8AEHw@mail.gmail.com>
Message-ID: <20131031012830.GZ2493@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 30, 2013 at 05:29:31PM -0500, Matt Sealey wrote:
> On Wed, Oct 30, 2013 at 4:29 PM, Mark Brown <broonie@kernel.org> wrote:
> > On Tue, Oct 29, 2013 at 10:05:40PM -0500, Matt Sealey wrote:

> >> 1) saif-controllers and ssi-controller could be a single property -
> >> controllers - which list the controller. It will be obvious which kind
> >> of controller it is by delving into that node referenced by the
> >> phandle.

> > Picking a consistent name for this might be nice, yes.  Feel free to
> > send patches...

> When - if - I have time.

Please consider prioritising this over writing e-mails; talking about
device tree does often seem more popular than solving the harder
problems.

> > To repeat yet again, if this concerns you please work with Morimoto-san
> > on his generic card driver.  There are some code differences with clock
> > setup for the devices which are encoded in the board definitions as
> > well, plus the external connections.

> Well the main crux of the problem here is that there's been a node
> defined with a special compatible property that requires a special
> device driver to marshall and collect nodes referenced within it - and
> most of these drivers do exactly the same thing, which is why generic
> card drivers seem like a good idea.

The missing bit with generic card drivers has been anyone other than
Morimoto-san working on it; I don't think anyone thinks that is a bad
idea for the simple cases.

> Where those things are generic it is not only a problem of code
> duplication but a bad idea in "creating a special node" to marshall
> it. The "sound" node here, with this special compatible property,
> doesn't really exist in real hardware design, it exists within the
> Linux kernel to allow it to construct a "card" out of a controller,

Please, as I have repeatedly asked you, go back and look at the previous
discussions on this topic and familiarise yourself with the needs of
advanced audio subsystems.  This has been covered ad nauseum in the
past, there's no need to go through it all over again.

> > That's not what's going on here, let me once again ask you to review the
> > previous discussion on device tree bindings and make sure that you
> > understand the needs of advanced audio hardware.

> There's no existing example of this advanced audio hardware, no
> discussion about what would be required, only a vague assertion that
> to build this abstract card structure in Linux, this is the only way
> to do it.

That is a rather strongly worded statement which doesn't appear to
correspond to reality; for example there are a number of Linux based
smartphones in production many if not most of which have complex audio
needs and components with lots of flexibility.

Please do the research I have been asking you to do and/or contribute
code, this will be less time consuming for all of us.

> > That's not going to scale well to boards that have inter CODEC analogue
> > links, we'd need a node for every single thing that could be a source
> > and sink on every device which seems tedious.

> Yes, but I am not sure having a single property with pairs of strings
> makes any more sense - sure, you require a node for each, but how does
> just requiring a static string for each do this any better? Now you
> need a string for each, which has to match a driver in Linux.. what
> about another OS?

Look at where the names come from...

> > We can't, one of the problems with this stuff is that clocking design
> > (especially for the advanced use cases) is not as simple or general as
> > one might desire for a bunch of totally sensible electrical engineering
> > and system design reasons.  When we get to the point of deploying simple
> > card widely it's just typing to define a standard constant that everyone
> > can use for whatever the default sensible clocks are, and of course
> > people working on simple card can do that as they're going.

> I would have thought using the clock bindings, and judicious use of
> clkdev internal to the codec or controller driver, would fix this.

The clock configuration bindings don't currently exist, won't cover the
dynamic cases and won't help non-DT platforms.  Remember also that we
don't even have a clock API of any kind on a good proportion at the
minute and don't have the common clock API on some of the rest.

> this all ends up at the codec level by dereference.. so why would it
> need to *be* defined at the card level in any of these cases? In all

This is the sort of information that you should be able to discover if
you review the previous discussions.

> of these cases, maybe not for all cases forever and ever, but the ones
> we're looking at here where we have a goodly selection of codecs and
> maybe 4 or 5 controllers and 2 or 3 implementations of each, there's
> no reason for it.

One of the devices you're looking at here is WM8962 - it does actually
have the ability to do a bunch of the things that make decisions about
clocking interesting.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131030/5bed6055/attachment.sig>
