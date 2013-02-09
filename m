From: balbi@ti.com (Felipe Balbi)
Date: Sat, 9 Feb 2013 22:56:52 +0200
Subject: [PATCH 3/7] ARM: omap2: gpmc: Fix gpmc_cs_reserved() return value
In-Reply-To: <20130209181432.GD32349@localhost>
References: <1360427896-12004-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1360427896-12004-4-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130209165335.GA13338@arwen.pp.htv.fi>
 <20130209181432.GD32349@localhost>
Message-ID: <20130209205632.GA14543@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Feb 09, 2013 at 03:14:33PM -0300, Ezequiel Garcia wrote:
> > >  static int gpmc_cs_reserved(int cs)
> > >  {
> > >  	if (cs > GPMC_CS_NUM)
> > >  		return -ENODEV;
> > >  
> > > -	return gpmc_cs_map & (1 << cs);
> > > +	if (gpmc_cs_map & (1 << cs))
> > > +		return -EBUSY;
> > > +
> > > +	return 0;
> > 
> > you could use a ternary operator here:
> > 
> > bit = gpmc_cs_map & (1 << cs);
> > 
> > return bit ? -EBUSY : 0;
> > 
> > But to be frank, I'm not sure this makes that much sense, I'd expect
> > gpmc_cs_reserved() to return 0 or 1 depending on the state (just as it
> > was before). The name of the method asks for a boolean return value.
> > 
> 
> Well, we can change the return value to a boolean.
> 
> However, note that the function 'as it was before' was somewhat inconsistent:
> gpmc_cs_reserved returned -ENODEV if the given 'cs' was out of range and
> a non-negative integer otherwise, 0 if the cs is available and positive
> integer otherwise.
> 
> So, what I'm doing here is fixing this by returning an appropriate error
> condition or 0 if the CS is available.
> 
> If we change it to return a boolean, we won't be able to distinguish
> between EBUSY and ENODEV.

that's the thing. IMO this should return 1 if it is available and 0 if
it's not. The method looks like a yes/no question:

Q: Is this GPMC CS reserved ?
A: Yes (1)

or

A: No (0)

then it's als far easier to use, just as code was before:

if (gpmc_cs_reserved(cs)) {
	dev_dbg(dev, "Oops, CS #%d is busy\n", cs);
	return -EBUSY;
} else {
	dev_dbg(dev, "Hurray!\n");
	return 0;
}

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130209/77b5416f/attachment.sig>
