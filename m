From: broonie@kernel.org (Mark Brown)
Date: Wed, 29 Jul 2015 18:16:13 +0100
Subject: [RFC PATCH 2/2] dt: spi: s3c64xx: add compatible to
 controller-data
In-Reply-To: <CAOMqctTZVET=U=2o65HpWSm4W660XZtYYbBND2k4u9CnfjfMhQ@mail.gmail.com>
References: <cover.1438170519.git.hramrach@gmail.com>
 <557c1962448393b2a8736f26bfa2a3a5ba4aeb7a.1438170519.git.hramrach@gmail.com>
 <20150729140046.GB11082@sirena.org.uk>
 <CAOMqctTZVET=U=2o65HpWSm4W660XZtYYbBND2k4u9CnfjfMhQ@mail.gmail.com>
Message-ID: <20150729171613.GI11162@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 29, 2015 at 06:19:24PM +0200, Michal Suchanek wrote:
> On 29 July 2015 at 16:00, Mark Brown <broonie@kernel.org> wrote:

> > I can't tell from this commit message what the issue you're trying to
> > fix is, sorry.  Nodes without compatible strings are entirely normal and
> > don't need compatible strings.  It sounds like a bug in whatever other
> > driver is becoming confused.

> The driver that gets confused is ofpart.

> The two-line patch to allow it to just ignore controller-data has been
> rejected on the basis that s3c64xx should use a compatible string
> because ofpart monopolizes all nodes without compatible which are
> children of a mtd device. Devicetrees containing such nodes that are
> not partitions are presumably invalid and should be rejected when
> ofpart is compiled into the kernel.

That seems like an extremely limited binding, the normal thing here
would be to create a specifically named node to contain the collection
of subnodes like many PMICs do for their regulators.  As a fix I'd
suggest just silently ignoring nodes it can't understand, or printing a
warning if that's a serious issue.

> >> +     if (!of_get_property(data_np, "compatible", NULL) ||
> >> +         strcmp(of_get_property(data_np, "compatible", NULL),
> >> +                "samsung,s3c-controller-data"))
> >> +             dev_err(&spi->dev, "child node 'controller-data' does not have correct compatible\n");

> > This will break all existing users which is not acceptable for
> > mainline, we need to preserve compatibility with existing device trees.

> It will not break anything. It will just spam dmesg.

I'm confused - if all this change does is to spam dmesg then what's the
point?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150729/8d5f2129/attachment-0001.sig>
