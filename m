From: broonie@kernel.org (Mark Brown)
Date: Fri, 9 Aug 2013 12:39:40 +0100
Subject: [PATCH v4 1/1] ASoc: kirkwood: add DT support to the mvebu audio
 subsystem
In-Reply-To: <5204CC04.4000401@gmail.com>
References: <20130808132201.2610aef3@armhf> <5204A716.6070507@gmail.com>
 <20130809091953.GO6427@sirena.org.uk> <5204B7A6.9050907@gmail.com>
 <20130809094340.GO23006@n2100.arm.linux.org.uk>
 <5204CC04.4000401@gmail.com>
Message-ID: <20130809113940.GY6427@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 09, 2013 at 01:01:24PM +0200, Sebastian Hesselbarth wrote:

> And that is *the only thing* that keeps bugging me in Mark's replies -
> he *insists* on having that virtual audio nodes. I have nothing against
> it, except it should be *required* for every DT we have. DRM doesn't
> _need_ it, media doesn't _need_ it, but audio is so very special that it
> _requires_ you to have it described in DT?

> I understand that it may be required on some boards, especially if you
> create different sound-cards out of the IP available. Just like the
> DRM discussion we had - have a virtual node if there is no other sane
> way to describe it, but there is no strict requirement.

The problem here is that the extra effort comes from the board, not from
the individual components - any component would have to optionally
support having a card binding hanging off it (or the properties for a
simple link) so it's more consistent just to say we link everything from
a board node all the time.  By the time you start adding all the things
like jacks and connected pins I'd expect you'd find you'd want to have
at least a sub node to organise everything.

Even things like buses aren't that clear - an I2S link can be a
fairly simple point to point link but it can also be a multi-master bus
or share some signals with other links.  Things like DRM generally have
interconnects which are much more regular and less open to interesting
board design decisions, though even for media the last time I looked at
the bindings the individual links were getting DT nodes which is another
way to try to deal with things.

Let me once more renew my request that you go and read the previous
discussions on this stuff, we've been through this loop repeatedly.

> That is what I am doing on top of the audio-controller node and except
> that there is no helper to determine the names, yet. If ASoC would
> provide a snd_soc_simple_card_register_from_dt(...,device_node *), I
> wouldn't even have to parse the properties myself.

So extend Morimoto-san's work on the simple card for this - that's what
it's there for, it's doing exactly this job for non-DT systems but it
just didn't get DT support added yet.  All the trivial cards should end
up using this.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130809/1b142bf9/attachment.sig>
