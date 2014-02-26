From: lauraa@codeaurora.org (Laura Abbott)
Date: Tue, 25 Feb 2014 20:59:46 -0800
Subject: arm64 cache maintenance on read only address loops forever
Message-ID: <530D74C2.4000402@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On arm64, set_pte_at currently write protects user ptes that are not 
dirty. The expected behavior is that the fault handler will fix this up 
on a write to the address. do_page_fault will not mark the fault as a 
write though if ESR has the CM (cache maintenance) bit set. This has the 
unfortunate side effect that if cache maintenance is performed on a user 
address that has not yet been marked as dirty, handle_mm_fault may 
return without actually adjusting the pte or returning an error. This 
means that the fault will be infinitely retried.

Calling cache maintenance on an address that hasn't actually been 
written to isn't all that useful but looping forever seems like a poor 
result. It seems like the check in do_page_fault is too restrictive and 
we need to be able to fault in pages via cache maintenance.

Thoughts?

Thanks,
Laura

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
