From: daniel@ffwll.ch (Daniel Vetter)
Date: Tue, 3 Feb 2015 08:48:56 +0100
Subject: [RFCv3 2/2] dma-buf: add helpers for sharing attacher
 constraints with dma-parms
In-Reply-To: <CAF6AEGuESM+e3HSRGM6zLqrp8kqRLGUYvA3KKECdm7m-nt0M=Q@mail.gmail.com>
References: <1422347154-15258-1-git-send-email-sumit.semwal@linaro.org>
 <1422347154-15258-2-git-send-email-sumit.semwal@linaro.org>
 <20150129143908.GA26493@n2100.arm.linux.org.uk>
 <CAO_48GEOQ1pBwirgEWeVVXW-iOmaC=Xerr2VyYYz9t1QDXgVsw@mail.gmail.com>
 <20150129154718.GB26493@n2100.arm.linux.org.uk>
 <CAF6AEGtTmFg66TK_AFkQ-xp7Nd9Evk3nqe6xCBp7K=77OmXTxA@mail.gmail.com>
 <20150129192610.GE26493@n2100.arm.linux.org.uk>
 <CAF6AEGujk8UC4X6T=yhTrz1s+SyZUQ=m05h_WcxLDGZU6bydbw@mail.gmail.com>
 <20150202165405.GX14009@phenom.ffwll.local>
 <CAF6AEGuESM+e3HSRGM6zLqrp8kqRLGUYvA3KKECdm7m-nt0M=Q@mail.gmail.com>
Message-ID: <20150203074856.GF14009@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 02, 2015 at 03:30:21PM -0500, Rob Clark wrote:
> On Mon, Feb 2, 2015 at 11:54 AM, Daniel Vetter <daniel@ffwll.ch> wrote:
> >> My initial thought is for dma-buf to not try to prevent something than
> >> an exporter can actually do.. I think the scenario you describe could
> >> be handled by two sg-lists, if the exporter was clever enough.
> >
> > That's already needed, each attachment has it's own sg-list. After all
> > there's no array of dma_addr_t in the sg tables, so you can't use one sg
> > for more than one mapping. And due to different iommu different devices
> > can easily end up with different addresses.
> 
> 
> Well, to be fair it may not be explicitly stated, but currently one
> should assume the dma_addr_t's in the dmabuf sglist are bogus.  With
> gpu's that implement per-process/context page tables, I'm not really
> sure that there is a sane way to actually do anything else..

Hm, what does per-process/context page tables have to do here? At least on
i915 we have a two levels of page tables:
- first level for vm/device isolation, used through dma api
- 2nd level for per-gpu-context isolation and context switching, handled
  internally.

Since atm the dma api doesn't have any context of contexts or different
pagetables, I don't see who you could use that at all.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
