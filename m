From: konrad.wilk@oracle.com (Konrad Rzeszutek Wilk)
Date: Tue, 10 Dec 2013 08:56:29 -0500
Subject: [PATCH 3/3] swiotlb: Add support for CMA allocations
In-Reply-To: <20131210135032.GB29700@mudshark.cambridge.arm.com>
References: <1386634334-31139-1-git-send-email-lauraa@codeaurora.org>
 <1386634334-31139-4-git-send-email-lauraa@codeaurora.org>
 <1da8f502-0e34-4b54-929e-bcbe40b20b7f@email.android.com>
 <52A66211.6010707@codeaurora.org>
 <83dd58eb-9a44-4b76-aa68-4669b26acab8@email.android.com>
 <20131210102555.GB2338@mudshark.cambridge.arm.com>
 <20131210104231.GB2521@darko.cambridge.arm.com>
 <20131210135032.GB29700@mudshark.cambridge.arm.com>
Message-ID: <84aa3feb-93df-4417-a7bd-bfc74fa319b5@email.android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will Deacon <will.deacon@arm.com> wrote:
>On Tue, Dec 10, 2013 at 10:42:31AM +0000, Catalin Marinas wrote:
>> On Tue, Dec 10, 2013 at 10:25:56AM +0000, Will Deacon wrote:
>> > On Tue, Dec 10, 2013 at 12:40:20AM +0000, Konrad Rzeszutek Wilk
>wrote:
>> > > Laura Abbott <lauraa@codeaurora.org> wrote:
>> > > >On 12/9/2013 4:29 PM, Konrad Rzeszutek Wilk wrote:
>> > > >> Can this be done in the platform dma_ops functions instead?
>> > > >
>> > > >I suppose it could but that seems like it would result in lots
>of 
>> > > >duplicated code if every architecture that uses swiotlb wants to
>use
>> > > >CMA.
>> > > >
>> > > 
>> > > Then let's do that it that way. Thank you.
>> > 
>> > Note that once arch/arm64 starts growing things like support for
>non-coherent
>> > DMA and IOMMU mappings, we'll probably want to factor out a bunch
>of the
>> > boilerplat from our dma-mapping.c file into places like
>lib/iommu-helper.c.
>> 
>> For coherency, we could build it on top of whatever dma (allocation)
>ops
>> are registered, whether swiotlb or iommu (see part of
>>
>https://git.kernel.org/cgit/linux/kernel/git/cmarinas/linux-aarch64.git/commit/?h=devel&id=c67fe405be6b55399c9e53dfeba5e2c6b930e429)
>> 
>> Regarding iommu, I don't think we need CMA on top, so it makes sense
>to
>> keep the CMA in the swiotlb code.
>
>I don't think it does; swiotlb doesn't care about things like remapping
>highmem pages returned from CMA, so inlining the code in there just
>implies
>that we should inline it in all of the dma_ops implementations that
>might
>want it (although agreed about IOMMU not needing it. I'm thinking about
>things like the non-coherent ops under arch/arm/).
>
>Instead, it should either be in a library that they can all use as they
>see
>fit, or in the code that deals with all of the dma_ops in the
>architecture
>backend.
>
>My reading of Konrad's reply was that he doesn't want this in the
>swiotlb
>code either...
>
>Will

Having it in a library - such as iommu-helper would be better. We could rename the library to dma-helper to make it more obvious of its intended usage.
