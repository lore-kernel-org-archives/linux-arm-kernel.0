From: broonie@kernel.org (Mark Brown)
Date: Wed, 28 May 2014 19:47:52 +0100
Subject: [PATCH 0/5] regulator: Enhance AXP209 DT support
In-Reply-To: <1401297069-7423-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1401297069-7423-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20140528184752.GA22488@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 28, 2014 at 07:11:04PM +0200, Maxime Ripard wrote:

> This patchset modifies the regulator core and axp209 regulator driver
> to be able to set in each regulators sub-node the supply, that should
> be possible, given that it's documented as such in the bindings, but

It is?  We should fix that.

> is not at the moment, since whenever looking up the supply in the DT,
> of_get_regulator will always look into the parent's device of_node
> pointer.

> This leads to a common pattern accross the regulators to have multiple
> supply in the main device node, while it would be more intuitive yet
> follow the documented bindings to look into the regulator sub-nodes
> first.

No, we've been round this loop several times before.  This reduces
consistency in how we map supplies since the user has to work out which
subnode the supply is associated with and what it's called there instead
of being able to just look at the schematic and translate the supply
name into a property name.  It also means you have to map supplies into
multiple child nodes if the same supply is used in multiple places.

The idea is that supplies that happen to be used to supply a regulator
don't get treated any differently to any other supply and that we do
that at the physical package level.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140528/3f997023/attachment.sig>
