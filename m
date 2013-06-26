From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 26 Jun 2013 14:52:36 +0200
Subject: [PATCH v2 3/5] ARM: add support for kernel mode NEON
In-Reply-To: <20130626124009.GL26142@mudshark.cambridge.arm.com>
References: <1372191891-24574-1-git-send-email-ard.biesheuvel@linaro.org>
 <1372191891-24574-4-git-send-email-ard.biesheuvel@linaro.org>
 <CAKv+Gu_NZNAcW13CBP=QJQ8KXD6H9zx_T6ZQPsWuagRm3n6Okg@mail.gmail.com>
 <20130626111430.GH26142@mudshark.cambridge.arm.com>
 <CAKv+Gu_R7=Euaa87kQqR5TfGQLyF6Ad51dBm2CroYHcKMRs_dA@mail.gmail.com>
 <20130626124009.GL26142@mudshark.cambridge.arm.com>
Message-ID: <CAKv+Gu9_V75jGSq675H+Gi7jkDWBkVDLXvewMuv8dWxx7-VxEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 June 2013 14:40, Will Deacon <will.deacon@arm.com> wrote:
> On Wed, Jun 26, 2013 at 12:28:49PM +0100, Ard Biesheuvel wrote:
>> So can you suggest a better way of making sure schedule_debug() shoots
>> us down if calling schedule() between kernel_neon_begin and
>> kernel_neon_end, even on non-preempt builds?
>
> With what we currently have in the kernel, no, I can't think of a better
> way. However, I also don't think that smuggling in a back-end hack is a good
> idea either. How about we follow x86's lead on this and rely on the caller
> not to sleep for the timebeing? Then, separately to this patch series, you
> could look at augmenting the scheduler so that schedule_debug can complain
> if it encounters a task that is not expected to sleep? That seems like the
> right place to fix this problem, and will benefit other architectures too.
>

Good point. As preempt_enable/disable already have this side effect on
PREEMPT builds, perhaps it wouldn't be such a bad idea to modify them
in the non-PREEMPT case to at least complain if schedule() is invoked
during such a section.

@Russell: you mentioned spinlocks at some point to prevent sleeping.
Are you ok with Will's suggestion instead, i.e., to rely on
preempt_disable() to do the right thing, and fix it later because
currently, it doesn't on non-PREEMPT?

-- 
Ard.
