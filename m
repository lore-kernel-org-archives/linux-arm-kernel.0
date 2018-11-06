From: lmark@codeaurora.org (Liam Mark)
Date: Tue, 6 Nov 2018 13:20:33 -0800 (PST)
Subject: [RFC PATCH v2] android: ion: How to properly clean caches for
 uncached allocations
In-Reply-To: <CALAqxLXzVna9BG8OJhTtTjcSiy4VbJ27nBOv4fKXoMnzc4xBgw@mail.gmail.com>
References: <alpine.DEB.2.02.1802282111320.22860@lmark-linux.qualcomm.com>
 <b1479541-13bd-85ea-f9c7-25264c91f9b9@redhat.com>
 <alpine.DEB.2.02.1803081635170.20592@lmark-linux.qualcomm.com>
 <alpine.DEB.2.10.1811011454430.23412@lmark-linux.qualcomm.com>
 <CALAqxLXzVna9BG8OJhTtTjcSiy4VbJ27nBOv4fKXoMnzc4xBgw@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1811061314240.16463@lmark-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2 Nov 2018, John Stultz wrote:

> On Thu, Nov 1, 2018 at 3:15 PM, Liam Mark <lmark@codeaurora.org> wrote:
> > Based on the suggestions from Laura I created a first draft for a change
> > which will attempt to ensure that uncached mappings are only applied to
> > ION memory who's cache lines have been cleaned.
> > It does this by providing cached mappings (for uncached ION allocations)
> > until the ION buffer is dma mapped and successfully cleaned, then it drops
> > the userspace mappings and when pages are accessed they are faulted back
> > in and uncached mappings are created.
> >
> > This change has the following potential disadvantages:
> > - It assumes that userpace clients won't attempt to access the buffer
> > while it is being mapped as we are removing the userpspace mappings at
> > this point (though it is okay for them to have it mapped)
> > - It assumes that kernel clients won't hold a kernel mapping to the buffer
> > (ie dma_buf_kmap) while it is being dma-mapped. What should we do if there
> > is a kernel mapping at the time of dma mapping, fail the mapping, warn?
> > - There may be a performance penalty as a result of having to fault in the
> > pages after removing the userspace mappings.
> >
> > It passes basic testing involving reading writing and reading from
> > uncached system heap allocations before and after dma mapping.
> >
> > Please let me know if this is heading in the right direction and if there
> > are any concerns.
> >
> > Signed-off-by: Liam Mark <lmark@codeaurora.org>
> 
> 
> Thanks for sending this out! I gave this a whirl on my HiKey960. Seems
> to work ok, but I'm not sure if the board's usage benefits much from
> your changes.
> 

Thanks for testing this.
I didn't expect this patch to improve performance but I was worried it
might hurt performance.

I don't know how many uncached ION allocations Hikey960 makes, or how it
uses uncached allocations.

It is possible that Hikey960 doesn't make much usage of uncached buffers,
or if it does it may not attempt to mmap them before dma mapping them,
so it is possible this change isn't getting exercised very much in the
test you ran.

I will need to look into how best to exercise this patch on Hikey960.

Liam

Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
