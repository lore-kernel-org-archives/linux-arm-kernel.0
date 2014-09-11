From: keescook@chromium.org (Kees Cook)
Date: Thu, 11 Sep 2014 09:05:14 -0700
Subject: [PATCH v5 3/8] arm: fixmap: implement __set_fixmap()
In-Reply-To: <CAGXu5jJaML_S+6LUn1uPLrScXxUJL+1N1B+Fa08ioxKt933nCw@mail.gmail.com>
References: <1409781429-27593-1-git-send-email-keescook@chromium.org>
 <1409781429-27593-4-git-send-email-keescook@chromium.org>
 <20140904170349.GL7156@arm.com>
 <CAGXu5jKimGaupwyUwt0Zwa3OtjeoED8-uBeMX0MwXjBYP6ssAg@mail.gmail.com>
 <20140904172748.GO7156@arm.com> <20140908191634.GV5598@outflux.net>
 <20140908215506.GA4759@dator>
 <CAGXu5jJFB+pcDVkcMoRZ9DnJu7MQuN=kceDhpkGrO=6ZLFy6Kw@mail.gmail.com>
 <20140909123829.GK1754@arm.com>
 <CAGXu5jJoW-B7WwuFUhbN4e1aL-HVxa9x4da9hB9DcCGEXVLgzw@mail.gmail.com>
 <20140910175126.GJ1710@arm.com>
 <CAGXu5jJaML_S+6LUn1uPLrScXxUJL+1N1B+Fa08ioxKt933nCw@mail.gmail.com>
Message-ID: <CAGXu5jJ_wLsKOuVgbS7cb+k-nyA=8XpaMYwov0o3hdFdyjaCmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 11, 2014 at 8:27 AM, Kees Cook <keescook@chromium.org> wrote:
> On Wed, Sep 10, 2014 at 10:51 AM, Will Deacon <will.deacon@arm.com> wrote:
>> Hi Kees,
>>
>> On Tue, Sep 09, 2014 at 03:33:11PM +0100, Kees Cook wrote:
>>> On Tue, Sep 9, 2014 at 5:38 AM, Will Deacon <will.deacon@arm.com> wrote:
>>> > On Mon, Sep 08, 2014 at 11:40:43PM +0100, Kees Cook wrote:
>>> >> Ah, so it was, yes! Will, which version of this logic would you prefer?
>>> >
>>> > I still don't think we're solving the general problem here -- we're actually
>>> > just making the ftrace case work. It is perfectly possible for another CPU
>>> > to undergo a TLB miss and refill whilst the page table is being modified by
>>> > the CPU with preemption disabled. In this case, a local tlb flush won't
>>> > invalidate that entry on the other core, and we have no way of knowing when
>>> > the original permissions are actually observed across the system.
>>>
>>> The fixmap is used by anything doing patching _except_ ftrace,
>>> actually. It's used by jump labels, kprobes, and kgdb. This code is
>>> the general case. Access to set_fixmap is done via the kernel patching
>>> interface: patch_text().
>>>
>>> Right now, the patch_text interface checks cache_ops_need_broadcast(),
>>> and conditionally runs under stop_machine(). We could make this
>>> unconditional, and we'll avoid any problem with TLB misses on another
>>> CPU.
>>
>> Yes, it we always use stop_machine, that solves the TLB broadcast problem
>> and we could do that if CONFIG_ARM_ERRATA_798181 is set.
>
> Okay, sounds good.
>
>>
>>> > So I think we need to figure out a way to invalidate the TLB properly. What
>>> > do architectures that use IPIs for TLB broadcasting do (x86, some powerpc,
>>> > mips, ...)? They must have exactly the same problem.
>>>
>>> I don't think this should be done at the set_fixmap level, as it is
>>> more a primitive. I think making sure patch_text() always works would
>>> be best. What do you think of using an unconditional stop_machine()
>>> instead?
>>
>> Why not move the TLB invalidation into patch_text, then we can do
>> stop_machine if IS_ENABLED(CONFIG_ARM_ERRATA_798181) ||
>> tlb_ops_need_broadcast()?
>
> The (local) TLB flush needs to happen for patch_text to do its work,
> so I'd rather it stay in set_fixmap, otherwise the flush calls will
> have to follow each call of set_fixmap.
>
> Is there a reason tlb_ops_need_broadcast() doesn't check
> IS_ENABLED(CONFIG_ARM_ERRATA_798181) itself?

Actually, this doesn't make sense. If we're using
local_flush_tlb_kernel_range() in set_fixmap, we must always run under
stop_machine. The needs-broadcast case is solved by using
local_flush_tlb_kernel_range(), and the TLB-miss-on-other-CPU case is
solved by using stop_machine(). This is how the ftrace case work,
though not via fixmap.

Since we need to flush the TLB on each fixmap change during
patch_text(), if we want to make the local_flush_tlb_... optionally
use flush_tlb_... to avoid calling stop_machine in the
does't-need-broadcast case, then we'd be checking in multiple places,
making this code overly complex for this rare operation. Is there a
good reason to complicate this code to avoid stop_machine()?

I think we should just do this:

diff --git a/arch/arm/kernel/patch.c b/arch/arm/kernel/patch.c
index 07314af47733..5038960e3c55 100644
--- a/arch/arm/kernel/patch.c
+++ b/arch/arm/kernel/patch.c
@@ -60,16 +125,5 @@ void __kprobes patch_text(void *addr, unsigned int insn)
                .insn = insn,
        };

-       if (cache_ops_need_broadcast()) {
-               stop_machine(patch_text_stop_machine, &patch, cpu_online_mask);
-       } else {
-               bool straddles_word = IS_ENABLED(CONFIG_THUMB2_KERNEL)
-                                     && __opcode_is_thumb32(insn)
-                                     && ((uintptr_t)addr & 2);
-
-               if (straddles_word)
-                       stop_machine(patch_text_stop_machine, &patch, NULL);
-               else
-                       __patch_text(addr, insn);
-       }
+       stop_machine(patch_text_stop_machine, &patch, NULL);
 }


-Kees

>> Then that just leaves ftrace.
>
> ftrace is already covered by stop_machine. Is there something I missing there?
>
> -Kees
>
> --
> Kees Cook
> Chrome OS Security



-- 
Kees Cook
Chrome OS Security
