From: Catalin.Marinas@arm.com (Catalin Marinas)
Date: Wed, 26 Feb 2014 14:03:01 +0000
Subject: arm64 cache maintenance on read only address loops forever
In-Reply-To: <530D74C2.4000402@codeaurora.org>
References: <530D74C2.4000402@codeaurora.org>
Message-ID: <20140226140301.GB7761@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 25, 2014 at 08:59:46PM -0800, Laura Abbott wrote:
> On arm64, set_pte_at currently write protects user ptes that are not
> dirty. The expected behavior is that the fault handler will fix this
> up on a write to the address. do_page_fault will not mark the fault
> as a write though if ESR has the CM (cache maintenance) bit set.
> This has the unfortunate side effect that if cache maintenance is
> performed on a user address that has not yet been marked as dirty,
> handle_mm_fault may return without actually adjusting the pte or
> returning an error. This means that the fault will be infinitely
> retried.
> 
> Calling cache maintenance on an address that hasn't actually been
> written to isn't all that useful but looping forever seems like a
> poor result. It seems like the check in do_page_fault is too
> restrictive and we need to be able to fault in pages via cache
> maintenance.

Which kernel are you using? We had a fix in this area, commit
db6f41063cbdb58b14846e600e6bc3f4e4c2e888 (arm64: mm: don't treat user
cache maintenance faults as writes).

-- 
Catalin
