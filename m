From: computersforpeace@gmail.com (Brian Norris)
Date: Wed, 29 Jul 2015 10:16:01 -0700
Subject: [RFC PATCH 2/2] dt: spi: s3c64xx: add compatible to
 controller-data
In-Reply-To: <CAOMqctTZVET=U=2o65HpWSm4W660XZtYYbBND2k4u9CnfjfMhQ@mail.gmail.com>
References: <cover.1438170519.git.hramrach@gmail.com>
 <557c1962448393b2a8736f26bfa2a3a5ba4aeb7a.1438170519.git.hramrach@gmail.com>
 <20150729140046.GB11082@sirena.org.uk>
 <CAOMqctTZVET=U=2o65HpWSm4W660XZtYYbBND2k4u9CnfjfMhQ@mail.gmail.com>
Message-ID: <20150729171601.GT8876@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 29, 2015 at 06:19:24PM +0200, Michal Suchanek wrote:
> On 29 July 2015 at 16:00, Mark Brown <broonie@kernel.org> wrote:
> > On Wed, Jul 29, 2015 at 12:19:57PM +0200, Michal Suchanek wrote:
> >
> > Please use subject lines matching the style for the subsytsem so people
> > can spot that the patch is in some way relevant.
> >
> >> The controller-data subnode has no compatible. This can lead to other
> >> drivers getting confused by it. Add a compatible to make devicetreee
> >> unambiguous.
> >
> > I can't tell from this commit message what the issue you're trying to
> > fix is, sorry.  Nodes without compatible strings are entirely normal and
> > don't need compatible strings.  It sounds like a bug in whatever other
> > driver is becoming confused.
> 
> The driver that gets confused is ofpart.
> 
> The two-line patch to allow it to just ignore controller-data has been
> rejected on the basis that s3c64xx should use a compatible string

It wasn't outright rejected, but it was questioned.

> because ofpart monopolizes all nodes without compatible which are
> children of a mtd device. Devicetrees containing such nodes that are
> not partitions are presumably invalid and should be rejected when
> ofpart is compiled into the kernel.

That characterization is currently correct. I'm not a fan of what ofpart
does in the first place; I'd really like it if its binding was written
in a way that made it more precise, but we have to live with what we
have.

I also didn't like that you were designing your system such that we were
now keying off the fact that your node has no 'reg' property. This
seemed awfully fragile. (Admittedly, so is ofpart.c.)

All in all, if you have better suggestions, I'm all ears. (At first
glance, I'm liking your patch 1 to help disambiguate both MTD partitions
and the 'controller-data' node going forward.)

Brian
