From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 28 Jun 2013 16:46:22 +0100
Subject: [PATCH v2 3/5] ARM: add support for kernel mode NEON
In-Reply-To: <CAKv+Gu92+pMLF9FPwbrkVLLhnPdBB702PXG-F2-3kqZx60TEHg@mail.gmail.com>
References: <1372191891-24574-1-git-send-email-ard.biesheuvel@linaro.org>
 <1372191891-24574-4-git-send-email-ard.biesheuvel@linaro.org>
 <CAKv+Gu_NZNAcW13CBP=QJQ8KXD6H9zx_T6ZQPsWuagRm3n6Okg@mail.gmail.com>
 <20130628134600.GC21034@game.jcrosoft.org>
 <CAKv+Gu92+pMLF9FPwbrkVLLhnPdBB702PXG-F2-3kqZx60TEHg@mail.gmail.com>
Message-ID: <20130628154622.GF1643@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 28, 2013 at 03:00:02PM +0100, Ard Biesheuvel wrote:
> On 28 June 2013 15:46, Jean-Christophe PLAGNIOL-VILLARD
> <plagnioj@jcrosoft.com> wrote:
> > On 12:55 Wed 26 Jun     , Ard Biesheuvel wrote:
> >> Meh. This is not going to please the RT crowd, as preempt_schedule()
> >> will not be called on PREEMPT builds in this case.
> >>
> >> Propose to replace it with
> >>
> >>     preempt_enable();
> >> #ifndef CONFIG_PREEMPT_COUNT
> > if (IS_ENABLED(CONFIG_xxx)) at least
> >>     /* in this case, the preempt_enable() right above is just a barrier() */
> >>     dec_preempt_count();
> >> #endif
> >
> > but why do you need to call inc_preempt and dec directly?
> 
> There is a concern that violations of the rule that a task should not
> sleep between kernel_neon_begin and kernel_neon_end calls may not be
> spotted on non-PREEMPT builds that don't have
> CONFIG_DEBUG_ATOMIC_SLEEP set.

Would an explicit call to schedule() trigger with
CONFIG_DEBUG_ATOMIC_SLEEP? It looks that this config option only
triggers for explicit might_sleep() calls but we don't have one for
explicit schedule() calls (cond_resched() call has might_sleep()).

-- 
Catalin
