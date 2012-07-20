From: gilles.chanteperdrix@xenomai.org (Gilles Chanteperdrix)
Date: Fri, 20 Jul 2012 22:41:15 +0200
Subject: [PATCH] ARM: mm: avoid attempting to flush the gate_vma with
 VIVT caches
In-Reply-To: <20120719122814.GE29153@mudshark.cambridge.arm.com>
References: <1342455826-9425-1-git-send-email-will.deacon@arm.com>
 <20120719122814.GE29153@mudshark.cambridge.arm.com>
Message-ID: <5009C26B.6080901@xenomai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/19/2012 02:28 PM, Will Deacon wrote:
> Gilles, Uros,
> 
> On Mon, Jul 16, 2012 at 05:23:46PM +0100, Will Deacon wrote:
>> The vivt_flush_cache_{range,page} functions check that the mm_struct
>> of the VMA being flushed has been active on the current CPU before
>> performing the cache maintenance.
>>
>> The gate_vma has a NULL mm_struct pointer and, as such, will cause a
>> kernel fault if we try to flush it with the above operations. This
>> happens during ELF core dumps, which include the gate_vma as it may be
>> useful for debugging purposes.
>>
>> This patch adds checks to the VIVT cache flushing functions so that VMAs
>> with a NULL mm_struct are ignored.
> 
> Would one of you be able to test this patch please?

Sorry for the delay, I am getting this mail just now.

> I've not managed to
> trigger the bug you reported on my boards,

I found this bug with the LTP testsuite, more precisely the test named
"abort01".

> so it would be useful to know
> whether or not this patch solves the problem for you.

Fixes linux 3.4 bug for me. But... are you sure this is the right fix? I
mean you are adding an almost always useless test to many cache flushes,
except in one corner case. Would not it make more sense to make the fix
local, and fix gate_vma to have a static mm struct with a valid cpumask?
Being 0 or 1 whether we want to flush the vector page (I believe we do
not want to flush it, but am not sure).

-- 
                                                                Gilles.
