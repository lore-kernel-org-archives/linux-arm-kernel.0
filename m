From: broonie@kernel.org (Mark Brown)
Date: Thu, 6 Aug 2015 10:02:02 +0100
Subject: [RFC PATCH 1/5] spi: introduce flag for memory mapped read
In-Reply-To: <CAOMqctS9Y5FxpUCCJew6+cnjH5iTvbzkH3g-8yrXs4OuS2pSGA@mail.gmail.com>
References: <1438072876-16338-1-git-send-email-vigneshr@ti.com>
 <1438072876-16338-2-git-send-email-vigneshr@ti.com>
 <20150731181745.GM20873@sirena.org.uk> <55BEF4AF.5090704@ti.com>
 <20150804155148.GR20873@sirena.org.uk> <55C0FD98.1090107@ti.com>
 <20150805115013.GJ20873@sirena.org.uk>
 <CAOMqctQXwcHyiWBwtugSDSE_k65qrNfrwnhjQMDJkLoJMmGzUw@mail.gmail.com>
 <20150805124412.GN20873@sirena.org.uk>
 <CAOMqctS9Y5FxpUCCJew6+cnjH5iTvbzkH3g-8yrXs4OuS2pSGA@mail.gmail.com>
Message-ID: <20150806090202.GO20873@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 05, 2015 at 02:56:09PM +0200, Michal Suchanek wrote:
> On 5 August 2015 at 14:44, Mark Brown <broonie@kernel.org> wrote:
> > On Wed, Aug 05, 2015 at 02:40:01PM +0200, Michal Suchanek wrote:

> >> I don't think sending 03 or other random byte as the first byte of a
> >> SPI transfer can be used as reliable detection that we are talking to
> >> a SPI flash memory.

> > Why care - if something is physically in the same format as a flash read
> > command how would a device be able to tell that it wasn't actually a
> > flash read command?  The signals sent on the bus are going to be
> > identical anyway.

> Not only must the command be the same but also the response must be tha same.

What difference would that make?  The caller is sending a single SPI
operation and this is a user visible thing...

> The flash chip responds by sending arbitrary amount of data. Given
> that transfer_one gets only the part that sends the read command and
> the part to do the actual read may or may not follow this is getting a
> bit hairy. Add in dummy bytes due to fast-read lag and page write
> wrap-around and you get something that you definitely do not want
> unless you are really sure that there is a flash memory on the other
> end of the wire.

So if you're doing this you may have a good reason to implement
transfer_one_message() instead.  Or perhaps implement it in the core and
provide operations to do the map and unmap.  And of course if this sort
of requirement exists that's an obvious thing that must be documented
in the interfaces but isn't.

We need a lot more thought about the interface here, the lack of any
explanation of what the interface is supposed to be and the fact that
all questions about it are being answered in terms of describing the
specific system are both a bit worrying.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150806/08a8a314/attachment.sig>
