From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 17 Dec 2013 14:19:07 +0000
Subject: [PATCH] arm64: Correct virt_addr_valid
In-Reply-To: <52AF465D.8040000@codeaurora.org>
References: <1386724982-16997-2-git-send-email-lauraa@codeaurora.org>
 <20131211104429.GE26730@mudshark.cambridge.arm.com>
 <20131211110618.GG4360@n2100.arm.linux.org.uk>
 <20131211172635.GJ26730@mudshark.cambridge.arm.com>
 <20131211211333.GI4360@n2100.arm.linux.org.uk>
 <20131212175753.GG3382@arm.com>
 <20131212180249.GV4360@n2100.arm.linux.org.uk>
 <52AA3401.3000004@codeaurora.org> <20131213115757.GC22933@arm.com>
 <52AF465D.8040000@codeaurora.org>
Message-ID: <20131217141907.GJ32118@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 16, 2013 at 06:28:45PM +0000, Laura Abbott wrote:
> On 12/13/2013 3:57 AM, Catalin Marinas wrote:
> > OK, I re-read it now.
> >
> >> Yes, I believe the point was that if we call virt_addr_valid on a
> >> not-direct-mapped address it should return false. We still need the
> >> range check on arm64 systems as well to ensure this.
> >
> > On arm64 we don't have highmem, so all RAM would be directly mapped (and
> > linear). Is there a case on a 64-bit architecture where pfn_valid() is
> > true but the memory not mapped? We don't unmap any memory which is
> > pfn_valid().
> >
> 
> We don't have highmem but we still have a vmalloc region. Calling 
> virt_to_page on a vmalloc address will not give a valid page so 
> virt_addr_valid should return false on anything in the vmalloc region.

We are talking about pfn_valid(__pa(addr) >> PAGE_SHIFT). The __pa()
cannot be used on vmalloc addresses, I agree, but from a practical point
of view it doesn't return valid memory address. I can't think of a
scenario where it would (and if it does, your v2 patch should first
check the range before invoking __pa()).

-- 
Catalin
