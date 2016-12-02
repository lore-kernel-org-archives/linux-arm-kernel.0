From: robert.richter@cavium.com (Robert Richter)
Date: Fri, 2 Dec 2016 08:11:57 +0100
Subject: [PATCH v2] arm64: mm: Fix memmap to be initialized for the
 entire section
In-Reply-To: <58405D5F.90805@arm.com>
References: <1480530091-1092-1-git-send-email-rrichter@cavium.com>
 <20161201164538.GB1236@arm.com> <58405D5F.90805@arm.com>
Message-ID: <20161202071157.GQ2213@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

James,

On 01.12.16 17:26:55, James Morse wrote:
> On 01/12/16 16:45, Will Deacon wrote:
> > Thanks for sending out the new patch. Whilst I'm still a bit worried about
> > changing pfn_valid like this, I guess we'll just have to fix up any callers
> > which suffer from this change.
> 
> Hibernate's core code falls foul of this. This patch causes a panic when copying
> memory to build the 'image'[0].
> saveable_page() in kernel/power/snapshot.c broadly assumes that pfn_valid()
> pages can be accessed.
> 
> Fortunately the core code exposes pfn_is_nosave() which we can extend to catch
> 'nomap' pages, but only if they are also marked as PageReserved().
> 
> Are there any side-effects of marking all the nomap regions with
> mark_page_reserved()? (it doesn't appear to be the case today).

Reserving the page adds it to the memory management which is what we
would like to avoid for NOMAP pages. I don't believe we should do
this. Since NOMAP is to some degree now core functionality I would
rather implement pfn_is_nomap() that defaults to pfn_is_valid() but
calls memblock_is_nomap() for arm64 or does something equivalent.

The question arises what to do with that mem at all. There could be
mappings by the kernel, e.g. of acpi tables. We can't assume the mem
regions still come out the same from the BIOS during resume. Do we
need to save the mem? I can't answer that as I don't know much about
hibernation yet.

Thanks,

-Robert
