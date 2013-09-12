From: broonie@kernel.org (Mark Brown)
Date: Thu, 12 Sep 2013 21:56:44 +0100
Subject: [PATCH v3 0/8] Add the Quadspi driver for vf610-twr
In-Reply-To: <20130913041208.GD3051@gmail.com>
References: <593AEF6C47F46446852B067021A273D6D984000B@MUCSE039.lantiq.com>
 <20130905020435.GA3970@gmail.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA0C7F4@DBDE04.ent.ti.com>
 <522817D7.1010206@freescale.com> <522D3B79.3060707@freescale.com>
 <52318953.6090405@freescale.com>
 <1378979431.2627.402.camel@shinybook.infradead.org>
 <20130913025827.GA3051@gmail.com>
 <1378999322.4210.95.camel@i7.infradead.org>
 <20130913041208.GD3051@gmail.com>
Message-ID: <20130912205644.GW29403@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 13, 2013 at 12:12:14AM -0400, Huang Shijie wrote:
> On Thu, Sep 12, 2013 at 04:22:02PM +0100, David Woodhouse wrote:

> > But the controller driver shouldn't *have* that incestuous knowledge of
> > the command set of the chip that happens to be connected to it.

> I think the controller is designed for the NOR flash, yes, a little
> strange.

I think this is part of the problem - you're trying to represent
something that isn't really a SPI controller as a SPI controller (or at
least trying to implement functionality beyond that which a SPI
controller has).

> Mark and you want to create the LUT instruction sequence at the runtime,
> But there is some disadvantage if we do so:
>   [1] low efficiency: 

>   [2] we may can not create all the LUT instruction sequence at the
>       runtime. For example, the buffer program(OPCODE_PP):

> 
>   [3] We may can not create the LUT instruction sequence at the runtime,
>       since we can not get enough information from the spi_transfer{}.
>       A whole LUT instruction sequence may needs the following info:

What this is saying to me is that you should not be impementing this as
a SPI controller, trying to do that is breaking the abstracton that SPI
is offering.  Like people have said SPI is just about byte streams.

I think what you should be doing is refactoring the MTD code which
interfaces to SPI flashes to split out the code so that there's an
abstraction which can express what this controller (and presumably
other controllers) can do and then implement this functionaltiy at
that level.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130912/a0a6b3bb/attachment.sig>
