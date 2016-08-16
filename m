From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 16 Aug 2016 11:32:04 +0100
Subject: Problem with atomic accesses in pstore on some ARM CPUs
In-Reply-To: <CABXOdTfT7xMfiBvRuUS1hsVs=q5q2wY1x1Z8oCyyJNFckM0g0A@mail.gmail.com>
References: <CABXOdTfT7xMfiBvRuUS1hsVs=q5q2wY1x1Z8oCyyJNFckM0g0A@mail.gmail.com>
Message-ID: <8f0c9ced-cdc3-ab9b-caee-06fe85e6c1e7@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guenter,

On 16/08/16 00:19, Guenter Roeck wrote:
> Hi,
> 
> we are having a problem with atomic accesses in pstore on some ARM
> CPUs (specifically rk3288 and rk3399). With those chips, atomic
> accesses fail with both pgprot_noncached and pgprot_writecombine
> memory. Atomic accesses do work when selecting PAGE_KERNEL protection.

What's the pstore backed by? I'm guessing it's not normal DRAM.

> Debugging on rk3399 shows the following crash.
> 
> [    0.912669] Bad mode in Error handler detected, code 0xbf000002 -- SError
> [    0.920140] CPU: 4 PID: 1 Comm: swapper/0 Not tainted 4.4.14 #389
> [    0.926838] Hardware name: Google Kevin (DT)
> [    0.931533] task: ffffffc0edfe0000 ti: ffffffc0edf7c000 task.ti:
> ffffffc0edf 7c000
> [    0.939780] PC is at __ll_sc___cmpxchg_case_mb_4+0x2c/0x5c
> [    0.945811] LR is at 0x1
> 
> The "solution" for this problem in various Chrome OS releases is to
> disable atomic accesses in pstore entirely, which seems to be a bit
> brute-force. Question is what a proper upstream-acceptable solution

>From that, it sounds like the endpoint doesn't support exclusive
accesses. I imagine you get away with it through a PAGE_KERNEL mapping
by virtue of being write-back cacheable, such that the exclusives end up
being handled by the local monitor at L1 and don't go out to memory, but
I'm not sure even that's necessarily reliable.

In general terms, not doing atomic accesses is probably the only 100%
safe solution.

Robin.

> might be. Introduce another memory type to select PAGE_KERNEL ? Is
> there some means to determine if atomic operations are supported with
> a given protection mask, maybe ? Anything else ?
> 
> Thanks,
> Guenter
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
