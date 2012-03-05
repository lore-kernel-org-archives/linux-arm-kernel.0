From: swarren@nvidia.com (Stephen Warren)
Date: Mon, 5 Mar 2012 10:30:43 -0800
Subject: [RFC PATCH] of: DMA helpers: manage generic requests specification
In-Reply-To: <4F54BC2E.3040702@ti.com>
References: <4F22DEF2.5000807@ti.com>
 <1330527248-4350-1-git-send-email-nicolas.ferre@atmel.com>
 <74CDBE0F657A3D45AFBB94109FB122FF17BDDF217B@HQMAIL01.nvidia.com>
 <4F54BC2E.3040702@ti.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17BE861C6E@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cousson, Benoit wrote at Monday, March 05, 2012 6:14 AM:
> On 2/29/2012 9:54 PM, Stephen Warren wrote:
> > Nicolas Ferre wrote at Wednesday, February 29, 2012 7:54 AM:
> >> By making DMA controllers register a generic translation
> >> function, we allow the management of any type of DMA requests
> >> specification.
> >> The void * output of an of_dma_xlate() function that will be implemented
> >> by the DMA controller can carry any type of "dma-request" argument.
> >>
> >> The DMA client will search its associated DMA controller in the list
> >> and call the registered of_dam_xlate() function to retrieve the
> >> request values.
> >>
> >> One simple xlate function is provided for the "single number" type
> >> of request biding.
> >>
> >> This implementation is independent from dmaengine so it can also be
> >> used by legacy drivers.
> >
> > At a high level this seems along the right lines.
> >
> > The big issue I see is the lack of type-safety in of_get_dma_request()'s
> > out_data pointer: The DMA xlate function will assume it points at some
> > particular type, and the client is responsible for allocating that
> > correct type. However, it's "user"-supplied device tree data that hooks
> > the two together, and there could easily be mismatches, thus causing
> > the xlate function to trash memory.
> >
> > Could each DMA controller (or type of out_data) have some enum in the
> > kernel that the client passes in, and the DMA engine validates matches
> > its expectations, to prevent this kind of thing?
> 
> Beside u32 and string, do we know what kind of parameters we can expect
> to retrieve?
> Because we can potentially reduce the scope to these two types only.

I wondered whether different drivers would return arbitrary driver-specific
structs, so that the DT specific would encode not only the DMA request
number, but perhaps some/all of the DMA parameters like transfer size,
wrap, even DMA FIFO address, ...

Still, there might not be much point in doing that, since drivers (at
least on Tegra) are already manually passing this information to the DMA
driver in the non-DT case, so we can just continue doing that same thing.

-- 
nvpublic
