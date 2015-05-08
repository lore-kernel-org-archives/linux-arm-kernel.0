From: tfiga@chromium.org (Tomasz Figa)
Date: Fri, 8 May 2015 17:22:10 +0900
Subject: [PATCH v2] CHROMIUM: iommu: rockchip: Make sure that page table
 state is coherent
In-Reply-To: <CAGS+omAPLMnwtMNhiakwc7Tn-yeMjdjiy3p=bxuj9AUQUrCO=A@mail.gmail.com>
References: <1429530224-24719-1-git-send-email-tfiga@chromium.org>
 <CAGS+omAPLMnwtMNhiakwc7Tn-yeMjdjiy3p=bxuj9AUQUrCO=A@mail.gmail.com>
Message-ID: <CAAFQd5A2aN_nMtUY52GMbmRWP_ibzn-Nw0sRcZtQBN=25UKa1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 23, 2015 at 6:09 PM, Daniel Kurtz <djkurtz@chromium.org> wrote:
> On Mon, Apr 20, 2015 at 7:43 PM, Tomasz Figa <tfiga@chromium.org> wrote:
>> To flush created mappings, current mapping code relies on the fact that
>> during unmap the driver zaps every IOVA being unmapped and that it is
>> enough to zap a single IOVA of page table to remove the entire page
>> table from IOMMU cache. Based on these assumptions the driver was made to
>> simply zap the first IOVA of the mapping being created. This is enough
>> to invalidate first page table, which could be shared with another
>> mapping (and thus could be already present in IOMMU cache), but
>> unfortunately it does not do anything about the last page table that
>> could be shared with other mappings as well.
>>
>> Moreover, the flushing is performed before page table contents are
>> actually modified, so there is a race between the CPU updating the page
>> tables and hardware that could be possibly running at the same time and
>> triggering IOMMU look-ups, which could bring back the page tables back
>> to the cache.
>>
>> To fix both issues, this patch makes the mapping code zap first and last
>> (if they are different) IOVAs of new mapping after the page table is
>> updated.
>>
>> Signed-off-by: Tomasz Figa <tfiga@chromium.org>
>> Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
>> Tested-by: Heiko Stuebner <heiko@sntech.de>
>
> You probably want to remove the "CHROMIUM: " label in the subject.

Sorry, I removed gerrit tags, but hurrying up too much, I missed the
label. I see, though, that Joerg has applied this patch already with
this fixed up. Thanks.

Best regards,
Tomasz
