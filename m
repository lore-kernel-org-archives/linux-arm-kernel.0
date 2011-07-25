From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 25 Jul 2011 15:22:01 +0100
Subject: [PATCH 0/9] PL08x further cleanups
In-Reply-To: <1311601872.8206.10.camel@vkoul-mobl4>
References: <20110705131030.GE8286@n2100.arm.linux.org.uk>
	<1310598328.1536.27.camel@vkoul-udesk3>
	<20110721160800.GR26574@n2100.arm.linux.org.uk>
	<1311601111.8206.5.camel@vkoul-mobl4>
	<20110725134340.GK9653@n2100.arm.linux.org.uk>
	<1311601872.8206.10.camel@vkoul-mobl4>
Message-ID: <20110725142201.GA14955@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 25, 2011 at 07:21:12PM +0530, Vinod Koul wrote:
> On Mon, 2011-07-25 at 14:43 +0100, Russell King - ARM Linux wrote:
> > No.  This function is used as:
> > 
> > +       width = pl08x_width(addr_width);
> > +       if (width == ~0) {
> >                 dev_err(&pl08x->adev->dev,
> >                         "bad runtime_config: alien address width\n");
> >                 return -EINVAL;
> >         }
> > 
> > Notice that it returns a u32 so negative errnos don't make sense.  It
> > returns ~0 to indicate error.
> > 
> > The code is actually correct as it stands, it's just gcc deciding to
> > emit a warning for an unhandled enum value which isn't really unhandled.
> > Just move the 'return ~0;' at the end of the function inside the switch
> > as a default case to shut it up.
> Okay but shouldn't this ideally check for width < 0, that way we can
> return proper errors?

No.  Two reasons:

1. u32 < 0 does not exist.

2. It's returning a sub bitmask value for the register, so signed numbers
   conceptually don't make sense.
