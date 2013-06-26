From: will.deacon@arm.com (Will Deacon)
Date: Wed, 26 Jun 2013 13:40:09 +0100
Subject: [PATCH v2 3/5] ARM: add support for kernel mode NEON
In-Reply-To: <CAKv+Gu_R7=Euaa87kQqR5TfGQLyF6Ad51dBm2CroYHcKMRs_dA@mail.gmail.com>
References: <1372191891-24574-1-git-send-email-ard.biesheuvel@linaro.org>
 <1372191891-24574-4-git-send-email-ard.biesheuvel@linaro.org>
 <CAKv+Gu_NZNAcW13CBP=QJQ8KXD6H9zx_T6ZQPsWuagRm3n6Okg@mail.gmail.com>
 <20130626111430.GH26142@mudshark.cambridge.arm.com>
 <CAKv+Gu_R7=Euaa87kQqR5TfGQLyF6Ad51dBm2CroYHcKMRs_dA@mail.gmail.com>
Message-ID: <20130626124009.GL26142@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

On Wed, Jun 26, 2013 at 12:28:49PM +0100, Ard Biesheuvel wrote:
> On 26 June 2013 13:14, Will Deacon <will.deacon@arm.com> wrote:
> > On Wed, Jun 26, 2013 at 11:55:33AM +0100, Ard Biesheuvel wrote:
> >> Propose to replace it with
> >>
> >>     preempt_enable();
> >> #ifndef CONFIG_PREEMPT_COUNT
> >>     /* in this case, the preempt_enable() right above is just a barrier() */
> >>     dec_preempt_count();
> >> #endif
> >>
> >> (and the converse in kernel_neon_begin())
> >
> > Yuck, that's ugly as sin! How does x86 deal with this? Looking at
> > kernel_fpu_{begin,end}, they just disable preemption so I guess that they
> > assume the caller is non-blocking? There's an aside about the use of
> > preempt-notifiers for KVM, so it does sound like the onus is on the caller
> > not to shoot themselves in the face.
> >
> 
> Even if x86 doesn't care about this, do you really think we should
> take the risk of silently clobbering the NEON registers if the caller
> does something that may end up sleeping? Anyway, I don't remember
> exactly who suggested using inc_preempt_count() directly, but doing so
> brings about the responsibility of calling preempt_schedule() when
> leaving the critical section, and just using both (without the #ifdef)
> is also not an option.
> 
> So can you suggest a better way of making sure schedule_debug() shoots
> us down if calling schedule() between kernel_neon_begin and
> kernel_neon_end, even on non-preempt builds?

With what we currently have in the kernel, no, I can't think of a better
way. However, I also don't think that smuggling in a back-end hack is a good
idea either. How about we follow x86's lead on this and rely on the caller
not to sleep for the timebeing? Then, separately to this patch series, you
could look at augmenting the scheduler so that schedule_debug can complain
if it encounters a task that is not expected to sleep? That seems like the
right place to fix this problem, and will benefit other architectures too.

Will
