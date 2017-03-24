From: kirill@shutemov.name (Kirill A. Shutemov)
Date: Fri, 24 Mar 2017 13:37:09 +0300
Subject: [RFC PATCH 0/2] Add hstate parameter to huge_pte_offset()
In-Reply-To: <bde0d8a5-f361-ef4e-5cb3-1615bc2a98b0@oracle.com>
References: <20170323125823.429-1-punit.agrawal@arm.com>
 <bde0d8a5-f361-ef4e-5cb3-1615bc2a98b0@oracle.com>
Message-ID: <20170324103709.253qw6pyjaq5wrgb@node.shutemov.name>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 23, 2017 at 01:55:27PM -0700, Mike Kravetz wrote:
> On 03/23/2017 05:58 AM, Punit Agrawal wrote:
> > On architectures that support hugepages composed of contiguous pte as
> > well as block entries at the same level in the page table,
> > huge_pte_offset() is not able to determine the right offset to return
> > when it encounters a swap entry (which is used to mark poisoned as
> > well as migrated pages in the page table).
> > 
> > huge_pte_offset() needs to know the size of the hugepage at the
> > requested address to determine the offset to return - the current
> > entry or the first entry of a set of contiguous hugepages. This came
> > up while enabling support for memory failure handling on arm64[0].
> > 
> > Patch 1 adds a hstate parameter to huge_pte_offset() to provide
> > additional information about the target address. It also updates the
> > signatures (and usage) of huge_pte_offset() for architectures that
> > override the generic implementation. This patch has been compile
> > tested on ia64 and x86.
> 
> I haven't looked at the performance implications of making huge_pte_offset
> just a little slower.  But, I think you can get hstate from the parameters
> passed today.
> 
> vma = find_vma(mm, addr);
> h = hstate_vma(vma);

It's better to avoid find_vma() in fast(?) path if possible. So passing it
down is probably better.

-- 
 Kirill A. Shutemov
