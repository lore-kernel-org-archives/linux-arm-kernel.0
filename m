From: broonie@kernel.org (Mark Brown)
Date: Fri, 25 Mar 2016 10:32:53 +0000
Subject: [PATCH v2] spi: orion.c: Add direct access mode
In-Reply-To: <12540712.SXPhdxqg9f@wuerfel>
References: <1458663893-13766-1-git-send-email-sr@denx.de>
 <30176583.aSTyzO0qS3@wuerfel> <56F42939.4020803@denx.de>
 <12540712.SXPhdxqg9f@wuerfel>
Message-ID: <20160325103253.GA2566@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 24, 2016 at 09:07:32PM +0100, Arnd Bergmann wrote:
> On Thursday 24 March 2016 18:51:53 Stefan Roese wrote:

> > I see. But with this we are back to statically mapping the MBus
> > windows that are used. Resulting in potentially multiple windows
> > per SPI controller, which is not necessary (Andrew and Mark
> > objected against that).

> I'm not following here. Do you mean we should set up and tear
> down the windows in the runtime PM callbacks so they are only
> present when we actually access a device instead?

What we're trying to avoid is allocating a window to every single client
device attached to SPI, the controller can only talk to one device at
once anyway so having one per device is wasteful when this is a limited
resource.  Looking at this from the point of view of a SPI driver it
just seems obviously bad, in order to get the best performance with this
controller we need to do a special per-device magic binding.  That's not
good for usability, it's not ideal having to do it per controller but at
least then it's done for the SoC.

We also already apparently have some dynamic code for PCIe. 

> Among the dts files we ship with the kernel, how many would
> actually use more than one mapping in practice if we decide to
> do the static ranges property? I had a quick look and could not
> even find one that has more than one chip-select connected.

Do any of these boards have things like expansion connectors?

> Ok, so with the static mapping it could be done very easily, or
> we need a more complex solution for the dynamic mapping.

Part of what I personally don't understand is why this is complicated?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160325/e3db35e2/attachment.sig>
