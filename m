From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 13 Apr 2017 19:41:48 +0200 (CEST)
Subject: [Bug] VCHIQ functional test broken
In-Reply-To: <331235003.222371.1491934205807@email.1und1.de>
References: <331235003.222371.1491934205807@email.1und1.de>
Message-ID: <685482264.60263.1492105308873@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Stefan Wahren <stefan.wahren@i2se.com> hat am 11. April 2017 um 20:10 geschrieben:
> 
> 
> Hi,
> 
> recently i found that vchiq_test -f doesn't work anymore with current mainline (4.11-rc6) and linux-next (20170404) on my Raspberry Pi Zero. The issue is always reproducible, but the error behavior isn't deterministic. Sometimes vchiq_test hangs and sometimes i get an error message from vchiq_test like this (but never errors from the kernel):
> 
> $ vchiq_test -f 10
> Functional test - iters:10
> ======== iteration 1 ========
> vchiq_test: 1502: expected callback reason VCHIQ_MESSAGE_AVAILABLE, got 1
> vchiq_test: 1524: expected callback reason VCHIQ_BULK_TRANSMIT_DONE, got 5
> vchiq_test: 863: func_error != 0
> 
> I didn't had the time to bisect, but at least 4.10 is safe.
> 

Okay, i've bisected this regression to this commit:

00a19f3e25c0c40e0ec77f52d4841d23ad269169 is the first bad commit
commit 00a19f3e25c0c40e0ec77f52d4841d23ad269169
Author: Rabin Vincent <rabinv@axis.com>
Date:   Tue Nov 8 09:21:19 2016 +0100

    ARM: 8627/1: avoid cache flushing in flush_dcache_page()
    
    When the data cache is PIPT or VIPT non-aliasing, and cache operations
    are broadcast by the hardware, we can always postpone the flush in
    flush_dcache_page().  A similar change was done for ARM64 in commit
    b5b6c9e9149d ("arm64: Avoid cache flushing in flush_dcache_page()").
    
    Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
    Signed-off-by: Rabin Vincent <rabinv@axis.com>
    Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

It seems that staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm relies on the behavior of flush_dcache_page before this patch get applied. Any advices to fix this issues are appreciated.

Regards
Stefan
