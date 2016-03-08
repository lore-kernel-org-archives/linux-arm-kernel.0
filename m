From: keescook@chromium.org (Kees Cook)
Date: Tue, 8 Mar 2016 09:39:27 -0800
Subject: [PATCH v2 0/5] arm64: kernel: Add support for User Access Override
In-Reply-To: <20160308171902.GE6192@e104818-lin.cambridge.arm.com>
References: <1454684330-892-1-git-send-email-james.morse@arm.com>
 <56DDAFA7.4090207@arm.com>
 <20160307173835.GB6192@e104818-lin.cambridge.arm.com>
 <CAGXu5jKNdisc7AOZBZj5ZbHLfdZPoF5pZ+N1SQjzdDnvQbfyzA@mail.gmail.com>
 <20160308171902.GE6192@e104818-lin.cambridge.arm.com>
Message-ID: <CAGXu5jJgL6yO2dFScePtwUvo_QPcfhhdROb35JhZ8_svT8u5mw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 8, 2016 at 9:19 AM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Mon, Mar 07, 2016 at 12:54:33PM -0800, Kees Cook wrote:
>> On Mon, Mar 7, 2016 at 9:38 AM, Catalin Marinas <catalin.marinas@arm.com> wrote:
>> > (cc'ing Kees)
>> >
>> > On Mon, Mar 07, 2016 at 04:43:19PM +0000, James Morse wrote:
>> >> I've just spotted UAO causes the test_user_copy module (CONFIG_TEST_USER_COPY)
>> >> to fail. Who to blame is up for discussion. The test is passing a user pointer
>> >> as the 'to' field of copy_from_user(), which it expects to fail gracefully:
>> >>
>> >> lib/test_user_copy.c:75
>> >> >     /* Invalid usage: none of these should succeed. */
>> >> [ ... ]
>> >> >     ret |= test(!copy_from_user(bad_usermem, (char __user *)kmem,
>> >> >                                 PAGE_SIZE),
>> >> >                 "illegal reversed copy_from_user passed");
>> >> >
>> >>
>> >> access_ok() catches the "(char __user *)kmem", causing copy_from_user() to pass
>> >> bad_usermem to memset():
>> >>
>> >> arch/arm64/include/asm/uaccess.h:279
>> >> >     if (access_ok(VERIFY_READ, from, n))
>> >> >             n = __copy_from_user(to, from, n);
>> >> >     else /* security hole - plug it */
>> >> >             memset(to, 0, n);
>> >>
>> >> This (correctly) trips UAO's "Accessing user space memory outside uaccess.h
>> >> routines" message, which is a little confusing to debug, and stops the rest of
>> >> the module's tests from being run.
>> >
>> > I suggest we don't do anything on arch/arm64 (or arch/arm), I just
>> > consider the test to be broken. The semantics of copy_from_user() don't
>> > say anything about the safety checks on the destination pointer, this is
>> > supposed to be a valid kernel address. The test assumes that if the
>> > source pointer is invalid, the copy_from_user() routine should not touch
>> > the destination.
>>
>> Hmmm, I'd prefer that copy_*_user was checking both src and
>> destination. That's what these tests are checking for.
>
> If the kernel pointer (source or destination, depending on the function)
> is not valid, I would rather panic the kernel (maybe as a result of a
> data abort) than silently returning a non-zero value from
> copy_from_user() which doesn't even tell whether the source or
> destination pointer is wrong.
>
> The copy_*_user functions are indeed meant to check the validity of user
> pointer arguments and safely handle aborts (extable annotations) since
> these values are usually provided by user space. But the kernel pointer
> arguments are under the control of the kernel, so IMO passing a corrupt
> value is a serious kernel/driver bug.

I'm totally fine with that, though I suspect Linus would not like this
(perhaps just Oops instead of panic). Regardless, if that was changed,
we could move this entire test into lkdtm (where system panics are
considered a "success").

-Kees

-- 
Kees Cook
Chrome OS & Brillo Security
