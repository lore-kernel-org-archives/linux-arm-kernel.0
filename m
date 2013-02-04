From: balbi@ti.com (Felipe Balbi)
Date: Mon, 4 Feb 2013 18:47:12 +0200
Subject: [PATCH v7 01/10] ARM: davinci: move private EDMA API to arm/common
In-Reply-To: <510FF1A6.403@mvista.com>
References: <1359742975-10421-2-git-send-email-mporter@ti.com>
 <5022f635a527470dbd0be932063e9cd2@DFLE72.ent.ti.com>
 <20130201184915.GP2244@beef> <510C1D0E.6030401@mvista.com>
 <20130201185820.GE29898@arwen.pp.htv.fi>
 <510C2A47.1090607@mvista.com>
 <20130201205600.GA31762@arwen.pp.htv.fi>
 <20130201213003.GW2637@n2100.arm.linux.org.uk>
 <20130204154153.GA18237@arwen.pp.htv.fi> <510FF1A6.403@mvista.com>
Message-ID: <20130204164712.GB4269@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Feb 04, 2013 at 08:36:38PM +0300, Sergei Shtylyov wrote:
> > opted out of it. From the top of my head we have CPPI 3.x, CPPI 4.1,
> > Inventra DMA, OMAP sDMA and ux500 DMA engines supported by the driver.
> 
> > Granted, CPPI 4.1 makes some assumptions about the fact that it's
> > handling USB tranfers,
> 
>    What CPPI 4.1 code makes this assumptions? MUSB DMA driver? Then it's just

HW makes the asumptions

> > but nevertheless, the IP can be, and in fact is,
> > used with many different DMA engines and driver needs to cope with it.
> 
>    What IP, CPPI 4.1 or MUSB?

MUSB

> > Current DMA abstraction is quite poor, for example there's no way to
> > compile support for multiple DMA engines. Code also makes certain, IMO
> > unnecessary, assumptions about the underlying DMA engine (abstraction is
> > poor, as said above but it we could follow MUSB's programming guide when
> > it comes to programming DMA transfers).
> 
>    Don't know, I was quite content with the abstraction when writing CPPI 4.1
> driver for MUSB...

look closer. The whole:

if (is_cppi())
	foo();
else if (is_inventra())
	bar();
else if (is_omap_sdma())
	baz();

is bogus.

> > Considering all of the above, it's far better to use DMA engine and get
> > rid of all the mess.
> 
>    In my eyes, getting rid of the mess doesn't justify breaking the rules that
> Russell formulated above.

MUSB is no PCI, there is no single, standard interface to the DMA
engine (unlike Synopsys' dwc-usb3 and dwc-usb2, where we don't use DMA
engine), every DMA engine comes with its own set of registers, its own
programming model and so forth.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130204/42a6e483/attachment.sig>
