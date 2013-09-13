From: broonie@kernel.org (Mark Brown)
Date: Fri, 13 Sep 2013 11:21:27 +0100
Subject: [PATCH v3 0/8] Add the Quadspi driver for vf610-twr
In-Reply-To: <52329AD3.2050608@freescale.com>
References: <20980858CB6D3A4BAE95CA194937D5E73EA0C7F4@DBDE04.ent.ti.com>
 <522817D7.1010206@freescale.com> <522D3B79.3060707@freescale.com>
 <52318953.6090405@freescale.com>
 <1378979431.2627.402.camel@shinybook.infradead.org>
 <20130913025827.GA3051@gmail.com>
 <1378999322.4210.95.camel@i7.infradead.org>
 <20130913041208.GD3051@gmail.com>
 <20130912205644.GW29403@sirena.org.uk>
 <52329AD3.2050608@freescale.com>
Message-ID: <20130913102127.GD29403@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 13, 2013 at 12:55:47PM +0800, Huang Shijie wrote:
> ? 2013?09?13? 04:56, Mark Brown ??:

> > I think this is part of the problem - you're trying to represent
> > something that isn't really a SPI controller as a SPI controller (or at
> > least trying to implement functionality beyond that which a SPI
> > controller has).

> The QuadSpi is not a traditional SPI controller, but i think it is still
> a SPI controller.
> It connects and controls the SPI NOR FLASH, so what do you think it is?

I think it is a SPI flash controller because...

> But the Quadspi controller can not work with the byte streams directly,
> it works with the LUT instruction sequences, so we have to parse the
> byte streams,
> and then uses the right LUT to trigger the transaction.

...it has a programming model that seems strongly oriented around that.
The device can offer a SPI interface too but as you say that's going to
be less efficient.  Externally it is still SPI but in terms of what it
is offering to the processor the functionality you are trying to support
looks like it will work a lot better if the code using it understands
that it is talking to a flash rather than having a SPI driver which
tries to reverse engineer the data that's being sent to it.

> > I think what you should be doing is refactoring the MTD code which
> > interfaces to SPI flashes to split out the code so that there's an
> > abstraction which can express what this controller (and presumably
> > other controllers) can do and then implement this functionaltiy at
> > that level.

> If i follow this advice, i have to create a new file cloned by the m25p80.c,
> and replace all the SPI APIs with other APIs.

Not quite, you need to split that file up so that there is an API
between the flash chip code and the SPI code - the code for the flash
chip should be shared between regular SPI and other controllers like
this one.

> I have no idea what APIs can be used to replace the SPI APIs.

You will need to create them.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130913/347bf631/attachment-0001.sig>
