From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 18 Aug 2016 14:00:56 +0200
Subject: [PATCH] arm64: Expose TASK_SIZE to userspace via auxv
In-Reply-To: <CED1E802-65C5-48B9-8165-46684BE81164@codeaurora.org>
References: <20160816183231.21179-1-cov@codeaurora.org>
 <20160817103006.GB20762@e104818-lin.cambridge.arm.com>
 <CED1E802-65C5-48B9-8165-46684BE81164@codeaurora.org>
Message-ID: <CAKv+Gu9ki6OHd+7PvHV5271_WQg5vx-rxzRSEgYsDLUho3k-7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 August 2016 at 13:12, Christopher Covington <cov@codeaurora.org> wrote:
>
>
> On August 17, 2016 6:30:06 AM EDT, Catalin Marinas <catalin.marinas@arm.com> wrote:
>>On Tue, Aug 16, 2016 at 02:32:29PM -0400, Christopher Covington wrote:
>>> Some userspace applications need to know the maximum virtual address
>>they can
>>> use (TASK_SIZE).
>>
>>Just curious, what are the cases needing TASK_SIZE in user space?
>
> Checkpoint/Restore In Userspace and the Mozilla Javascript Engine https://bugzilla.mozilla.org/show_bug.cgi?id=1143022 are the specific cases I've run into. I've heard LuaJIT might have a similar situation. In general I think making allocations from the top down is a shortcut for finding a large unused region of memory.
>

One aspect of this that I would like to discuss is whether the current
practice makes sense, of tying TASK_SIZE to whatever the size of the
kernel VA space is.

I could imagine simply limiting the user VA space to 39-bits (or even
36-bits, depending on how deeply we care about 16 KB pages), and
implement an arch specific hook (prctl() perhaps?) to increase
TASK_SIZE on demand. That would not only give us a reliable way to
check whether this is supported (i.e., the prctl() would return error
if it isn't), it also allows for some optimizations, since a 48-bit VA
kernel can run all processes using 3 levels with relative ease (and
switching between 4levels and 3levels processes would also be
possible, but would either require a TLB flush, or would result in
this optimization to be disabled globally, whichever is less costly in
terms of performance)

-- 
Ard.
