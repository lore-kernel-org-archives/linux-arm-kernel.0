From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Wed, 4 Aug 2010 10:16:35 +0530
Subject: Memory type used for ioremap
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B030E5E42A7@dbde02.ent.ti.com>
References: <2A3DCF3DA181AD40BDE86A3150B27B6B030E181724@dbde02.ent.ti.com>
	<1278677464.11895.41.camel@e102109-lin.cambridge.arm.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B030E181CAD@dbde02.ent.ti.com>
	<20100709141416.GI22845@n2100.arm.linux.org.uk>
	<2A3DCF3DA181AD40BDE86A3150B27B6B030E5E42A7@dbde02.ent.ti.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C641DE6B@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
> kernel-bounces at lists.infradead.org] On Behalf Of Pedanekar, Hemant
> Sent: Tuesday, August 03, 2010 11:24 PM
> To: Russell King - ARM Linux
> Cc: linux-arm-kernel at lists.infradead.org
> Subject: RE: Memory type used for ioremap
> 
> Pedanekar, Hemant wrote:
> > Russell King - ARM Linux wrote:
> >> On Fri, Jul 09, 2010 at 07:32:46PM +0530, Pedanekar, Hemant wrote:
> >>> Catalin,
> >>
> >> It'd help if I could see more of your mail than just the above when
> >> replying to it.  Please wrap your messages rather than typing entire
> >> paragraphs on one single line.
> >>
> >> <save this message, go back and read your original, re-edit reply>
> >>
> >
> > Sorry for that. Here is the earlier reply:
> >
> [...]
> >>
> >> We have had devices in the past where certain peripherals are only
> >> visible via non-shared device mappings.  Could this be one of them?
> >>
> >
> > If I wanted to have mapping for "Strongly-ordered" memory type, is there
> any
> > function that I can use from driver? I guess 'ioremap' won't help here?
> > Probably I need to use MT_MEMORY_NONCACHED and do a static mapping?
> >
> >> Without knowing more about the device you're using, in particular
> >> how the bus matrix is setup, there's no way to comment definitively.
> >> What does the documentation for your device say about the type of
> >> mappings required for this peripheral?
> >
> > I will confirm and update but looks like I need to have "Strongly-
> ordered"
> > type.
> >
> 
> Russell,
> 
> I have confirmed that with mapping the concerned region as "Strongly
> Ordered",
> the write accesses work fine.
> 
> Following are the observations and particulars:
> 
> 1) The peripheral region has constraint that it requires writes to be
> non-posted. Posted writes are not supported.
> 2) On my system, writes to the region mapped as MT_DEVICE or
> MT_DEVICE_NONSHARED
> are posted and hence do not work in this case.
> 3) While writes on "Strongly Ordered" region are non-posted and work fine.
> 
DEVICE attributes with proper ordering(barriers) also should work. If you
use recent series from Catalin the ordering is more or less taken care from
CPU point of view.

For interconnect ordering, you need to a read back in some cases. This is
better option from performance point of view than SO.
SO is very good to figure out ordering BUGS though.

Regards,
Santosh
