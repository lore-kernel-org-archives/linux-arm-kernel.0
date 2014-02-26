From: will.deacon@arm.com (Will Deacon)
Date: Wed, 26 Feb 2014 13:55:21 +0000
Subject: arm64 cache maintenance on read only address loops forever
In-Reply-To: <530D74C2.4000402@codeaurora.org>
References: <530D74C2.4000402@codeaurora.org>
Message-ID: <20140226135521.GF8961@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 26, 2014 at 04:59:46AM +0000, Laura Abbott wrote:
> Hi,

Hi Laura,

> On arm64, set_pte_at currently write protects user ptes that are not 
> dirty. The expected behavior is that the fault handler will fix this up 
> on a write to the address. do_page_fault will not mark the fault as a 
> write though if ESR has the CM (cache maintenance) bit set. This has the 
> unfortunate side effect that if cache maintenance is performed on a user 
> address that has not yet been marked as dirty, handle_mm_fault may 
> return without actually adjusting the pte or returning an error. This 
> means that the fault will be infinitely retried.
> 
> Calling cache maintenance on an address that hasn't actually been 
> written to isn't all that useful but looping forever seems like a poor 
> result. It seems like the check in do_page_fault is too restrictive and 
> we need to be able to fault in pages via cache maintenance.

My understanding is that the EL0 cache maintenance instructions only require
read permission (note that DC ZVA is treated like a store and doesn't set
ESR.CM), so I'm failing to appreciate the problem here.

Do you have a small testcase I can play with?

Will
