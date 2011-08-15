From: ivan.djelic@parrot.com (Ivan Djelic)
Date: Mon, 15 Aug 2011 10:41:42 +0200
Subject: GPMI-NAND Status?
In-Reply-To: <97D3A72708D04647A5AC84A04996E5B5194B56@039-SN1MPN1-002.039d.mgd.msft.net>
References: <20110805135133.GA26981@pengutronix.de>
	<20110814081139.GD17063@parrot.com>
	<20040.45443.810005.525431@ipc1.ka-ro>
	<97D3A72708D04647A5AC84A04996E5B5194B56@039-SN1MPN1-002.039d.mgd.msft.net>
Message-ID: <20110815084142.GB18364@parrot.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 15, 2011 at 07:30:58AM +0100, Lin Tony-B19295 wrote:
> > -----Original Message-----
> > From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
> > kernel-bounces at lists.infradead.org] On Behalf Of Lothar Wa?mann
> > Sent: Monday, August 15, 2011 1:41 PM
> > To: Ivan Djelic
> > Cc: Koen Beel; Wolfram Sang; Huang Shijie-B32955; linux-
> > mtd at lists.infradead.org; Shawn Guo; linux-arm-kernel at lists.infradead.org
> > Subject: Re: GPMI-NAND Status?
> > 
> > Hi,
> > 
> > Ivan Djelic writes:
> > > On Fri, Aug 05, 2011 at 02:51:33PM +0100, Wolfram Sang wrote:
> > > (...)
> > > >
> > > > problem overwriting all-0xff data in NAND [2]
> > > > =============================================
> > > >
> > > > Although it occured only when writing JFFS2 images so far, this is a
> > > > generic issue and needs to be fixed, right?
> > > >
> > > >
> > > (...)
> > > > [2]
> > > > http://lists.infradead.org/pipermail/linux-mtd/2011-July/037104.html
> > >
> > > As explained in the thread linked above, this issue should be fixed in
> > > your flashing tool, _not_ in your driver. The nand device you are
> > > using does not support programming pages multiple times in a row;
> > > pretending it does in the
> > >
> > It's not a problem of the device (Samsung K9F1G08U0B in my case)! The
> > problem is that the controller generates an ECC code that is non-FF for
> > all-FF data, which JFFS2 cannot handle properly.
> > 
> As I know, this is BCH algorithm limitation for ECC.(non-FF ECC code for all-FF data)

Not a BCH algorithm limitation: you can always XOR BCH bytes to get all-FF ECC
code for all-FF data. It is equivalent to simply adding a particular
polynomial. See drivers/mtd/nand/nand_bch.c:62 for an example.
Not being able to do so is a hardware limitation. For instance, the OMAP35xx
BCH engine allows this masking operation.

BR,

Ivan
