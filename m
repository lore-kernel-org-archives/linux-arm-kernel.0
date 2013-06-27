From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 27 Jun 2013 16:13:18 +0100
Subject: [PATCH v2 3/5] ARM: add support for kernel mode NEON
In-Reply-To: <CAKv+Gu_=Ctg8+KVMp9amq+2nOgj8DiUKidNDwas8qy2=y3TX-A@mail.gmail.com>
References: <1372191891-24574-1-git-send-email-ard.biesheuvel@linaro.org>
 <1372191891-24574-4-git-send-email-ard.biesheuvel@linaro.org>
 <CAKv+Gu_NZNAcW13CBP=QJQ8KXD6H9zx_T6ZQPsWuagRm3n6Okg@mail.gmail.com>
 <20130626111430.GH26142@mudshark.cambridge.arm.com>
 <CAKv+Gu_R7=Euaa87kQqR5TfGQLyF6Ad51dBm2CroYHcKMRs_dA@mail.gmail.com>
 <20130626124009.GL26142@mudshark.cambridge.arm.com>
 <CAKv+Gu9_V75jGSq675H+Gi7jkDWBkVDLXvewMuv8dWxx7-VxEw@mail.gmail.com>
 <CAKv+Gu-5SsvJCvXkJoqPm-TZx6tr+49pUXfpkSoBo-s+Z8_YmQ@mail.gmail.com>
 <CAKv+Gu_=Ctg8+KVMp9amq+2nOgj8DiUKidNDwas8qy2=y3TX-A@mail.gmail.com>
Message-ID: <20130627151318.GB1360@darko.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 27, 2013 at 02:11:27PM +0100, Ard Biesheuvel wrote:
> On 26 June 2013 15:13, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > On 26 June 2013 14:52, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> >> On 26 June 2013 14:40, Will Deacon <will.deacon@arm.com> wrote:
> >>> With what we currently have in the kernel, no, I can't think of a better
> >>> way. However, I also don't think that smuggling in a back-end hack is a good
> >>> idea either. How about we follow x86's lead on this and rely on the caller
> >>> not to sleep for the timebeing? Then, separately to this patch series, you
> >>> could look at augmenting the scheduler so that schedule_debug can complain
> >>> if it encounters a task that is not expected to sleep? That seems like the
> >>> right place to fix this problem, and will benefit other architectures too.
> >>>
> >>
> >> Good point. As preempt_enable/disable already have this side effect on
> >> PREEMPT builds, perhaps it wouldn't be such a bad idea to modify them
> >> in the non-PREEMPT case to at least complain if schedule() is invoked
> >> during such a section.
> >>
> >
> > It appears we have this already, but in the non-PREEMPT case, it needs
> > CONFIG_DEBUG_ATOMIC_SLEEP to be defined.
> > Let's just rely on preempt_disable() to do the right thing...
> 
> OK, just one more question before I respin the next (hopefully final) version:
> if a caller does sleep after calling kernel_neon_begin() (and thus
> receives no warning if he runs a non-PREEMPT build with
> CONFIG_DEBUG_ATOMIC_SLEEP disabled), he will most likely find the
> NEON/VFP unit disabled after waking up (as we disable it on a context
> switch), so any subsequent NEON instructions will trigger the undef
> handler.

Can you check on the VFP context switch path whether kernel_neon_begin()
has been called and we are moving away from the task? You could even
store the LR in kernel_neon_begin() to give better error information.

-- 
Catalin
