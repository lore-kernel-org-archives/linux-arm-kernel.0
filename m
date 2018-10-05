From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 5 Oct 2018 17:24:03 +0200
Subject: [RFC PATCH 1/9] kernel: add support for patchable function
 pointers
In-Reply-To: <9E0E08C8-0DFC-4E50-A4FA-73208835EF9E@amacapital.net>
References: <20181005081333.15018-1-ard.biesheuvel@linaro.org>
 <20181005081333.15018-2-ard.biesheuvel@linaro.org>
 <20181005141433.GS19272@hirez.programming.kicks-ass.net>
 <9E0E08C8-0DFC-4E50-A4FA-73208835EF9E@amacapital.net>
Message-ID: <CAKv+Gu9z503ZJXcsG+9Ys240BZiB-+GB=kNY4VGWpjvdzN4JtA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 October 2018 at 17:08, Andy Lutomirski <luto@amacapital.net> wrote:
>
>
>> On Oct 5, 2018, at 7:14 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>>
>>> On Fri, Oct 05, 2018 at 10:13:25AM +0200, Ard Biesheuvel wrote:
>>> diff --git a/include/linux/ffp.h b/include/linux/ffp.h
>>> new file mode 100644
>>> index 000000000000..8fc3b4c9b38f
>>> --- /dev/null
>>> +++ b/include/linux/ffp.h
>>> @@ -0,0 +1,43 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +
>>> +#ifndef __LINUX_FFP_H
>>> +#define __LINUX_FFP_H
>>> +
>>> +#include <linux/types.h>
>>> +#include <linux/compiler.h>
>>> +
>>> +#ifdef CONFIG_HAVE_ARCH_FFP
>>> +#include <asm/ffp.h>
>>> +#else
>>> +
>>> +struct ffp {
>>> +    void    (**fn)(void);
>>> +    void    (*default_fn)(void);
>>> +};
>>> +
>>> +#define DECLARE_FFP(_fn, _def)                        \
>>> +    extern typeof(_def) *_fn;                    \
>>> +    extern struct ffp const __ffp_ ## _fn
>>> +
>>> +#define DEFINE_FFP(_fn, _def)                        \
>>> +    typeof(_def) *_fn = &_def;                    \
>>> +    struct ffp const __ffp_ ## _fn                    \
>>> +        = { (void(**)(void))&_fn, (void(*)(void))&_def };    \
>>> +    EXPORT_SYMBOL(__ffp_ ## _fn)
>>> +
>>> +static inline void ffp_set_target(const struct ffp *m, void *new_fn)
>>> +{
>>> +    WRITE_ONCE(*m->fn, new_fn);
>>> +}
>>> +
>>> +static inline void ffp_reset_target(const struct ffp *m)
>>> +{
>>> +    WRITE_ONCE(*m->fn, m->default_fn);
>>> +}
>>> +
>>> +#endif
>>> +
>>> +#define SET_FFP(_fn, _new)    ffp_set_target(&__ffp_ ## _fn, _new)
>>> +#define RESET_FFP(_fn)        ffp_reset_target(&__ffp_ ## _fn)
>>> +
>>> +#endif
>>
>> I don't understand this interface. There is no wrapper for the call
>> site, so how are we going to patch all call-sites when you update the
>> target?
>
> I?m also confused.
>
> Anyway, we have patchable functions on x86. They?re called PVOPs, and they?re way overcomplicated.
>
> I?ve proposed a better way that should generate better code, be more portable, and be more maintainable.  It goes like this.
>
> To call the function, you literally just call  the default implementation.  It *might* be necessary to call a nonexistent wrapper to avoid annoying optimizations. At build time, the kernel is built with relocations, so the object files contain relocation entries for the call. We collect these entries into a table. If we?re using the ?nonexistent wrapper? approach, we can link in a .S or linker script to alias them to the default implementation.
>
> To patch them, we just patch them. It can?t necessarily be done concurrently because nothing forces the right alignment. But we can do it at boot time and module load time. (Maybe we can patch at runtime on architectures with appropriate instruction alignment.  Or we ask gcc for an extension to align calls to a function.)
>
> Most of the machinery already exists: this is roughly how the module loader resolves calls outside of a module.

Yeah nothing is ever simple on x86 :-(

So are you saying the approach i use in patch #2 (which would
translate to emitting a jmpq instruction pointing to the default
implementation, and patching it at runtime to point elsewhere) would
not fly on x86?
