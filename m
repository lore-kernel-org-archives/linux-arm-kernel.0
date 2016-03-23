From: broonie@kernel.org (Mark Brown)
Date: Wed, 23 Mar 2016 18:29:16 +0000
Subject: [PATCH v2] spi: orion.c: Add direct access mode
In-Reply-To: <56F2D19A.7020604@denx.de>
References: <1458663893-13766-1-git-send-email-sr@denx.de>
 <20160322173546.40d24cc2@free-electrons.com>
 <56F17684.2010307@denx.de> <20160323113316.GH2566@sirena.org.uk>
 <56F2852C.5010006@denx.de> <20160323125448.GM2566@sirena.org.uk>
 <56F295E1.4030505@denx.de> <20160323132732.GN2566@sirena.org.uk>
 <56F2D19A.7020604@denx.de>
Message-ID: <20160323182916.GQ2566@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 23, 2016 at 06:25:46PM +0100, Stefan Roese wrote:
> On 23.03.2016 14:27, Mark Brown wrote:

> >No, really - it's just unhelpful.  Putting this in the ABI means that
> >every single system integrator who cares about performance is going to
> >need to go and manually figure out how to configure this in DT and
> >manually select values.  That's not doing a good job for users, it's
> >making their lives harder for no gain.  If there are no physical
> >constraints then how we allocate space in the MBus should be a runtime
> >thing, it shouldn't be part of the ABI.

> Do I understand you correctly, that you want the complete MBus
> allocation and configuration to be included in the SPI driver
> instead of using the DT to describe the window (target, attribute,
> area)? If yes, then the SPI driver would be the first driver
> to do this "internally". All other drivers using MBus resources
> parse these from the DT (AFAIK) as this is highly SoC specific.

That seems pretty surprising, especially if there is a possibility that
we might run out of resources on the MBus even if just in some unusual
situation.  Why would this be manually configured in DT if there's no
hardware restriction?  Based on what people are saying I'd expect the
SPI controller to have a reference to the attached bus which it uses to
find the bus and then ask the bus to allocate it whatever it needs from
the space available.  I mean, I guess if that's what you're forcing
users to do that's what you're forcing users to do but it seems like
it's making people do manual work that should be automated.

It's possible I'm missing something about how this hardware works...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160323/bf851f6f/attachment.sig>
