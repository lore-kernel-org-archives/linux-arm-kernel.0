From: robdclark@gmail.com (Rob Clark)
Date: Thu, 29 Jan 2015 18:19:51 -0500
Subject: [RFCv3 2/2] dma-buf: add helpers for sharing attacher constraints
 with dma-parms
In-Reply-To: <20150129223158.GF26493@n2100.arm.linux.org.uk>
References: <1422347154-15258-1-git-send-email-sumit.semwal@linaro.org>
 <1422347154-15258-2-git-send-email-sumit.semwal@linaro.org>
 <20150129143908.GA26493@n2100.arm.linux.org.uk>
 <CAO_48GEOQ1pBwirgEWeVVXW-iOmaC=Xerr2VyYYz9t1QDXgVsw@mail.gmail.com>
 <20150129154718.GB26493@n2100.arm.linux.org.uk>
 <CAF6AEGtTmFg66TK_AFkQ-xp7Nd9Evk3nqe6xCBp7K=77OmXTxA@mail.gmail.com>
 <20150129192610.GE26493@n2100.arm.linux.org.uk>
 <CAF6AEGujk8UC4X6T=yhTrz1s+SyZUQ=m05h_WcxLDGZU6bydbw@mail.gmail.com>
 <20150129223158.GF26493@n2100.arm.linux.org.uk>
Message-ID: <CAF6AEGuF8j7CpPmKpPhqmc_Rc8qDDSMPSpPfvACsGShnaCRAxQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 29, 2015 at 5:31 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Jan 29, 2015 at 05:18:33PM -0500, Rob Clark wrote:
>> On Thu, Jan 29, 2015 at 2:26 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > Now, if we're going to do the "more clever" thing you mention above,
>> > that rather negates the point of this two-part patch set, which is to
>> > provide the union of the DMA capabilities of all users.  A union in
>> > that case is no longer sane as we'd be tailoring the SG lists to each
>> > user.
>>
>> It doesn't really negate.. a different sg list representing the same
>> physical memory cannot suddenly make the buffer physically contiguous
>> (from the perspective of memory)..
>>
>> (unless we are not on the same page here, so to speak)
>
> If we are really only interested in the "physically contiguous" vs
> "scattered" differentiation, why can't this be just a simple flag?

I'd be fine with that..  I was trying to make it a bit less of a point
solution, but maybe trying to be too generic is not worth it..

There is apparently some hw which has iommu's but small # of tlb
entries, and would prefer partially contiguous buffers.  But that
isn't a hard constraint, and maybe shouldn't be solved w/
max_segment_count.  And I'm not sure how common that is.

> I think I know where you're coming from on that distinction - most
> GPUs can cope with their buffers being discontiguous in memory, but
> scanout and capture hardware tends to need contiguous buffers.
>
> My guess is that you're looking for some way that a GPU driver could
> allocate a buffer, which can then be imported into the scanout
> hardware - and when it is, the underlying backing store is converted
> to a contiguous buffer.  Is that the usage scenario you're thinking
> of?

Pretty much..  and maybe a few slight permutations on that involving
cameras / video codecs / etc.  But the really-really common case is
gpu (with mmu/iommu) + display (without).  Just solving this problem
would be a really good first step.

BR,
-R

>
> --
> FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
> according to speedtest.net.
