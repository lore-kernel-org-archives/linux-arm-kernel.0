From: keescook@chromium.org (Kees Cook)
Date: Thu, 7 Jul 2016 13:29:38 -0400
Subject: [PATCH 1/9] mm: Hardened usercopy
In-Reply-To: <alpine.DEB.2.11.1607070938430.4083@nanos>
References: <1467843928-29351-1-git-send-email-keescook@chromium.org>
 <1467843928-29351-2-git-send-email-keescook@chromium.org>
 <alpine.DEB.2.11.1607070938430.4083@nanos>
Message-ID: <CAGXu5jJWVow4i_M7Qg4ZFgZh3k_fUxUs4pDJSf5Yc8Q-FK9HoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 7, 2016 at 3:42 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Wed, 6 Jul 2016, Kees Cook wrote:
>> +
>> +#if defined(CONFIG_FRAME_POINTER) && defined(CONFIG_X86)
>> +     const void *frame = NULL;
>> +     const void *oldframe;
>> +#endif
>
> That's ugly

Yeah, I'd like to have this be controlled by a specific CONFIG, like I
invented for the linear mapping, but I wasn't sure what was the best
approach.

>
>> +
>> +     /* Object is not on the stack at all. */
>> +     if (obj + len <= stack || stackend <= obj)
>> +             return 0;
>> +
>> +     /*
>> +      * Reject: object partially overlaps the stack (passing the
>> +      * the check above means at least one end is within the stack,
>> +      * so if this check fails, the other end is outside the stack).
>> +      */
>> +     if (obj < stack || stackend < obj + len)
>> +             return -1;
>> +
>> +#if defined(CONFIG_FRAME_POINTER) && defined(CONFIG_X86)
>> +     oldframe = __builtin_frame_address(1);
>> +     if (oldframe)
>> +             frame = __builtin_frame_address(2);
>> +     /*
>> +      * low ----------------------------------------------> high
>> +      * [saved bp][saved ip][args][local vars][saved bp][saved ip]
>> +      *                   ^----------------^
>> +      *             allow copies only within here
>> +      */
>> +     while (stack <= frame && frame < stackend) {
>> +             /*
>> +              * If obj + len extends past the last frame, this
>> +              * check won't pass and the next frame will be 0,
>> +              * causing us to bail out and correctly report
>> +              * the copy as invalid.
>> +              */
>> +             if (obj + len <= frame)
>> +                     return obj >= oldframe + 2 * sizeof(void *) ? 2 : -1;
>> +             oldframe = frame;
>> +             frame = *(const void * const *)frame;
>> +     }
>> +     return -1;
>> +#else
>> +     return 1;
>> +#endif
>
> I'd rather make that a weak function returning 1 which can be replaced by
> x86 for CONFIG_FRAME_POINTER=y. That also allows other architectures to
> implement their specific frame checks.

Yeah, though I prefer CONFIG-controlled stuff over weak functions, but
I agree, something like arch_check_stack_frame(...) or similar. I'll
build something for this on the next revision.

-Kees

-- 
Kees Cook
Chrome OS & Brillo Security
