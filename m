From: balbi@ti.com (Felipe Balbi)
Date: Tue, 29 Jan 2013 16:33:02 +0200
Subject: [PATCH,RFC] usb: add devicetree helpers for determining dr_mode
 and phy_type
In-Reply-To: <5107D84F.80401@ti.com>
References: <1359458548-25071-1-git-send-email-s.hauer@pengutronix.de>
 <5107D253.5030400@ti.com> <20130129135336.GA3323@pengutronix.de>
 <5107D84F.80401@ti.com>
Message-ID: <20130129143302.GF2046@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jan 29, 2013 at 07:40:23PM +0530, kishon wrote:
> On Tuesday 29 January 2013 07:23 PM, Wolfram Sang wrote:
> >>>+	err = of_property_read_string(np, "phy_type", &phy_type);
> >>>+	if (err < 0)
> >>>+		return USBPHY_INTERFACE_MODE_NA;
> >>
> >>Why don't we use a u32 property type for the *phy-type*? IMHO we
> >>should use string property only when the property should be
> >>absolutely unambiguous (e.g., compatible property should be string).
> >
> >If we would use u32-numbers in the compatible entry, this would also be
> >unambiguous, no? 0xd00dfeed would be the at24-driver. Pretty specific.
> 
> hehe... But we don't have a corresponding *enum* representing the
> drivers :-)
> >
> >I don't mind having readable devicetrees. And we have it for ethernet
> >phys already with strings, so it would be consistent.
> 
> Ok. Fine with it then :-)

I prefer u32 here, because we have the matching enum. Otherwise we end
up with:

of_property_read_string(...,&type);

if (!strcmp(type, "ulpi"))
	foo();
else if (!strcmp(type, "utmi"))
	bar();
else if (!strcmp(type, "pipe3"))
	baz();
else
	BUG();

and I don't like that, it's ugly and error prone. Also looks awful when
someone needs to change that, the diff looks messy. A u32 followed by a
switch statement looks nicer.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130129/bb037592/attachment.sig>
