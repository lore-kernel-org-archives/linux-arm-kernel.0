From: keescook@chromium.org (Kees Cook)
Date: Tue, 12 Dec 2017 11:36:18 -0800
Subject: [PATCH v5 15/30] arm64/sve: Signal handling support
In-Reply-To: <20171212111125.GL22781@e103592.cambridge.arm.com>
References: <1509465082-30427-1-git-send-email-Dave.Martin@arm.com>
 <1509465082-30427-16-git-send-email-Dave.Martin@arm.com>
 <CAGXu5jJgsAg1VBMbx=mV3ep4hzs+1G46Sow4eeFqCK31b_sORA@mail.gmail.com>
 <20171207104948.GE31900@arm.com>
 <CAGXu5jLO6tHm-mCPBo-csCw--+_jhLfGD_sHXCkFjmyvdame=g@mail.gmail.com>
 <20171211140720.GE2141@arm.com>
 <CAGXu5j+2MNOnAfstr8RyD0Orrt37ewL8uE2N8e3fL--fNPs3TQ@mail.gmail.com>
 <20171212104030.GG28301@arm.com>
 <20171212111125.GL22781@e103592.cambridge.arm.com>
Message-ID: <CAGXu5j+Kxd9+QBKmFa0i34Xqygh45pE_zQ00VfW87+20m1pSjg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 12, 2017 at 3:11 AM, Dave Martin <Dave.Martin@arm.com> wrote:
> On Tue, Dec 12, 2017 at 10:40:30AM +0000, Will Deacon wrote:
>> On Mon, Dec 11, 2017 at 11:23:09AM -0800, Kees Cook wrote:
>> > On Mon, Dec 11, 2017 at 6:07 AM, Will Deacon <will.deacon@arm.com> wrote:
>> > > On Thu, Dec 07, 2017 at 10:50:38AM -0800, Kees Cook wrote:
>> > >> My question is mainly: why not just use copy_*() everywhere instead?
>> > >> Having these things so spread out makes it fragile, and there's very
>> > >> little performance benefit from using __copy_*() over copy_*().
>> > >
>> > > I think that's more of a general question. Why not just remove the __
>> > > versions from the kernel entirely if they're not worth the perf?
>> >
>> > That has been something Linus has strongly suggested in the past, so
>> > I've kind of been looking for easy places to drop the __copy_*
>> > versions. :)
>>
>> Tell you what then: I'll Ack the arm64 patch if it's part of a series
>> removing the thing entirely :p
>>
>> I guess we'd still want to the validation of the whole sigframe though,
>> so we don't end up pushing half a signal stack before running into an
>> access_ok failure?
>
> That's an interesting question.  In many cases access_ok() might become
> redundant, but for syscalls that you don't want to have side-effects
> on user memory on failure it's still relevant.
>
> In the signal case we'd still an encompassing access_ok() to prevent
> stack guard overruns, because the signal frame can be large and isn't
> written or read contiguously or in a well-defined order.

Yeah, I think bailing early is fine. I think the existing access_ok()
checks are fine; I wouldn't want to drop those.

-Kees

-- 
Kees Cook
Pixel Security
