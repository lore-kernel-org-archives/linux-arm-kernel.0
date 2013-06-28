From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 28 Jun 2013 16:00:02 +0200
Subject: [PATCH v2 3/5] ARM: add support for kernel mode NEON
In-Reply-To: <20130628134600.GC21034@game.jcrosoft.org>
References: <1372191891-24574-1-git-send-email-ard.biesheuvel@linaro.org>
 <1372191891-24574-4-git-send-email-ard.biesheuvel@linaro.org>
 <CAKv+Gu_NZNAcW13CBP=QJQ8KXD6H9zx_T6ZQPsWuagRm3n6Okg@mail.gmail.com>
 <20130628134600.GC21034@game.jcrosoft.org>
Message-ID: <CAKv+Gu92+pMLF9FPwbrkVLLhnPdBB702PXG-F2-3kqZx60TEHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 June 2013 15:46, Jean-Christophe PLAGNIOL-VILLARD
<plagnioj@jcrosoft.com> wrote:
> On 12:55 Wed 26 Jun     , Ard Biesheuvel wrote:
>> Meh. This is not going to please the RT crowd, as preempt_schedule()
>> will not be called on PREEMPT builds in this case.
>>
>> Propose to replace it with
>>
>>     preempt_enable();
>> #ifndef CONFIG_PREEMPT_COUNT
> if (IS_ENABLED(CONFIG_xxx)) at least
>>     /* in this case, the preempt_enable() right above is just a barrier() */
>>     dec_preempt_count();
>> #endif
>
> but why do you need to call inc_preempt and dec directly?
>

There is a concern that violations of the rule that a task should not
sleep between kernel_neon_begin and kernel_neon_end calls may not be
spotted on non-PREEMPT builds that don't have
CONFIG_DEBUG_ATOMIC_SLEEP set. However, in this case (as I pointed out
in my previous mail), you will at least oops the kernel with a message
that points to in-kernel use of the NEON/VFP, so perhaps we should not
be too paranoid about this. On the other hand, considering that this
stuff is intended to be used for RAID-6 checksumming etc, it's better
to err on the side of caution.

On arm64, it's a bit worse, as there is not lazy restore for the FP
context (and hence no oops if you sleep in the wrong place), so
context switches that clobber the NEON register contents may not be
detectable at all.

-- 
Ard.
