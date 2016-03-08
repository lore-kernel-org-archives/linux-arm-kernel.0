From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 8 Mar 2016 21:21:05 +0700
Subject: [PATCH] arm64: account for sparsemem section alignment when
 choosing vmemmap offset
In-Reply-To: <20160308141821.GA31570@kroah.com>
References: <1457446169-23099-1-git-send-email-ard.biesheuvel@linaro.org>
 <20160308141821.GA31570@kroah.com>
Message-ID: <CAKv+Gu_9zL7_EszhQJNFvXqs6rncqe00ZpeiPFPuBxj+ELU6Pg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 March 2016 at 21:18, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Tue, Mar 08, 2016 at 09:09:29PM +0700, Ard Biesheuvel wrote:
>> Commit dfd55ad85e4a ("arm64: vmemmap: use virtual projection of linear
>> region") fixed an issue where the struct page array would overflow into the
>> adjacent virtual memory region if system RAM was placed so high up in
>> physical memory that its addresses were not representable in the build time
>> configured virtual address size.
>>
>> However, the fix failed to take into account that the vmemmap region needs
>> to be relatively aligned with respect to the sparsemem section size, so that
>> a sequence of page structs corresponding with a sparsemem section in the
>> linear region appears naturally aligned in the vmemmap region.
>>
>> So round up vmemmap to sparsemem section size. Since this essentially moves
>> the projection of the linear region up in memory, also revert the reduction
>> of the size of the vmemmap region.
>>
>> Fixes: dfd55ad85e4a ("arm64: vmemmap: use virtual projection of linear region")
>> Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>  arch/arm64/include/asm/pgtable.h | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> Why no "Cc: stable" in the signed-off-by area?
>

Because Will nor Catalin have responded yet to the proposed fix, nor
to the bug report itself. They may prefer another approach to fixing
the original problem rather than putting this on top, so I don't feel
it is up to me to add a cc stable at this time.

-- 
Ard.
