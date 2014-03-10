From: david.vrabel@citrix.com (David Vrabel)
Date: Mon, 10 Mar 2014 17:35:58 +0000
Subject: [PATCH] xen/grant-table: Refactor gnttab_[un]map_refs to avoid
 m2p_override
In-Reply-To: <1393516530-9145-1-git-send-email-zoltan.kiss@citrix.com>
References: <1393516530-9145-1-git-send-email-zoltan.kiss@citrix.com>
Message-ID: <531DF7FE.1000708@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/02/14 15:55, Zoltan Kiss wrote:
> (This is a continuation of "[PATCH v9] xen/grant-table: Avoid m2p_override
> during mapping")
> 
> The grant mapping API does m2p_override unnecessarily: only gntdev needs it,
> for blkback and future netback patches it just cause a lock contention, as
> those pages never go to userspace. Therefore this series does the following:
> - the bulk of the original function (everything after the mapping hypercall)
>   is moved to arch-dependent set/clear_foreign_p2m_mapping
> - the "if (xen_feature(XENFEAT_auto_translated_physmap))" brach goes to ARM
> - therefore the ARM function could be much smaller, the m2p_override stubs
>   could be also removed
> - on x86 the set_phys_to_machine calls were moved up to this new funcion
>   from m2p_override functions
> - and m2p_override functions are only called when there is a kmap_ops param
> 
> It also removes a stray space from arch/x86/include/asm/xen/page.h.

Applied to devel/for-linus-3.15.

Thanks.

David
