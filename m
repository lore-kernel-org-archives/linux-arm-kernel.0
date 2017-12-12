From: steve.capper@arm.com (Steve Capper)
Date: Tue, 12 Dec 2017 15:39:23 +0000
Subject: [PATCH 05/12] arm64: mm: Remove VMALLOC checks from
 update_mapping_prot(.)
In-Reply-To: <CAKv+Gu80J1vGn6V6Z3eXajDos=sjY_fLhUQP=-n0A8MyunTfgQ@mail.gmail.com>
References: <20171204141313.31604-1-steve.capper@arm.com>
 <20171204141313.31604-6-steve.capper@arm.com>
 <CAKv+Gu80J1vGn6V6Z3eXajDos=sjY_fLhUQP=-n0A8MyunTfgQ@mail.gmail.com>
Message-ID: <20171212153923.a7z6kcowxj7thljy@capper-debian.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

On Mon, Dec 04, 2017 at 04:01:09PM +0000, Ard Biesheuvel wrote:
> On 4 December 2017 at 14:13, Steve Capper <steve.capper@arm.com> wrote:
> > update_mapping_prot assumes that it will be used on the VA for the
> > kernel .text section. (Via the check virt >= VMALLOC_START)
> >
> > Recent kdump patches employ this function to modify the protection of
> > the direct linear mapping (which is strictly speaking outside of this
> > area), via mark_linear_text_alias_ro(.).
> >
> 
> Isn't that a bug? Is it guaranteed that those protection attributes
> can be modified without splitting live page tables, and the resulting
> risk of TLB conflicts?

IIUC there is a bug in my earlier patch to flip the kernel VA space round,
it should allow addresses from the linear mapping to be processed by
update_mapping_prot. I'll update the logic in VA flip patch, so this
patch can be removed from the series.

It is not apparent to me how mark_linear_text_alias_ro(.) guarantees
that no page table entries for the linear map are split, though.

Cheers,
-- 
Steve
