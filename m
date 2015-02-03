From: robdclark@gmail.com (Rob Clark)
Date: Tue, 3 Feb 2015 12:35:34 -0500
Subject: [Linaro-mm-sig] [RFCv3 2/2] dma-buf: add helpers for sharing
 attacher constraints with dma-parms
In-Reply-To: <20150203165829.GW8656@n2100.arm.linux.org.uk>
References: <1422347154-15258-1-git-send-email-sumit.semwal@linaro.org>
 <3783167.LiVXgA35gN@wuerfel>
 <20150203155404.GV8656@n2100.arm.linux.org.uk>
 <6906596.JU5vQoa1jV@wuerfel>
 <20150203165829.GW8656@n2100.arm.linux.org.uk>
Message-ID: <CAF6AEGuf6XBe3YOjhtbBcSyqJrkZ7sNMfc83hZdnKsE3P=vSuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 3, 2015 at 11:58 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
>
> Okay, but switching contexts is not something which the DMA API has
> any knowledge of (so it can't know which context to associate with
> which mapping.)  While it knows which device, it has no knowledge
> (nor is there any way for it to gain knowledge) about contexts.
>
> My personal view is that extending the DMA API in this way feels quite
> dirty - it's a violation of the DMA API design, which is to (a) demark
> the buffer ownership between CPU and DMA agent, and (b) to translate
> buffer locations into a cookie which device drivers can use to instruct
> their device to access that memory.  To see why, consider... that you
> map a buffer to a device in context A, and then you switch to context B,
> which means the dma_addr_t given previously is no longer valid.  You
> then try to unmap it... which is normally done using the (now no longer
> valid) dma_addr_t.
>
> It seems to me that to support this at DMA API level, we would need to
> completely revamp the DMA API, which IMHO isn't going to be nice.  (It
> would mean that we end up with three APIs - the original PCI DMA API,
> the existing DMA API, and some new DMA API.)
>
> Do we have any views on how common this feature is?
>

I can't think of cases outside of GPU's..  if it were more common I'd
be in favor of teaching dma api about multiple contexts, but right now
I think that would just amount to forcing a lot of churn on everyone
else for the benefit of GPU's.

IMHO it makes more sense for GPU drivers to bypass the dma api if they
need to.  Plus, sooner or later, someone will discover that with some
trick or optimization they can get moar fps, but the extra layer of
abstraction will just be getting in the way.

BR,
-R
