From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 20 Sep 2012 10:32:19 +0100
Subject: [PATCH 2/2] arm: Add ARM ERRATA 782773 workaround
In-Reply-To: <20120913172057.GB13739@n2100.arm.linux.org.uk>
References: <1347434097-7924-1-git-send-email-horms@verge.net.au>
 <1347434097-7924-3-git-send-email-horms@verge.net.au>
 <5050CD87.4020800@codeaurora.org>
 <20120913010041.GD7622@verge.net.au>
 <20120913172057.GB13739@n2100.arm.linux.org.uk>
Message-ID: <CAHkRjk4fg5m+UztnAKmQZNpB_NF2cZv-NtQoJ4M_DcO6FYnyrA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 September 2012 18:20, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Sep 13, 2012 at 10:00:42AM +0900, Simon Horman wrote:
>> +config ARM_ERRATA_782773
>> +     bool "ARM errata: Updating a translation entry might cause an unexpected translation fault"
>> +     depends on CPU_V7
>> +     help
>> +       This option enables the workaround for the 782773 Cortex-A9 (all r0,
>> +       r2 and r3 revisions) erratum. It might cause MMU exception in case
>> +       page table walk happens just after updating the existing
>> +       with setting page table in L1 data cache.
>
> What if we're running on a SMP system where the L1 caches are mandated
> to be in write-allocate mode?  This write will immediately cause the
> cache line to be brought back into the cache.

Flushing the L1 cache line before being written (even though it will
be immediately brought back into the cache) will prevent a
micro-architectural condition that causes the erratum (the processor
writing the page table must hit in the L1 cache).

-- 
Catalin
