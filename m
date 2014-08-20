From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 20 Aug 2014 07:21:46 +0200
Subject: [PATCH v5 1/1] iommu-api: Add map_sg/unmap_sg functions
In-Reply-To: <2767102.8U6hAaZh2n@avalon>
References: <1407797150-515-1-git-send-email-ohaugan@codeaurora.org>
 <2348740.xICP2AxYHy@avalon> <53F39A18.70409@codeaurora.org>
 <2767102.8U6hAaZh2n@avalon>
Message-ID: <20140820052144.GA13793@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 19, 2014 at 10:52:46PM +0200, Laurent Pinchart wrote:
> On Tuesday 19 August 2014 11:40:24 Olav Haugan wrote:
> > On 8/19/2014 9:11 AM, Laurent Pinchart wrote:
> > > On Tuesday 19 August 2014 13:59:54 Joerg Roedel wrote:
> > >> On Mon, Aug 18, 2014 at 03:47:56PM -0700, Olav Haugan wrote:
> > >>> If the alignment is not correct then iommu_map() will return error. Not
> > >>> sure what other option we have here (and why make it different behavior
> > >>> than iommu_map which just return error when it is not aligned properly).
> > >>> I don't think we want to force any kind of alignment automatically. I
> > >>> would rather have the API tell me I am doing something wrong than having
> > >>> the function aligning the values and possibly undermap or overmap.
> > >> 
> > >> But sg->offset is an offset into the page (at least it is used that way
> > >> in the DMA-API and since you do 'page_len = s->offset + s->length' you
> > >> use it the same way).
> > >> So when you pass iova + offset the result will no longer be
> > >> page-aligned. You should force sg->offset == 0 and sg->length to be
> > >> page-aligned instead. This makes more sense because the IOMMU-API works
> > >> on (io)-page granularity and not on arbitrary phys-addr ranges like the
> > >> DMA-API.
> > >> 
> > >>> Yes, I am aware of that. However, several people prefer this than
> > >>> passing in scatterlist. It is not very convenient to pass a scatterlist
> > >>> in some use cases. Someone mentioned a use case where they would have to
> > >>> create a dummy sg list and populate it with the iova just to do an
> > >>> unmap. I believe we would have to do this also. There is no use for
> > >>> sglist when unmapping. However, would like to keep separate API from
> > >>> iommu_unmap() to keep the API function names symmetric
> > >>> (map_sg/unmap_sg).
> > >> 
> > >> Keeping it symetric is not more complicated, the caller just needs to
> > >> keep the sg-list used for mapping around. I prefer the unmap_sg call to
> > >> work in sg-lists too.
> > > 
> > > Do we have a use case where the unmap_sg() implementation would be
> > > different than a plain iommu_unmap() call ? If not I'd rather remove
> > > unmap_sg() completely.
> > > 
> > >>> I thought that was why we added the default fallback and set all the
> > >>> drivers to point to these fallback functions. Several people wanted this
> > >>> so that we don't have to have NULL-check in these functions (and have
> > >>> the functions be simple inline functions).
> > >> 
> > >> Okay, since you add these call-backs to all drivers I think I can live
> > >> with not doing a pointer check here.
> > > 
> > > I suggested doing a
> > > 
> > > if (ops is not NULL)
> > > 
> > > 	return ops();
> > > 
> > > else
> > > 
> > > 	return default_ops();
> > > 
> > > to avoid modifying all drivers. I'm not sure why that wasn't received with
> > > much enthusiasm.
> > 
> > Both Thierry R. and Konrad W. argued for modifying the drivers instead
> > so I implemented what the majority wanted. :-)
> 
> I'm not blaming you :-) I was just wondering what their rationale was.

In my opinion it's much more direct that way. It means that if a driver
doesn't implement it, it won't fall back to some default implementation
instead. Providing an explicit helper like this makes it obvious that
the driver is using a default implementation rather than making things
work "magically". It's easier to see in the driver that there's the
potential to optimize.

It also has the side-effect of keeping the core code cleaner in my
opinion, since the core iommu_map_sg() and iommu_unmap_sg() functions
can now blindly call into drivers directly rather than performing the
various checks to see if they implement the required functionality.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140820/192e9789/attachment.sig>
