From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Mon, 04 Feb 2013 20:54:17 +0300
Subject: [PATCH v7 01/10] ARM: davinci: move private EDMA API to arm/common
In-Reply-To: <20130204164712.GB4269@arwen.pp.htv.fi>
References: <1359742975-10421-2-git-send-email-mporter@ti.com>
 <5022f635a527470dbd0be932063e9cd2@DFLE72.ent.ti.com>
 <20130201184915.GP2244@beef> <510C1D0E.6030401@mvista.com>
 <20130201185820.GE29898@arwen.pp.htv.fi> <510C2A47.1090607@mvista.com>
 <20130201205600.GA31762@arwen.pp.htv.fi>
 <20130201213003.GW2637@n2100.arm.linux.org.uk>
 <20130204154153.GA18237@arwen.pp.htv.fi> <510FF1A6.403@mvista.com>
 <20130204164712.GB4269@arwen.pp.htv.fi>
Message-ID: <510FF5C9.3030600@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 02/04/2013 07:47 PM, Felipe Balbi wrote:

> On Mon, Feb 04, 2013 at 08:36:38PM +0300, Sergei Shtylyov wrote:
>>> opted out of it. From the top of my head we have CPPI 3.x, CPPI 4.1,
>>> Inventra DMA, OMAP sDMA and ux500 DMA engines supported by the driver.

>>> Granted, CPPI 4.1 makes some assumptions about the fact that it's
>>> handling USB tranfers,

>>    What CPPI 4.1 code makes this assumptions? MUSB DMA driver? Then it's just

> HW makes the asumptions

   Not true at all. There is a separate set of registers (at offset 0) which
copes with USB specifics, but CPPI 4.1 itself doesn't know about USB anything.
It's just the way the driver was written that it used both sets of registers but
this needs to be changed into more abstacted accesses to the USB-specific part,
to cope with it being different on different platfroms, like AM35x. The driver
as it was last posted, just needs rework now.

>>> but nevertheless, the IP can be, and in fact is,
>>> used with many different DMA engines and driver needs to cope with it.

>>    What IP, CPPI 4.1 or MUSB?

> MUSB

>>> Current DMA abstraction is quite poor, for example there's no way to
>>> compile support for multiple DMA engines. Code also makes certain, IMO
>>> unnecessary, assumptions about the underlying DMA engine (abstraction is
>>> poor, as said above but it we could follow MUSB's programming guide when
>>> it comes to programming DMA transfers).

>>    Don't know, I was quite content with the abstraction when writing CPPI 4.1
>> driver for MUSB...

> look closer. The whole:

> if (is_cppi())
> 	foo();
> else if (is_inventra())
> 	bar();
> else if (is_omap_sdma())
> 	baz();

> is bogus.

   That part -- yes. There were attempt to get rid of this, but without changing
the DMA API. It was left halfway done after my only critical comment, IIRC. Will
we ever see the continuation of this effort?

>>> Considering all of the above, it's far better to use DMA engine and get
>>> rid of all the mess.

>>    In my eyes, getting rid of the mess doesn't justify breaking the rules that
>> Russell formulated above.

> MUSB is no PCI, there is no single, standard interface to the DMA
> engine (unlike Synopsys' dwc-usb3 and dwc-usb2, where we don't use DMA
> engine), every DMA engine comes with its own set of registers, its own
> programming model and so forth.

   Same can be said about PCI where each bus master has its own programming i/f
-- so I didn't really dig this example.

WBR, Sergei
