From: keescook@chromium.org (Kees Cook)
Date: Mon, 8 Sep 2014 15:40:43 -0700
Subject: [PATCH v5 3/8] arm: fixmap: implement __set_fixmap()
In-Reply-To: <20140908215506.GA4759@dator>
References: <1409781429-27593-1-git-send-email-keescook@chromium.org>
 <1409781429-27593-4-git-send-email-keescook@chromium.org>
 <20140904170349.GL7156@arm.com>
 <CAGXu5jKimGaupwyUwt0Zwa3OtjeoED8-uBeMX0MwXjBYP6ssAg@mail.gmail.com>
 <20140904172748.GO7156@arm.com> <20140908191634.GV5598@outflux.net>
 <20140908215506.GA4759@dator>
Message-ID: <CAGXu5jJFB+pcDVkcMoRZ9DnJu7MQuN=kceDhpkGrO=6ZLFy6Kw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 8, 2014 at 2:55 PM, Rabin Vincent <rabin@rab.in> wrote:
> On Mon, Sep 08, 2014 at 12:16:34PM -0700, Kees Cook wrote:
>> On Thu, Sep 04, 2014 at 06:27:48PM +0100, Will Deacon wrote:
>> > On Thu, Sep 04, 2014 at 06:23:42PM +0100, Kees Cook wrote:
>> > > Ah! If this is the case, perhaps we can get away with
>> > > local_flush_tlb_kernel_range() then?
>> >
>> > That's a bit tricky, since you need to ensure that preemption is disabled
>> > until the mapping is put back like it was.
>>
>> Okay, under both real hardware with the errata, and under QEMU, things seem
>> to work with this change to the series. What do you think?
>
> Preemption is already disabled until the mapping is put back in this
> patch.c code because interrupts are disabled from before the time
> set_fixmap() is called until after clear_fixmap() is called.

Should I drop the preempt_disable/enable(), and just add a comment to
set_fixmap()?

> I'd guess that Will meant other (future) callers of set_fixmap() would
> have to ensure similar behaviour with set_fixmap() / clear_fixmap().
>
> Unless I'm missing something set/clear_fixmap() seem to be quite arch
> specific and only really used on x86, so we could ensure that future
> users on ARM perform the correct tlb flush:  the first user on ARM with
> a non-atomic context (or you) could implement a set_fixmap() which does
> the global flush and have this patch.c (and any other atomic context
> callers) call __set_fixmap() directly.
>
> The change to local_flush_tlb_kernel_range() in __set_fixmap() would of
> course be needed in that case, and IIRC that was what my original patch
> had (via set_top_pte()).

Ah, so it was, yes! Will, which version of this logic would you prefer?

Thanks!

-Kees

-- 
Kees Cook
Chrome OS Security
