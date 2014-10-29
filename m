From: broonie@kernel.org (Mark Brown)
Date: Wed, 29 Oct 2014 10:56:00 +0000
Subject: [PATCH 3/6] ASoC: kirkwood: get rid of armada-370-db driver
In-Reply-To: <20141029092419.5eb8ad3a@free-electrons.com>
References: <1414512524-24466-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1414512524-24466-4-git-send-email-thomas.petazzoni@free-electrons.com>
 <20141028223521.GL18557@sirena.org.uk>
 <20141028235456.7d68d53e@free-electrons.com>
 <20141028230740.GQ18557@sirena.org.uk>
 <20141029092419.5eb8ad3a@free-electrons.com>
Message-ID: <20141029105600.GZ18557@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 29, 2014 at 09:24:19AM +0100, Thomas Petazzoni wrote:
> On Tue, 28 Oct 2014 23:07:40 +0000, Mark Brown wrote:

> > Yes, this is the entire point of device tree as an ABI.  We also need to
> > care about out of tree users.

> Right, but I believe it has been discussed multiple times that when a
> subsystem doesn't yet have the proper generic DT bindings and that
> temporary solutions are used, we are allowed to break the compatibility
> when moving to the proper generic DT bindings.

*sigh*  As has been discussed *repeatedly* audio system integration is
itself frequently intersting hardware and "proper" "generic" bindings
are not a useful goal for a large class of systems, we need to apply
some taste in describing things in DT - it's the same problem we've got
with people just constantly dumping Linux implementation details into
DT really.

> > good to avoid adding new drivers there's nothing inherently bad about
> > having a machine driver or adaption layer into simple card (you could do
> > this just as platform data for simple card for many devices).

> I'm sorry but I don't understand what you mean: the simple card DT
> binding is completely sufficient, in its current state, to describe the
> audio complex of the Armada 370 DB.

That's nice but like I just said that still doesn't mean that there's
anything inherently bad about a machine driver.

> In addition, the Marvell Armada 370 DB board is an internal evaluation
> board that is not publicly available. So the rules in terms of DT
> backward compatibility should I believe be a bit relaxed for such
> platforms.

Which you're absolutely sure will never have been used as a reference
design or otherwise cloned?  The board you have might not be widely
available but that doesn't mean other people aren't using boards with a
similar design.

> > In this particular case I'm especially worried since we've got the whole
> > thing with not having a good story for supporting simulataneous use of
> > the S/PDIF and I2S links worked out yet on the controller side and on
> > the simple-card side it's pretty much just the most basic CPUs that are
> > supported.

> I agree that the simple card binding may not be sufficient for all
> situations, but in the case of this platform, it is sufficient. The
> audio data gets sent simultaneously to the codec and the S/PDIF
> transceiver, with no way of enabling or disabling those outputs
> independently. So I believe the simple card DT binding is good enough
> for this case.

You're looking at the current driver implementation, there are actually
separate enable bits for I2S and S/PDIF in the hardware.

> All that being said, if you really want to keep the armada-370-db audio
> machine driver around that's fine with me. It's going to be just an
> unused piece of code and therefore a piece of code that will probably
> be broken in the near future, but I'm not the ASoC maintainer, so it's
> your call.

What I'm seeing is a patch that just totally ignores DT compatibility,
there is no reference to ABI stability in the changelog and no effort to
maintain it in the code.  If you're sending patches like that you should
expect them not to be applied, DT stability is something we're trying to
maintian.  Patches breaking compatibility need to both justify the
benefits of the break and explain why this isn't going to hurt users.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141029/4c51bc68/attachment.sig>
